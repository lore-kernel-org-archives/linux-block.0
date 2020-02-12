Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F30C35242
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033F22086A
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 00:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="n+lA2Nw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLAoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:44:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:16946 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgBLAoN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 19:44:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 16:44:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347403484"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 16:44:07 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 16:44:07 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Feb 2020 16:44:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRkWTRQkyk7gvCHYxs0q0Uf1X+fbu/55GTPao8VJwWztT8UPMlaI2Gafx3SVEo2clj7jeBr5LQyLlrm2D3siJiR1HsYZ1kxwvlHANWj9gEZLIPTHDeLlwQel6bxl1XQhGLHDF9rQX62plDZudmTl7ij4llOL+acRso16XJjuk5Z5XSAwIAiwYpeBDspHa4GPTtJYqiE/QvkMmJ7sHVzF1tadKIqJmt0OsqyhAPFWBkhdIUFjUDHbCJ5mn6ZhrVd4rFaXdRLHr4CRjjrVVYnFSI1CzVs1T81/iiPgp2qhqUckyg8teHphNy3y2f317Kv+Bz/JOL/G25ayv3EmYDE9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizPM7tbYo676wSpAZfkhJDVIeh3pBvO+cXiPqlr14A=;
 b=PqGpMZB99AKpKxOWWrEbh+Yyt7vSHEErqTqMeOtIEOua2eva2X5Gkdx5hBQPLq2aAakUx1jmw1pjBUbngYnumYFHZqj3gi6h/JQvBkKue9XMRvk1yZmPMp1b/6S1J9UQceFkH6ved9TVi1V44KKkkJKmU+Sfc1I0FxF3d1303au8srpvTmonB/Z3hUH4r76B9gAp3kwMulfnPgMBgfoFposoBHiLQLI8CqqXvtwvh8XiaPRr91VFQx+Ucl1MoTe5ZsTNHeu/4u9dI3O3+sSbSu9lBOyxAvrsFI/KsBDzBkhuXHCBJrPWHnaoAkKhEItwQ76lwJ7h6mWM94Ng2v565Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pizPM7tbYo676wSpAZfkhJDVIeh3pBvO+cXiPqlr14A=;
 b=n+lA2Nw1POIOkyEvN5PqljVKwaySfu5vFk70Lc6Ndm1WaqOCHs+Dc72K0nkB2HoIGocZebSnqLbHqIeD5l2EWEusKHE9LrC5ccEwkuTKx6Fwfe1lWA0arH9pzZEr1Rj3reoztIisAJUsVy0ZytDyBRTY4dL450TclB028RPhu0s=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (10.169.252.137) by
 CY4PR11MB1655.namprd11.prod.outlook.com (10.172.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 00:44:05 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::4989:9d34:1d46:f384]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::4989:9d34:1d46:f384%9]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 00:44:05 +0000
From:   "Wunderlich, Mark" <mark.wunderlich@intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>
Subject: RE: Fault seen with io_uring and nvmf/tcp
Thread-Topic: Fault seen with io_uring and nvmf/tcp
Thread-Index: AdXhDtQrqxADyDVdQge7HdIgujH1owABO5EAAAo24SA=
Date:   Wed, 12 Feb 2020 00:44:05 +0000
Message-ID: <CY4PR11MB135109B62E8C85E343D10DC6E51B0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <CY4PR11MB13515FF9DCEFD14FF68FC65CE5180@CY4PR11MB1351.namprd11.prod.outlook.com>
 <7334a739-78b4-d3dc-be00-668aab2e2522@kernel.dk>
