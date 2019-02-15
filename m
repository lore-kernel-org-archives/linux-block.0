Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A97C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 22:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96BE222DE
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="zkpUZP1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfBOW0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:26:38 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:50134 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389286AbfBOW0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 17:26:37 -0500
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 17:26:36 EST
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FMAgmi011679;
        Fri, 15 Feb 2019 14:14:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=AqOLhg/6IuJbgBjY47g4JTH0Jg1MQzxQgM64qcaIdyE=;
 b=zkpUZP1rhlkviqqj+TeavW23k25gAMkzV9BEIB/m5qqUJf4oi5g+RmoaXJcsQW50T1IM
 t4Kc1+DOWMLp17xR10lkSbG8QIkWVFYVNIc0UEv6LSuN7qdXBH/mjxB7pkKZdeDxe4vz
 MTKoXUBPZ/WrDq6m6OMQobeQOR0skY+ONZjXbT0hN5cigK06lr5wY3qG3l1dpBAgSQpx
 fPFu88Jla9oY0RvarKDpVxUo9d+sQdGxEHjfUYmtshdmVct8H+ncJAC/zg29X/rVX09a
 ztaMzhh6Kv3MrDtbMKySZ+H36K/2Qqv6NuUCBG6vP5ZAEML+E0HYI2n63ra879ia2f+1 CA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2qp1upgym4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 14:14:37 -0800
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.18) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.205.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 22:14:35 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f54f:a1c0:e5e4:699b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f54f:a1c0:e5e4:699b%8]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 22:14:35 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Thread-Topic: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Thread-Index: AQHUxXQTBlSPmQnE0kePZHyqHo/yEaXhZR4AgAAHowA=
Date:   Fri, 15 Feb 2019 22:14:35 +0000
Message-ID: <694B95F6-290C-4065-B6D6-38B4858C71B8@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
 <20190215214714.GA11307@localhost.localdomain>
