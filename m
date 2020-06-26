Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E6C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D59207D8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 01:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fxyV2kDO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V6sIzCgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFZBiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:38:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30500 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgFZBiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 21:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593135491; x=1624671491;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VNEMBL64Nrrgorsa6euS7Ll8zBO3+Ywn5BMhE93AZY4=;
  b=fxyV2kDOTAagrFD7Nsj/osURtd3kCm1Va3Kmn7oss0qLjy/77Ug7dyR3
   pFWiel9bRz9xpQvmflyytnBjH9//kr8maiXHN8pgqzqrb3t56foJEBFB1
   uN6mL1kCEegsZdUSwrlmL76/FBDoSdcOjEHIbZHIqGVl0cYpz8pXo8ojQ
   lkym1rn3l8TWD9VsyHE3hvaXhjqLroUBci88wV01KhZmYfuEox67xB7Wu
   4v0bLN6aadFd/CYh/OsmSp58NaBD4/SyK5D3mHmtZ5qX0Uc7jrYjnGbFX
   nxwYi0hRi5u3Xg+b+VsmwrxgAnIqf0EzU1n7tFpxWAn1xnsmNwc16P+UY
   A==;
IronPort-SDR: J6kbdRdMjWTHGcjUBoRXjdeWbF8HMQ8v6Jx0GDSQajRUP8uEPoFYK5Itejh4b9KyN6PAF4pEP5
 lT9I98wl0MbHDyTNboljsLolVtcEELkFkVCtAhBbNr8QSISMcXndWxqAFNHKqmTOOjabF9m1uW
 xdJ5afp24bS3LHSsgIpDqUYrjefZdKsUi8xFqJMNi+bQhUKKZ9uRtUqv+wD5E2INqmc2bxXz4N
 s2OsneFcJY8gl3KbfQABxngJvRQeZBF6cyIltHGXzE6iTAtkUCUI2mV/DyXUlcBvsAT2vMOL5J
 UM8=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="142330076"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:38:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2OOg4G/qXXGY8zZ9tNKPOWS7ejzNp0HxzxsUzfJomgaTXoC7qIYkHxh9NHpXWkPb5JtMtkHv/KWEYZqIGsExoU/z+lztBS28H14WQc2T0v9569MwYQDWjMFSA2LoF3jo9f5V/5mQPrqtN4ZrFNHhXOZr0LjkSqIQae1cPW3lqUzl9j0pgaxjJMoTPAnyK7jiJ55U/xCdl/vJBpU4BVE+x1DpWfBAjDI3vwofsqOelsHCbiYlvmvDSEWLvMB8fCMx/9AyUeFuKEvL5nM6PZYx0pFR8ewNscBXA09MjRywBdsKlGJ1hRe7lj8K6wKZPFcS596WkyJxSBlSM/L+B7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF1wiQPZqW0R3xp+/BYfIeRC4HaS/cdipp7x2Hb2Eus=;
 b=kk0WFs4KEegUw69d4Q+bEathZOw19S0nQoKJfdvglkHSSppiVmSRSq4ezHF/ygLBQUO+T106VNUgddkLhc04g2IDgWuQCC3/qds3yTwNJi5suIRm4KJZVHvEUdn808vz2fe1PffRmE6Sg7NXSHiNEbVmxC9AQvaa31bSi168as/scYtWjELO7debA7p4LIt03I/rOOdn3hkh66rhfE23vu0yXwMphfLLyKO0phZ75j5nIXKgvxW8P9moYVApwGP7rywpE7tbWjMdx244/ksmaGXOqsxiwf2GRrZTcSdrTeWPXwXyplzZXDKS4MONtlj8D5mTJWg0NRWejr5IV6SIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF1wiQPZqW0R3xp+/BYfIeRC4HaS/cdipp7x2Hb2Eus=;
 b=V6sIzCgpnpA5cS+d0DMaiZrgQf0jldLwagbpXXUqBl8GRO43kPJ9wfWRLl0FVo085FMRlw7NiRKQmSU4G3XB8xojHqUyTMjc0Z9kQyS8Xslq4nPKeE1CILVxrbwHDl415jUZjMzxNewh+Nkjst4ni+sYeoGmLF2j0vJJj/M/lkE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 01:38:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:38:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Topic: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Index: AQHWSutNlrk/U7ZovU6aHVaoqZz0nw==
