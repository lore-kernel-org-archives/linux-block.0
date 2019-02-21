Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B5C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243E2086D
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oTtAbEmw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="My2RjFde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfBUCu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:50:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35906 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfBUCu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 21:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550717428; x=1582253428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9o2disGBZvRk2q6B957wncGXtQqCGZNUbe9bWb/iEZ4=;
  b=oTtAbEmwnvvwUMR8NjE7Jz8aXbiMDzr9se147RR/IRN7cKVJMa9qUsRp
   JRRGFxKB4Yq/2kOu6pe+Zgm/r/UhPijpUATBhBQWncpZ+oc94F7L5QGWU
   xsHJS2ofJ1539NLdi0HY+UMO5n1pqb/n6gGTcGWkBUokW/2fZj5jPqf+t
   XXzsYjDQ4018lGY89ZOTrQFjBcyYoiYyedwFvoj6g4HeYxDguVxXQqIyF
   bjhZz99n9ZtOI+26bGd9OE/1ugsKBUvtm0GXmjf3Sdrf6Ju3W1RRh7Sac
   IjENAacX0XfjmRkcMr3jLZXgRBfa+9W+jhvI+zcoHTGv9O1WlkwSXHFQ8
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="103559093"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 10:50:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o2disGBZvRk2q6B957wncGXtQqCGZNUbe9bWb/iEZ4=;
 b=My2RjFdeVFs5zJ/ddNnXJiPKepjZ3J51+UGw6r9nGVvK30eFfmU4DJv0LuXEPTtL7IVh0wMuzUhPEcgsKLnLEwkpSOdOyYNMvZvvHq5Bx5jEGo4HgsAMmHlNvDBKZZ2MPfcW1VItA5vd92lbspP9RPHZGqTWC5sFi7VEEyLEyCE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4838.namprd04.prod.outlook.com (52.135.240.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 02:50:08 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb%3]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 02:50:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "osandov@osandov.com" <osandov@osandov.com>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH blktests 0/5] Fix failures found with zoned block devices
Thread-Topic: [PATCH blktests 0/5] Fix failures found with zoned block devices
Thread-Index: AQHUyPQPfwbhJtK5TkeaGVLgiM1bFKXpAJGAgACN1YA=
Date:   Thu, 21 Feb 2019 02:50:08 +0000
Message-ID: <2d843c9b0768200c268fb0eac8b046af7aef2a14.camel@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
         <20190220182229.GC8325@vader>