In-Reply-To: <20190215214714.GA11307@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbb8cbaa-fb71-4856-2b98-08d69392f815
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2512;
x-ms-traffictypediagnostic: MWHPR02MB2512:
x-proofpoint-crosstenant: true
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR02MB2512;23:01EYlL/iuD40VdWZarmecu3YNTP9ORhcJyboEdNbW?=
 =?us-ascii?Q?SiXhcqA208S6artJ8Ab1iVFYLO9bKvP1QX+x6RoLPYzlBcfzmOxXiyQAx5+a?=
 =?us-ascii?Q?L1n0faeqVHfRDo/LgRUEMx87rZ6lz+pSVsOPeEaDSC03d3IPalD3QvNxy7mt?=
 =?us-ascii?Q?d7qzPBhLctDljDT/C0/PzieuS2me+4w147GDaSUxMs1dTlAEgOGGKe1PcJ2V?=
 =?us-ascii?Q?WCmyPo7PwFYfIQ6creb1m7OxmXipiNo5rVQRM1ZxaeOXPKITuSjYNOPHB0x+?=
 =?us-ascii?Q?IO/RH1KM1qFunJVanLBIeCRJrSRb4tCJrp/G+Ro5CsMvx6uPEmP8h0KyMdjf?=
 =?us-ascii?Q?Wxix2/RRLNVd+ICQLefAP8z500W/MaPh4JU3b69Xf/ZPf6sYy1Gjn/14d+op?=
 =?us-ascii?Q?XsaNB4IylxPlpfrjDYSydlMwtPnZSFKfN+uELr/qrLmT6uDxJ+OMbsgyr9jc?=
 =?us-ascii?Q?zN5xhCs+N9MZ/HZ9DNjVNyBn2Ixw4Igqc714Cbi7njMjdoPrrPrEFoclclmz?=
 =?us-ascii?Q?IzMUSriId2dfBTdZmthxxIK55PMXlBrDJzl90AHZD/NxD6xjpCkDy37ZTC6g?=
 =?us-ascii?Q?nZd5tRdeIuf3rN4MDBFsS+tQIApS3z2bsp4P0GX2NEs24obIXbjOXxkiOeKG?=
 =?us-ascii?Q?q9Erx9Vy6zf5xKUTPUdImbH4wRgnBvLB7iG6TkAoAqongY8uM4x9htiJNDZp?=
 =?us-ascii?Q?z3mUUhuEJuiSL9AP14V/X5pjgRTKthgN0xaI+kc9aKIXXm5Kjqvump2vAe35?=
 =?us-ascii?Q?McTNI9QNtnRZFBJDWOtEn4rd7nsOMKUIlvPv0ij5NtLBdNpFYlu4s8TW/t3j?=
 =?us-ascii?Q?lJk85lFNpmHtAREaAoZbEKnWTy/z9wg9llGK0k/Jl0osDihK3evGERh82HZW?=
 =?us-ascii?Q?VCVfL18CS2oWxMzalMU9qFCHdvj5X0JUlkNYi3RffK2TFFtT5mGfgRXLFIf5?=
 =?us-ascii?Q?a6h4Aw3i8NlyMykPCdic7tt7HPCgeGw34T1FXWgttcTOZQ0CzzX8daI8ClGS?=
 =?us-ascii?Q?3H42PIAZnjpkX5FS6Bcb6G9jr5SbCgZ4O04mQHeqBt4tkRQUne+bCKi2x/Iy?=
 =?us-ascii?Q?Qw3q9vJ30ycCRu16h38oHAudehWA3QhJERFr7KV16nIsXjj9eLSrI6Rt4YJo?=
 =?us-ascii?Q?rUW2fApjJIrfxHad77Mo3kQqRTBCIJVumv1vz2IW2Asw4UgP2kGJyHZWBSDv?=
 =?us-ascii?Q?MuuUzJqvY2kAJPrkJAEtXv3gMGY5+nkPBMVZi+3wThG/bZmfMyBq5ulP60VU?=
 =?us-ascii?Q?t+DNKO5E/Aj3nD1tAGm2jEG0Wzh+PQ+mnynnJQJ1XephEMOzusa5GByAdz0m?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <MWHPR02MB2512267D02978393D45712AAD7600@MWHPR02MB2512.namprd02.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(36756003)(25786009)(81156014)(8676002)(81166006)(76176011)(8936002)(99286004)(53546011)(4326008)(53936002)(66066001)(6506007)(102836004)(14444005)(256004)(7736002)(5660300002)(2906002)(6512007)(305945005)(6916009)(97736004)(33656002)(106356001)(71200400001)(105586002)(229853002)(186003)(478600001)(476003)(14454004)(6436002)(6116002)(3846002)(6246003)(316002)(486006)(82746002)(11346002)(68736007)(2616005)(446003)(26005)(71190400001)(86362001)(54906003)(83716004)(6486002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR02MB2512;H:MWHPR02MB2656.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aLEHxr0J7BRQt64mvqAE2L7SCJW5s9PoozA3uZCroROP22RPJbm8q3UK0BgCzjaHPpoOp2R5AqWW/elLJj9QqnD1l4rgXKioLmA7CV6NVxF4xaJ5gEEygr8Ih9I3qEWG3S8xm+Uqpvtf6XXduol3KnNCRKX0CubKILmE/1aoavZNX6zNEixSw6vA3nhn4Pbx3ewutEXlmdx2HBIva6VBNV7uX88xnawG8I0VnICmP16vAeGM87idRdwee8yBtnyDnPw07tIHJ/8Im4YyEoQIKOKxRu4X8MZ3MzBrFEawrhsQzsFerZYRhQicyLmRkp87mGhGjLF2yZ+Iixl75mPz5xqkvdG0UbGJtpDEUn5zXOMkNhk+krg51jmodwk8MuTR5dsKxDrdM3C3mpjqnvNDNQnNfPV1hSMmkYWqWjwdj6c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E64A176A182A84092E88962A2D76886@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb8cbaa-fb71-4856-2b98-08d69392f815
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 22:14:35.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith,

> On Feb 15, 2019, at 9:47 PM, Keith Busch <keith.busch@intel.com> wrote:
>=20
> On Fri, Feb 15, 2019 at 09:19:02PM +0000, Felipe Franciosi wrote:
>> Over the last year or two, I have done extensive experimentation compari=
ng applications using libaio to those using SDPK.=20
>=20
> Try the io_uring interface instead. Its queued up in the linux-block
> for-next tree.

I just read about that based on the other response from Bart. Thanks for po=
inting it out.

>=20
>> For hypervisors, where storage devices can be exclusively accessed with =
userspace drivers (given the device can be dedicated to a single process), =
using SPDK has proven to be significantly faster and more efficient.
>=20
> It doesn't work so well for file based or multi-device backing
> storage. But if you are sequestering an entire controller over to a VM,
> direct-assign/device-passthrough is usually also an option and that
> ought to be even faster.

The advantage is to dedicate a controller to "the hypervisor" (ie. one user=
space process responsible for mediating access between multiple VMs). Some =
VMs may choose to use userspace drivers, too. Others can use traditional ke=
rnel datapaths. The average overhead we have measured from virtual machines=
 in this setup is neglectable.

I did not experience problems with multiple devices, but surely careful tho=
ught is required for the data format.

Cheers,
Felipe=
