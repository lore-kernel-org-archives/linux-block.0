Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9214C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774F2086A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 01:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A8XlHiDn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U7YhSzFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBUBaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:30:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26906 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfBUBaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 20:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550712600; x=1582248600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uuXRXjumDCUR3z9pN40Imoj6u8PCppFYYmDcmv4gjHg=;
  b=A8XlHiDn6ylIFMAZ0UKbZ/LycGlq7nRbQpgFRq75qwR9irqTvlRgEa8t
   3ZKkhYsXy1F5zYs5OYIzlMPM1JKCwPNLPEbVqudF2f/CAC/L4VFVlMjEg
   vQZ6eBMAHL7nI0IIV2r6Zp6GnncLIinMhSnuJU8Wm8xXAz13jRAVdel96
   uiO6aldKVN2O2o44gRvVIstnXDwtUOWioCri8Ru73NSgsKiSB/CwbS2wH
   qM8u+tTkij2QJ3kfKpRT10Au89Nrc3i3dA9suEhSP3Aot/7vtGKFwmbhX
   bnxn5hFn03Utz9aB6AeO7ro6vQ/kFYmFRFoqW7VNXMvoONKuznZCohVzk
   A==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="101790849"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 09:29:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuXRXjumDCUR3z9pN40Imoj6u8PCppFYYmDcmv4gjHg=;
 b=U7YhSzFku5DWqodJJLmaYwBpr1ArY/n8jAlLnkkZ+ENwunXhEgtstdvU4Lkeu+CC/w5rH45j4y6CLBEaKE6FHNbKKZpwW6pD5uvHbkqgCK/b9ykgG1o9+L/VikXq3cC3IvLTnfmg09w+SKXYrSn2AiFfrCqTEeDA3MRFzMfNFeU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3968.namprd04.prod.outlook.com (52.135.82.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 01:29:57 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 01:29:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Topic: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Thread-Index: AQHUyMoAEYk0t39XfkCklw1XmMrTmKXpTSS+//+lEgA=
Date:   Thu, 21 Feb 2019 01:29:57 +0000
Message-ID: <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
References: <20190220031122.GA17298@ming.t460p>
 <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <yq1tvgyhxyv.fsf@oracle.com>
In-Reply-To: <yq1tvgyhxyv.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.16.1.190220
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffd07297-575d-4ff4-6b0c-08d6979c16ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3968;
x-ms-traffictypediagnostic: SN6PR04MB3968:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUIzOTY4OzIzOldrZFRMMENjdGh3TmNSQ2NuS2cxNzd0LzZt?=
 =?utf-8?B?RU95RkxjQmRRcTNzcUhFOWNOWlFzQi8zc2J5emxVaTExb1RpVXhpSm1QbW1B?=
 =?utf-8?B?c0p4RlI3V3BBNGV2N1M3b1RuTittL3k0aFBPcDFtdEZHM2tZUkZsUmVLVm1q?=
 =?utf-8?B?NCtNcFU5cmcrLzNrYW01QldFMHlmYm96OUMvQ2IyN0M2RG8wb2tsd3hlQmRP?=
 =?utf-8?B?bFZWRktZYmVSNUZVem5GNnRHU1ZLKzJxRlE4TzBDTEozMk1aMUZvcnBKZkJM?=
 =?utf-8?B?NEk0LzIvS3FTUWpUbzV5VzBjaE81Q2VCR2N4S1NlTFpwWjkvRUo2dVdWTktR?=
 =?utf-8?B?cFYxY0dVMmJKaHR0Z0tkNTZzaXdvcTIrZm96T1lGZmtIQzQrTFdyUnpqR2hY?=
 =?utf-8?B?eXgxbjdPMFpCcGpRQUpBQkdSczdrbFF2TDNMR1lXWDRkTTl4SlRYNUxFKzhm?=
 =?utf-8?B?dU9VUDdkYVhsUXliTWNJV1N5VS9OblU1UzhTUmlkR0VBRkxzS2o5MVlWNTYz?=
 =?utf-8?B?d1pUeUZFU1VMcFB4NHVaQ1VGbVRqR1V6VGszb3ZWcGhQQmhUZEdlRXY0ZVZV?=
 =?utf-8?B?UXpvdDdzSTRGaVQ1c0xOdm52N0RPTlMwdW5qc1BZVytsOXlUZFZlT3lSSWZz?=
 =?utf-8?B?aWJtT2hkTkZWcDdWSnFBbVlxRmlQRk45WXF3b1U0S29JcW1nTlAzYjBVNGdj?=
 =?utf-8?B?OWF4d2Z6MzhaTHgvb2xsNDVHb1RzSVVIZjE5MjBqZUJCVHJiaWorM2hBM1My?=
 =?utf-8?B?dERldmhpZFh4YjJ4alhnQnFHS3d5TUhsUWRrZ1ZGZm5rbEMzblZRQUxCWE1i?=
 =?utf-8?B?TFZ1VHM2SUlQZldQbHE1c2kxNm1aN2dhUmREQjFDR1BQYlNWbGZ3S0hITHk1?=
 =?utf-8?B?UW00ajFmVDBBclJoYnFxWlJMcVIwYS9BVXNiZnYvdmdFUGdSZXJEUm1ZeUo5?=
 =?utf-8?B?KzVLcEoxaEJjQlZxcUhLZHI1MzE0emMyWWZSSkVacDRRWm9IS2wwMnFEdWgy?=
 =?utf-8?B?OFE2RVcvVnAzM1NqbFNhV2toUHpxNURVNHFLM3pDTjNzOUlvY0U2MjA4ZzlK?=
 =?utf-8?B?MGYwQmFLZ3F0U284RTg1VFNnMUx5VnVHOEhzbHhDMEd4NXJxb21RRU5ySjZW?=
 =?utf-8?B?UzFaUlE1NzE1cVZubFRpR0J2eVRWSS9ReWlodlVMUTIzZDdkc0tQWVluQzN6?=
 =?utf-8?B?VDV4cHV4ZXZLN0VJL09KdW5hK085WTJpb1ZWemN4blpnZUM4dXhUeXZFV3hZ?=
 =?utf-8?B?ZHJnT2YrM0tibUlzQ1ZOSUNDcDFodmJha1dBSVdtbkxmWEZlL2tNTFRKWkdk?=
 =?utf-8?B?N3hUUkIwUUJXSVBUcmhDWCtuRzNsaE1Gazd4aUhyREdWVnlIL01RZkpkQ1Ux?=
 =?utf-8?B?enVoYlJ0dzBPMHc1NEVKa2djTWNjdXpTS0YwbWFSVGRWd3FBM1d4Z0dDV2o2?=
 =?utf-8?B?Rmw0VlppSE1zL0Z1S2cyUW4wMTl4S0g0VmNRZzdnTkI4OTJqZ0tvOHl0eVdu?=
 =?utf-8?B?MmUwMkJ1a3FqeTlQMVBoWVJ4cGhTMDJuenJKS2V3YWU5TWNBWWNZT0g0Mnl5?=
 =?utf-8?B?dmJTZHVmWk5VVmlpb2YwYzdyVEY2Q2F0bmhibERjbEs3b0p1VG16YUJ5TkhD?=
 =?utf-8?B?VHVCRFQwYjhDNVFNencxSjE3d0gxNUlCRHpNQ3pWVUFaVmJZNUZyYlJxSFpr?=
 =?utf-8?B?UmFVcGJtaHFRZU00eEwzbmNsOFo0bFBNWWlJQ01GV0IyQ29GbUNCaTVVaU02?=
 =?utf-8?B?VHEyMCtkY3M5VVl6TnBxclJIenh1Nm1FVGg0QVVxQ2tmcmt0UUQzQ2dSNmhE?=
 =?utf-8?Q?ETlagfUGb+IBJ?=
x-microsoft-antispam-prvs: <SN6PR04MB3968073913B8839DBF8A39E7867E0@SN6PR04MB3968.namprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(6916009)(82746002)(6116002)(316002)(83716004)(7736002)(72206003)(8936002)(3846002)(36756003)(71200400001)(6436002)(81156014)(102836004)(81166006)(68736007)(99286004)(86362001)(58126008)(5660300002)(33656002)(71190400001)(6506007)(6512007)(53546011)(54906003)(8676002)(478600001)(229853002)(76176011)(476003)(66066001)(2906002)(486006)(256004)(2616005)(446003)(11346002)(186003)(14444005)(14454004)(53936002)(4326008)(6486002)(25786009)(305945005)(97736004)(106356001)(93886005)(6246003)(26005)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3968;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nq+ZfbhCsuQHX4Z4ZRY5VBJqNHwyVGbFrXT6K/BSnKqHCwL003VnLreWA0x7+GO3MqUDIdo3GlFLfd/4vu11XCLzjh9viXF0nhVnLsWtIJOoxGhoB+tuBSRGFz1lPioK5DDozYM27+Yd12KjPVaY79kd5UHgkxjmCXoNDDU8JBtcpsvGufr90WAcE5/ibbfmm/3Hs2J0fS1xmecr5aEotcdQRgMnW7zfUocqvtdFpj9TOeaaAL7LxUuvM3B/IZU9IxLE377bH3gfkK5TTDRdiM81NPk/GR+L3TSuYjV0B4YHwWt68b4zwiZpyP+2uVCwRxDWRATRC0pBGFXQ8xQjHxCmR56uM9nGGpdQ0GBgkGeDlMWIBY3DCPtYldrkU3QxihS4msHT5k9E7WUV+wLpT1pgl1Ie0yYJ+T7WNfscOeQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5A2FD2070BCEA458404EB7ED5920B74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd07297-575d-4ff4-6b0c-08d6979c16ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 01:29:57.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3968
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgTWFydGluLA0KDQpJIGRvbid0IG1pbmQgZ29pbmcgdGhvdWdoIHRoYXQgcm91dGUsIGhlcmUg
YXJlIHNvbWUgcG9pbnRzIGFib3V0DQpiZW5lZml0cyBvZiBub3QgdXNpbmcgUkVRX1NQRUNJQUxf
UEFZTE9BRCBmb3Igd3JpdGUtemVyb2VzIDotDQoNCjEuIFdlIGFyZSB1c2luZyBSUUZfU1BFQ0lB
TF9QQVlMT0FEIGZvciBvbmx5IGRpc2NhcmQgY29tbWFuZHMgYW5kIG5vdCBmb3INCiAgICAgd3Jp
dGUtemVyb2VzIGJlY2F1c2UgaXQgZG9lcyBub3QgaGF2ZSBhbnkgcGF5bG9hZC4gVXNpbmcgdGhp
cyBpbiB0aGUgY29kZSB3aWxsDQogICAgIHRyaWdnZXIgbW9yZSBjb2RlIGNoYW5nZXMgdG8gaGFu
ZGxlIGluIHRoZSBjb21wbGV0aW9uIHBhdGguDQoNCjIuIFJpZ2h0IG5vdywgYmxrX3JxX25yX3Bo
eXNfc2VnbWVudHMoKSBpcyB1c2VkIGluOi0NCiAgICBudm1lL2hvc3QvcGNpLmMNCiAgICBudm1l
L3RhcmdldC9sb29wLmMNCg0KICAgIEluIG9yZGVyIHRvIGtlZXAgdGhlIGNvZGUgY29uc2lzdGVu
dCwgSSB0aGluayB3ZSBzaG91bGQgdXNlIHRoZSBzYW1lIGZ1bmN0aW9uDQogICAgY2FsbCBldmVy
eXdoZXJlIGluIHRoZSBudm1lIGNvZGUgYmFzZTotDQogICAgbnZtZS9ob3N0L3JkYW0uYyA6IG52
bWVfcmRtYV9tYXBfZGF0YSgpIGZvciB0aGUgZmlyc3QgY2hlY2suDQogICAgbnZtZS9ob3N0L2Zj
LmMgOiBudm1lX2ZjX3F1ZXVlX3JxKCkuDQoNCiAzLiBBbHNvIGJsa19ycV9ucl9waHlzX3NlZ21l
bnRzKCkgdGFrZXMgUlFGX1NQRUNJQUxfUEFZTE9BRCBpbnRvIGFjY291bnQgc28NCiAgICAgbm8g
bW9yZSBjaGFuZ2VzIHJlcXVpcmVkIGZvciBkaXNjYXJkIGFuZCB3cml0ZS16ZXJvZXMgY2FzZXMu
DQoNClJlZ2FyZHMsDQotQ2hhaXRhbnlhDQoNCk9uIDIvMjAvMTksIDI6NTUgUE0sICJNYXJ0aW4g
Sy4gUGV0ZXJzZW4iIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQoNCiAgICAN
CiAgICBDaGFpdGFueWEsDQogICAgDQogICAgPiAtCWlmICghYmxrX3JxX3BheWxvYWRfYnl0ZXMo
cnEpKQ0KICAgID4gKwlpZiAoIWJsa19ycV9ucl9waHlzX3NlZ21lbnRzKHJxKSkNCiAgICANCiAg
ICBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gc2V0IFJRRl9TUEVDSUFMX1BBWUxPQUQgYW5kIGZy
aWVuZHMgaW4NCiAgICBudm1lX3NldHVwX3dyaXRlX3plcm9lcygpIGxpa2UgaXQncyBkb25lIGZv
ciBkaXNjYXJkPw0KICAgIA0KICAgIC0tIA0KICAgIE1hcnRpbiBLLiBQZXRlcnNlbglPcmFjbGUg
TGludXggRW5naW5lZXJpbmcNCiAgICANCg0K
