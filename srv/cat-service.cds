using my.bookshop as my from '../db/data-model';


service CatalogService @(requires: 'authenticated-user') {
    @odata.draft.enabled
    entity Books as projection on my.Books;
}

//For viewing all recoreds from cap-launchpad-srv
service AdminService {
    @readonly
    entity Books as projection on my.Books;
}

annotate CatalogService.Books with @(
    restrict: [
        { grant: ['WRITE'], to: ['authenticated-user'] },
        { grant: ['READ'], where: 'createdBy = $user'}
    ]
);

annotate CatalogService.Books with @(
    UI : { 
        SelectionFields  : [
            title
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            }, 
            {
                $Type : 'UI.DataField',
                Value : stock,
            }                                   
        ],
        Identification : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            }, 
            {
                $Type : 'UI.DataField',
                Value : stock,
            }              
        ],
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.Identification',
            },
        ]
     }
){
    ID @( title: 'ID' );    
    title @( title: 'Title' );
    stock @( title: 'Stock' );
};