Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D73C433E9
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE462074F
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhA0IMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:12:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49760 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhA0IDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 03:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611734630; x=1643270630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9lwInD6Qg9s8edOSYImdLJNpUEMyv9YPfamIEXYvIhc=;
  b=giJB6vkJmA8tIuj24i1vx+V4PP8Rw/CcNt/uS7H4qk/M7SbBDcYoXXQ0
   6KyZKUl/LXoX4Paf0+JOYoTnkTjh9/eREPc84iLyT2A3pjbFrIEYyX4f8
   wrj8zkhPtN1mmQ+AkJdSnn8MdOrnk/53tQlyQkM6tsX4nzt+RGWg5F0gb
   E85LsfZzKEfIxAdkFFjNyy8d8jtidEmJTaLkJK6j0UXUFsu1q9tZsu6LU
   AzDMYdNvRjNSNF5YxgEn+GAy1nlSO7xJN/2r+kQVxCs6pGGGcn9eFC0X7
   pmeG6oo1nK8q+CkUA03R61bGBgyLmZFQoMLt4MF1fBICQbjcnAX4OO7Z9
   A==;
IronPort-SDR: f3/Wn6sVBL/T9AbdZKos8GRrgyHnB56eQg2KcXbFx3HJbYSI90b4arTOyfHCVjqVretvTsIkNj
 m05P+4GoBr0BmT78ZMxXAsYVb/DtOfH3SAK5ydKmpt2dRkSfhuQF2z/IPsOsg3BJXabMRduZp8
 5hmiUoWecsc40fmy+qfNZCNIqaD9u1/JKU95QnOCcYOu2Fcp6fUaYnBd/1luJgTVs4Zttnrm6j
 Vk2GGfm1FPcwhu70fQxA87kER6tpYvDspmppaJ4P3lcoP/3b4SKHt1TNAJNFVCOxCTqQZ52std
 lTk=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="268796580"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 15:58:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqoMLf39WOeyYy0fPyxJLxbL2XbBTSImrGVWpdOJ+4o8jF9UaEywVH9SZtZwZOSjCzOJ/LTXwGY7jW1NcAT6CxYC9g1rpf7JgEB9StSj7LSSuVzcmgm2Ypk5tdyTJ6dJL3i8ZkAu6BoAIHh819kXQpYeOYNoFLJ1WpvVx/eO9Uo3tnFlyGfr5n7uS5IXO/8SB58gSFApbK/H1Hn6AnaB4MNmSui1xWjgfIg4wuvQ0S96LfqTNEOvPqEZykQwHYuDysSULhz1fa62AcwyM94g+2/n/97tVw3UPCkXdGBobns4W46rbEBsC9XVaQYfJcuVT2WfIpV2M41Z09Kq2/BDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lwInD6Qg9s8edOSYImdLJNpUEMyv9YPfamIEXYvIhc=;
 b=aRrMNQ6hESCpduYRuz3mNfOMgoHtV6Y6KkYyz1olEy/XRqypfvCmwu6+eR5zRN0mJ3h4UgpC9NTamujDLIa8bfX+fEmX6OZA+FGLOBLbhgav4f4rFIqLIxa6y2WL4xz83GjOsFZJGpnWwJFn+Ffy1wsHoZ4gTwdA9I/ONSQG+jqeFVDu59M47K//+ava8iiYbeZvPZSXBIWNJ9jWY1NxFO8seBJBEfTxlX+RXhTwe+DYtGRcHCtvCj25oR4Jl1lnL9qz/7xJXLTdn3jPJUMXNCSWQUoYECDg7cNfJX0zKvhBoRx6nX9Bf6uV0RsGNTpVZkNSCMaCdEGdbQXGOAKjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lwInD6Qg9s8edOSYImdLJNpUEMyv9YPfamIEXYvIhc=;
 b=WSHwYB176+tIo3tJ+NR9HCzNCjYN813onZTmAQxPq//vMb2YdHQKScA1z3T425hjKfGu9W4sj2rdrFRo6D+2Riev4oweIRtOqRTM5x3OaMkV9pOr6QIxcsTf8cFfB/gapUvJK6N3TYd2/LNu7eKgralJdouwFjuZHKB4qjE2MV8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 07:58:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Wed, 27 Jan 2021
 07:58:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Thread-Topic: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Thread-Index: AQHW9DCX9RtNxF9J2Ui6R7ku9PxAZKo7HAEr
