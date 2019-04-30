Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE26C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350020854
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RxdiGESw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HJQW9OMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfD3Vi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:38:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58616 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfD3Vi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660306; x=1588196306;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OVOwyxv1PxGF2yePnQ7dWHI2JtK0ukpXNYL6l2jUmCI=;
  b=RxdiGESwsT4Smh5/b3swls8ulR9WasP6nKU5GRQeEhuDTR6IOP4DeSwe
   LTUfUYAGNcEZj9eJDBFcXm5FAGRc42/1wPilVmpOnxhHdAPLLOYZgoMDA
   dpN8oTNa/Ec2JvighKs5YROWGDbeK7WGneRJXEQvjCUGmbmUMIdwTHidQ
   piQ9uEMJuVBTp6+oAEMLgssaD6uWo3w1k2p4/nWEjmM3WdH2J/E0woFMH
   ptiiPTRio8T5eJ5WQW3Ff+Z7S0Qo5XZx2vjnA/lSGV5FrfUACx6/mf5r+
   WF+DcaKoIc4poNU+pKVI3gavb+fhxifPJnCajdtYCm6MttidnmcS2kBHP
   w==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; 
   d="scan'208";a="108930339"
Received: from mail-co1nam03lp2058.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.58])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:38:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py8IiWuAxyxhkAKkUI1awbDBld/8mENdAHzJHyvEsxg=;
 b=HJQW9OMNlpT5RWx1D9CJ03kBCNmRL4InXJkvEc4XUiJPhRnnmi7vbNoDlD1xy8yqAcvLZCyvLW0zN2kVBFMY4wM/Yb1I2dS6+WHvrQP8zUebO6A+D2HxLMZVmBNltdEpPZ7FIHyIGtEWpbjAVT45JQwzH+2jlznEk7ZvynmOVvc=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4064.namprd04.prod.outlook.com (52.135.82.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 21:38:13 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:38:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] block: switch all files cleared marked as GPLv2 or
 later to SPDX tags
Thread-Topic: [PATCH 2/5] block: switch all files cleared marked as GPLv2 or
 later to SPDX tags
Thread-Index: AQHU/4SuzMMnXoVCi0CiEdzW/0z0bA==
Date:   Tue, 30 Apr 2019 21:38:13 +0000
Message-ID: <SN6PR04MB45279D29F7D7DD0A9619AD6A863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430184243.23436-1-hch@lst.de>
 <20190430184243.23436-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d3907b5-411f-417b-4ec7-08d6cdb425f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4064;
