Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE59C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E91217D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qNJBxqOR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W5TOgPl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbeLTRIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:08:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729720AbeLTRII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:08:08 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKGxuLw003648;
        Thu, 20 Dec 2018 09:08:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MoSum3lXlafz/ri1eI4VoM0zzraxjJ267tMMn2oqN44=;
 b=qNJBxqORZyrU8qZMjbGx3CrqiTJQLPz1KtqWD8MVDHgjXARX/816/T2GnyRbm+XTleLt
 tYUlehcBOahbABmgJDJ6dG90NKArQZu3a6+/KQ02dBVk/7H2sx4/p7/LImZUTFhFYVHd
 j2BBFUuVNXVxxGuv9wRTj8BtL/DeGU9B7qs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pgc53grg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 09:08:05 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 09:08:04 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 09:08:03 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 20 Dec 2018 09:08:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoSum3lXlafz/ri1eI4VoM0zzraxjJ267tMMn2oqN44=;
 b=W5TOgPl1y4srW7H5pLtEqYVFjH/fgRo4ZyeiC5Mkm88dFyqXDxyYst7io5mPPZHNsecqBXWDHncHIXXG0wKIn38yEvq4bedKJGCHD+piN4MDl49w5jLXn/epk8ZqODwm9EOQheXIYOX02u2Cip7zKGGFn59aClu1ik4P/72wwIQ=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1143.namprd15.prod.outlook.com (10.172.175.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 17:08:00 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4084:e0a:d6ef:5222]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4084:e0a:d6ef:5222%5]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 17:08:00 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkcg: clean up blkg_tryget_closest()
Thread-Topic: [PATCH] blkcg: clean up blkg_tryget_closest()
Thread-Index: AQHUl+xfX3LinmG1VECjSPe8ZEbyG6WH3UCA
Date:   Thu, 20 Dec 2018 17:07:59 +0000
Message-ID: <149cd7b6-a330-2197-6792-b8f0235f02de@fb.com>
References: <20181219224321.32624-1-dennis@kernel.org>
In-Reply-To: <20181219224321.32624-1-dennis@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1143;20:Ga1UlFKT1vySaQCUGZHjXyHDU+Fn/xc+HOr75batr8F7RI4+z3ZQL1psyVk+farWKdW9qb9RXaw14D475qH/igA7rXdcNVf2BdKIt2FypswzuhTI8G/xyPif3KbuYVivT1wcVurIkB1CVvSJIiK79tFRELBT5QgapFzGqOh1iOA=
x-ms-office365-filtering-correlation-id: f63bada0-aa86-4cc7-e766-08d6669db1a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1143;
x-ms-traffictypediagnostic: CY4PR15MB1143:
x-microsoft-antispam-prvs: <CY4PR15MB1143284C3C7F460F64C3D900C0BF0@CY4PR15MB1143.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(5005026)(6040522)(2401047)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1143;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(5660300001)(316002)(26005)(76176011)(71200400001)(71190400001)(256004)(53546011)(6506007)(386003)(186003)(97736004)(52116002)(305945005)(102836004)(36756003)(81156014)(81166006)(486006)(8936002)(2906002)(8676002)(14454004)(6512007)(68736007)(476003)(31696002)(229853002)(6486002)(54906003)(110136005)(25786009)(478600001)(66066001)(7736002)(86362001)(6246003)(3846002)(6116002)(53936002)(6436002)(2616005)(106356001)(4326008)(446003)(11346002)(99286004)(31686004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1143;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XkkDdUE+w8gzx7zMiG0wLGjXBhxUU/5gK1NmGEeqzxharKqkjptEZK8GP8ASdYrem+pvs7kOH5vkwBoznvfZptVBP9y4j4vf6px5lR/aF7C13FhMK9wY5+ySTyScdBiNRnopnekZlvQ+hzokNqOk2kXIVug0SRCnyhjY34X2VSJgRmRbbddO+0juKg7CQfDlnvDVEy5GUa/M+vfu5xDadDpL06EBJOKO2ZsohPeCgCZYiYy+jNI8QksnLU6Jk18NpyGSkck4qdaMtmkiJ6OgSP43UjrJifzpqxRd/ucyLFD95rgcb5/Wpy1Fjt2PD/Rm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DA903CE69BE754E81BDE655E83BCC41@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f63bada0-aa86-4cc7-e766-08d6669db1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:08:00.1612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTIvMTkvMTggMzo0MyBQTSwgRGVubmlzIFpob3Ugd3JvdGU6DQo+IFRoZSBpbXBsZW1lbnRh
dGlvbiBvZiBibGtnX3RyeWdldF9jbG9zZXN0KCkgd2Fzbid0IHN1cGVyIG9idmlvdXMgYW5kDQo+
IGJlY2FtZSBhIHBvaW50IG9mIHN1c3BpY2lvbiB3aGVuIGRlYnVnZ2luZyBbMV0uIFNvIGxldCdz
IGNsZWFuIGl0IHVwIHNvDQo+IGl0J3Mgb2J2aW91c2x5IG5vdCB0aGUgcHJvYmxlbS4NCg0KSSBs
aWtlIHRoZSBjbGVhbnVwIC0gYWRkaW5nIHRvIHRoZSBsYXRlciBwaWxlIGZvciB0aGUgbWVyZ2Ug
d2luZG93LCB0aGFua3MNCkRlbm5pcy4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