In-Reply-To: <20190220182229.GC8325@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51468314-0544-43df-5a7a-08d697a74ac8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4838;
x-ms-traffictypediagnostic: BYAPR04MB4838:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjA0TUI0ODM4OzIzOnhON0ZhMG1reEs1UDNSdm1aaXFBMjFFUnNn?=
 =?utf-8?B?aktyYlZoN2NvTkM2OHQ5RU5BNUZ1T2hNeEUzdDdHRmc5YnBMemFoQ3FVTHgy?=
 =?utf-8?B?Y24zYjVxbDNwdVJaQVNYeUVNWEVxKzdFdHdPanIvUXE4SzJpRkV1Z2cwZm5M?=
 =?utf-8?B?SEN1K25vRFVIMjZMZ2ZTTktZRHZYUURCb0U1d3lrNlI2TmE3UGF5bE1hVStO?=
 =?utf-8?B?aCtPUk81NDlkdVBQZ1lERlhaRWxpMmUwOC9wUFV2ekt5WXpWd3ozOHowS0Jp?=
 =?utf-8?B?dk1oOTNVQTErdW9xUkhacTFQcXdRREdWMjRyTHd4ZlRyUCtPbTJsS05kZmlD?=
 =?utf-8?B?SVd5TVVUZzRhbXcxaGZSdHQvNEpyUFE1ZC9OWkx2S2FkdGlBdVBSVHFTWndt?=
 =?utf-8?B?c201WE41bTJBaWU3ZjI3cUhPOHRXMndaUDFZd2dENmkrUm5WSUhDRTIxM3Fm?=
 =?utf-8?B?c00yWloxV21FMVBUZnE4RHhQUndNMWJmdUkwcHQwemxsR3FNUzVFeFo1aXZL?=
 =?utf-8?B?a3kwRS8yRGxDVm9pMnVMWXk2bmZNUmc1MFFhbUtMZFBLUTZDaWxpSHVlVjFi?=
 =?utf-8?B?L05rZ2NjdDg1aXZQcVp2ZmhVN2hFS1hKSkUvajR5UEFtSXdyaUZ5a2FFSWdH?=
 =?utf-8?B?MUYrZjBpWHVIUWR6bE8zZmROK0NLOCtDbGt2V1N6RVRacnpvTzJiOVp0VWlC?=
 =?utf-8?B?aDJnT2FLd0d0SjZ6c0FSMjlpSWdjbHF0b3FDQVFtSTlRdDY3c2lXUFhmZW40?=
 =?utf-8?B?RVB2TERMVzBVK1Vrck9TT1B2L1FVbDFFWW9KQWxpKy94aDc0Tzh4WW9uZm0r?=
 =?utf-8?B?S2NBeEFoRDg1Vi9CR3dXc2I4WTQ2QS9kZkpJMFdEUEZYVFZiUzl6Tm9jVzR1?=
 =?utf-8?B?RHJFZkY3R20vTFd1RGFRTTM0S1JoREQ4bXVYNWJnbkdWcklPSXNzM3N4Y0xF?=
 =?utf-8?B?QTVYSms3b2ZVZmpPU29TMDFUR0Nwbzg5L3JycWY1WVBrZTBRRnFqT20rYlc0?=
 =?utf-8?B?U1F0R0pwRzVwa1EyOWR1dXJycGQzRU1sOFJFM0NJMEFOTFgzY2wzYjlJQ2dX?=
 =?utf-8?B?U09PSUV5N2VZTXhCa05CT2FiUXFndmdzYk9JcUFkUHFJTEJ4dzNtc1A5aGhy?=
 =?utf-8?B?cjdGbXVUcDhZRmwreldhQThqb3pLVWZmKzlFZ0pnWkZlckZBZlVnRERIODkr?=
 =?utf-8?B?aTE1SzZKMlUyVVI1ZnhHMFlQc1lyaGZuSFZjWXhXUGJxZHd1ZG9rbHJCV0k5?=
 =?utf-8?B?UWRiaEJyWDJVN0ZDOXFjdyt5UTVqQXBEVnZmZE1sNmVkdmFZeGZLTkdzOXZL?=
 =?utf-8?B?WTYydldUL25UUXpLTUQ4Z1IwRFB5NDF2WWx4dkhTSXY1b1dZZjJTRUxFTTIz?=
 =?utf-8?B?NUVNT1JpaUtDNzVxbU02SWdyZkJjOXExYkx5aDlTOVhtU3lSaDZqT3Bsdnlo?=
 =?utf-8?B?V2NseVJEM1N6bVNvR0FUVkp1UE1TYU1uL1Jzd25pcUVlZkxWTk5mRnRWRWg2?=
 =?utf-8?B?UmZKVmQxcHAxRVRySzkvbUEvZit2SG5TblhHQ3oyMHJSMCt0M3FCU0F6SVRJ?=
 =?utf-8?B?M01DZ1pVYUhTSGgvMEZNMm01VitjTVFzdmdlc0hRY3cyZkt6NDdLNWVqMnQy?=
 =?utf-8?B?b3M3UTdrRnBhODdQVlRhbS94ZEx6ZGpTTlB4dkdBWWdYczBFbEYzZE1vSEwr?=
 =?utf-8?Q?VzchfMoAewjbrQOV9Wj+00RGNbFXkUjg1ErxIxm?=
