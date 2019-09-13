Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD9C4CEC9
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B1620830
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M0YorW3d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VV/qmt7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbfIMUSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:18:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2053 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbfIMUSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 16:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568405913; x=1599941913;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kVSe8IlwWbOrCuwDTwAoBqolJc3rLO3LjxafWVdLZ6E=;
  b=M0YorW3dvmRTcE8aeYpEcQ6F464scMVHC6tsMFSjtclozNZmxt3EnKia
   cfe0BVRXLqjudXtgqQGFA+N56VFNRdcr0lk2h8drIR6tv5Gik87ZmpXk0
   ftwTH2ta/v0mZNH6jZComgVYiQeTLZlJZ2NhE5CAyoIV1kRHH57aTaBLR
   wwboQvmfCsMrlui85P6BrSklaACbyplusol3FSY9UW8MkBeSdRM7hT7ui
   PXXOJcLWBYhs8vJQxyfGmVGjHmAHv5yJ980V8H8H/cGVCN6BcuXHKsiod
   RBRq6b8HecSwSoYlc30JPZcNL6aIrzHZopsHrcbPHWCuwKcSN/HNzhsl/
   Q==;
IronPort-SDR: 8j+KneiPKb1wlZxnis6YbCyeyrz59uEZi6DIr4vk112X03OzMFGnb1DeIcPLzy6xOwetbPdVUu
 rzZXZ9NrIr0ZtLCgii4S4Kn7h20naH7658W4m0pShdK3jP5tNWVbBHvBR+XrWFW8O7JYBVhq1S
 FcQn0153ClkCiVy70Mg5ZclUWbSaTw7cBzVGvqMICjzwO3hUdmgYtxnuyKV0H7IzDAmYzAytiC
 4NO4HGQPrv/iFylptXH3exihDqU58mgxUrKVsrFtOtB3GYpPorOfBM3EpiZo2hRMVcitbnoDFk
 +cc=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="224997194"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 04:18:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlHVSjw4g4tZb/2WuK3UW38rDFPnpNFDJBZwqBtcPM1IwoJ7h+GeHIIp6sqvrSfzrp50F/mTMaVgvgBKTdXAkkWsb6YAxrlBLkiZv/9BhW8+ua1m9LF7IlDaN05c/4Q8iCCs8VkS6eo0ievPcX9RYvxQNpxDhJZU1VzdxmP5BJJUX726/HA5NBV/oD8lOfc2dzLsVXdgJEHnIE3v/G+PjWlpvKFnTdUq6yRn+w2FDMw8us0pGJiFenBBwEFVi639R6FXKUBJ7GoxyaDY5y6SHTTCJaFtbY3prHzubAlAAxPl2D+5NE443N47FgjEILiZFiGMU6uEl2oefVeUfSy4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tklQ04idnghNadg0B3yJlgqdITApnrUPW210fmZ2jxo=;
 b=SunL0oQMG+MH+v7IfZccQGDAC2iN2NR3X6B8gU1zfGTrvL4okMblP7110flZN5NVzWw+uBMWIj2TKkXhCx2srfw2sQMW76vVW8D2L93pLt9mh0EW9eI3lCwSIOP5hTqpezfV2+7O+7OdhpC4BgatTdsgSUWaKpi3xhSJbFnyPHOS8/qdVoN+TvY1ipmUn9LQUqTCYjF1PkNOIECnONeZKhIzLQC8/t3EVD4r3GkhGu2TzyFHmDpM+QVhcrhdZ7sokPvriIo/HWgFR82xOq9h4cpnoxCdfblB2z60dCVPOMmNiBKPjQt//iw8zx7mlVm3oxdT9RyM+05E2JfMwEGSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tklQ04idnghNadg0B3yJlgqdITApnrUPW210fmZ2jxo=;
 b=VV/qmt7Aij/BWQUlcETRoRUWumMFtVwdLjmpPieCzsYU/3pv4T3MNLamhlnfDZ9A6GJ9P9sUvG3ACWS3dZu6L2pGWK3w1+GAmGiBLAkBG19tWzA9ndhwnXrgG1hCptare0J0bDlj3Ld4zjWTUIDywQaRpOjU7X9LdGJqtOx4M2w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5478.namprd04.prod.outlook.com (20.178.197.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 20:18:31 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 20:18:31 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH 3/4] null_blk: format pr_* logs with pr_fmt
