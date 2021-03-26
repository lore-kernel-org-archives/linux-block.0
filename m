Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F66C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A461A3F
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhCZJhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:37:12 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:39595
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230006AbhCZJgq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 05:36:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx32GGRO8fl+0IVhfsPW/yMCaPcRElVX+wBW3fwrrU3Oob61653cd3xtnHMgT68D7nt2MhpwcRORDsHSG9zn5AB97t4TGt1p02/I20gk7bj55Ha7nN8hXCdZahQ8E8sszn3I5bFn7RE+IUDOYKJmrFbu5+dI517XJcOIBXMe76fjpEnShwebWSIgLlajVyBJXAVJgQFqp6YcMexpPZAYheJmFCjTWdEvARr+Fl8+hodwryRXtE1lRJG7dGUGeFCKcaksG4XWTpaQqL2DRXphtvM0AJE7F1sB3+acOmPD4Hj61HuCpC0KVHNSTodWJV40gKQYLzqTFKrd5Q8hhBSr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1b3+JeKCkjMm8UWyvgiYPVPUCp07SJsIGl80DOSE3Y=;
 b=DMruGSOedL1dKbVpEoK6T/alucOmV5gFqUDhfmXdGAjd8blEDRpkEWvQJanWBUqaFRmyZtHGry5W14WJj7FZMQ2OI09oDAAW+tr7Tk4JgCzPIJg8XXlcvhRoYBuzoIEJnrRG9G9gh0xG+j45jXEpKQomDlNDUsoyHZEMtSDek51fJ08mHUNMl3N8FM4am2HuNYZ+UeCoBPzatHTh+DrNim1RybQyAgmiWrQ/tIFwz68+kvlGSYz4O5OMMot9AbSdqOVf6kiiSp+kaxeDbxAEnpsVNosLOyBkK2QV08IvX2ivMwisHfb615GDvpo73syEsq0Bsdq9RyOQj1m0N9UhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1b3+JeKCkjMm8UWyvgiYPVPUCp07SJsIGl80DOSE3Y=;
 b=pSTadXkjuWDKQxhmCDNV+Ala6DaOru1C4Xn2mCU4IF2rNbZOwkn8/iOu66ClmVbqvNfH+k1Zjfh2vCe23xN1/ruPMNNAucZTw7UVUYoVg7i+T4FioJ8uSFpPsceHX0tSlVs7ex7TiyjYtPW69pdtRd2EpSlxc2WJ/ZZRsAUMn8g=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1691.namprd11.prod.outlook.com (2603:10b6:3:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 09:36:44 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 09:36:44 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBsb29wOiBGaXggdXNlIG9mIHVuc2FmZSBsby0+bG9f?=
 =?gb2312?Q?mutex_locks?=
Thread-Topic: [PATCH] loop: Fix use of unsafe lo->lo_mutex locks
Thread-Index: AQHXIVhIOFjKQavTx0Ciyxtr6hqn7KqUrYiAgAFR1PY=
Date:   Fri, 26 Mar 2021 09:36:44 +0000
Message-ID: <DM6PR11MB4202C12F805234630A5F6BDEFF619@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210325092203.10251-1-qiang.zhang@windriver.com>,<CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
In-Reply-To: <CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7637a9-bc46-435d-faec-08d8f03aab59
x-ms-traffictypediagnostic: DM5PR11MB1691:
x-microsoft-antispam-prvs: <DM5PR11MB16917639E232D735FCB3D543FF619@DM5PR11MB1691.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4tFnqJp5PKQaDzhl6ZpXFjfs6eT8zN/wfXGITxWdQtn/pTQeILtVL0HfOD33uBFsMHb/XbbrYIm8o1OzZGQKY+PwvqzZo83R99sagB45eEbBaR9xqb/UZvqeI8LYq40GXknGG54f7vBGhTMFjpFsuxxtON5TKxmtM/S3Q4vv0jDUT+Y6cnw1itvOqNd0Xl+LSrvW/adAcoFNh9YJK3yBGzVabJEg6Yqnfy4ep51742Fxu0qo4FXzvNQvvG2hct1pZTMNHMjey36huTgKVt6xGd/ge5mZ7PLJeGje/J5cNwi+uGxndFIlisGHcFJAs+dRgkTTFkvhy6TGTHngadM0Ql8Zwv4J+PXcWEu7So1+tlRIhQD6HcnLuUZThiXJJ7Ov3VnloX97zUx+If1XImtirDjQ6WJ8fJA2SBh3y01vVE2GVzoMXBHxIuLnEMMJ0Exu8eHBN3YW+hkQ03IgW4NyE35Enu0208mgn43E2q5OA5rF/6jEYkHGKi6LEWAYG59uWJjbRv7AnnvHMzDXjzPUXqTLKWcv07fJTxQb0TklTZjIudWIpdFuhIRMjD6NozGiPXgOfmIgfIuWM7QjuVFYQy6p69eCArV4gUT8Oi2Ud3uvpPHwi3XbsD14GOTdPxvr2V34UWFkGW8kE7H6FL/4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(76116006)(66476007)(52536014)(64756008)(2906002)(6916009)(33656002)(86362001)(316002)(66446008)(54906003)(6506007)(91956017)(55016002)(4326008)(5660300002)(66946007)(9686003)(71200400001)(478600001)(7696005)(26005)(186003)(66556008)(83380400001)(224303003)(8936002)(38100700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YmdxRWljdnA3VWtobHkrRWNTakZ1RU5MZHI1eitGeHg1cnRIREZHTExVYXlq?=
 =?gb2312?B?N0YvQ2pUTGtzdFIvSGFJblFWU0FES2NlMmpWQVVuNUwzYkNvYzhmeVRxMUNi?=
 =?gb2312?B?d1NYME5VeTFZUHhPQS9JUjc1cDNETDI4TW5FS1gxNE9SZ0lLSlgyLzluR3Qv?=
 =?gb2312?B?L0grNEVMUWhncVdaUFVVVEJXeDZKdFFKZ1RCOTY2RVk4RE8rbkZBYklvOXZ4?=
 =?gb2312?B?eDZnQkZDeUdIYyt6TGp4cGd0ZGl2WmFzeThDOVl4NTJNTTN6R2NRRHRxN2dR?=
 =?gb2312?B?ZXR2ZmtlMWM2WUUrRzU2WUxkd3B5UHlOUllXcm1hRlNhd0ZMYWVCSzdvYXpU?=
 =?gb2312?B?ZkdnR2M1TjU5b1RTbU9ER0xKRE4xM09tUkhQTFdRVW1VcUZsTzQvMGFYZzZh?=
 =?gb2312?B?SlhrdTN2SmIrOG9JUTNFZTM0a2ZwSS84eVZiN3JKa3FVTmcvZmc5RmduL1pv?=
 =?gb2312?B?UjdHb3JrTHB5dnZqRnVKcE8xb21Pd2ZPeGIyR2RKRHVsRjFPR2VySDNzblla?=
 =?gb2312?B?TW94aG12SlVhMHBoYURYYW1Dd0lXb0NoZWtLOU1OY2hmbHYxdmMvVVhiayth?=
 =?gb2312?B?d0JZVzY1YzhoWVBuRFprc0FhZEQ4RmVZaE9zT0dMUWUzSzU3VzZIVGZueVk4?=
 =?gb2312?B?NTJaTDZUZ2ZPaklyQXM1RlpXaTEvL201aUhEREVQRGFUR0VDRHdoWHlVaVpj?=
 =?gb2312?B?WjY5U0Y0Q1BVclR6VGhtNDVjMm82MEZzcEZDL0txZ2k2dENWNHR5K0RuaHpK?=
 =?gb2312?B?eXJLYlY2VHAybitRYktzK0JFSHRzdE1QMDRja3A2OFUxdWE2cCtmaU1HcXdB?=
 =?gb2312?B?VWNwUkhKVStWVHZMVVpNWUpCcDc2bmI0cWliTkJrekp3RHNPY0p3WHRkdGt2?=
 =?gb2312?B?TGtrV05LazgySEkrWExmLytkUEdpbm9PMlc2eWRrenUxS01mZ0d0dDNGQmNQ?=
 =?gb2312?B?UXFWckV2SXAveG81RHVGbjNhcWVvclpJZjFGWDNzemIxcE5WVm9maStRUWhy?=
 =?gb2312?B?ZyswcHFtV1RBWjRzS0FyY2ZibXVNS3ptT210b0Jtck5VckZ0R2FhYmlMV210?=
 =?gb2312?B?N1JVZnBtNzhPcDRtNzV0YzJBSVQ5NWptSzhUT3JFMUs1ZFRGZjBidS9rREhO?=
 =?gb2312?B?amlhcHVOWDRKY0ZIbExIcjMxU1Y3enhQUUJ2TkJqdDE2Qk5iYjJoUVNhRStv?=
 =?gb2312?B?VkY0OW91aDBlWG5ENDNzSTVFY3Z4OHZGS3BEV1RiMjdJUCtMU1Z3bVp4Sm1M?=
 =?gb2312?B?UWVsSEZwdk5SN0REVm9XUHhYdHI1OGFZS01Yc2JmTG1qTFY3bGJTTm5Ha2pT?=
 =?gb2312?B?UVJ3SjJTZ0Y5eDluKzNPbVVwUHp1U2lLWjQwOFVKemkzd2tOR2dhVWdzbWN0?=
 =?gb2312?B?WktJZTNEZjNkdFpJY1Y3Q2FHZElYOEcrOHRCamJFNkMydFI3L1VEYW81MWFo?=
 =?gb2312?B?c2EveTZWdWk1U2VuanZwSnNaZERkZFp2WVBuR2Z2SzRTK2xjbTNDRmRtT2s0?=
 =?gb2312?B?Rjl0Q0NJZVcwb2hLWnF2VEg0U0lMZkxjay9pS3RlRHlaUlA3UXE4WWxuQ3RU?=
 =?gb2312?B?NGhaOFJBdC95eTB0SXdGOVNXWUdEcm5PU1dKa3JickMyelRJcXF4Rmk2Uzln?=
 =?gb2312?B?U2RmbUIrNUg1bkdNd2V1cS9DSXJwN1kya25pT3VoZGpYKzliSTN5Z2ZiWjd5?=
 =?gb2312?B?dS9NaVR3MVloTHJ6VXIzaC9Cenh0blFnZEoyMVhhTlBUVzk0Tm1wNm8wWmNu?=
 =?gb2312?Q?HojX4+4Amzuod6oh6k=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7637a9-bc46-435d-faec-08d8f03aab59
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 09:36:44.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frRye2JTmoD4COrO0rB8UkKPxJVV4dxd8zWAtQHaqIMzX2FIoeQmCJ7PcxEfpfD5xhZvFT4FkwWhGAH7AgPMBsSMFaf3t2JjjxgdJt84Wj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1691
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF2ZWwg
VGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNvbGVlbi5jb20+Creiy83KsbzkOiAyMDIxxOoz1MIy
NcjVIDIxOjA5CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IEplbnMgQXhib2U7IGxpbnV4LWJs
b2NrQHZnZXIua2VybmVsLm9yZzsgTEtNTArW98ziOiBSZTogW1BBVENIXSBsb29wOiBGaXggdXNl
IG9mIHVuc2FmZSBsby0+bG9fbXV0ZXggbG9ja3MKCltQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwg
aXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10KCj5IaSBRaWFuZywKPgo+VGhhbmsg
eW91IGZvciByb290IGNhdXNpbmcgdGhpcyBpc3N1ZS4gRGlkIHlvdSBlbmNvdW50ZXIgdGhpcyBp
c3N1ZSA+b3IKPmZvdW5kIGJ5IGluc3BlY3Rpb24/Cj4KPkkgd291bGQgY2hhbmdlIHRoZSB0aXRs
ZSB0byB3aGF0IGFjdHVhbGx5IGJlaW5nIGNoYW5nZWQsIHNvbWV0aGluZyA+bGlrZToKPgo+bG9v
cDogY2FsbCBfX2xvb3BfY2xyX2ZkKCkgd2l0aCBsb19tdXRleCBsb2NrZWQgdG8gYXZvaWQgYXV0
b2NsZWFyID5yYWNlCj4KPgo+ICAgLi4uLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAga2ZyZWUobG8pCj4gICAgICAgIFVBRgo+Cj4gV2hlbiBkaWZmZXJlbnQgdGFza3Mg
b24gdHdvIENQVXMgcGVyZm9ybSB0aGUgYWJvdmUgb3BlcmF0aW9ucyBvbiB0aGUgc2FtZQo+IGxv
IGRldmljZSwgVUFGIG1heSBvY2N1ci4KPgo+UGxlYXNlIGFsc28gZXhwbGFpbiB0aGUgZml4Ogo+
Cj5EbyBub3QgZHJvcCBsby0+bG9fbXV0ZXggYmVmb3JlIGNhbGxpbmcgX19sb29wX2Nscl9mZCgp
LCBzbyByZWZjbnQgPmFuZAo+TE9fRkxBR1NfQVVUT0NMRUFSIGNoZWNrIGluIGxvX3JlbGVhc2Ug
c3RheSBpbiBzeW5jLgoKIFNvcnJ5IFBhc2hhLCBwbGVhc2UgSWdub3JlIEkgc2VudCB2MiBwYXRj
aC4KIAogSW4gbG9fcmVsZWFzZSgpICwgd2Ugc2V0IGxvLT5sb19zdGF0ZSA9IExvX3J1bmRvd24K
IEluIGxvb3BfY29udHJvbF9pb2N0bCgpLCBMT09QX0NUTF9SRU1PVkU6ICAgaWYgKGxvLT5sb19z
dGF0ZSAhPSAgTG9fdW5ib3VuZCkgaXMgdHJ1ZSAgd2lsbCByZXR1cm4sIG5vdCBjYWxsIGxvb3Bf
cmVtb3ZlKCkuCiAKIEknbSBzb3JyeSB0byBtaXNsZWFkIHlvdS4KCiBUaGFua3MKUWlhbmcKIAoK
Pgo+IEZpeGVzOiA2Y2M4ZTc0MzA4MDEgKCJsb29wOiBzY2FsZSBsb29wIGRldmljZSBieSBpbnRy
b2R1Y2luZyBwZXIgZGV2aWNlIGxvY2siKQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcu
emhhbmdAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ibG9jay9sb29wLmMgfCAxMSAr
KysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbG9vcC5jIGIvZHJpdmVycy9ibG9j
ay9sb29wLmMKPiBpbmRleCBkNThkNjhmM2M3Y2QuLjU3MTJmMTY5OGE2NiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2Jsb2NrL2xvb3AuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svbG9vcC5jCj4gQEAg
LTEyMDEsNyArMTIwMSw2IEBAIHN0YXRpYyBpbnQgX19sb29wX2Nscl9mZChzdHJ1Y3QgbG9vcF9k
ZXZpY2UgKmxvLCBib29sIHJlbGVhc2UpCj4gICAgICAgICBib29sIHBhcnRzY2FuID0gZmFsc2U7
Cj4gICAgICAgICBpbnQgbG9fbnVtYmVyOwo+Cj4gLSAgICAgICBtdXRleF9sb2NrKCZsby0+bG9f
bXV0ZXgpOwo+ICAgICAgICAgaWYgKFdBUk5fT05fT05DRShsby0+bG9fc3RhdGUgIT0gTG9fcnVu
ZG93bikpIHsKPiAgICAgICAgICAgICAgICAgZXJyID0gLUVOWElPOwo+ICAgICAgICAgICAgICAg
ICBnb3RvIG91dF91bmxvY2s7Cj4gQEAgLTEyNTcsNyArMTI1Niw2IEBAIHN0YXRpYyBpbnQgX19s
b29wX2Nscl9mZChzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvLCBib29sIHJlbGVhc2UpCj4gICAgICAg
ICBsb19udW1iZXIgPSBsby0+bG9fbnVtYmVyOwo+ICAgICAgICAgbG9vcF91bnByZXBhcmVfcXVl
dWUobG8pOwo+ICBvdXRfdW5sb2NrOgo+IC0gICAgICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0
ZXgpOwo+ICAgICAgICAgaWYgKHBhcnRzY2FuKSB7Cj4gICAgICAgICAgICAgICAgIC8qCj4gICAg
ICAgICAgICAgICAgICAqIGJkX211dGV4IGhhcyBiZWVuIGhlbGQgYWxyZWFkeSBpbiByZWxlYXNl
IHBhdGgsIHNvIGRvbid0Cj4gQEAgLTEyODgsMTIgKzEyODYsMTEgQEAgc3RhdGljIGludCBfX2xv
b3BfY2xyX2ZkKHN0cnVjdCBsb29wX2RldmljZSAqbG8sIGJvb2wgcmVsZWFzZSkKPiAgICAgICAg
ICAqIHByb3RlY3RzIHVzIGZyb20gYWxsIHRoZSBvdGhlciBwbGFjZXMgdHJ5aW5nIHRvIGNoYW5n
ZSB0aGUgJ2xvJwo+ICAgICAgICAgICogZGV2aWNlLgo+ICAgICAgICAgICovCj4gLSAgICAgICBt
dXRleF9sb2NrKCZsby0+bG9fbXV0ZXgpOwo+ICsKPiAgICAgICAgIGxvLT5sb19mbGFncyA9IDA7
Cj4gICAgICAgICBpZiAoIXBhcnRfc2hpZnQpCj4gICAgICAgICAgICAgICAgIGxvLT5sb19kaXNr
LT5mbGFncyB8PSBHRU5IRF9GTF9OT19QQVJUX1NDQU47Cj4gICAgICAgICBsby0+bG9fc3RhdGUg
PSBMb191bmJvdW5kOwo+IC0gICAgICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0ZXgpOwo+Cj4g
ICAgICAgICAvKgo+ICAgICAgICAgICogTmVlZCBub3QgaG9sZCBsb19tdXRleCB0byBmcHV0IGJh
Y2tpbmcgZmlsZS4gQ2FsbGluZyBmcHV0IGhvbGRpbmcKPiBAQCAtMTMzMiw5ICsxMzI5LDEwIEBA
IHN0YXRpYyBpbnQgbG9vcF9jbHJfZmQoc3RydWN0IGxvb3BfZGV2aWNlICpsbykKPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9Cj4gICAgICAgICBsby0+bG9fc3RhdGUgPSBM
b19ydW5kb3duOwo+ICsgICAgICAgZXJyID0gX19sb29wX2Nscl9mZChsbywgZmFsc2UpOwo+ICAg
ICAgICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0ZXgpOwo+Cj4gLSAgICAgICByZXR1cm4gX19s
b29wX2Nscl9mZChsbywgZmFsc2UpOwo+ICsgICAgICAgcmV0dXJuIGVycjsKPiAgfQo+Cj4gIHN0
YXRpYyBpbnQKPiBAQCAtMTkxNiwxMyArMTkxNCwxMiBAQCBzdGF0aWMgdm9pZCBsb19yZWxlYXNl
KHN0cnVjdCBnZW5kaXNrICpkaXNrLCBmbW9kZV90IG1vZGUpCj4gICAgICAgICAgICAgICAgIGlm
IChsby0+bG9fc3RhdGUgIT0gTG9fYm91bmQpCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBvdXRfdW5sb2NrOwo+ICAgICAgICAgICAgICAgICBsby0+bG9fc3RhdGUgPSBMb19ydW5kb3du
Owo+IC0gICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmxvLT5sb19tdXRleCk7Cj4gICAgICAg
ICAgICAgICAgIC8qCj4gICAgICAgICAgICAgICAgICAqIEluIGF1dG9jbGVhciBtb2RlLCBzdG9w
IHRoZSBsb29wIHRocmVhZAo+ICAgICAgICAgICAgICAgICAgKiBhbmQgcmVtb3ZlIGNvbmZpZ3Vy
YXRpb24gYWZ0ZXIgbGFzdCBjbG9zZS4KPiAgICAgICAgICAgICAgICAgICovCj4gICAgICAgICAg
ICAgICAgIF9fbG9vcF9jbHJfZmQobG8sIHRydWUpOwo+IC0gICAgICAgICAgICAgICByZXR1cm47
Cj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsKPiAgICAgICAgIH0gZWxzZSBpZiAo
bG8tPmxvX3N0YXRlID09IExvX2JvdW5kKSB7Cj4gICAgICAgICAgICAgICAgIC8qCj4gICAgICAg
ICAgICAgICAgICAqIE90aGVyd2lzZSBrZWVwIHRocmVhZCAoaWYgcnVubmluZykgYW5kIGNvbmZp
ZywKPiAtLQo+IDIuMTcuMQo+Cgo+TEdUTQo+UmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxw
YXNoYS50YXRhc2hpbkBzb2xlZW4uY29tPgo+Cj5UaGFuayB5b3UsCj5QYXNoYQo=
