const cds = require("@sap/cds");

class WorkflowService extends cds.ApplicationService {
  async init() {
    const { Header } = cds.entities("com.leverx.Header");
    const { Attachment } = cds.entities("com.leverx.Attachment");

    // const { Header } = this.entities;
    // register your event handlers...
    this.before("CREATE", Header, (req) => {
      const header = req.data;
      header.status = "In Progress";
    });
    this.on("complete", Header, async (req) => {
      const headers = await cds.run(req.query);
      if (headers.length != 1) {
        return req.error(404, "Request not found");
      }
      const header = headers[0];
      const { resolution } = req.data;
      let query = UPDATE("com.leverx.Header", header.ID).with({
        status: "Completed",
        resolution: resolution,
      });
      await cds.run(query);
      let result = cds.run(req.query);
      // const headerUpdate = headers[0];
      req.reply(result);
    });
    // ensure to call super.init()
    await super.init();
  }
}
module.exports = WorkflowService;