Thread-Topic: [PATCH 3/4] null_blk: format pr_* logs with pr_fmt
Thread-Index: AQHVamV+U8QDepbwdE+Oy7LlvKTEIA==
Date:   Fri, 13 Sep 2019 20:18:31 +0000
Message-ID: <BYAPR04MB5749503121D7B1D81B4CB44386B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <20190913185746.337429-4-andrealmeid@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83bcf9a7-91da-4984-0cc8-08d738878c08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5478;
x-ms-traffictypediagnostic: BYAPR04MB5478:
x-microsoft-antispam-prvs: <BYAPR04MB54789E8983897D5863ECF37586B30@BYAPR04MB5478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(305945005)(25786009)(4326008)(54906003)(6116002)(3846002)(102836004)(26005)(9686003)(256004)(14444005)(7696005)(81166006)(76176011)(2201001)(66946007)(66446008)(316002)(86362001)(81156014)(64756008)(66476007)(66556008)(53546011)(6506007)(53936002)(8936002)(186003)(8676002)(229853002)(478600001)(6246003)(33656002)(99286004)(7736002)(486006)(5660300002)(2906002)(6436002)(71200400001)(71190400001)(74316002)(2501003)(55016002)(476003)(52536014)(76116006)(446003)(110136005)(14454004)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5478;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VHlkwgEkJBGEgmQ10L73z7Y3RhQbjWr4WTGCiXSnrli/t4UkDalXkpzuJu5y1EQsAgPiTajVBm9PqfuCndyuleqwaN0hdqW7mTeHfNRvYuLWQHNUX0md3vsOXz8EWVu9xqvAm5QJwXFVHsaAO1NB7jiqVpmHll2ErqPxO/kCtEIdnkWaphIlyjoeYoxkNhuCJ4z/A/d6GsEes0B1NGpGyrZY654QcCZvirYWLo9fX0U2Vcsy8nBrVqDp5kih2+0zPCNwVcmfsS6Vexg6R+Yj95ULgdkEiti74MUKYleBFSvONXoqmhJw3vHG2qNdbMjQ25fn5UHjDelvQNzXDYdMlJeYVDHKLx5YU/dtLgRvUalTm/o1oI9O55uoq40E05NR7INOyRY31VlYavPn529Gy9CxFak7hnx5xA2YaveMMoA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bcf9a7-91da-4984-0cc8-08d738878c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 20:18:31.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaw4G0Zh/d4I3SPIHXVS6PFd31AclxA4vU2tP9AC/irsZDA+F1C/2zhR66Ui1gWx+6i/pr2WcgdKgArlM8YwcFRTzCfdNJTLiNAsfBGLncI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5478
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/13/2019 12:00 PM, Andr=E9 Almeida wrote:=0A=
> Instead of writing "null_blk: " at the beginning of each pr_err/info/warn=
=0A=
Please limit above line to 72 character.=0A=
> log message, format messages using pr_fmt() macro. Change the order of=0A=
> includes to prevent '"pr_fmt" redefined' warning messages.=0A=
Why change the order of headers ? Can we use #undef  ?=0A=
=0A=
This change of order for block driver looks bit odd as compare to=0A=
othe kernel block driver source code.=0A=
=0A=
See :- drivers/scsi, drivers/nvme.=0A=
>=0A=
> Signed-off-by: Andr=E9 Almeida <andrealmeid@collabora.com>=0A=
> ---=0A=
>   drivers/block/null_blk.h       |  4 +++-=0A=
>   drivers/block/null_blk_main.c  | 18 +++++++++---------=0A=
>   drivers/block/null_blk_zoned.c |  6 +++---=0A=
>   3 files changed, 15 insertions(+), 13 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
> index a1b9929bd911..2d2183320be2 100644=0A=
> --- a/drivers/block/null_blk.h=0A=
> +++ b/drivers/block/null_blk.h=0A=
> @@ -2,6 +2,8 @@=0A=
>   #ifndef __BLK_NULL_BLK_H=0A=
>   #define __BLK_NULL_BLK_H=0A=
>=0A=
> +#define pr_fmt(fmt) "null_blk: " fmt=0A=
Is there a reason why KBUILD_MODNAME is not used here ?=0A=
> +=0A=
>   #include <linux/blkdev.h>=0A=
>   #include <linux/slab.h>=0A=
>   #include <linux/blk-mq.h>=0A=
> @@ -96,7 +98,7 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t se=
ctor);=0A=
>   #else=0A=
>   static inline int null_zone_init(struct nullb_device *dev)=0A=
>   {=0A=
> -	pr_err("null_blk: CONFIG_BLK_DEV_ZONED not enabled\n");=0A=
> +	pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");=0A=
>   	return -EINVAL;=0A=
>   }=0A=
>   static inline void null_zone_exit(struct nullb_device *dev) {}=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 5d20d65041bd..081ca55bb0a6 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -3,13 +3,13 @@=0A=
>    * Add configfs and memory store: Kyungchan Koh <kkc6196@fb.com> and=0A=
>    * Shaohua Li <shli@fb.com>=0A=
>    */=0A=
> +#include "null_blk.h"=0A=
>   #include <linux/module.h>=0A=
>=0A=
>   #include <linux/moduleparam.h>=0A=
>   #include <linux/sched.h>=0A=
>   #include <linux/fs.h>=0A=
>   #include <linux/init.h>=0A=
> -#include "null_blk.h"=0A=
=0A=
Unless there is a strong reason we should avoid this change ?=0A=
=0A=
>=0A=
>   #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)=0A=
>   #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)=0A=
> @@ -1311,7 +1311,7 @@ static bool should_requeue_request(struct request *=
rq)=0A=
>=0A=
>   static enum blk_eh_timer_return null_timeout_rq(struct request *rq, boo=
l res)=0A=
>   {=0A=
> -	pr_info("null_blk: rq %p timed out\n", rq);=0A=
> +	pr_info("rq %p timed out\n", rq);=0A=
>   	blk_mq_complete_request(rq);=0A=
>   	return BLK_EH_DONE;=0A=
>   }=0A=
> @@ -1739,28 +1739,28 @@ static int __init null_init(void)=0A=
>   	struct nullb_device *dev;=0A=
>=0A=
>   	if (g_bs > PAGE_SIZE) {=0A=
> -		pr_warn("null_blk: invalid block size\n");=0A=
> -		pr_warn("null_blk: defaults block size to %lu\n", PAGE_SIZE);=0A=
> +		pr_warn("invalid block size\n");=0A=
> +		pr_warn("defaults block size to %lu\n", PAGE_SIZE);=0A=
>   		g_bs =3D PAGE_SIZE;=0A=
>   	}=0A=
>=0A=
>   	if (!is_power_of_2(g_zone_size)) {=0A=
> -		pr_err("null_blk: zone_size must be power-of-two\n");=0A=
> +		pr_err("zone_size must be power-of-two\n");=0A=
>   		return -EINVAL;=0A=
>   	}=0A=
>=0A=
>   	if (g_home_node !=3D NUMA_NO_NODE && g_home_node >=3D nr_online_nodes)=
 {=0A=
> -		pr_err("null_blk: invalid home_node value\n");=0A=
> +		pr_err("invalid home_node value\n");=0A=
>   		g_home_node =3D NUMA_NO_NODE;=0A=
>   	}=0A=
>=0A=
>   	if (g_queue_mode =3D=3D NULL_Q_RQ) {=0A=
> -		pr_err("null_blk: legacy IO path no longer available\n");=0A=
> +		pr_err("legacy IO path no longer available\n");=0A=
>   		return -EINVAL;=0A=
>   	}=0A=
>   	if (g_queue_mode =3D=3D NULL_Q_MQ && g_use_per_node_hctx) {=0A=
>   		if (g_submit_queues !=3D nr_online_nodes) {=0A=
> -			pr_warn("null_blk: submit_queues param is set to %u.\n",=0A=
> +			pr_warn("submit_queues param is set to %u.\n",=0A=
>   							nr_online_nodes);=0A=
>   			g_submit_queues =3D nr_online_nodes;=0A=
>   		}=0A=
> @@ -1803,7 +1803,7 @@ static int __init null_init(void)=0A=
>   		}=0A=
>   	}=0A=
>=0A=
> -	pr_info("null_blk: module loaded\n");=0A=
> +	pr_info("module loaded\n");=0A=
>   	return 0;=0A=
>=0A=
>   err_dev:=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index cb28d93f2bd1..670f9cf79d80 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -1,6 +1,6 @@=0A=
>   // SPDX-License-Identifier: GPL-2.0=0A=
> -#include <linux/vmalloc.h>=0A=
>   #include "null_blk.h"=0A=
> +#include <linux/vmalloc.h>=0A=
Same here.=0A=
>=0A=
>   /* zone_size in MBs to sectors. */=0A=
>   #define ZONE_SIZE_SHIFT		11=0A=
> @@ -17,7 +17,7 @@ int null_zone_init(struct nullb_device *dev)=0A=
>   	unsigned int i;=0A=
>=0A=
>   	if (!is_power_of_2(dev->zone_size)) {=0A=
> -		pr_err("null_blk: zone_size must be power-of-two\n");=0A=
> +		pr_err("zone_size must be power-of-two\n");=0A=
>   		return -EINVAL;=0A=
>   	}=0A=
>=0A=
> @@ -31,7 +31,7 @@ int null_zone_init(struct nullb_device *dev)=0A=
>=0A=
>   	if (dev->zone_nr_conv >=3D dev->nr_zones) {=0A=
>   		dev->zone_nr_conv =3D dev->nr_zones - 1;=0A=
> -		pr_info("null_blk: changed the number of conventional zones to %u",=0A=
> +		pr_info("changed the number of conventional zones to %u",=0A=
>   			dev->zone_nr_conv);=0A=
>   	}=0A=
>=0A=
>=0A=
=0A=
