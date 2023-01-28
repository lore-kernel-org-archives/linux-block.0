Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86172C38142
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjA1Qef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjA1Qee (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 11:34:34 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAC2222D0
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 08:34:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTUeSq6yUkRMc1LqxwLM8VzoMN9M/okavA0IJYLR3UDiG/WDwMHtor0xBvz7sCxs3H492ik6COkGktxsN3BzoRA5bliGZ2Hofy2k5eMkW4h1BKaGxWfPmVmhlNR9xbJyYcRlyHqG0AaRrnWgP1TS17lGj/QLuqRHltX8L4xSyR95PeXExgZvcfIlBpHbY/BdW5MN4gfxr9xZ3njkp3FaYyHw0TQl8e3v4IZP5WRT8498cDXj0S3WDHZdQklLVYdH+lYZwTmzuATZsOPr2UUHtsC+0hOZAvuK3dVCJSB49rwvIXeyOwWYRnz4xJ+uf/7AsxgnrPjHQ+G9kc5/PFfvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/70VFZsb5YoCKntFo3wPPSJOonYK6cUVwnw5xUzXIw0=;
 b=LIVcWiOUqzZWDlTsFLiylKz6Bxd5L+cSC4PtHo5iHUbhul/E1voDVDZuTZlplo9nYHK+RQLOYxUNb2TOBPAe9Ditd0QJ2laPqChGICNjkhUWmkGTcU944j4e0J7KinwLRta3DHrfooTRBNJUd80WlINsVmcApuSpcOZXejKynJcgQMT5q4RUDIMZOI/DfcFk5wd6qlCBpzGiMGIk2bZH0t7Ss9pU5w5eMzyG3ehS1f8TQKNWfAvJJWBLoROMFbjn42D8JLSSCgmRomWIUSrkHBDdlM/XwjcyBPzh7XKzyHT0DZC7XYmsWCeGMR96vBg5XadXFG0w7FiXYvXMFjKBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/70VFZsb5YoCKntFo3wPPSJOonYK6cUVwnw5xUzXIw0=;
 b=CbudjtzvxnY6y7qDWbFXoZYoeWzX3JTjkLWybu6RcT+C6p2ABEnceUuV3le7zMHs0CylmmhVC3CtHqANaRDz3v6i4byoXx1m2JZR4Gt9qptLp1P7S5XpD1ZTS5qKM7H0uiVNyZiDae9aV8QThi6EFa4WnAgty1S3UJMdXI4iPV8=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by MN0PR21MB3414.namprd21.prod.outlook.com
 (2603:10b6:208:3d1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.10; Sat, 28 Jan
 2023 16:34:30 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::b7de:9d4c:ebe8:8248]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::b7de:9d4c:ebe8:8248%6]) with mapi id 15.20.6064.017; Sat, 28 Jan 2023
 16:34:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Thread-Topic: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT
 issue
Thread-Index: AQHZKe5eY4YKqF4/rUGyGUKn5WFEPa6oUYAggAEUTgCABF8qgIAABLUAgAZMQOA=
Date:   Sat, 28 Jan 2023 16:34:30 +0000
Message-ID: <SN6PR2101MB1693A1FC29290A7191D11D80D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <167f918d-8417-8f3c-e208-5a4cc3004004@kernel.dk>
 <BYAPR21MB168820EEC294D8A951AA20EAD7C99@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2443254b-6a9c-0e46-b157-d698c79ed915@kernel.dk>
