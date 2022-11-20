// using my.bookshop as my from '../db/data-model';

// service CatalogService {
//     @readonly entity Books as projection on my.Books;
// }

// annotate CatalogService.Books with @(
//     UI : {
//         SelectionFields  : [
//             title
//         ],
//         LineItem  : [
//             {
//                 $Type : 'UI.DataField',
//                 Value : ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : title,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : stock,
//             }
//         ],
//      }
// ){
//     ID @( title: 'ID' );
//     title @( title: 'Title' );
//     stock @( title: 'Stock' );
// };

using {com.leverx as db} from '../db/data-model';

service WorkflowService @(
                          // no authorization for now -> adjust in frame of POC
                          // requires : 'authenticated-user',

                        impl : './libs/workflow-service.js') {
    // some kind of data archiving oafter completion
    action clearAll();

    entity Header     as projection on db.Header actions {
        // complete action -> plan to call it before workflow is complete to finish
        action complete(resolution : String) returns Header;
    }

    // the child can be created as deep insert for now
    @readonly
    entity Item       as projection on db.Item;

    // for future dev!
    // @readonly
    entity Attachment as projection on db.Attachment
// excluding {
//       content
// };

}

annotate WorkflowService.Header with @(UI : {
    SelectionFields : [status],
    LineItem        : [
        {
            ![@UI.Hidden],
            Value : ID
        },
        {
            $Type : 'UI.DataField',
            Value : semanticId,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            @readonly,
            $Type : 'UI.DataField',
            Value : status,
        }
    ],
}) {
    semanticId @(title : 'ID');
    name       @(title : 'Name');
    status     @(title : 'Status');
};