In-Reply-To: <7334a739-78b4-d3dc-be00-668aab2e2522@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed428691-c28f-4ac6-e1e5-08d7af54a9e7
x-ms-traffictypediagnostic: CY4PR11MB1655:
x-microsoft-antispam-prvs: <CY4PR11MB1655B4BE0F03D0E3C73F2656E51B0@CY4PR11MB1655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(55016002)(2906002)(316002)(52536014)(7696005)(5660300002)(81166006)(26005)(33656002)(64756008)(66556008)(66476007)(53546011)(8676002)(86362001)(66946007)(81156014)(66446008)(6506007)(8936002)(9686003)(71200400001)(478600001)(186003)(110136005)(4326008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1655;H:CY4PR11MB1351.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S5lXUj/Y6nuzqLPDnvUpB7xylkIg62sHTIyRGTW0nqZWQfBKaE1FW5sBkpUXsGr1MCzJsRV+1DXJT9npR+40HpWN/S2srmpgRGS7riPABNFEy8nn6bvlesrD9KXQyM/vi7SySmpi9+H/9jEVmC1LiUuNXAGxEJv2bUhmdpxeHqEAaqDSCoVkLemAKZwHt2QLgH0twWwk5rcwYraMOIsEXHUpuwB3ohWOBSsjJMUS5hvx+bF9oRZcMoCD07959UA+Nt+OMJ8epcMfYUE0JCIzvruyeY5Ro9kscX1+bFbhd/kgDClzlKFm5jQMss21oZg5z0JWA1m49n0kQ9HVmlXoRzEHRMw+yHKbRWdXw79hryA+iSbNl8oXTPse1pVvAucXSStUkxd1MHUu9Mer5xbZfX4/v1Lbr71HO+rnDLCz2HQ0b2qesRFjq0t7KK72GqGr
x-ms-exchange-antispam-messagedata: /DuAsNqTCEMiK0OPossg0cUEwZBA6IDNV15QXwg8BMuhksA98TWfz12B9gfJSsTZtL50jfVWlc8dTVYDF+Au1b6W+xGDPMBHx3RFTnEtTgkGl4JdZ05VJit6R+TIWycRSSfOCcBU4DldIt2aD2IwFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed428691-c28f-4ac6-e1e5-08d7af54a9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 00:44:05.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQs/ctZFbStvvLnjYslxbtFJv4OiHZA1tu5amzsH2NYLIuEUBawLPSGMxsGYFIy/RXzhKugP43T511ptcsT4yEPCtRaQ0N9JYx5rOWtwmts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1655
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhhbmtzIEplbnMsDQoNCkltcG9ydGVkIHRob3NlIHR3byBjb21taXRzLCBpbiBhZGRpdGlvbiB0
byBjb21taXQgdGhhdCByZWludHJvZHVjZWQgaGVscGVyIGlvX3dxX2N1cnJlbnRfaXNfd29ya2Vy
KCkgdXNlZCBieSBvbmUgb2YgdGhlbS4NClJlLXRlc3RlZCB0aGlzIGJhc2UgYW5kIG5vIGxvbmdl
ciBzZWUgdGhlIGZhaWx1cmUuICBBd2Vzb21lIQ0KDQpDaGVlcnMgLS0tIE1hcmsNCg0KRGF0ZTog
VHVlLCAxNyBEZWMgMjAxOSAxNDoxMzozNyAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBpby13cTog
cmUtYWRkIGlvX3dxX2N1cnJlbnRfaXNfd29ya2VyKCkNCg0KVGhpcyByZXZlcnRzIGNvbW1pdCA4
Y2RkYTg3YTQ0MTQsIHdlIG5vdyBoYXZlIHNldmVyYWwgdXNlIGNzYWVzIGZvciB0aGlzDQpoZWxw
ZXIuIFJlaW5zdGF0ZSBpdC4NCg0KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVucyBBeGJvZSA8
YXhib2VAa2VybmVsLmRrPiANClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDExLCAyMDIwIDExOjQ1
IEFNDQpUbzogV3VuZGVybGljaCwgTWFyayA8bWFyay53dW5kZXJsaWNoQGludGVsLmNvbT47IGxp
bnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZw0KQ2M6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJl
cmcubWU+DQpTdWJqZWN0OiBSZTogRmF1bHQgc2VlbiB3aXRoIGlvX3VyaW5nIGFuZCBudm1mL3Rj
cA0KDQpPbiAyLzExLzIwIDEyOjMwIFBNLCBXdW5kZXJsaWNoLCBNYXJrIHdyb3RlOg0KPiBQb3N0
aW5nIHRvIHRoaXMgbWFpbCBsaXN0IGluIGhvcGVzIHNvbWVvbmUgaGFzIGFscmVhZHkgc2VlbiB0
aGlzIGZhdWx0IGJlZm9yZSBJIHN0YXJ0IGRpZ2dpbmcuICBVc2luZyB0aGUgbnZtZS01LjUtcmMg
YnJhbmNoIG9mICBnaXQuaW5mcmFkZWFkLm9yZyByZXBvLg0KPiBQdWxsZWQgdGhpcyBicmFuY2gg
YW5kIHJ1bm5pbmcgdW4tbW9kaWZpZWQuDQo+IFBlcmZvcm1pbmcgRklPIChpb191cmluZykgdGVz
dDogKGluaXRpYXRpbmcgb24gOCBob3N0IGNvcmVzLCBUSU1FPTMwLCBSV01JWD0xMDAsIEJMT0NL
X1NJWkU9NGssIERFUFRIPTMyLCBCQVRDSD04KSwgdXNpbmcgbGF0ZXN0IHZlcnNpb24gb2YgZmlv
Lg0KPiBjbWQ9ImZpbyAtLWZpbGVuYW1lPS9kZXYvbnZtZTBuMSAtLXRpbWVfYmFzZWQgLS1ydW50
aW1lPSRUSU1FIA0KPiAtLXJhbXBfdGltZT0xMCAtLXRocmVhZCAtLXJ3PXJhbmRydyAtLXJ3bWl4
cmVhZD0kUldNSVggDQo+IC0tcmVmaWxsX2J1ZmZlcnMgLS1kaXJlY3Q9MSAtLWlvZW5naW5lPWlv
X3VyaW5nIC0taGlwcmkgLS1maXhlZGJ1ZnMgDQo+IC0tYnM9JEJMT0NLX1NJWkUgLS1pb2RlcHRo
PSRERVBUSCAtLWlvZGVwdGhfYmF0Y2hfY29tcGxldGVfbWluPTEgDQo+IC0taW9kZXB0aF9iYXRj
aF9jb21wbGV0ZV9tYXg9JERFUFRIIC0taW9kZXB0aF9iYXRjaD0kQkFUQ0ggLS1udW1qb2JzPTEg
DQo+IC0tZ3JvdXBfcmVwb3J0aW5nIC0tZ3RvZF9yZWR1Y2U9MCAtLWRpc2FibGVfbGF0PTAgLS1u
YW1lPWNwdTMgDQo+IC0tY3B1c19hbGxvd2VkPTMgLS1uYW1lPWNwdTUgLS1jcHVzX2FsbG93ZWQ9
NSAtLW5hbWU9Y3B1NyANCj4gLS1jcHVzX2FsbG93ZWQ9NyAtLW5hbWU9Y3B1OSAtLWNwdXNfYWxs
b3dlZD05IC0tbmFtZT1jcHUxMSANCj4gLS1jcHVzX2FsbG93ZWQxMSAtLW5hbWU9Y3B1MTMgLS1j
cHVzX2FsbG93ZWQ9MTMgLS1uYW1lPWNwdTE1IA0KPiAtLWNwdXNfYWxsb3dlZD0xNSAtLW5hbWU9
Y3B1MTcgLS1jcHVzX2FsbG93ZWQ9MTcNCj4gDQo+IE5WTWYgVENQIHF1ZXVlIGNvbmZpZ3VyYXRp
b24gaXMgMSBkZWZhdWx0IHF1ZXVlIGFuZCAxMDEgcG9sbCBxdWV1ZXMuICBDb25uZWN0ZWQgdG8g
YSBzaW5nbGUgcmVtb3RlIE5WTWUgcmFtIGRpc2sgZGV2aWNlLg0KPiBJL08gcGVyZm9ybXMgbm9y
bWFsbHkgdXAgdG8gMzAgc2Vjb25kIHJ1biwgYnV0IGZhdWx0cyBqdXN0IGF0IHRoZSBlbmQuIFZl
cnkgcmVwZWF0YWJsZS4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciB0aW1lIC0tLSBNYXJrDQo+IA0K
PiBbNjQ1OTIuODQxOTQ0XSBudm1lIG52bWUwOiBtYXBwZWQgMS8wLzEwMSBkZWZhdWx0L3JlYWQv
cG9sbCBxdWV1ZXMuDQo+IFs2NDU5Mi44NjcwMDNdIG52bWUgbnZtZTA6IG5ldyBjdHJsOiBOUU4g
InRlc3RyZCIsIGFkZHIgDQo+IDE5Mi4xNjguMC4xOjQ0MjAgWzY0NjQ2Ljk0MDU4OF0gbGlzdF9h
ZGQgY29ycnVwdGlvbi4gcHJldi0+bmV4dCBzaG91bGQgYmUgbmV4dCAoZmZmZjljMWZlYjJiYzdj
OCksIGJ1dCB3YXMgZmZmZjljMWZmN2VlNTM2OC4gKHByZXY9ZmZmZjljMWZmN2VlNTQ2OCkuDQo+
IFs2NDY0Ni45NDExNDldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLSBbNjQ2
NDYuOTQxMTUwXSANCj4ga2VybmVsIEJVRyBhdCBsaWIvbGlzdF9kZWJ1Zy5jOjI4IQ0KPiBbNjQ2
NDYuOTQxMzYwXSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUCBQVEkNCj4gWzY0NjQ2Ljk0
MTU2MV0gQ1BVOiA4MiBQSUQ6IDc4ODYgQ29tbTogaW9fd3FlX3dvcmtlci0wIFRhaW50ZWQ6IEcg
ICAgICAgICAgIE8gICAgICA1LjUuMC1yYzJzdGFibGUrICMzMg0KPiBbNjQ2NDYuOTQxOTk0XSBI
YXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIFI3NDAvMDBXR0QxLCBCSU9TIA0KPiAx
LjQuOSAwNi8yOS8yMDE4IFs2NDY0Ni45NDIzNDldIFJJUDogMDAxMDpfX2xpc3RfYWRkX3ZhbGlk
KzB4NjQvMHg3MCANCj4gWzY0NjQ2Ljk0MjU2Ml0gQ29kZTogNDggODkgZmUgMzEgYzAgNDggYzcg
YzcgNDAgMjEgMTcgODkgZTggZjkgNWMgYzYgDQo+IGZmIDBmIDBiIDQ4IDg5IGQxIDQ4IGM3IGM3
IGU4IDIwIDE3IDg5IDQ4IDg5IGYyIDQ4IDg5IGM2IDMxIGMwIGU4IGUwIA0KPiA1YyBjNiBmZiA8
MGY+IDBiIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDQ4IDhiIDA3IDQ4IGI5IDAwIDAx
IDAwIA0KPiAwMCAwMCBbNjQ2NDYuOTQzNDQyXSBSU1A6IDAwMTg6ZmZmZmE3OGE0OTEzN2Q5MCBF
RkxBR1M6IDAwMDEwMjQ2IA0KPiBbNjQ2NDYuOTQzNjg3XSBSQVg6IDAwMDAwMDAwMDAwMDAwNzUg
UkJYOiBmZmZmOWMxZmY3ZWU1YTAwIFJDWDogDQo+IDAwMDAwMDAwMDAwMDAwMDAgWzY0NjQ2Ljk0
NDAyMV0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogDQo+IGZmZmY5YzBmZmZlNTlkMjggUkRJ
OiBmZmZmOWMwZmZmZTU5ZDI4IFs2NDY0Ni45NDQzNTZdIFJCUDogDQo+IGZmZmZhNzhhNDkxMzdk
ZjggUjA4OiAwMDAwMDAwMDAwMDAwNmFkIFIwOTogZmZmZmZmZmY4OGVjM2JlMCANCj4gWzY0NjQ2
Ljk0NDY5MV0gUjEwOiAwMDAwMDAwMDAwMDAwMDBmIFIxMTogMDAwMDAwMDAwNzA3MDcwNyBSMTI6
IA0KPiBmZmZmOWMxZmViMmJjNjAwIFs2NDY0Ni45NDUwMjVdIFIxMzogZmZmZjljMWZlYjJiYzdj
OCBSMTQ6IA0KPiBmZmZmOWMxZmY3ZWU1NDY4IFIxNTogZmZmZjljMWZmN2VlNWE2OCBbNjQ2NDYu
OTQ1MzYwXSBGUzogIA0KPiAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5YzBmZmZlNDAw
MDAoMDAwMCkgDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAgWzY0NjQ2Ljk0NTczOV0gQ1M6ICAw
MDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogDQo+IDAwMDAwMDAwODAwNTAwMzMgWzY0NjQ2Ljk0
NjAwOF0gQ1IyOiAwMDAwN2Y0NDIzZWI3MDA0IENSMzogMDAwMDAwMTY5OTQwYTAwNSBDUjQ6IDAw
MDAwMDAwMDA3NjA2ZTAgWzY0NjQ2Ljk0NjM0M10gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTog
MDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAgWzY0NjQ2Ljk0NjY3N10gRFIz
OiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAw
MDA0MDAgWzY0NjQ2Ljk0NzAxMl0gUEtSVTogNTU1NTU1NTQgWzY0NjQ2Ljk0NzEzOF0gQ2FsbCBU
cmFjZToNCj4gWzY0NjQ2Ljk0NzI2MF0gIGlvX2lzc3VlX3NxZSsweDExNS8weGEzMCBbNjQ2NDYu
OTQ3NDI5XSAgDQo+IGlvX3dxX3N1Ym1pdF93b3JrKzB4YjUvMHgxZDAgWzY0NjQ2Ljk0NzYxNV0g
IA0KPiBpb193b3JrZXJfaGFuZGxlX3dvcmsrMHgxOWQvMHg0YzAgWzY0NjQ2Ljk0NzgyM10gIA0K
PiBpb193cWVfd29ya2VyKzB4ZGMvMHgzOTAgWzY0NjQ2Ljk0Nzk5OF0gIGt0aHJlYWQrMHhmOC8w
eDEzMCANCj4gWzY0NjQ2Ljk0ODE0MV0gID8gaW9fd3FfZm9yX2VhY2hfd29ya2VyKzB4YjAvMHhi
MCBbNjQ2NDYuOTQ4MzQ5XSAgPyANCj4ga3RocmVhZF9iaW5kKzB4MTAvMHgxMCBbNjQ2NDYuOTQ4
NTIyXSAgcmV0X2Zyb21fZm9yaysweDM1LzB4NDANCg0KSSB0aGluayB5b3Ugd2FudCB0byBjaGVj
ayB0aGF0IHlvdSBoYXZlIHRoZXNlIGluIHlvdXIgdHJlZToNCg0KDQpjb21taXQgMTFiYTgyMGJm
MTYzZTIyNGJmNWRkNDRlNTQ1YTY2YTQ0YTViMWQ3YQ0KQXV0aG9yOiBKZW5zIEF4Ym9lIDxheGJv
ZUBrZXJuZWwuZGs+DQpEYXRlOiAgIFdlZCBKYW4gMTUgMjE6NTE6MTcgMjAyMCAtMDcwMA0KDQog
ICAgaW9fdXJpbmc6IGVuc3VyZSB3b3JrcXVldWUgb2ZmbG9hZCBncmFicyByaW5nIG11dGV4IGZv
ciBwb2xsIGxpc3QNCg0KYW5kDQoNCmNvbW1pdCA3OTdmM2Y1MzVkNTlmMDVhZDEyYzYyOTMzOGJl
ZWY2Y2I4MDFkMTllDQpBdXRob3I6IEJpamFuIE1vdHRhaGVkZWggPGJpamFuLm1vdHRhaGVkZWhA
b3JhY2xlLmNvbT4NCkRhdGU6ICAgV2VkIEphbiAxNSAxODozNzo0NSAyMDIwIC0wODAwDQoNCiAg
ICBpb191cmluZzogY2xlYXIgcmVxLT5yZXN1bHQgYWx3YXlzIGJlZm9yZSBpc3N1aW5nIGEgcmVh
ZC93cml0ZSByZXF1ZXN0DQoNCi0tDQpKZW5zIEF4Ym9lDQoNCg==
