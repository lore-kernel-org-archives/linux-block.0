Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C7BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiFUQ6b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiFUQ6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 12:58:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E61C906
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 09:58:29 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L9VHDH009597
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 09:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jqBKd9EPQPzGxstkEz9AuCLd/jqjwKOi/ur0nDBbjSU=;
 b=CRMCwOueSglTF6hOy5Yq3cIn4F0X2LZAnE+3xS6W3oYFiuhwnjme+s3YmhSWOGhUfJsC
 7dvxMkHPjJ2fQkFWlfWsLBXkaUJOv8mOVHY5qsh6hqrsPhVP4apgHvvZIbHbIFGQpZ1F
 LeUHr/5tThvee1LeXpyAkDUxT7iGMM40y10= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gtunfynbw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 09:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyA3979+ue1/mLBL0BB1DEKhwXnKuTFS0sy+0T+s3Tw+1WmSmJR15kOQ5PRQur5YoKp6BAsr3AS1QW5Cx4ppi8GlQwKu6eMHBdlercV2ZMbEYVuOgBwxwkRxAzCx1Ftj0JTQXVhSWcJa4U/cjTQTY9nUX+BPoIkrvuxsjiJTYSA6v5fjjUkIVO9KOYvPB79EyRVZ4N07EBaNT+U2vyy9YZZ36mkFJ9Qn5pyDaqLDwsYuUoCTPqL3ZOR3LWKbhgXQMJIvNo1o0yhL74ty+vybxxEMSw0sp1c/IRqfVBZPor8w0Wkmx48OF1C1PFPynCWbMumZJhpBdlBR+HVZwFf62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqBKd9EPQPzGxstkEz9AuCLd/jqjwKOi/ur0nDBbjSU=;
 b=GTMm/LXuKj8rBb0x4B6F/mvFoNrNWhwIOxl0JVYWfA4mQaKScmOnBYlPOpx4PdsNs1UEitx0fBBjpruUuVEG+YgxubY1pz5uK2jZt2e/II+vZIvcaI3yDndE4DAC758UQC8uNFMmU+Ndj8vFVUmV2/fWv6wxrhah9khR37SQGmDQa3AWRtzqVjscp5hM4jXYpVSQQflrnArarSQWUbzpS/0CrMm6fG9nX7M45zPPVR8CRaQN4475QxJk5ONq7m1+YowHpRyOcGE8SBvnsAO+LvVucQ8rhVnBzPZKoHHjzoIEizgPUQ3PGpZd28WZk+JN07hOv+3SmMOglNi+NG5SEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4854.namprd15.prod.outlook.com (2603:10b6:806:1e1::19)
 by BL3PR15MB5483.namprd15.prod.outlook.com (2603:10b6:208:3bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 16:58:26 +0000
Received: from SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::f0a8:296c:754f:2369]) by SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::f0a8:296c:754f:2369%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 16:58:26 +0000
From:   Dylan Yudaken <dylany@fb.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Topic: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Index: AQHYhYkDgMsjbKCMOUWlz1BDFOG4yK1aFS0A
Date:   Tue, 21 Jun 2022 16:58:26 +0000
Message-ID: <0b2b702939f8c9228d6e34838fe4ca042782317b.camel@fb.com>
References: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
In-Reply-To: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0471709a-26ef-48d4-a4a4-08da53a74277
x-ms-traffictypediagnostic: BL3PR15MB5483:EE_
x-microsoft-antispam-prvs: <BL3PR15MB5483563381D3CFB0D1DFE687B6B39@BL3PR15MB5483.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXG8RcA5IQDWfrExe7irjHeJuhOYxNlOhqaXEFHlDdR5s+Jzih90ALYBgIIuaWpdUTsNWFZ1BYgEXYb+oQuhx3XlSqDEuywNbiVXHH5roZZXAHGRAeY4BBxXi6QqA58jcIF7KDpo/vK+iqS4u6To3l704GKoLrKwmE8dtjLLCkDMbnhzGn76fpz061yLrrplKMvjq/lh+mY+K/Pwd0+PMSeJ+yrXo6g7n/GyNL5T0dqOTspzy92mtzt0NhqLadPNDBcEq5lddRelJl39MpVE02XD9MWGJhVnH6F3SM/ocQcZdivJpfWpKSMS+e61RDp+41wGNUpZGqaJvR5O+lS56Qf+fPDMknE64GtQnRcKIrbekrTdlL77EOQkv77dHFnAC/cQitovE99flKnBHydCUfbHD9lx/GxudNTRNj61DQ1+9qBHJv8BpdbWFRLA/LKCjVLaj/K21favtZEufiADoxy0ongVpQtljOiCnNQhzgzZYfOIQSxORBhTy5rL65Q8tyLy+6JBo+hCECcfdvTlBbu3B2azLm0HUBQ+JgHYRrbupkUkTla2GPb9pEtwuIQ6Foqgn9EgQEwI0r2h9d3QxEppBAW1OJvHi6uQqABUaxRNsLxHrvcKzrVr1vz4BtljvFHSOxfAUQgV6OkaU+fiyviSvqbZonkgiSzdLkljcRgZEOsKeB8UNgcfxWF+ioj4TB59a+Qs9A6P6XnPYXOH0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4854.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(66476007)(66446008)(64756008)(4326008)(83380400001)(6486002)(66556008)(478600001)(5660300002)(8676002)(91956017)(122000001)(76116006)(66946007)(8936002)(6512007)(71200400001)(36756003)(6506007)(38100700002)(38070700005)(2906002)(316002)(86362001)(186003)(41300700001)(110136005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elJ2WnIrVE96Yzk1bE5yOXVsakk2L3AvY3lLSGVkNzh6RUt5dlcreEJ1OFVm?=
 =?utf-8?B?Sm9DT08xK2RTMHFuYlhGd3Jha09IckFxNTFHY3V4U3VaaXVLRkpPdk5wa0ds?=
 =?utf-8?B?d3pPOXgwVFFDSGVseW1xcEg1Nlg4Z2t2ZzJwaTVvOThQMTU2aXZsRkMybC93?=
 =?utf-8?B?U0IrREEwQ2F5WDBoblJNWDRjOGlEQ1cwU3B4TDFCanJNOHUrNHZqVDdRUjM5?=
 =?utf-8?B?Mko3cjZIYmRjdWV5SUczclpOT2pwaU1ZSlpVZWlGYWthRTlIZ0M5WGVzNEp3?=
 =?utf-8?B?bGRUOGs5STVXZmJpSGsyam53ZitJZE5mUWgwdC83VFJZeE1jUjBDdXROaFRx?=
 =?utf-8?B?bnJPMVNYVHR2MkZ3MlkrZ1pWeTF5SVNGMDk4QWtrNnpFOFpiM1NUUEJzbk56?=
 =?utf-8?B?VGVJTmpLVDNHd3o2eVdhUys3VmE2YzlvY1lsakhxWk1OdUFCSFZzdm5NV2dG?=
 =?utf-8?B?UzVjTEs2blZKYmY3WHpSOHFGM1A5S0xUWGYxWS80Wk5SNDVSeGw0alozcHB6?=
 =?utf-8?B?a3ZJcURnelJrSGI3VzNkT3Fnelhaa05KWEFaUkpGUzZwbXBNYjF4ekpoSWd0?=
 =?utf-8?B?RDRuTEMyWjYvZXZPTjZFQlBHejlYMXhocGdpRVgxZ21jSHdkaURVdGpPaHFO?=
 =?utf-8?B?dU03Y09LTkdVMjNjNmdwSXNWSy9QdkEvTkZ0RU9JQWxuSXgvcTNqdjlXeHpM?=
 =?utf-8?B?dGNUWjRsMUJWRkJrSVYvbEs2YnZEQ2hmdEtwL3RkeHZBaG8yb0R3QlQyekll?=
 =?utf-8?B?bUdCUUNBeXFwT0JLYjJsN0kwbTNLazFYUEdwMFZLcnZZcnlUYTNweCtSSUN3?=
 =?utf-8?B?RkVEYVZValp1QVJlY1FyUFU5ZkY0MmRCRkc2aEpvWlBadnJXV1BMOUU2SlNU?=
 =?utf-8?B?ZktPRXk1YjNrYnFrTWE4dFZQMmZxVmpBN1dXZ0Z5T2NQK2JSclo1MGZhRDhj?=
 =?utf-8?B?QWZ4TUwvUEVicXBQUGZPMjRVMFRveFpQUytpbXFvdEw2RktNN3FCYmxEenlW?=
 =?utf-8?B?d0NmUk8yT0tZRkNTOE1XT3Y1N1VHUTBGZ1BkN2tBRzVNMy9oS3VIU2hMaGtt?=
 =?utf-8?B?UnRRUGVtOGR5UnBDRXRObVVreHpKeXZSK3duUjN4dlowaHhRa2k2WmswYnJV?=
 =?utf-8?B?a053TU81dUVERHFzNGRCK1Z0c1NXWFZyTXB2Z0gzc2RqZnNxQUoxUHpDcEJp?=
 =?utf-8?B?U0NuVjd5OHE1ZmdvOUFqbzRHMmtSWVh2V3hBMzFka0huY0t6TWtINktZL2o0?=
 =?utf-8?B?SmhCbWZDZnBmcVIxTkcyVmEwTTNJRFhOaGhnL2dubDhZYjdqTGsvazk5RWQv?=
 =?utf-8?B?b0V2MS9qYURIUVZNMmY4eGZSVkZEdjJtMHphZmhtdmo4eDZBV3UycHdLVVBU?=
 =?utf-8?B?ZVJtMTB3eWZwdTVvcFk3SzBBYzFwcDJaMlJpY3I5WGpTdFhkMTRsOGljUGNh?=
 =?utf-8?B?Vk1jMjQ5SWlUSUJSQ1dGWmVGbUNyMTdETGdLeXdsbUtsNktYSG13dHVZelN1?=
 =?utf-8?B?MGp4VSs0NVcrdnk3M0cwMTVDSk5qTkFiWnAvT2NMaUFCRDErL2ZjSkI0K3hs?=
 =?utf-8?B?SDRLa0RjeWdHUXFtVzlKRUNRbit2dHFxUG1raW5QeVpyUEdoZFBocHFYWTJr?=
 =?utf-8?B?d0pkdzB1djc0OC9PcGs4TlZTSWR0M29iWXA2R2p2MENEZ0hubFN1S0dMTCt2?=
 =?utf-8?B?WldPeDBwcU9rSTI3U2RFSkJyVThmV1U5S3E3dnlEeHhkRlg4ZzdVaStBcEd4?=
 =?utf-8?B?RGM3YmJFU25sRldCKzJHZzE3M1pqb2Rkc2N2M3pUL1ZEL2tGbGlPK3JyYWRH?=
 =?utf-8?B?aGpGZldDaHhuSDdYd3FDdXczNzdIUkVSMHIzUTFmUk8xRmdDemRZdkU5YU4v?=
 =?utf-8?B?aWNUSnlRcjg0Z0pzVXdubmNFQ2d1bEVUMURYTU9LNk00dU5iNkVLVUV4OFpV?=
 =?utf-8?B?d0toZEFVdmJtY2ptakxFV2F6STJhOHBTM1RQVjhGZ0MwZEF4OTVNNnB6SjN0?=
 =?utf-8?B?d0hRam9BMjZROTJBdUhjazlRbnExckxsMjlUTm11MHp2QnV0MENVUkhqRVd2?=
 =?utf-8?B?M2Q1TTcrNnl3WkhTN1dUWnJmTVIzeGsrYzkxWGdCOHN3dFU2Q2QvS0VKQ1Vt?=
 =?utf-8?B?dTVZVDd4M3BUS0NDYjNtRVRsRWNZZGg2TVNwUFl0aFphUDF6QlFPNUlzWS91?=
 =?utf-8?B?NDZ4bU5MQkE4TVVJTGdLNTMvaE03UGdhTHpZOWZiTmsxdlRBajhZK1NtN2xl?=
 =?utf-8?B?aWRObFI1YnhUOVMzUWZ1cUJsL09NQzh0S2oyRmlIS2VYSDJBSSt3S3VDMFI0?=
 =?utf-8?B?TVhqbTE3VlZXMXFPSG5PbzRrVGFPb0o4bHViVGtaMHNYRTV5SW95ZHhNWTg3?=
 =?utf-8?Q?9N4Iau23xo5vgcs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4680B69C7578E4AA21E7E0B79DD4885@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4854.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0471709a-26ef-48d4-a4a4-08da53a74277
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 16:58:26.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwTKS4I50wlDFRL/k8Fkje2/jhjfm/PKENGTwxO5FrndNMXuYe9eo9kxbEk1dof6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5483
X-Proofpoint-GUID: z472Pjhkqn4cLOf4luwjDnxV4gpfQ3k-
X-Proofpoint-ORIG-GUID: z472Pjhkqn4cLOf4luwjDnxV4gpfQ3k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVHVlLCAyMDIyLTA2LTIxIGF0IDEwOjA3IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBJ
ZiBycV9xb3NfdGhyb3R0bGUoKSBlbmRzIHVwIGJsb2NraW5nLCB0aGVuIHdlIHdpbGwgaGF2ZSBp
bnZhbGlkYXRlZA0KPiBhbmQNCj4gZmx1c2hlZCBvdXIgY3VycmVudCBwbHVnLiBTaW5jZSBibGtf
bXFfZ2V0X2NhY2hlZF9yZXF1ZXN0KCkgaGFzbid0DQo+IHBvcHBlZCB0aGUgY2FjaGVkIHJlcXVl
c3Qgb2ZmIHRoZSBwbHVnIGxpc3QganVzdCB5ZXQsIHdlIGVuZCBob2xkaW5nDQo+IGENCj4gcG9p
bnRlciB0byBhIHJlcXVlc3QgdGhhdCBpcyBubyBsb25nZXIgdmFsaWQuIFRoaXMgaW5zdGEtY3Jh
c2hlcyB3aXRoDQo+IHJxLT5tcV9oY3R4IGJlaW5nIE5VTEwgaW4gdGhlIHZhbGlkaXR5IGNoZWNr
cyBqdXN0IGFmdGVyLg0KPiANCj4gUG9wIHRoZSByZXF1ZXN0IG9mZiB0aGUgY2FjaGVkIGxpc3Qg
YmVmb3JlIGRvaW5nIHJxX3Fvc190aHJvdHRsZSgpIHRvDQo+IGF2b2lkIHVzaW5nIGEgcG90ZW50
aWFsbHkgc3RhbGUgcmVxdWVzdC4NCj4gDQo+IEZpeGVzOiAwYTVhYThkMTYxZDEgKCJibG9jazog
Zml4IGJsa19tcV9hdHRlbXB0X2Jpb19tZXJnZSBhbmQNCj4gcnFfcW9zX3Rocm90dGxlIHByb3Rl
Y3Rpb24iKQ0KPiBSZXBvcnRlZC1ieTogRHlsYW4gWXVkYWtlbiA8ZHlsYW55QGZiLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiANCj4gLS0tDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiBpbmRl
eCAzMzE0NWJhNTJjOTYuLjkzZDlkNjA5ODBmYiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1x
LmMNCj4gKysrIGIvYmxvY2svYmxrLW1xLmMNCj4gQEAgLTI3NjUsMTUgKzI3NjUsMjAgQEAgc3Rh
dGljIGlubGluZSBzdHJ1Y3QgcmVxdWVzdA0KPiAqYmxrX21xX2dldF9jYWNoZWRfcmVxdWVzdChz
dHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gTlVMTDsNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gLcKgwqDCoMKgwqDC
oMKgcnFfcW9zX3Rocm90dGxlKHEsICpiaW8pOw0KPiAtDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
YmxrX21xX2dldF9oY3R4X3R5cGUoKCpiaW8pLT5iaV9vcGYpICE9IHJxLT5tcV9oY3R4LQ0KPiA+
dHlwZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4g
wqDCoMKgwqDCoMKgwqDCoGlmIChvcF9pc19mbHVzaChycS0+Y21kX2ZsYWdzKSAhPSBvcF9pc19m
bHVzaCgoKmJpbyktDQo+ID5iaV9vcGYpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBOVUxMOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBycS0+Y21kX2ZsYWdzID0g
KCpiaW8pLT5iaV9vcGY7DQo+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ICvCoMKgwqDCoMKgwqDCoCAq
IElmIGFueSBxb3MgLT50aHJvdHRsZSgpIGVuZCB1cCBibG9ja2luZywgd2Ugd2lsbCBoYXZlDQo+
IGZsdXNoZWQgdGhlDQo+ICvCoMKgwqDCoMKgwqDCoCAqIHBsdWcgYW5kIGhlbmNlIGtpbGxlZCB0
aGUgY2FjaGVkX3JxIGxpc3QgYXMgd2VsbC4gUG9wIHRoaXMNCj4gZW50cnkNCj4gK8KgwqDCoMKg
wqDCoMKgICogYmVmb3JlIHdlIHRocm90dGxlLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gwqDC
oMKgwqDCoMKgwqDCoHBsdWctPmNhY2hlZF9ycSA9IHJxX2xpc3RfbmV4dChycSk7DQo+ICvCoMKg
wqDCoMKgwqDCoHJxX3Fvc190aHJvdHRsZShxLCAqYmlvKTsNCj4gKw0KPiArwqDCoMKgwqDCoMKg
wqBycS0+Y21kX2ZsYWdzID0gKCpiaW8pLT5iaV9vcGY7DQo+IMKgwqDCoMKgwqDCoMKgwqBJTklU
X0xJU1RfSEVBRCgmcnEtPnF1ZXVlbGlzdCk7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcnE7
DQo+IMKgfQ0KDQpUaGlzIGZpeGVzIHRoZSBwcm9ibGVtcyBJIHdhcyBzZWVpbmcNCg0KVGVzdGVk
LWJ5OiBEeWxhbiBZdWRha2VuIDxkeWxhbnlAZmIuY29tPg0KDQo=
