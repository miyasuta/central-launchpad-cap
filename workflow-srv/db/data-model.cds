// namespace my.bookshop;

// entity Books {
//   key ID : Integer;
//   title  : String;
//   stock  : Integer;
// }


namespace com.leverx;

using {
  cuid,
  managed
} from '@sap/cds/common';

entity Header : cuid, managed {
  // id is ocupied with cuid and has type UUID
  // it's additional id in meaning of semantic thing
  semanticId  : Integer;
  name        : String;
  // TODO: achecktable for status and change status to int or so
  status      : String;
  // TODO: check if it's really needed
  resolution  : String;
  // assiciations to children
  items       : Composition of many Item
                  on items.header = $self;
  attachments : Composition of many Attachment
                  on attachments.header = $self;
}

entity Item : cuid {
  // only name for now
  name   : String;
  // assiciation to parent
  header : Association to one Header;
}

entity Attachment : cuid {
  // will be needed for external service + for mime type definition
  fileName                    : String;
  @Core.IsMediaType mediaType : String;
  @Core.MediaType                   : mediaType
  @Core.ContentDisposition.Filename : fileName
  // content itself -> won't be shown in main service as it pan to be separate one
  content                     : LargeBinary;
  // assiciation to parent
  header                      : Association to one Header;
}