In-Reply-To: <2443254b-6a9c-0e46-b157-d698c79ed915@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=db4168a0-6c2e-4e03-8e70-662035a3beea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-28T16:23:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|MN0PR21MB3414:EE_
x-ms-office365-filtering-correlation-id: a48798a0-da9d-4b2a-88d8-08db014d879a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /25hKwmM3t630Ahojl83qIu9vjKo3wMyL1i7frEvrJGLztha0iBQSqkULR8Fbhzq3Xf6fNVoQo7yG9iE4aBU/6KzURbDQdbjKJ4XAYQSA2jpv5XFpzMU0ehBacn+BN8n95LC9gjREvYAtofAKFWeaTManEdqX3OnBHnhutDt0rlv/3O5ecOOzBBJVkd6pd3SUzfkl91wMFUul0V9/pElitlkmsjPxZKimmjAPIl2BB+kk0yrOZkSc5r/dYDnALcPnqflMq20MiOHXrkLHlm40tpKHPu9yTKutStqbnOli9GJFVMiQYLGmjY8wgHPbA5srGW/qN+2bWBtNNJFEctXVm0h/CeoLB76expFAyVQlpo9i17THIplfkpTq/HOj3NHypsWkTW+mLC9kAFBgqjYnSRvkyDtcftePwsXD5+sllgxSZt+6FDVrMeH6uFJGYwIycLnigjPxTPySg16caIcw74qMRsW49jZQ2kBQjLggSK8PiMCMhyeuwahN8yXbZHetcjZ4UKN5pnsLUj9DR0P84UzvOQ0pIuzlDoLUvd05U7dNpp2koyM/K1iaF3ifLMPsGhGAZ57bYwcbW2APkqPHzkQJe21TGdn9ETmyx1rqoEoCVb6I1xFZ8L38juzbqDJEewJbRqikX33q4C/Tx2JRnn6blSkT4RgjYsIzt2HjVqS8UIs2X6v4blKu3gxglWypPf6o4sYrHzXxBcrsO8S91DqdjuFRRkbRJn7YNi6LNDm7cg9nmHHcZn6h1Z500gY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(53546011)(122000001)(2906002)(26005)(186003)(6506007)(5660300002)(8990500004)(38100700002)(9686003)(8936002)(82950400001)(82960400001)(52536014)(10290500003)(41320700001)(71200400001)(41300700001)(33656002)(38070700005)(76116006)(7696005)(110136005)(66476007)(8676002)(4326008)(83380400001)(55016003)(478600001)(64756008)(66946007)(316002)(66556008)(66446008)(786003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2J3c09JVU5wSkE5NlZ1YysvcS9wdjVtYlZQYzY0WTBSNDg5SFZ6U0VMcHJk?=
 =?utf-8?B?YmtZWU5jY21YN0tEZXRqWDdXMUJwb2lNY3NQa0N5ay91V3pBL3cwa3J4L1VT?=
 =?utf-8?B?VjRURVR1ZVYwWkdDci90TUh6Mitad2hZRGZKdGh3MlliSStqVjlIQ1NoQmRq?=
 =?utf-8?B?aE9hWDl0dEJGdVVKNHYxRE9UQXJmeVRvZmtheXRSV0k3VjlHeXNidkVCYU9a?=
 =?utf-8?B?M1VNV0xhRWRnZFdJMVZKb1Y5YXgyREdhQzhnY2Z4RDVLbnA3cUw5Q3V4RUV6?=
 =?utf-8?B?RDZOT002L1cyQ09Nby9SaHpPSk1FdnZHM2I2YVYyTEYvTVBjNFdqeDNmWmps?=
 =?utf-8?B?aktiMkk2YmkzaFVCT2p5anlPaElYQzFmcjM4enltWnJQZlVwU3hlWDNqaHI5?=
 =?utf-8?B?Umg4c01HUVFOUE1NdmxOeXY2QVg2VWZVa0wyT2x3TndZZHUwMGJtUzd2UzQy?=
 =?utf-8?B?QUorbm9KblhUUGpqM1NTU21vV2VZNmMzU2hWckd4dFNkcEFicTlyQ0VyTWNU?=
 =?utf-8?B?NXhRSXdHWVZwZHQ2V0FGQU5xS29sMnpIdklPSkdBWjdUQWtLaU5SSmtZSmIv?=
 =?utf-8?B?TjN5cnJ6NUZERWxteS9GZ2dJQ05BeVVDemN5L2lJUEExTldMdXNQZjBOU1V2?=
 =?utf-8?B?d3c3eFRtVjU0Z3NMWlR5alFrMVZsdTZJYkluWmg2Q0ZZWkFBWkRQM1VWTm5I?=
 =?utf-8?B?cG5HNDRlK0RSc2lUamNxVXkzbnJrTm0wRDBwcGtZdkdHVHpxamZBeGVra1NZ?=
 =?utf-8?B?NFN5L01Hc0VGbDlzdnpKdytmNE1PZ1lZQXJaSW1hd2NrK2laU1lTeUpmQkZk?=
 =?utf-8?B?SUtORTAwcm1Wb0NwZjZJYmRVZ1ltenA0MEN1U1BYUGd4RFdlNDFhc3RjZVZF?=
 =?utf-8?B?d0p3bVFxbVFMcTRDVFovSTd3Y3FmcDJLRzNpZTg4bDhoTjRBcXF0R2FURDQ0?=
 =?utf-8?B?Mmc3eWhqd01SelFhd0MrQWp2MkJxdDVRWHYySG1UMG9xU09QUS9sRnBtVUc5?=
 =?utf-8?B?SDhQSExhN2RxWWJHSVk1amlsVjR4OEdueEI3dFpUTVk3dEV3dWI4OGpoclJo?=
 =?utf-8?B?UGhCY3ZhZ1NwK1ZaMHhEczlPV1ducnVxeFRzL2xTcHhwK29PVy9oOTRLZmtp?=
 =?utf-8?B?M0FSbWZieS9SQW9sTjltNUt5MTI1VzM4M0RQMjlwcTZZUURkczdndDhpWjBU?=
 =?utf-8?B?VGJRalJKdlExSm5ZNnk0a2J1UWRpaEtYN0NYNmlPcXp0SUpBaUg1MGoybHhs?=
 =?utf-8?B?cVdTTjQzcm5menpsQm9paDhpem42bXVXQmU0cTk1dk5iRXcxVkRBbDVzZ1hw?=
 =?utf-8?B?UFhqZkFtd3JHcE1SOFZIVzdUdWs4QmphcERqeUNOR1d5QmtQZjQrdE5FVkV2?=
 =?utf-8?B?TnI1VFBVSGlZQmZBdjJJOFkzNDlMc3UvdzVUbUpaRStoOVJqbXJqcmxXSVRF?=
 =?utf-8?B?dVg0dUpMQ1JsVzVqaE51TmIvSjY2SVh5Q25IVFRwRkl0cmFqN292aXlHQk9p?=
 =?utf-8?B?eWNFalpMaGNlb1NEeEltVzZKV3BndzBhaGpXSmEvS0I3RnpYTCtnS2s3bW5J?=
 =?utf-8?B?akh6Ym1GVUN2cDRwSVZ5eWg0bXVTNFF0YmFPVEIzU0p2cVhKYlc4Q2VhWDlm?=
 =?utf-8?B?ai9SZkNvTStsZkIvVnoxKzU3WHZDTFpHQlkzWlgwSWU2aGNTOHNpUXpqREo4?=
 =?utf-8?B?WTFZaWJSNyt2KzJQaTFXc2plSEoyYzhmbkFPdC9KQ3N3OFF0d0ZmelloV3M3?=
 =?utf-8?B?WUxXZGdhVEZhZmY2bldZc2pWdmZPaXdLT3gvN3VqWWxDRlVCQkdSaXBENW9W?=
 =?utf-8?B?Z3A3VDhPRWdBZUlqYkhCdXhxSGtuOHd0RVFrcWRScXU1aUxtai9WS05Dbms0?=
 =?utf-8?B?VGtOOE1wT3hRUDhqUXFBMXFpR2JRRG5YWC9RTDRiY3p5TmZRSThKM0FyYUN4?=
 =?utf-8?B?UUoxSlhJNEFJeEJjL0ZIdkRSdXZDbFdZUmIzQWZ5UkZBSjNsalRiWnN1cFl2?=
 =?utf-8?B?ekZoS1BXcmlNQ3kxSW0ySThOMzVCTVJYM2lyMGhNZU9HalVaaXRWYnEzOTdM?=
 =?utf-8?B?SFNXdFNQQTkwbEVSaExET3Vad0ZraWtZWFlGK3J2SUc5MERxYWkrM1RrZ0Nn?=
 =?utf-8?B?SlJiMUhtelhGM3FuMlJUcWlJb1dUUk1Rc0VYUVVZYkJQd0tIZjg4dU9pbDZF?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48798a0-da9d-4b2a-88d8-08db014d879a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 16:34:30.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyvym7DzVN/FdllKvjC4SgSlZREWWPPhAY1zj+oN1mDNN+carcheCrrEBI1oW1QXpPozdZJnp+yBWN+iUiqR2YqE2HPhCmZn9GeI5uNpd+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3414
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDI0LCAyMDIzIDg6MTMgQU0NCj4gDQo+IE9uIDEvMjQvMjMgOTowM+KAr0FNLCBNaWNoYWVsIEtl
bGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMjEsIDIwMjMgMToxMSBQTQ0KPiA+Pg0KPiA+PiBP
biAxLzIwLzIzIDk6NTY/UE0sIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+ID4+PiBG
cm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAx
NiwgMjAyMyAxOjA2IFBNDQo+ID4NCj4gPiBbc25pcF0NCj4gPg0KPiA+Pj4NCj4gPj4+IEkndmUg
d3JhcHBlZCB1cCBteSB0ZXN0aW5nIG9uIHRoaXMgcGF0Y2guICBBbGwgdGVzdGluZyB3YXMgdmlh
DQo+ID4+PiBpb191cmluZyAtLSBJIGRpZCBub3QgdGVzdCBvdGhlciBwYXRocy4gIFRlc3Rpbmcg
d2FzIGFnYWluc3QgYQ0KPiA+Pj4gY29tYmluYXRpb24gb2YgdGhpcyBwYXRjaCBhbmQgdGhlIHBy
ZXZpb3VzIHBhdGNoIHNldCBmb3IgYSBzaW1pbGFyDQo+ID4+PiBwcm9ibGVtLiBbMV0NCj4gPj4+
DQo+ID4+PiBJIHRlc3RlZCB3aXRoIGEgc2ltcGxlIHRlc3QgcHJvZ3JhbSB0byBpc3N1ZSBzaW5n
bGUgSS9PcywgYW5kIHZlcmlmaWVkDQo+ID4+PiB0aGUgZXhwZWN0ZWQgcGF0aHMgd2VyZSB0YWtl
biB0aHJvdWdoIHRoZSBibG9jayBsYXllciBhbmQgaW9fdXJpbmcNCj4gPj4+IGNvZGUgZm9yIHZh
cmlvdXMgc2l6ZSBJL09zLCBpbmNsdWRpbmcgb3ZlciAxIE1ieXRlLiAgTm8gRUFHQUlOIGVycm9y
cw0KPiA+Pj4gd2VyZSBzZWVuLiBUaGlzIHRlc3Rpbmcgd2FzIHdpdGggYSA2LjEga2VybmVsLg0K
PiA+Pj4NCj4gPj4+IEFsc28gdGVzdGVkIHRoZSBvcmlnaW5hbCBhcHAgdGhhdCBzdXJmYWNlZCB0
aGUgcHJvYmxlbS4gIEl0J3MgYSBsYXJnZXINCj4gPj4+IHNjYWxlIHdvcmtsb2FkIHVzaW5nIGlv
X3VyaW5nLCBhbmQgaXMgd2hlcmUgdGhlIHByb2JsZW0gd2FzIG9yaWdpbmFsbHkNCj4gPj4+IGVu
Y291bnRlcmVkLiAgVGhhdCB3b3JrbG9hZCBydW5zIG9uIGEgcHVycG9zZS1idWlsdCA1LjE1IGtl
cm5lbCwgc28gSQ0KPiA+Pj4gYmFja3BvcnRlZCBib3RoIHBhdGNoZXMgdG8gNS4xNSBmb3IgdGhp
cyB0ZXN0aW5nLiAgQWxsIGxvb2tzIGdvb2QuIE5vDQo+ID4+PiBFQUdBSU4gZXJyb3JzIHdlcmUg
c2Vlbi4NCj4gPj4NCj4gPj4gVGhhbmtzIGEgbG90IGZvciB5b3VyIHRob3JvdWdoIHRlc3Rpbmch
IENhbiB5b3Ugc2hhcmUgdGhlIDUuMTUNCj4gPj4gYmFja3BvcnRzLCBzbyB3ZSBjYW4gcHV0IHRo
ZW0gaW50byA1LjE1LXN0YWJsZSBhcyB3ZWxsIHBvdGVudGlhbGx5Pw0KPiA+Pg0KPiA+DQo+ID4g
Q2VydGFpbmx5LiAgV2hhdCdzIHRoZSBiZXN0IHdheSB0byBkbyB0aGF0PyAgU2hvdWxkIEkgc2Vu
ZCB0aGVtIHRvIHlvdSwNCj4gPiBvciB0byB0aGUgbGludXgtYmxvY2sgbGlzdD8gIE9yIHBvc3Qg
ZGlyZWN0bHkgdG8gc3RhYmxlQHZnZXIua2VybmVsLm9yZz8NCj4gPiBJZiB0aGUgbGF0dGVyLCBt
YXliZSBJIG5lZWQgdG8gd2FpdCB1bnRpbCBpdCBoYXMgYW4gdXBzdHJlYW0gY29tbWl0IElEDQo+
ID4gdGhhdCBjYW4gYmUgcmVmZXJlbmNlZC4gIEFsc28sIHlvdSBvciBzb21lb25lIHNob3VsZCBk
byBhIHF1aWNrIHJldmlldw0KPiA+IG9mIHRoZSBiYWNrcG9ydCB0byBtYWtlIHN1cmUgSSBkaWRu
J3QgYnJlYWsgc29tZXRoaW5nIGluIGEgcGF0aCBJDQo+ID4gZGlkbid0IHRlc3QuDQo+IA0KPiBK
dXN0IHNlbmQgdGhlbSB0byB0aGUgYmxvY2sgbGlzdCwgdGhlbiB3ZSBoYXZlIHRoZW0gZm9yIHdo
ZW4gdGhlIGNvbW1pdA0KPiBoaXRzIHVwc3RyZWFtIGFuZCBnaXZlcyB1cyBhIGNoYW5jZSB0byBy
ZXZpZXcgdGhlbSB1cGZyb250Lg0KPiANCj4gVGhhbmtzIQ0KPiANCg0KWW91ciBmaXJzdCB0d28g
cGF0Y2hlcyBmb3IgaGFuZGxpbmcgYmlvIHNwbGl0dGluZyBoYXZlIGFscmVhZHkgYmVlbg0KYmFj
a3BvcnRlZCB0byA1LjE1IGFuZCBhcmUgaW5jbHVkZWQgaW4gNS4xNS45MC4gICBIb3dldmVyLCBp
biByZXZpZXdpbmcNCnRoZSBiYWNrcG9ydHMsIHN0YWJsZSBjb21taXQgNjEzYjE0ODg0Yjg1IGRp
ZG4ndCB1cGRhdGUgZG1fc3VibWl0X2JpbygpDQp0byBjaGVjayBmb3IgYSBOVUxMIGJpbyBiZWlu
ZyByZXR1cm5lZCBieSBibGtfcXVldWVfc3BsaXQoKS4gICBQcmVzdW1hYmx5DQp0aGF0IG5lZWRz
IHRvIGJlIGZpeGVkIHVubGVzcyB0aGVyZSBpcyBhIHJlYXNvbiB0aGUgY2hlY2sgaXNuJ3QgbmVl
ZGVkDQood2hpY2ggSSBkaWRuJ3Qgc2VlKS4NCg0KU2VwYXJhdGVseSwgSSd2ZSBwb3N0ZWQgYSB2
NS4xNS45MCBiYWNrcG9ydCBmb3IgdGhlIF9fYmxrZGV2X2RpcmVjdF9JTygpDQpmaXggZm9yIG11
bHRpcGxlIGJpbydzLg0KDQpNaWNoYWVsDQoNCg0K
