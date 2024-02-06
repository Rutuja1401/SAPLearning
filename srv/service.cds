using { BusinessPartnerA2X } from './external/BusinessPartnerA2X.cds';

using { RiskManagement as my } from '../db/schema';

@path : '/service/RiskManagement'
service RiskManagementService
{
    annotate A_BusinessPartner with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] }
    ];

    annotate Mitigations with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'RiskManager' ] }
    ];

    annotate Risks with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'RiskManager' ] }
    ];

    @odata.draft.enabled
    entity Risks as
        projection on my.Risks;

    entity A_BusinessPartner as projection on BusinessPartnerA2X.A_BusinessPartner
    {
        BusinessPartner,
        Customer,
        Supplier,
        BusinessPartnerCategory,
        BusinessPartnerFullName,
        BusinessPartnerIsBlocked
    };

    @odata.draft.enabled
    entity Mitigations as
        projection on my.Mitigations;
}

annotate RiskManagementService with @requires :
[
    'authenticated-user'
];