Date:   Wed, 27 Jan 2021 07:58:26 +0000
Message-ID: <3228074F-0E0A-4AF1-A950-C978F6FB3908@wdc.com>
References: <20210126200433.2911982-1-helgaas@kernel.org>
 <20210126200433.2911982-2-helgaas@kernel.org>,<BYAPR04MB496569EC5AB6FB3A8A2D562786BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496569EC5AB6FB3A8A2D562786BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:5f6:d68b:d1ea:7c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29a8c46e-b4d3-427b-9d96-08d8c29953e4
x-ms-traffictypediagnostic: BYAPR04MB4968:
x-microsoft-antispam-prvs: <BYAPR04MB49681FB428CCC40BEE7FF62C86BB9@BYAPR04MB4968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n81hEDRtgU2bGxjOjQj44UTWrX65IkgvWqQ/GB2qmPb0XW34OVRHKreHimAeRGJtJhg7rTeMzDik71jV8NHGXzzRJE6VfFsXG8b7UJN/hn5kBERl+3fRMluXmpJWjBIFPl1Zz+ezOWLftbyVOs9JZRPqE8exWTBxj73+BzKMh5CWIUL3tgoSqd8p6PDy5sM5TuyN1Cq85/9mXvgxLlXMewfEn8InOz4LNMTUSUBgBe1oS4ZqwsD5PgRj9UXBfMUoKLE2u1/Xo70oelVNJecrRffEE9MkY1WPT98ONmvYxMqADgcQGWxrV3jz34NE7U5eRDCU1iKt1ZjPcHlR0jJKZ8ndEUaMVds4acW/JFCNBXgER28C6q4yohfC3MHlDiWEQAOy0NQAQ7yLwbdl+obsRMWfvn09MTlT0JZuHhO+5mArUpEYSUfoeZUF+GN91PU5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(53546011)(2906002)(66476007)(33656002)(83380400001)(71200400001)(4326008)(66946007)(8676002)(186003)(110136005)(5660300002)(36756003)(86362001)(64756008)(316002)(76116006)(54906003)(2616005)(478600001)(6512007)(66446008)(4744005)(6506007)(66556008)(8936002)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVVwc3ZqWVlUK2s5MVYwSk1ib3J1QzdmZDV6dlF2aDlIWTQ0MFpmcjFkTWVw?=
 =?utf-8?B?NTRPbWpiQXNkampYMEozQ0FBaTZldWFQSFVLeUpQWDNQeW5pcTNpcUFxWDBV?=
 =?utf-8?B?bW1IMGZjOVhKRHpIdHNUQXRlL25RQjNOeXNscUxrUUVXQ3NWS1VJb21jTmY3?=
 =?utf-8?B?Ny82ZzA2QUY3V09xMFROazdsVUFTWjhkakNwQWZkR3BmNkxzSHhVR2JnQUJB?=
 =?utf-8?B?dkFJQ3dVaTVQT2tSM3RqVXlQcWhDSWYyS3Z0UU00SVRnOW5jQ3pzT0k2aFNi?=
 =?utf-8?B?eG5UVUgzTEdnNmZrZ082SGttb1hNNGRLVXJmaXhERkxxc2lDWTYzYXNvYks1?=
 =?utf-8?B?c1g5RmN0U3EzazRhNWlPQWdQU3dRY1hRb2FRSUpmSDJraG52Yk14RVNGOXBl?=
 =?utf-8?B?ODVLelBBKzRpSDYrbW96VFhpTm91ekErNnl2VHNlYXkzVzdXWlRSRWN3L1pJ?=
 =?utf-8?B?RjRXSWZlVkplQ2hHUlNJMTRqSXdOamVqbUl3WEFtekpFWjFBTlY0SktTYVky?=
 =?utf-8?B?Mm5iUk1IVmpuMnAxMUV5bGRIM0RuTytERzNvVVdvRnNyME1DejYzaFAwNkFO?=
 =?utf-8?B?YVJMV204aU9mRWpKNnRKZmR1Q3hYcitldmJTODFQVnhPZTVzSHYxWlhwR3Bz?=
 =?utf-8?B?ZE5icDdURkVybm9tOUpiNWFLNitPSnhOaVVMQTZjUmNsc3gxaTNCekc5RnNR?=
 =?utf-8?B?eXZzN2xVbEl1Vy90WDRHdlYxUjV2V3hTNVV1S2V1dER6SUg2blgzeS9Lc2c4?=
 =?utf-8?B?QXB1blF2TDVWY1o4WmpaTyt3aEYybkFiUUxNSUcxa1M4WHF0WDk4Ti9IKzAy?=
 =?utf-8?B?WnU0dkErV0ZTUVdBZG5jM3VaQ2Vac2l6WHJIclIybExQSm5WQ0hLU1NLcjBx?=
 =?utf-8?B?bFNqVFJnODZRU3JnSEcrS2xHdlpyVnlFc3dFQUJ0bnBRdjJvNG0wSFpuRGgy?=
 =?utf-8?B?cGg1Y3d5MWZDcXNXalhRQ2tUWHJ6SGNONnU4Ym9HWHBVVnJxeFNkSk1qcW5z?=
 =?utf-8?B?Q1ZPT0lta0w4QXcvQWJ0Q1VJeHNXTi9ScHE2MXcrbG9mcytSSmZWUGJJU1NU?=
 =?utf-8?B?aUp5elJUaHV2Um94dVM0aWlQTlR6YUd3SG8wck9QcDBDUVJDcHBNamMzajVQ?=
 =?utf-8?B?WkxteURlUnVSQnZhd0ROOS9XRjVQOU5DZUoydDBzWUxYMm1yNHhjOWlWV1Ra?=
 =?utf-8?B?KzJkWGErdUNaQ2JtTHA3RkIrbXBmZ0ZreXpraXBnblJUWmM1eldXR2FkYVlo?=
 =?utf-8?B?cnFDMGVENUU0ZWFlRUx3czU1OTVkVUpRVG12RGkwM0Zyc3g3aUNBRkZzUVQ4?=
 =?utf-8?B?WDRDTWRhcEpyYkhEOW1PamF5NFJXZ2xDSnl3SHpGZGZ4UlkzcFI0YmNxOFBz?=
 =?utf-8?B?alNjOFN6bFpCaGREc0dNNVdVdWs1bXJBMnd1VmVTZGgyTlVpeEMxQ1BZNmtE?=
 =?utf-8?B?VG5qMkdhSXlDdmtTOEc1cFozbDIzODJKZUh1Und6REdjemF0S2VPMWY5M2s2?=
 =?utf-8?Q?FsCKF2HFeV+c3oGhuZiLJujjkmd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a8c46e-b4d3-427b-9d96-08d8c29953e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 07:58:26.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U1G1Cm6A+OBuVKibn3U/JRv16IWR97j+gzewMBwaavtenLyjXsWkVEUWq/mkEj8WSMALeSXbWWgsbqIaALLB/3L/tPCw5ZzHDCPq9vAOz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4968
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gSmFuIDI2LCAyMDIxLCBhdCAxMTo0MSBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIDxD
aGFpdGFueWEuS3Vsa2FybmlAd2RjLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiAxLzI2LzIxIDE0
OjE0LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT4NCj4+IA0KPj4gVXNlIFBDSSAjZGVmaW5lcyBmb3IgUENJZSBEZXZpY2Ug
Q29udHJvbCByZWdpc3RlciB2YWx1ZXMgaW5zdGVhZCBvZg0KPj4gaGFyZC1jb2RpbmcgYml0IHBv
c2l0aW9ucy4gIE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiANCj4gSSd2ZSB2
ZXJpZmllZCB0aGUgdmFsdWVzIHByZXNlbnQgaW4gdGhlIGluY2x1ZGUvdWFwaS9saW51eC9wY2lf
cmVncy5oDQo+IG1hdGNoZXMgb3BlbiBjb2RlZCBiaXQgc2hpZnQgdmFsdWVzLiBMR1RNLg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdk
Yy5jb20+DQo+IA0KU29tZXRoaW5nIGlzIHNlcmlvdXNseSB3cm9uZy4gSSBzZW50IG91dCB0aGlz
IGluIHRoZSBtb3JuaW5nIGFuZCBpdCBnb3QgZGVsaXZlcmVkIHJpZ2h0IG5vdy4gDQo+IA0K