x-ms-traffictypediagnostic: SN6PR04MB4064:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB40641832035D0B40AD604CD6863A0@SN6PR04MB4064.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(54534003)(189003)(199004)(76176011)(6436002)(7736002)(7696005)(6246003)(25786009)(305945005)(3846002)(6116002)(966005)(66066001)(4326008)(55016002)(72206003)(33656002)(53936002)(52536014)(478600001)(102836004)(8936002)(30864003)(446003)(74316002)(2906002)(316002)(229853002)(81166006)(81156014)(8676002)(53546011)(6506007)(476003)(66476007)(66556008)(186003)(66946007)(68736007)(7416002)(91956017)(486006)(73956011)(76116006)(66446008)(64756008)(256004)(26005)(9686003)(6306002)(86362001)(71200400001)(71190400001)(110136005)(54906003)(99286004)(15188155005)(5660300002)(14454004)(16799955002)(2004002)(19623215001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4064;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TGpWE7kqglwOZLgxGDGUnLLVLVY07yFMmjPfnkya7DTiwTQPq9GGU7AGfpbZXA0wFjX5yUJfAcxk4BwjjjvtpTfZkQV/FoSvOfES8wc9Y3T/vyxCi95H6dOzYoaP/xs14TF37Aqif7/m0ioj97Xe9iYfqgxDCG+kwsd+2Y8JxusT/8haPPUfoadWEC9/SefItChRbEq7rlIhRDhiVcq72RtencAQUDjBNjDAWn6Ujnm3jIMBq07h6Z/Y0yo53OlLbN/vk6Jo55uFWWYCCSpF6Zc8vRYy77nzW/T+gt7eQna6i1EzlTqGVkvm7/+YxCnY0o/TwrUP/HcppxnzFICIm8CxHlIC01TfK3pXv6Q6j0I1sdM+Um7RWL+3IXca3ud/O8rxCIIgX/xYx4uI3qJR/ncaACOIFDsS6Yajse4cEf4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3907b5-411f-417b-4ec7-08d6cdb425f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:38:13.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4064
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/30/19 11:44 AM, Christoph Hellwig wrote:=0A=
> All these files have some form of the usual GPLv2 or later boilerplate.=
=0A=
> Switch them to use SPDX tags instead.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/bfq-cgroup.c      | 11 +----------=0A=
>   block/bfq-iosched.c     | 11 +----------=0A=
>   block/bfq-iosched.h     | 11 +----------=0A=
>   block/bfq-wf2q.c        | 11 +----------=0A=
>   block/bsg-lib.c         | 16 +---------------=0A=
>   block/partitions/efi.c  | 16 +---------------=0A=
>   block/partitions/efi.h  | 16 +---------------=0A=
>   block/partitions/ldm.c  | 16 +---------------=0A=
>   block/partitions/ldm.h  | 16 +---------------=0A=
>   include/linux/bsg-lib.h | 16 +---------------=0A=
>   10 files changed, 10 insertions(+), 130 deletions(-)=0A=
> =0A=
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c=0A=
> index 793c027ca60e..b3796a40a61a 100644=0A=
> --- a/block/bfq-cgroup.c=0A=
> +++ b/block/bfq-cgroup.c=0A=
> @@ -1,15 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /*=0A=
>    * cgroups support for the BFQ I/O scheduler.=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or=0A=
> - *  modify it under the terms of the GNU General Public License as=0A=
> - *  published by the Free Software Foundation; either version 2 of the=
=0A=
> - *  License, or (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - *  General Public License for more details.=0A=
>    */=0A=
>   #include <linux/module.h>=0A=
>   #include <linux/slab.h>=0A=
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c=0A=
> index b85a4ab8b9db..f8d430f88d25 100644=0A=
> --- a/block/bfq-iosched.c=0A=
> +++ b/block/bfq-iosched.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /*=0A=
>    * Budget Fair Queueing (BFQ) I/O scheduler.=0A=
>    *=0A=
> @@ -12,16 +13,6 @@=0A=
>    *=0A=
>    * Copyright (C) 2017 Paolo Valente <paolo.valente@linaro.org>=0A=
>    *=0A=
> - *  This program is free software; you can redistribute it and/or=0A=
> - *  modify it under the terms of the GNU General Public License as=0A=
> - *  published by the Free Software Foundation; either version 2 of the=
=0A=
> - *  License, or (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - *  General Public License for more details.=0A=
> - *=0A=
>    * BFQ is a proportional-share I/O scheduler, with some extra=0A=
>    * low-latency capabilities. BFQ also supports full hierarchical=0A=
>    * scheduling through cgroups. Next paragraphs provide an introduction=
=0A=
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h=0A=
> index eba7cd449ab4..c2faa77824f8 100644=0A=
> --- a/block/bfq-iosched.h=0A=
> +++ b/block/bfq-iosched.h=0A=
> @@ -1,16 +1,7 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
>   /*=0A=
>    * Header file for the BFQ I/O scheduler: data structures and=0A=
>    * prototypes of interface functions among BFQ components.=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or=0A=
> - *  modify it under the terms of the GNU General Public License as=0A=
> - *  published by the Free Software Foundation; either version 2 of the=
=0A=
> - *  License, or (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - *  General Public License for more details.=0A=
>    */=0A=
>   #ifndef _BFQ_H=0A=
>   #define _BFQ_H=0A=
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c=0A=
> index 48d899cfbe03..c9ba225081ce 100644=0A=
> --- a/block/bfq-wf2q.c=0A=
> +++ b/block/bfq-wf2q.c=0A=
> @@ -1,19 +1,10 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /*=0A=
>    * Hierarchical Budget Worst-case Fair Weighted Fair Queueing=0A=
>    * (B-WF2Q+): hierarchical scheduling algorithm by which the BFQ I/O=0A=
>    * scheduler schedules generic entities. The latter can represent=0A=
>    * either single bfq queues (associated with processes) or groups of=0A=
>    * bfq queues (associated with cgroups).=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or=0A=
> - *  modify it under the terms of the GNU General Public License as=0A=
> - *  published by the Free Software Foundation; either version 2 of the=
=0A=
> - *  License, or (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - *  General Public License for more details.=0A=
>    */=0A=
>   #include "bfq-iosched.h"=0A=
>   =0A=
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c=0A=
> index 005e2b75d775..b898a1cdf872 100644=0A=
> --- a/block/bsg-lib.c=0A=
> +++ b/block/bsg-lib.c=0A=
> @@ -1,24 +1,10 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /*=0A=
>    *  BSG helper library=0A=
>    *=0A=
>    *  Copyright (C) 2008   James Smart, Emulex Corporation=0A=
>    *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.=0A=
>    *  Copyright (C) 2011   Mike Christie=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or modify=
=0A=
> - *  it under the terms of the GNU General Public License as published by=
=0A=
> - *  the Free Software Foundation; either version 2 of the License, or=0A=
> - *  (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - *  GNU General Public License for more details.=0A=
> - *=0A=
> - *  You should have received a copy of the GNU General Public License=0A=
> - *  along with this program; if not, write to the Free Software=0A=
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA=0A=
> - *=0A=
>    */=0A=
>   #include <linux/slab.h>=0A=
>   #include <linux/blk-mq.h>=0A=
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c=0A=
> index 39f70d968754..db2fef7dfc47 100644=0A=
> --- a/block/partitions/efi.c=0A=
> +++ b/block/partitions/efi.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /************************************************************=0A=
>    * EFI GUID Partition Table handling=0A=
>    *=0A=
> @@ -7,21 +8,6 @@=0A=
>    * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>=0A=
>    *   Copyright 2000,2001,2002,2004 Dell Inc.=0A=
>    *=0A=
> - *  This program is free software; you can redistribute it and/or modify=
=0A=
> - *  it under the terms of the GNU General Public License as published by=
=0A=
> - *  the Free Software Foundation; either version 2 of the License, or=0A=
> - *  (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - *  GNU General Public License for more details.=0A=
> - *=0A=
> - *  You should have received a copy of the GNU General Public License=0A=
> - *  along with this program; if not, write to the Free Software=0A=
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA=0A=
> - *=0A=
> - *=0A=
>    * TODO:=0A=
>    *=0A=
>    * Changelog:=0A=
> diff --git a/block/partitions/efi.h b/block/partitions/efi.h=0A=
> index abd0b19288a6..3e8576157575 100644=0A=
> --- a/block/partitions/efi.h=0A=
> +++ b/block/partitions/efi.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
>   /************************************************************=0A=
>    * EFI GUID Partition Table=0A=
>    * Per Intel EFI Specification v1.02=0A=
> @@ -5,21 +6,6 @@=0A=
>    *=0A=
>    * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000=
=0A=
>    *   Copyright 2000,2001 Dell Inc.=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or modify=
=0A=
> - *  it under the terms of the GNU General Public License as published by=
=0A=
> - *  the Free Software Foundation; either version 2 of the License, or=0A=
> - *  (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - *  GNU General Public License for more details.=0A=
> - *=0A=
> - *  You should have received a copy of the GNU General Public License=0A=
> - *  along with this program; if not, write to the Free Software=0A=
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA=0A=
> - *=0A=
>    ************************************************************/=0A=
>   =0A=
>   #ifndef FS_PART_EFI_H_INCLUDED=0A=
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c=0A=
> index 16766f267559..6db573f33219 100644=0A=
> --- a/block/partitions/ldm.c=0A=
> +++ b/block/partitions/ldm.c=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /**=0A=
>    * ldm - Support for Windows Logical Disk Manager (Dynamic Disks)=0A=
>    *=0A=
> @@ -6,21 +7,6 @@=0A=
>    * Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>=0A=
>    *=0A=
>    * Documentation is available at http://www.linux-ntfs.org/doku.php?id=
=3Ddownloads=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it under=0A=
> - * the terms of the GNU General Public License as published by the Free =
Software=0A=
> - * Foundation; either version 2 of the License, or (at your option) any =
later=0A=
> - * version.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful, but W=
ITHOUT=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
 FITNESS=0A=
> - * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for mor=
e=0A=
> - * details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License alo=
ng with=0A=
> - * this program (in the main directory of the source in the file COPYING=
); if=0A=
> - * not, write to the Free Software Foundation, Inc., 59 Temple Place, Su=
ite 330,=0A=
> - * Boston, MA  02111-1307  USA=0A=
>    */=0A=
>   =0A=
>   #include <linux/slab.h>=0A=
> diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h=0A=
> index f4c6055df956..1ca63e97bccc 100644=0A=
> --- a/block/partitions/ldm.h=0A=
> +++ b/block/partitions/ldm.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>   /**=0A=
>    * ldm - Part of the Linux-NTFS project.=0A=
>    *=0A=
> @@ -6,21 +7,6 @@=0A=
>    * Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>=0A=
>    *=0A=
>    * Documentation is available at http://www.linux-ntfs.org/doku.php?id=
=3Ddownloads=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms of the GNU General Public License as published by the=
 Free=0A=
> - * Software Foundation; either version 2 of the License, or (at your opt=
ion)=0A=
> - * any later version.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - * GNU General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program (in the main directory of the Linux-NTFS sour=
ce=0A=
> - * in the file COPYING); if not, write to the Free Software Foundation,=
=0A=
> - * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA=0A=
>    */=0A=
>   =0A=
>   #ifndef _FS_PT_LDM_H_=0A=
> diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h=0A=
> index 7f14517a559b..960988d42f77 100644=0A=
> --- a/include/linux/bsg-lib.h=0A=
> +++ b/include/linux/bsg-lib.h=0A=
> @@ -1,24 +1,10 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
>   /*=0A=
>    *  BSG helper library=0A=
>    *=0A=
>    *  Copyright (C) 2008   James Smart, Emulex Corporation=0A=
>    *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.=0A=
>    *  Copyright (C) 2011   Mike Christie=0A=
> - *=0A=
> - *  This program is free software; you can redistribute it and/or modify=
=0A=
> - *  it under the terms of the GNU General Public License as published by=
=0A=
> - *  the Free Software Foundation; either version 2 of the License, or=0A=
> - *  (at your option) any later version.=0A=
> - *=0A=
> - *  This program is distributed in the hope that it will be useful,=0A=
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - *  GNU General Public License for more details.=0A=
> - *=0A=
> - *  You should have received a copy of the GNU General Public License=0A=
> - *  along with this program; if not, write to the Free Software=0A=
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA=0A=
> - *=0A=
>    */=0A=
>   #ifndef _BLK_BSG_=0A=
>   #define _BLK_BSG_=0A=
> =0A=
=0A=