Date:   Fri, 26 Jun 2020 01:38:07 +0000
Message-ID: <CY4PR04MB3751A4DAA69F56A10F3D9196E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92c2e757-96cf-4237-c4ed-08d819719439
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB1032CC2F8B15D3E9BF246F9EE7930@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZZfGOeqp6hCBxCnZSwjhD9A5VGnOaJAbQZ0d6KQtRYwADAtYY6D2Eh8T2xx1XO5YWhRJfhjUNZP7PunSljcn5FQ0/bioeI7p6jFoo9sWWz4GMK5DEShKk7O/XzkiWHuwpseD0GLEwCXshR4bRO6eDa7y/ojSQ5xZMbkdGsyroZw17iMIFvm7ipxgS2aIhINCRtIzbMTKqGf25C1ippmjHG1MtwifuxM+qIJYsT0+OcT8hefAMw/xASP2P1uOl5AmVY4NhRisZdnKh8/daTmI3t7V44cjNolboVDy/XEujVUfLujY1iR7FHvog1Rf7mSRPl2focajZJa/Y6gbT64rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(91956017)(7416002)(86362001)(55016002)(66446008)(2906002)(83380400001)(66946007)(71200400001)(66476007)(64756008)(478600001)(66556008)(5660300002)(186003)(76116006)(9686003)(26005)(8936002)(33656002)(53546011)(316002)(6506007)(66574015)(4326008)(8676002)(54906003)(52536014)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uZZwbHSLXYa2LABKJl2J4tuUkITX2ZHKtKuuoUzHEs5zKMvvYKf6gZH1N4YNrcHQ/q8Y0wmZoWSkQQO8Xs3nkw7haV+bi1rDyAj0QEoqlTtr5U0VgjAJBSSpBFTJ+5L9pYEWd2owxMW20QUtX75pOVfacdroi0ojaLP+zGbCZJDuZEyGYa88Bvdq1L5A31JvDYe6DWTZndKHbn/YBROahx7WNc+3LyTouM1DOG84Yvc635wB74Uc4Tm6Q9zwVKOE88IeGBwSBjM1R+1MkZuowKMqnENVkMReetaSxpwYV30Wi1DgnkF+HdBfNBjKDtUVfqEZqCRpr5M8QqE09RY6d0iqWlWhgmAbilBXZJTQePB/CdrIpXVssbpiCxx9UwP5/uEyRclHAWb4NKwaNzUtAOARF35DSaJcBJthF6igIPPHVkWX+gxHzX7GECca6ChpRwBzHSQWi35XafBpGBKmJXaK1YtaChL8HhZlP/dUYwY9Ql2QIrY2otmBbL894lne
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2e757-96cf-4237-c4ed-08d819719439
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:38:07.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJC9tfaPbYDLNetwjoTsNXqAi+0LRIvxiSW+fzBed6Bzb8RcKCMSme9OihnE45VMU9x/yt1bE3JWkXytSuyQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> With the addition of ZNS, a new set of properties have been added to the=
=0A=
> zoned block device. This patch introduces a new IOCTL to expose these=0A=
> rroperties to user space.=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  block/blk-zoned.c             | 46 ++++++++++++++++++++++++++=0A=
>  block/ioctl.c                 |  2 ++=0A=
>  drivers/nvme/host/core.c      |  2 ++=0A=
>  drivers/nvme/host/nvme.h      | 11 +++++++=0A=
>  drivers/nvme/host/zns.c       | 61 +++++++++++++++++++++++++++++++++++=
=0A=
>  include/linux/blkdev.h        |  9 ++++++=0A=
>  include/uapi/linux/blkzoned.h | 13 ++++++++=0A=
>  7 files changed, 144 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 704fc15813d1..39ec72af9537 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -169,6 +169,17 @@ int blkdev_report_zones(struct block_device *bdev, s=
ector_t sector,=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
>  =0A=
> +static int blkdev_report_zonedev_prop(struct block_device *bdev,=0A=
> +				      struct blk_zone_dev *zprop)=0A=
> +{=0A=
> +	struct gendisk *disk =3D bdev->bd_disk;=0A=
> +=0A=
> +	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zone_p))=0A=
> +		return -EOPNOTSUPP;=0A=
> +=0A=
> +	return disk->fops->report_zone_p(disk, zprop);=0A=
> +}=0A=
> +=0A=
>  static inline bool blkdev_allow_reset_all_zones(struct block_device *bde=
v,=0A=
>  						sector_t sector,=0A=
>  						sector_t nr_sectors)=0A=
> @@ -430,6 +441,41 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  				GFP_KERNEL);=0A=
>  }=0A=
>  =0A=
> +int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,=0A=
> +			unsigned int cmd, unsigned long arg)=0A=
> +{=0A=
> +	void __user *argp =3D (void __user *)arg;=0A=
> +	struct request_queue *q;=0A=
> +	struct blk_zone_dev zprop;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!argp)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	q =3D bdev_get_queue(bdev);=0A=
> +	if (!q)=0A=
> +		return -ENXIO;=0A=
> +=0A=
> +	if (!blk_queue_is_zoned(q))=0A=
> +		return -ENOTTY;=0A=
> +=0A=
> +	if (!capable(CAP_SYS_ADMIN))=0A=
> +		return -EACCES;=0A=
> +=0A=
> +	if (!(mode & FMODE_WRITE))=0A=
> +		return -EBADF;=0A=
> +=0A=
> +	ret =3D blkdev_report_zonedev_prop(bdev, &zprop);=0A=
> +	if (ret)=0A=
> +		goto out;=0A=
> +=0A=
> +	if (copy_to_user(argp, &zprop, sizeof(struct blk_zone_dev)))=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +out:=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
>  						   unsigned int nr_zones)=0A=
>  {=0A=
> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
> index 0ea29754e7dd..f7b4e0f2dd4c 100644=0A=
> --- a/block/ioctl.c=0A=
> +++ b/block/ioctl.c=0A=
> @@ -517,6 +517,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,=0A=
>  		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);=0A=
>  	case BLKMGMTZONE:=0A=
>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);=0A=
> +	case BLKZONEDEVPROP:=0A=
> +		return blkdev_zonedev_prop(bdev, mode, cmd, arg);=0A=
>  	case BLKGETZONESZ:=0A=
>  		return put_uint(argp, bdev_zone_sectors(bdev));=0A=
>  	case BLKGETNRZONES:=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 5b95c81d2a2d..a32c909a915f 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2254,6 +2254,7 @@ static const struct block_device_operations nvme_fo=
ps =3D {=0A=
>  	.getgeo		=3D nvme_getgeo,=0A=
>  	.revalidate_disk=3D nvme_revalidate_disk,=0A=
>  	.report_zones	=3D nvme_report_zones,=0A=
> +	.report_zone_p	=3D nvme_report_zone_prop,=0A=
>  	.pr_ops		=3D &nvme_pr_ops,=0A=
>  };=0A=
>  =0A=
> @@ -2280,6 +2281,7 @@ const struct block_device_operations nvme_ns_head_o=
ps =3D {=0A=
>  	.compat_ioctl	=3D nvme_compat_ioctl,=0A=
>  	.getgeo		=3D nvme_getgeo,=0A=
>  	.report_zones	=3D nvme_report_zones,=0A=
> +	.report_zone_p	=3D nvme_report_zone_prop,=0A=
>  	.pr_ops		=3D &nvme_pr_ops,=0A=
>  };=0A=
>  #endif /* CONFIG_NVME_MULTIPATH */=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index ecf443efdf91..172e0531f37f 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -407,6 +407,14 @@ struct nvme_ns {=0A=
>  	u8 pi_type;=0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>  	u64 zsze;=0A=
> +=0A=
> +	u32 nr_zones;=0A=
> +	u32 mar;=0A=
> +	u32 mor;=0A=
> +	u32 rrl;=0A=
> +	u32 frl;=0A=
> +	u16 zoc;=0A=
> +	u16 ozcs;=0A=
>  #endif=0A=
>  	unsigned long features;=0A=
>  	unsigned long flags;=0A=
> @@ -704,11 +712,14 @@ int nvme_update_zone_info(struct gendisk *disk, str=
uct nvme_ns *ns,=0A=
>  int nvme_report_zones(struct gendisk *disk, sector_t sector,=0A=
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
>  =0A=
> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zpr=
op);=0A=
> +=0A=
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct reques=
t *req,=0A=
>  				       struct nvme_command *cmnd,=0A=
>  				       enum nvme_zone_mgmt_action action);=0A=
>  #else=0A=
>  #define nvme_report_zones NULL=0A=
> +#define nvme_report_zone_prop NULL=0A=
>  =0A=
>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,=
=0A=
>  		struct request *req, struct nvme_command *cmnd,=0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index 2e6512ac6f01..258d03610cc0 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -32,6 +32,28 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)=
=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)=0A=
> +{=0A=
> +	struct nvme_command c =3D { };=0A=
> +	struct nvme_zone_report report;=0A=
> +	int buflen =3D sizeof(struct nvme_zone_report);=0A=
> +	int ret;=0A=
> +=0A=
> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;=0A=
> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);=0A=
> +	c.zmr.slba =3D cpu_to_le64(0);=0A=
> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));=0A=
> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;=0A=
> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;=0A=
> +	c.zmr.pr =3D 0;=0A=
> +=0A=
> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	return le64_to_cpu(report.nr_zones);=0A=
> +}=0A=
> +=0A=
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,=0A=
>  			  unsigned lbaf)=0A=
>  {=0A=
> @@ -87,6 +109,13 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,=0A=
>  		goto free_data;=0A=
>  	}=0A=
>  =0A=
> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);=0A=
> +	ns->mar =3D le32_to_cpu(id->mar);=0A=
> +	ns->mor =3D le32_to_cpu(id->mor);=0A=
> +	ns->rrl =3D le32_to_cpu(id->rrl);=0A=
> +	ns->frl =3D le32_to_cpu(id->frl);=0A=
> +	ns->zoc =3D le16_to_cpu(id->zoc);=0A=
> +=0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
>  free_data:=0A=
> @@ -230,6 +259,38 @@ int nvme_report_zones(struct gendisk *disk, sector_t=
 sector,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +static int nvme_ns_report_zone_prop(struct nvme_ns *ns, struct blk_zone_=
dev *zprop)=0A=
> +{=0A=
> +	zprop->nr_zones =3D ns->nr_zones;=0A=
> +	zprop->zoc =3D ns->zoc;=0A=
> +	zprop->ozcs =3D ns->ozcs;=0A=
> +	zprop->mar =3D ns->mar;=0A=
> +	zprop->mor =3D ns->mor;=0A=
> +	zprop->rrl =3D ns->rrl;=0A=
> +	zprop->frl =3D ns->frl;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zpr=
op)=0A=
> +{=0A=
> +	struct nvme_ns_head *head =3D NULL;=0A=
> +	struct nvme_ns *ns;=0A=
> +	int srcu_idx, ret;=0A=
> +=0A=
> +	ns =3D nvme_get_ns_from_disk(disk, &head, &srcu_idx);=0A=
> +	if (unlikely(!ns))=0A=
> +		return -EWOULDBLOCK;=0A=
> +=0A=
> +	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS)=0A=
> +		ret =3D nvme_ns_report_zone_prop(ns, zprop);=0A=
> +	else=0A=
> +		ret =3D -EINVAL;=0A=
> +	nvme_put_ns_from_disk(head, srcu_idx);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct reques=
t *req,=0A=
>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)=0A=
>  {=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 8308d8a3720b..0c0faa58b7f4 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -372,6 +372,8 @@ extern int blkdev_zone_ops_ioctl(struct block_device =
*bdev, fmode_t mode,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,=0A=
>  				  unsigned int cmd, unsigned long arg);=0A=
> +extern int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,=
=0A=
> +			unsigned int cmd, unsigned long arg);=0A=
>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)=0A=
> @@ -400,6 +402,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct bloc=
k_device *bdev,=0A=
>  	return -ENOTTY;=0A=
>  }=0A=
>  =0A=
> +static inline int blkdev_zonedev_prop(struct block_device *bdev, fmode_t=
 mode,=0A=
> +				      unsigned int cmd, unsigned long arg)=0A=
> +{=0A=
> +	return -ENOTTY;=0A=
> +}=0A=
> +=0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
>  struct request_queue {=0A=
> @@ -1770,6 +1778,7 @@ struct block_device_operations {=0A=
>  	int (*report_zones)(struct gendisk *, sector_t sector,=0A=
>  			unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);=0A=
> +	int (*report_zone_p)(struct gendisk *disk, struct blk_zone_dev *zprop);=
=0A=
>  	struct module *owner;=0A=
>  	const struct pr_ops *pr_ops;=0A=
>  };=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index d0978ee10fc7..0c49a4b2ce5d 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -142,6 +142,18 @@ struct blk_zone_range {=0A=
>  	__u64		nr_sectors;=0A=
>  };=0A=
>  =0A=
> +struct blk_zone_dev {=0A=
> +	__u32	nr_zones;=0A=
> +	__u32	mar;=0A=
> +	__u32	mor;=0A=
> +	__u32	rrl;=0A=
> +	__u32	frl;=0A=
> +	__u16	zoc;=0A=
> +	__u16	ozcs;=0A=
> +	__u32	rsv31[2];=0A=
> +	__u64	rsv63[4];=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   * enum blk_zone_action - Zone state transitions managed from user-space=
=0A=
>   *=0A=
> @@ -209,5 +221,6 @@ struct blk_zone_mgmt {=0A=
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>  #define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)=0A=
> +#define BLKZONEDEVPROP	_IOR(0x12, 138, struct blk_zone_dev)=0A=
>  =0A=
>  #endif /* _UAPI_BLKZONED_H */=0A=
> =0A=
=0A=
As commented already, NVMe passthrough or sysfs device attributes would be =
much=0A=
better. See scsi: there is no IOCTL defined to obtain every single log page=
 or=0A=
mode page defined. Passthrough is the interface to do that. For frequently =
used=0A=
log pages giving device information, sysfs is used as a cache. See all the=
=0A=
"vpd_pgXX" entries under /sys/block/sdX/device. All of this is done by the=
=0A=
driver. Not the block layer.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
