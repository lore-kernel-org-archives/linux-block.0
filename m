Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D2C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4668920663
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 08:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="KGcCFCAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4668920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408588AbeKWTOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:14:23 -0500
Received: from mail-eopbgr730045.outbound.protection.outlook.com ([40.107.73.45]:47512
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408556AbeKWTOX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 14:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmJH/Pigs4Nq+U1+uGOEJmJ5OI8L9oC7+2NmG/D59Ck=;
 b=KGcCFCALtyg4gXzZn8pJMIbs1T4gTmgrKJryjziHkb+1pwXUxqEcXBSRWRbO9cp4EyAPkU6Q1QJ1oMRboLqDqJo6saR9pN8GgdmyA7gERdbrBILQvRL7OYsFsRv+IKLZlBtORJuGId3flve2cZjQEJGgBXdrd8EKK39R8ig24W8=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB5291.namprd06.prod.outlook.com (20.178.26.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Fri, 23 Nov 2018 08:31:06 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.017; Fri, 23 Nov 2018
 08:31:05 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "javier@javigon.com" <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lightnvm: pblk: avoid ref warning on cache creation
Thread-Topic: lightnvm: pblk: avoid ref warning on cache creation
Thread-Index: AQHUgmngYlYqD1slx0yfDxHproHlAaVdBDIAgAAAoWGAAAIZAIAAAgDb
Date:   Fri, 23 Nov 2018 08:31:05 +0000
Message-ID: <2A862095-B029-4CBF-A67D-74D8704F5137@cnexlabs.com>
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
 <2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
 <2D1F9096-EFF8-43C2-8403-9897B3D36409@cnexlabs.com>,<cfcc4dee-c07f-156f-4523-1bda9c878b02@lightnvm.io>
In-Reply-To: <cfcc4dee-c07f-156f-4523-1bda9c878b02@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [2a02:aa7:400b:6c85:246c:4a27:fbbe:89b1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB5291;6:jTmU7ekewUb24YAxl2mKMaw5dAE5UppLHdWq6jx/5Z/N83oD/fw9H90FaiBIWFpD9rfTdYxDO/J7yWqfnYwo2r7HSEbEWsUVbFr7JDdDuDbdMsMOfksmBEhyXp9wPCBjbB7vNI6B7sHbTWjOBL7goRXmlOlzS5PMt4UPsPMQ3I6B48BAadC9tf1k4g10WGK7X5e088w70IsowF7qiBq8xBrlbrZbQfpqfI+pK0SIA2pQIqYL8EwmOGoWTQNFTYfmGGaeeGl12iiPH1dowtbv98TkOyRsJ7Or9TiVHcSLoyUxIb5gD4yiZMMgLkEZhJZRRrDKv8U3i3N4nB9OxQGEfL7V1DJi2mbjLcgjPjz59lX6qYQMHt7R4kcLBBmr/HZsM7wYpG6wCzHAHO8/D286GIMlTIzZNmeJJ3jPEyEoFSKCO5oBscZNu/WF2WgFDxGcLhNRoHIEvVHaZPfxtWjkiQ==;5:TjAqUaP6yn/6n58avoXUoPsSXezlhHMTtUZZmAh7pRXDM10njv3UnQb8u4kmZD5UCowCJLVeK8TwzzHBJ4FlWClxbGpNqyovJfVQDnJNzPdYPXFtC8uSOASPCZ/S9fw7FVUQW53LvTyMMJUE1H/LuRbZgeXoFe0N/OrAe5qItBc=;7:XhLL9BzDulBdeZJ9XizWGhDouYoe+dcUu4sJBPh4UAwyGNByi1A+t2Nf/yNlqcbFuYuhLcktyZVkh0RuHTHR9Z4e80x7vX7ZxUnoNizrFVTkpji52cXp7T2WAosi3TZzjYLdgD4d7pePpdIpZnDSvQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(199004)(93886005)(14444005)(256004)(6916009)(46003)(6506007)(99286004)(4326008)(186003)(486006)(68736007)(229853002)(446003)(6116002)(53546011)(476003)(71200400001)(7736002)(305945005)(71190400001)(478600001)(11346002)(316002)(66574009)(2906002)(76176011)(102836004)(54906003)(33656002)(2616005)(2900100001)(83716004)(8936002)(53936002)(86362001)(36756003)(6436002)(6486002)(5660300001)(8676002)(6512007)(6246003)(105586002)(25786009)(106356001)(81166006)(97736004)(82746002)(81156014)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB5291;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d9b0a16d-3559-41da-ebef-08d6511e02f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR06MB5291;
x-ms-traffictypediagnostic: DM6PR06MB5291:
x-microsoft-antispam-prvs: <DM6PR06MB5291A2D5FAD018EF03CE003ABAD40@DM6PR06MB5291.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB5291;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB5291;
x-forefront-prvs: 086597191B
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GTY8n3bFkoVISoEDRkHkJJ7qWLUjHBTjKS+v+rUnz3sEtktjPMyJRl4cvVrWHL94yYPYa+lceOcFlwdOoB5mRW19kxRT7QBfn/3+JWs3n4LSm71C6ZzlKAXgUDywXWZNwzeT26fP0zaMlyo7PAFmHb/RwqiF5XgsiIZSFTfhsg+N1IkFOvtlvbvOy5eQ2LjvNMMpFdLyOYp11jTytXN4gaGRg2rbNUzGUzzZ8YJFWoB5DmlM7bQh+2wGCWNyZx7urA4uqKjtA95UH5JZJa9TecZkVvrZIAcRXgwZm1Gi7Fs0E6Us1U7kQE0bolOXK4dsOziIQcyTbSsWGFunE/IaBpK1JQJkZkVFIYVs77XSIec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b0a16d-3559-41da-ebef-08d6511e02f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 08:31:05.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5291
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gMjMgTm92IDIwMTgsIGF0IDA5LjI0LCBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdo
dG52bS5pbz4gd3JvdGU6DQo+IA0KPiBPbiAxMS8yMy8yMDE4IDA5OjE2IEFNLCBKYXZpZXIgR29u
emFsZXogd3JvdGU6DQo+Pj4gT24gMjMgTm92IDIwMTgsIGF0IDA5LjE0LCBNYXRpYXMgQmrDuHJs
aW5nIDxtYkBsaWdodG52bS5pbz4gd3JvdGU6DQo+Pj4gDQo+Pj4+IE9uIDExLzIyLzIwMTggMDI6
NDYgUE0sIEphdmllciBHb256w6FsZXogd3JvdGU6DQo+Pj4+IE1hdGlhcywNCj4+Pj4gQ2FuIHlv
dSBwaWNrIHRoaXMgdXAgZm9yIDQuMjA/IEV2ZW4gdGhvdWdoIGl0IGlzIG5vdCBhbiBlcnJvciBw
ZXIgc2UsIGl0DQo+Pj4+IGRvZXMgdHJpZ2dlciBhbiB1Z2x5IGZhbHNlIHBvc2l0aXZlIHdhcm5p
bmcgd2hlbiBDT05GSUdfUkVGQ09VTlRfRlVMTCBpcw0KPj4+PiBzZXQuDQo+Pj4+IFRoYW5rcywN
Cj4+Pj4gSmF2aWVyDQo+Pj4+IEphdmllciBHb256w6FsZXogKDEpOg0KPj4+PiAgIGxpZ2h0bnZt
OiBwYmxrOiBhdm9pZCByZWYgd2FybmluZyBvbiBjYWNoZSBjcmVhdGlvbg0KPj4+PiAgZHJpdmVy
cy9saWdodG52bS9wYmxrLWluaXQuYyB8IDE0ICsrKysrLS0tLS0tLS0tDQo+Pj4+ICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IEl0IGlz
IHRvbyBsYXRlIHRvIGdldCBpdCBmb3IgNC4yMC4gSSdsbCBwdWxsIGl0IGluIGZvciA0LjIxLg0K
Pj4gV2VsbCwgaWYgaXQgaXMgYSBmaXggaXTigJlzIG5vdCB0b28gbGF0ZSBBRkFJSy4gSXQgYWxz
byBhcHBsaWVzIHRvIGEgcGF0Y2ggcGlja2VkIHVwIGluIHRoaXMgc2VyaWVzLiBXZSBzaG91bGQg
aGF2ZSBjYXRjaGVzIHRoaXMgYmVmb3JlLg0KPj4gQnV0IEkgZ3Vlc3MgaXTigJlzIHlvdXIgY2Fs
bC4NCj4gDQo+IFRoZXJlIGlzIGEgbGlrZWxpaG9vZCB0aGF0IExpbnVzIHdvdWxkIGNhdGNoIGl0
LCB3aXRoIHRoZSByZXN1bHQgb2YgZmlyZSAmIGZ1cnkuIEkgZG9uJ3QgZmVlbCBsaWtlIHVzaW5n
IG9uZSBvZiBteSBjYXQgbGlmZSdzIGZvciB0aGlzIG9uZS4NCg0KSSBkb27igJl0IGdldCBob3cg
YSBmaXggaW4gcmMzIHdpbGwgcmVzdWx0IGluIEplbnMgb3IgTGludXMgY29tcGxhaW5pbmcuIEJ1
dCBPaywgbGV04oCZcyByZWxlYXNlIDQuMjAgd2l0aCBhIGZhbHNlIHBvc2l0aXZlIHdhcm5pbmcg
Zm9yIHVzZS1hZnRlci1mcmVlIG9uIHBibGsgY3JlYXRpb24uIA0KDQoNCj4+PiBXZSBjYW4gcHV0
IG9uIGEgRml4ZXM6IDE4NjRkZTk0ZWM5ZDYgImxpZ2h0bnZtOiBwYmxrOiBzdG9wIHJlY3JlYXRp
bmcgZ2xvYmFsIGNhY2hlcyIgaWYgeW91IHdhbnQgR3JlZyBhbmQgZnJpZW5kcyB0byBwaWNrIHBp
Y2tlZCBpdCB1cCBmb3Igc3RhYmxlIGtlcm5lbHM/DQo+PiBJIGRpZG7igJl0IGFkZCBpdCBhcyBp
dCBpcyBub3QgYSBidWcgaW4gaXRzZWxmLiBCdXQgaXQgaXMgZ29vZCB0byBhZGQgaXQuIENhbiB5
b3UgZG8gaXQuDQo+IA0KPiBJJ2xsIGRvIGl0Lg0KDQpUaGFua3MuIA0KDQpKYXZpZXIuIA==