x-microsoft-antispam-prvs: <BYAPR04MB4838BCF4B5E01496DA214BABE77E0@BYAPR04MB4838.namprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(97736004)(102836004)(186003)(81166006)(118296001)(478600001)(2616005)(6506007)(76176011)(11346002)(476003)(8936002)(72206003)(2906002)(68736007)(81156014)(8676002)(105586002)(66066001)(6436002)(446003)(106356001)(6512007)(54906003)(53936002)(6246003)(110136005)(6116002)(4326008)(14444005)(99286004)(5660300002)(58126008)(229853002)(256004)(6486002)(14454004)(86362001)(486006)(36756003)(305945005)(2501003)(316002)(71190400001)(71200400001)(7736002)(3846002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4838;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nno7xp3YyDPApKLnCiP6Uh+NSIRMYTIBNb2bzHBOqUGJ9XId6OexM8FxiIU6hiPDYtjwEAq4g/+o3fykD/Par4BpmIbLMdx3C6Fn8cpizhFPH6TKvA97BXOTDTLzmZ1hAIq+R7/yd9BV9yXqvIb6bXXdpYECaolppJfc3oDnThIQ4bqdwEwtuGIL4Cl4zklSYMK0WMIRvJ9pni0X1caKmRSk7w6IzZuYPV3NT9MCB3pSH3tOdXzUdN3mJmwzHan3utL30DW/NGCgzvV2gv83pQxfbLRhIcy8zdHmn1hixyHAkr1rwyNPVZSc+k5LjyNIDF5wPbgBvr2HRb1vNjWR5bluwv3Sdfm/hyKdj7kIFu3i5hEnQYkYBdWl6dPE1R5UhJgAH3iMvbgBQ27zvdzDwHm7du874tblbJcvAQM2KXo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D40932F8CE671E43807C0199380E37CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51468314-0544-43df-5a7a-08d697a74ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 02:50:08.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4838
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgT21hciwNCg0KT24gV2VkLCAyMDE5LTAyLTIwIGF0IDEwOjIyIC0wODAwLCBPbWFyIFNhbmRv
dmFsIHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCAwNToxMjoyNlBNICswOTAwLCBT
aGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRyZXNz
ZXMgdHdvIGluY29ycmVjdCB0ZXN0IGZhaWx1cmVzIGZvdW5kIGluIHRoZQ0KPiA+IHpiZCB0ZXN0
DQo+ID4gZ3JvdXAuIFR3byBvdGhlciBwcm9ibGVtcyB3aXRoIHRoZSBjaGVjayBzY3JpcHQgYW5k
IHRoZSBjb21tb24gcmMNCj4gPiBzY3JpcHQgYXJlDQo+ID4gYWxzbyBmaXhlZC4NCj4gPiANCj4g
PiBNb3JlIHNwZWNpZmljYWxseSwNCj4gPiAqIFBhdGNoIDEgYWRkcmVzc2VzIGFuIGluY29ycmVj
dCBmYWlsdXJlIG9mIGJsb2NrLzAyNCBjYXVzZWQgYnkNCj4gPiBzaG9ydGVyIHdyaXRlDQo+ID4g
ICBJL08gdGltZSB0aGFuIGV4cGVjdGVkIG9uIHZlcnkgZmFzdCBzeXN0ZW1zIHdpdGggYSBsb3cg
b3ZlcmhlYWQuDQo+ID4gKiBQYXRjaCAyIGZpeGVzIHRlc3QgemJkLzAwNCB3aGljaCBjYW4gZmFp
bCB3aGVuIGEgZGlzayBjbG9zZXMgYW4NCj4gPiBpbXBsaWNpdGx5DQo+ID4gICBvcGVuIHpvbmUg
YWZ0ZXIgY29tcGxldGlvbiBvZiBhIHdyaXRlIGNvbW1hbmQuIFRvIGF2b2lkIHRoaXMNCj4gPiBm
YWlsdXJlLCB0aGUNCj4gPiAgIGNsb3NlZCB6b25lIGNvbmRpdGlvbiBpcyBhZGRlZCBhcyBhbiBh
bGxvd2VkIGNvbmRpdGlvbi4NCj4gPiAqIFBhdGNoIDMgdG8gNSBmaXggcHJvYmxlbXMgdG8gYWNj
ZXNzIGEgYmxvY2sgZGV2aWNlIHN5c2ZzDQo+ID4gYXR0cmlidXRlcyBpZiB0aGUNCj4gPiAgIHRh
cmdldCBkZXZpY2UgaXMgYSBwYXJ0aXRpb24uDQo+ID4gDQo+ID4gT2Ygbm90ZSBpcyB0aGF0IHRl
c3QgYmxvY2svMDA0IHN0aWxsIGZhaWxzIHdpdGggYSB0YXJnZXQgZGV2aWNlIHRoYXQNCj4gPiBp
cyBhDQo+ID4gcGFydGl0aW9uIG9mIGEgem9uZWQgYmxvY2sgZGV2aWNlLiBUaGUgZmFpbHVyZSBj
YXVzZSBpcyBkdWUgdG8gYW4NCj4gPiBpbmNvcnJlY3QNCj4gPiBhY2Nlc3MgdG8gc3lzZnMgZGlz
ayBhdHRyaWJ1dGVzIGJ5IGZpby4gQSBwYXRjaCB0byBmaXggdGhpcyBpc3N1ZQ0KPiA+IHdhcyBz
ZW50IHRvDQo+ID4gZmlvIG1haWxpbmcgbGlzdC4NCj4gDQo+IFRoYW5rcywgSSBtZXJnZWQgMSBh
bmQgMi4gSSdtIG5vdCBuZWNlc3NhcmlseSBvcHBvc2VkIHRvIHRoZSByZXN0LCBidXQNCj4gSSdt
IGN1cmlvdXMgd2hhdCB5b3VyIHVzZSBjYXNlIGlzIGZvciB0ZXN0aW5nIG9uIHBhcnRpdGlvbnM/
DQoNClBhcmFwaHJhc2luZyBteSBhbnN3ZXIgdG8gQmFydCB3aG8gaGFkIGEgc2ltaWxhciBxdWVz
dGlvbiBvbiB0aGUgZmlvDQptYWlsaW5nIGxpc3QuDQoNCkZvciBob3N0LW1hbmFnZWQgZGlza3Ms
IHBhcnRpdGlvbmluZyBhIHpvbmVkIGJsb2NrIGRldmljZSBpcyBub3QgYSB2ZXJ5DQpjb21wZWxp
bmcgdXNlIGNhc2UsIG5vciBpcyBpdCBjb21tb25seSBpbiB1c2UgaW4gdGhlIGZpZWxkIGFzIGZh
ciBhcyBJDQprbm93LiBDaHVua2luZyBhIGhvc3QtbWFuYWdlZCBkaXNrIGludG8gc21hbGxlciBk
cml2ZXMgd2l0aCBkbS1saW5lYXIgaXMNCmxpa2VseSBhIGJldHRlciBvcHRpb24uIFRoZXJlIGlz
IG9uZSB1c2UgY2FzZSBJIGhhdmUgc2VlbiBpbiB0aGUgZmllbGQNCnRob3VnaCB3aGVyZSBhIHBh
cnRpdGlvbiB3YXMgY3JlYXRlZCBvdmVyIHRoZSBjb252ZW50aW9uYWwgem9uZXMgc3BhY2UNCm9m
IGEgZGlzayB0byBjcmVhdGUgYW4gZXNzZW50aWFsbHkgbm9ybWFsIChpLmUuIHJhbmRvbWx5IHdy
aXRhYmxlKSBkaXNrDQp0byBwdXQgYW4gZXh0NCBmaWxlIHN5c3RlbSBvbiB0b3AgZm9yIGEgbWV0
YWRhdGEgREIgdG8gbWFuYWdlIGRhdGENCnN0b3JlZCBvbiB0aGUgcmVtYWluaW5nIHNlcXVlbnRp
YWwgem9uZXMgb2YgdGhlIGRpc2suIFN1Y2ggY2hvaWNlIGFsbG93cw0KdG8gc2ltcGxpZnkgdGhl
IG92ZXJhbGwgc3lzdGVtIGRlc2lnbiBieSBlbmFibGluZyB0aGUgdXNlIG9mIHByb3Zlbg0KY29t
cG9uZW50cyAoZXh0NCwgREIpIHJhdGhlciB0aGFuIHdyaXRpbmcgb3IgcG9ydGluZyBldmVyeXRo
aW5nIHRvIGZpdCBhDQpwdXJlIHpvbmVkIGJsb2NrIGRldmljZSBtb2RlbC4NCg0KVGhlIG1haW4g
dXNlIGNhc2UgZm9yIHVzaW5nIHBhcnRpdGlvbnMgaXMgd2l0aCBob3N0LWF3YXJlIGRpc2sgbW9k
ZWxzIGFzDQp0aGVzZSBjYW4gYmUgd3JpdHRlbiByYW5kb21seSBhbnl3aGVyZSBhbmQgc28gYXJl
IGluIGVzc2VuY2UgIm5vcm1hbCINCmRpc2tzLCBtb3JlIHNvIGNvbnNpZGVyaW5nIHRoZSBmYWN0
IHRoYXQgdGhlc2UgZHJpdmVzIFNDU0kgZGV2aWNlIHR5cGUNCmlzICIweDAiLCBlcXVpdmFsZW50
IHRvIHJlZ3VsYXIgZGlzayBkZXZpY2VzLiBBcyBzdWNoLCBwYXJ0aXRpb25pbmcNCmhvc3QtYXdh
cmUgZGlza3MgaW4gdGhlIHNhbWUgbWFubmVyIGFzIHJlZ3VsYXIgZGlza3MgZ2VuZXJhbGx5IGFy
ZSBpcyBhDQp2YWxpZCB1c2UgY2FzZS4NCg0KVGhlIGludGVudCBvZiB0aGVzZSBmaXhlcyBpcyB0
byBhbGxvdyBmb3IgcnVubmluZyB0ZXN0cyBhZ2FpbnN0DQpwYXJ0aXRpb25zIHRvIGNoZWNrIHRo
ZSBrZXJuZWwgaGFuZGxpbmcgb2YgcGFydGl0aW9uIHNlY3RvciByZW1hcHBpbmcNCmZvciB6b25l
ZCBibG9jayBkaXNrcy4gU2luY2UgdGhlIGtlcm5lbCBzdXBwb3J0cyAoSSBtZWFuIGRvZXMgbm90
DQpwcmV2ZW50KSBwYXJ0aXRpb25zIG9mIHpvbmVkIGRpc2tzLCBleHRlbmRpbmcgdGVzdCBjb3Zl
cmFnZSB0byB0aGF0IGNvZGUNCmlzIEkgdGhpbmsgdXNlZnVsLiBTcGVjaWZpYyB0ZXN0IGNhc2Vz
IG9yIGdyb3VwcyBpbiBibGt0ZXN0cyBhcmUgbm90DQpuZWVkZWQgdG8gc3BlY2lmaWNhbGx5IHRl
c3QgdGhhdCwgd2Ugb25seSBuZWVkIHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkgYQ0KcGFydGl0aW9u
IGRldmljZSBmaWxlIGluIGJsa3Rlc3RzIGNvbmZpZyAoVEVTVF9ERVZTIHZhcmlhYmxlKS4gVGVz
dHMNCnJ1bnMgb24gdG9wIG9mIHpvbmVkIGRtLWxpbmVhciBkZXZpY2VzIGhhdmUgdGhlIHNhbWUg
aW50ZW50IChzZWN0b3INCnJlbWFwcGluZyB2ZXJpZmljYXRpb24pIGFuZCB0aGF0IHdvcmtzIGFz
IGlzIG5vdy4gR2V0dGluZyB0aGUgc2FtZSB0bw0KcnVuIGZvciBwYXJ0aXRpb25zIHdvdWxkIGNs
b3NlIGEgZ2FwLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KDQpCZXN0IHJlZ2FyZHMu
DQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0K
