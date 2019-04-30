Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB716C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B5820854
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UP/rrMvE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jezabK3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3ViH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:38:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61474 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3ViH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660287; x=1588196287;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8HvXwL5Hqeli1MX7kxOxxstGuagcLK3wQLqdKMMRatM=;
  b=UP/rrMvEGYQcX6h+2obLnk/A3J0nt/FiuVI3WWmtKzTcDXlbBHo60CJh
   hXsTMU62LzYpD7LgjKEOzxgKrRyWUXIIO1dj8I5ETjVsELbkO5fmtImOK
   lzog8zK6aqHac4EohqQBaqEQan2Bf68AG75Sfmj1KC03C83gfv1jr7ESb
   xYnoq3dVnnnQ+QAqpJXfNf8LEFO5AcfoIVo+dnCj9qEBkfZlgATWpciGT
   NTyLQdv2E5a1sDQZP27OCc47hPMS6ZyKk3hxvG2f1xsZtb4i2Kp8ItP6b
   enDji5UvdKq9u+uKq0wWsMiuHrr9ZW/APRRg8OAFADRHuApceNhrMc3fm
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; 
   d="scan'208";a="112162809"
Received: from mail-co1nam03lp2054.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:38:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc6z8IvetLVeocvTUUtp+NGa2oW6G3fWKdDDt7seD/k=;
 b=jezabK3QfaAXwQpvb32Zp4ejYyDHQSsxkXAHZ4UPX/2oFGyf8KMr3cxLQWOMYLMTUaKPxwT0UyorR+3b1mFGHYLELE/Tk451/arVaZJu/TVkC9XNqYwPnp7NTiG8twr5Yk11Ccouq7oSLNk7J7aiisrhHxpFpda9YL8qy7tYgQ0=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4064.namprd04.prod.outlook.com (52.135.82.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 21:38:02 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:38:02 +0000
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
Subject: Re: [PATCH 1/5] block: switch all files cleared marked as GPLv2 to
 SPDX tags
Thread-Topic: [PATCH 1/5] block: switch all files cleared marked as GPLv2 to
 SPDX tags
Thread-Index: AQHU/4SxylqRRrn5pUmnnBiPCIf9vw==
Date:   Tue, 30 Apr 2019 21:38:01 +0000
Message-ID: <SN6PR04MB4527F42E251571339493CB3C863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430184243.23436-1-hch@lst.de>
 <20190430184243.23436-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e64a9403-db13-46bb-fd8d-08d6cdb41f2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4064;
x-ms-traffictypediagnostic: SN6PR04MB4064:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB40645BAC7B181B570A6C94F6863A0@SN6PR04MB4064.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(76176011)(6436002)(7736002)(7696005)(6246003)(25786009)(305945005)(3846002)(6116002)(66066001)(4326008)(55016002)(72206003)(33656002)(53936002)(52536014)(478600001)(102836004)(8936002)(30864003)(446003)(74316002)(2906002)(316002)(229853002)(81166006)(81156014)(8676002)(53546011)(6506007)(476003)(66476007)(66556008)(186003)(66946007)(68736007)(7416002)(91956017)(486006)(73956011)(76116006)(66446008)(64756008)(256004)(14444005)(26005)(53946003)(9686003)(6306002)(86362001)(71200400001)(71190400001)(110136005)(54906003)(99286004)(5660300002)(14454004)(2004002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4064;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IdsxQmA390gxuqVr+KqpFiFcv+cl3Kl4qksV9x6OBcflVOMCjWUOC4eyXfgeNmWVNN4IQWqvFCe5St7mzGCU77mqLnJzRxoydA2l+wBzUOtaH2RSjgKLO+ua87uXQI4gFgr8B47qRcxBEpXXTxEkV1lOZ15ysmrmJYzvUdfydFpE7EERmVzSshpMimxW1f52H1k0uIBf282b8QAg4fe538l7xlikdoT7qoo6pQLgGTuHyT9zs7f7njfywjAMrW9hL41KQMhnitynOFvCPpoecDuSrXCoBUyztyEd8tBxhoEdzho1aeuzsmIZ+ioZB2BFuPtOXByxF5IPCjgZMJjHvtTr+K177Neh6l+dAPTy5KUIJ3vc1yA+pMWQw68JPMRc+dL4h/9Op6JxrCVEpNODNb2V074lw20j7vZNm/Nx0ng=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a9403-db13-46bb-fd8d-08d6cdb41f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:38:01.8406
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
On 4/30/19 11:44 AM, Christoph Hellwig wrote:=0A=
> All these files have some form of the usual GPLv2 boilerplate.  Switch=0A=
> them to use SPDX tags instead.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/badblocks.c        | 10 +---------=0A=
>   block/bio-integrity.c    | 16 +---------------=0A=
>   block/bio.c              | 15 +--------------=0A=
>   block/blk-flush.c        |  3 +--=0A=
>   block/blk-integrity.c    | 16 +---------------=0A=
>   block/blk-mq-debugfs.c   | 13 +------------=0A=
>   block/blk-mq-pci.c       | 10 +---------=0A=
>   block/blk-mq-rdma.c      | 10 +---------=0A=
>   block/blk-mq-virtio.c    | 10 +---------=0A=
>   block/bsg.c              |  9 +--------=0A=
>   block/kyber-iosched.c    | 13 +------------=0A=
>   block/opal_proto.h       | 10 +---------=0A=
>   block/partitions/acorn.c |  7 +------=0A=
>   block/scsi_ioctl.c       | 16 +---------------=0A=
>   block/sed-opal.c         | 10 +---------=0A=
>   block/t10-pi.c           | 19 +------------------=0A=
>   include/linux/bio.h      | 15 +--------------=0A=
>   include/linux/bvec.h     | 15 +--------------=0A=
>   include/linux/sed-opal.h | 10 +---------=0A=
>   19 files changed, 19 insertions(+), 208 deletions(-)=0A=
> =0A=
> diff --git a/block/badblocks.c b/block/badblocks.c=0A=
> index 91f7bcf979d3..2e5f5697db35 100644=0A=
> --- a/block/badblocks.c=0A=
> +++ b/block/badblocks.c=0A=
> @@ -1,18 +1,10 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Bad block management=0A=
>    *=0A=
>    * - Heavily based on MD badblocks code from Neil Brown=0A=
>    *=0A=
>    * Copyright (c) 2015, Intel Corporation.=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   =0A=
>   #include <linux/badblocks.h>=0A=
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c=0A=
> index 1b633a3526d4..42536674020a 100644=0A=
> --- a/block/bio-integrity.c=0A=
> +++ b/block/bio-integrity.c=0A=
> @@ -1,23 +1,9 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * bio-integrity.c - bio data integrity extensions=0A=
>    *=0A=
>    * Copyright (C) 2007, 2008, 2009 Oracle Corporation=0A=
>    * Written by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or=0A=
> - * modify it under the terms of the GNU General Public License version=
=0A=
> - * 2 as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful, but=
=0A=
> - * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - * General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program; see the file COPYING.  If not, write to=0A=
> - * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,=0A=
> - * USA.=0A=
> - *=0A=
>    */=0A=
>   =0A=
>   #include <linux/blkdev.h>=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 029afb121a48..683cbb40f051 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1,19 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (C) 2001 Jens Axboe <axboe@kernel.dk>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify=
=0A=
> - * it under the terms of the GNU General Public License version 2 as=0A=
> - * published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - * GNU General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public Licens=0A=
> - * along with this program; if not, write to the Free Software=0A=
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=0A=
> - *=0A=
>    */=0A=
>   #include <linux/mm.h>=0A=
>   #include <linux/swap.h>=0A=
> diff --git a/block/blk-flush.c b/block/blk-flush.c=0A=
> index d95f94892015..aedd9320e605 100644=0A=
> --- a/block/blk-flush.c=0A=
> +++ b/block/blk-flush.c=0A=
> @@ -1,11 +1,10 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Functions to sequence PREFLUSH and FUA writes.=0A=
>    *=0A=
>    * Copyright (C) 2011		Max Planck Institute for Gravitational Physics=
=0A=
>    * Copyright (C) 2011		Tejun Heo <tj@kernel.org>=0A=
>    *=0A=
> - * This file is released under the GPLv2.=0A=
> - *=0A=
>    * REQ_{PREFLUSH|FUA} requests are decomposed to sequences consisted of=
 three=0A=
>    * optional steps - PREFLUSH, DATA and POSTFLUSH - according to the req=
uest=0A=
>    * properties and hardware capability.=0A=
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c=0A=
> index d1ab089e0919..7f302f7b9d84 100644=0A=
> --- a/block/blk-integrity.c=0A=
> +++ b/block/blk-integrity.c=0A=
> @@ -1,23 +1,9 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * blk-integrity.c - Block layer data integrity extensions=0A=
>    *=0A=
>    * Copyright (C) 2007, 2008 Oracle Corporation=0A=
>    * Written by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or=0A=
> - * modify it under the terms of the GNU General Public License version=
=0A=
> - * 2 as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful, but=
=0A=
> - * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - * General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program; see the file COPYING.  If not, write to=0A=
> - * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,=0A=
> - * USA.=0A=
> - *=0A=
>    */=0A=
>   =0A=
>   #include <linux/blkdev.h>=0A=
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c=0A=
> index ec1d18cb643c..6aea0ebc3a73 100644=0A=
> --- a/block/blk-mq-debugfs.c=0A=
> +++ b/block/blk-mq-debugfs.c=0A=
> @@ -1,17 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (C) 2017 Facebook=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or=0A=
> - * modify it under the terms of the GNU General Public=0A=
> - * License v2 as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - * General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program.  If not, see <https://www.gnu.org/licenses/>=
.=0A=
>    */=0A=
>   =0A=
>   #include <linux/kernel.h>=0A=
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c=0A=
> index 1dce18553984..ad4545a2a98b 100644=0A=
> --- a/block/blk-mq-pci.c=0A=
> +++ b/block/blk-mq-pci.c=0A=
> @@ -1,14 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (c) 2016 Christoph Hellwig.=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   #include <linux/kobject.h>=0A=
>   #include <linux/blkdev.h>=0A=
> diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c=0A=
> index 45030a81a1ed..cc921e6ba709 100644=0A=
> --- a/block/blk-mq-rdma.c=0A=
> +++ b/block/blk-mq-rdma.c=0A=
> @@ -1,14 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (c) 2017 Sagi Grimberg.=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   #include <linux/blk-mq.h>=0A=
>   #include <linux/blk-mq-rdma.h>=0A=
> diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c=0A=
> index 370827163835..75a52c18a8f6 100644=0A=
> --- a/block/blk-mq-virtio.c=0A=
> +++ b/block/blk-mq-virtio.c=0A=
> @@ -1,14 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (c) 2016 Christoph Hellwig.=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   #include <linux/device.h>=0A=
>   #include <linux/blk-mq.h>=0A=
> diff --git a/block/bsg.c b/block/bsg.c=0A=
> index f306853c6b08..833c44b3d458 100644=0A=
> --- a/block/bsg.c=0A=
> +++ b/block/bsg.c=0A=
> @@ -1,13 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * bsg.c - block layer implementation of the sg v4 interface=0A=
> - *=0A=
> - * Copyright (C) 2004 Jens Axboe <axboe@suse.de> SUSE Labs=0A=
> - * Copyright (C) 2004 Peter M. Jones <pjones@redhat.com>=0A=
> - *=0A=
> - *  This file is subject to the terms and conditions of the GNU General =
Public=0A=
> - *  License version 2.  See the file "COPYING" in the main directory of =
this=0A=
> - *  archive for more details.=0A=
> - *=0A=
>    */=0A=
>   #include <linux/module.h>=0A=
>   #include <linux/init.h>=0A=
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c=0A=
> index ec6a04e01bc1..c3b05119cebd 100644=0A=
> --- a/block/kyber-iosched.c=0A=
> +++ b/block/kyber-iosched.c=0A=
> @@ -1,20 +1,9 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * The Kyber I/O scheduler. Controls latency by throttling queue depths=
 using=0A=
>    * scalable techniques.=0A=
>    *=0A=
>    * Copyright (C) 2017 Facebook=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or=0A=
> - * modify it under the terms of the GNU General Public=0A=
> - * License v2 as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - * General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program.  If not, see <https://www.gnu.org/licenses/>=
.=0A=
>    */=0A=
>   =0A=
>   #include <linux/kernel.h>=0A=
> diff --git a/block/opal_proto.h b/block/opal_proto.h=0A=
> index b6e352cfe982..d9a05ad02eb5 100644=0A=
> --- a/block/opal_proto.h=0A=
> +++ b/block/opal_proto.h=0A=
> @@ -1,18 +1,10 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    * Copyright =A9 2016 Intel Corporation=0A=
>    *=0A=
>    * Authors:=0A=
>    *    Rafael Antognolli <rafael.antognolli@intel.com>=0A=
>    *    Scott  Bauer      <scott.bauer@intel.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   #include <linux/types.h>=0A=
>   =0A=
> diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c=0A=
> index fbeb697374d5..7587700fad4a 100644=0A=
> --- a/block/partitions/acorn.c=0A=
> +++ b/block/partitions/acorn.c=0A=
> @@ -1,12 +1,7 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
> - *  linux/fs/partitions/acorn.c=0A=
> - *=0A=
>    *  Copyright (c) 1996-2000 Russell King.=0A=
>    *=0A=
> - * This program is free software; you can redistribute it and/or modify=
=0A=
> - * it under the terms of the GNU General Public License version 2 as=0A=
> - * published by the Free Software Foundation.=0A=
> - *=0A=
>    *  Scan ADFS partitions on hard disk drives.  Unfortunately, there=0A=
>    *  isn't a standard for partitioning drives on Acorn machines, so=0A=
>    *  every single manufacturer of SCSI and IDE cards created their own=
=0A=
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c=0A=
> index 533f4aee8567..f5e0ad65e86a 100644=0A=
> --- a/block/scsi_ioctl.c=0A=
> +++ b/block/scsi_ioctl.c=0A=
> @@ -1,20 +1,6 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright (C) 2001 Jens Axboe <axboe@suse.de>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify=
=0A=
> - * it under the terms of the GNU General Public License version 2 as=0A=
> - * published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - * GNU General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public Licens=0A=
> - * along with this program; if not, write to the Free Software=0A=
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=0A=
> - *=0A=
>    */=0A=
>   #include <linux/kernel.h>=0A=
>   #include <linux/errno.h>=0A=
> diff --git a/block/sed-opal.c b/block/sed-opal.c=0A=
> index b1aa0cc25803..a46e8d13e16d 100644=0A=
> --- a/block/sed-opal.c=0A=
> +++ b/block/sed-opal.c=0A=
> @@ -1,18 +1,10 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * Copyright =A9 2016 Intel Corporation=0A=
>    *=0A=
>    * Authors:=0A=
>    *    Scott  Bauer      <scott.bauer@intel.com>=0A=
>    *    Rafael Antognolli <rafael.antognolli@intel.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   =0A=
>   #define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt=0A=
> diff --git a/block/t10-pi.c b/block/t10-pi.c=0A=
> index 62aed77d0bb9..0c0094609dd6 100644=0A=
> --- a/block/t10-pi.c=0A=
> +++ b/block/t10-pi.c=0A=
> @@ -1,24 +1,7 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
>   /*=0A=
>    * t10_pi.c - Functions for generating and verifying T10 Protection=0A=
>    *	      Information.=0A=
> - *=0A=
> - * Copyright (C) 2007, 2008, 2014 Oracle Corporation=0A=
> - * Written by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or=0A=
> - * modify it under the terms of the GNU General Public License version=
=0A=
> - * 2 as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful, but=
=0A=
> - * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
> - * General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public License=0A=
> - * along with this program; see the file COPYING.  If not, write to=0A=
> - * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,=0A=
> - * USA.=0A=
> - *=0A=
>    */=0A=
>   =0A=
>   #include <linux/t10-pi.h>=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 077cecdf9437..ea73df36529a 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -1,19 +1,6 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    * Copyright (C) 2001 Jens Axboe <axboe@suse.de>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify=
=0A=
> - * it under the terms of the GNU General Public License version 2 as=0A=
> - * published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - * GNU General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public Licens=0A=
> - * along with this program; if not, write to the Free Software=0A=
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=0A=
>    */=0A=
>   #ifndef __LINUX_BIO_H=0A=
>   #define __LINUX_BIO_H=0A=
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h=0A=
> index a4811410e4fc..545a480528e0 100644=0A=
> --- a/include/linux/bvec.h=0A=
> +++ b/include/linux/bvec.h=0A=
> @@ -1,21 +1,8 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    * bvec iterator=0A=
>    *=0A=
>    * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify=
=0A=
> - * it under the terms of the GNU General Public License version 2 as=0A=
> - * published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope that it will be useful,=0A=
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> - *=0A=
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> - * GNU General Public License for more details.=0A=
> - *=0A=
> - * You should have received a copy of the GNU General Public Licens=0A=
> - * along with this program; if not, write to the Free Software=0A=
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=0A=
>    */=0A=
>   #ifndef __LINUX_BVEC_ITER_H=0A=
>   #define __LINUX_BVEC_ITER_H=0A=
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h=0A=
> index 04b124fca51e..3e76b6d7d97f 100644=0A=
> --- a/include/linux/sed-opal.h=0A=
> +++ b/include/linux/sed-opal.h=0A=
> @@ -1,18 +1,10 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   /*=0A=
>    * Copyright =A9 2016 Intel Corporation=0A=
>    *=0A=
>    * Authors:=0A=
>    *    Rafael Antognolli <rafael.antognolli@intel.com>=0A=
>    *    Scott  Bauer      <scott.bauer@intel.com>=0A=
> - *=0A=
> - * This program is free software; you can redistribute it and/or modify =
it=0A=
> - * under the terms and conditions of the GNU General Public License,=0A=
> - * version 2, as published by the Free Software Foundation.=0A=
> - *=0A=
> - * This program is distributed in the hope it will be useful, but WITHOU=
T=0A=
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=
=0A=
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for=0A=
> - * more details.=0A=
>    */=0A=
>   =0A=
>   #ifndef LINUX_OPAL_H=0A=
> =0A=
=0A=
