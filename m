Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03368C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98349206B2
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="l8zxY4Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98349206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbeKWS7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:59:39 -0500
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:20224
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731828AbeKWS7j (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 13:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRjdeP6WLmMUh6ll66EeDMk02L77fIseKmq0GGyfsHc=;
 b=l8zxY4LhzEhk5y1MYg2n1e7oOvSTbQ/rCdWhkxgFZIWYzcK22UrQgbm4KQZ9vz/Lw7qEbg58mp4ZGX/toRi++fPqMaVatC+lmTZxd2XcQvNTEWHmddc8spTJkJaRyubqV+drNczetao6Z91N4jQ2JrQ6uNrZPj5gs/I8srASiK0=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4122.namprd06.prod.outlook.com (20.176.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Fri, 23 Nov 2018 08:16:27 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.017; Fri, 23 Nov 2018
 08:16:26 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "javier@javigon.com" <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lightnvm: pblk: avoid ref warning on cache creation
Thread-Topic: lightnvm: pblk: avoid ref warning on cache creation
Thread-Index: AQHUgmngYlYqD1slx0yfDxHproHlAaVdBDIAgAAAoWE=
Date:   Fri, 23 Nov 2018 08:16:25 +0000
Message-ID: <2D1F9096-EFF8-43C2-8403-9897B3D36409@cnexlabs.com>
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>,<2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
In-Reply-To: <2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [2a02:aa7:400b:6c85:246c:4a27:fbbe:89b1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4122;6:MDe5RzlOlJKN8hgndQHOASi6nJJ3FJHKrVQkPJl8m2qw0LUYcp+Rx2S1G6QaExqLuRhGxRqt0UmBqe8P337LRD2iyUo3KIKPSUr/6W4EBYdYxqycncrNyUOaTmp+ep3rOpfaKskPWSV6r+5bNJ4sOtJ4LHrTqmmV1BU3glahXVBBsXw4/cM2miAZe9hAvxG8iHlZ1obY4ADQsfW3BZyXY9QKw9/Oqoo3PFLAvKeFazQkHv5Xc3I3OATGhQAZ5EekxOdUD4PbRo36CY6+zZ7WWxDHpGMcACh/FnDrMajWlBV+mvwdOGJS1O7xGOn7F9m6QGPdXN4ilWYdqm5/AyGsk18yy/bGYSRrZtS44dZrqQeHNyVxB5r5UGYmFcM70asZmlEyzx4EWH2V/M9AhZhrUk16RnBXYlRYEdivPurPh5W9Sc7ZQfIKMhRiDm+pj4QOKUIAIqPIy1iBjf0vZeGbdg==;5:/o8MPRDpc45Fcz/tQE9QxFqnsTt1S5ciRxWpw0B1if7jkV79LNphT2DcUvfPeWQ5oQHw2Bw/jKaPOr3r87aPEuTUddFRrZFfmTj3jiGWNO3QVfKNc9AhCaR5iYEkKS4G30v7irsqGAjog7kaHunK1j0CDz8vh51tTfbsfclhMCE=;7:p1xg7dNXww/dypJuuR+vYbKH8bPr50qhHmQ5avgiXYugCTjQnb/zHPILGU0b5SqwRLGNsuSRtvxSi4XAg/6lMnFVmbAzuVfzJTNsf2rDW5BHOZ8aL5LvFnV4RoMxc8bGhIWhVKKCXDGnSJCB2/X+2A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39830400003)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(106356001)(33656002)(5660300001)(53546011)(6916009)(25786009)(6506007)(6486002)(14454004)(229853002)(76176011)(66574009)(8936002)(6246003)(102836004)(105586002)(81156014)(81166006)(71190400001)(71200400001)(8676002)(46003)(2906002)(53936002)(14444005)(99286004)(476003)(6436002)(305945005)(36756003)(7736002)(82746002)(478600001)(6116002)(68736007)(54906003)(256004)(2900100001)(2616005)(486006)(4326008)(83716004)(97736004)(6512007)(446003)(316002)(186003)(86362001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4122;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 6f764054-f9c9-4896-2d73-08d6511bf691
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR06MB4122;
x-ms-traffictypediagnostic: DM6PR06MB4122:
x-microsoft-antispam-prvs: <DM6PR06MB4122B2A6DA2DD4FC38FDE377BAD40@DM6PR06MB4122.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4122;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4122;
x-forefront-prvs: 086597191B
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LlbEiTiNoSj5a+umxKNZu3mXD6TbyTSt0RZbaNW6tPfPRQ6ijrZdK6H7VKMXlDhgejfUDvqAXP5SBUMF2qdeHW6TOtzt1aRQDKjgltIyCYe/L+LXj2Di0iyAOTsntW+zydrioXTmJjd1fcUk3R95asOgrmcAME2ZdFvN801OCXHLxE3d3Qe7aW9i0A/bjZJz+m9g1zvbITn/csAapL/4+VwpSSbxKYpCi+w7KOdcbK5L81BCzNq9XOM7COSYoKVVX4pQPkpEYRmAIXQExSkGKEqC1grWJ3bYMtx4VFD12DufxKr63p0ZOvSIVLZl79iLea9PDegMv01O97pEXCaXSFhB86QiTYha9Xhifwdzdd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f764054-f9c9-4896-2d73-08d6511bf691
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 08:16:25.9258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4122
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gMjMgTm92IDIwMTgsIGF0IDA5LjE0LCBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdo
dG52bS5pbz4gd3JvdGU6DQo+IA0KPj4gT24gMTEvMjIvMjAxOCAwMjo0NiBQTSwgSmF2aWVyIEdv
bnrDoWxleiB3cm90ZToNCj4+IE1hdGlhcywNCj4+IENhbiB5b3UgcGljayB0aGlzIHVwIGZvciA0
LjIwPyBFdmVuIHRob3VnaCBpdCBpcyBub3QgYW4gZXJyb3IgcGVyIHNlLCBpdA0KPj4gZG9lcyB0
cmlnZ2VyIGFuIHVnbHkgZmFsc2UgcG9zaXRpdmUgd2FybmluZyB3aGVuIENPTkZJR19SRUZDT1VO
VF9GVUxMIGlzDQo+PiBzZXQuDQo+PiBUaGFua3MsDQo+PiBKYXZpZXINCj4+IEphdmllciBHb256
w6FsZXogKDEpOg0KPj4gICBsaWdodG52bTogcGJsazogYXZvaWQgcmVmIHdhcm5pbmcgb24gY2Fj
aGUgY3JlYXRpb24NCj4+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jIHwgMTQgKysrKyst
LS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gSXQgaXMgdG9vIGxhdGUgdG8gZ2V0IGl0IGZvciA0LjIwLiBJJ2xsIHB1bGwg
aXQgaW4gZm9yIDQuMjEuDQoNCldlbGwsIGlmIGl0IGlzIGEgZml4IGl04oCZcyBub3QgdG9vIGxh
dGUgQUZBSUsuIEl0IGFsc28gYXBwbGllcyB0byBhIHBhdGNoIHBpY2tlZCB1cCBpbiB0aGlzIHNl
cmllcy4gV2Ugc2hvdWxkIGhhdmUgY2F0Y2hlcyB0aGlzIGJlZm9yZS4gDQoNCkJ1dCBJIGd1ZXNz
IGl04oCZcyB5b3VyIGNhbGwuIA0KDQo+IA0KPiBXZSBjYW4gcHV0IG9uIGEgRml4ZXM6IDE4NjRk
ZTk0ZWM5ZDYgImxpZ2h0bnZtOiBwYmxrOiBzdG9wIHJlY3JlYXRpbmcgZ2xvYmFsIGNhY2hlcyIg
aWYgeW91IHdhbnQgR3JlZyBhbmQgZnJpZW5kcyB0byBwaWNrIHBpY2tlZCBpdCB1cCBmb3Igc3Rh
YmxlIGtlcm5lbHM/DQoNCkkgZGlkbuKAmXQgYWRkIGl0IGFzIGl0IGlzIG5vdCBhIGJ1ZyBpbiBp
dHNlbGYuIEJ1dCBpdCBpcyBnb29kIHRvIGFkZCBpdC4gQ2FuIHlvdSBkbyBpdC4gDQoNCkphdmll
ci4gDQoNCg==
