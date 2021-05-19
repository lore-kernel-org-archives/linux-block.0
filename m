Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E8C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715A3610A1
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbhESJtk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 05:49:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29645 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbhESJtj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 05:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621417707; x=1652953707;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FPLES1uGZ8muexykXuBd+UEdXzNWFpTJJ0vxb5dpmg0=;
  b=pjRgj7t5y7nNgyFqZUETb66fNoJSE6Y6WoCzG56hLSMyngznkCvFHMjZ
   YvuwDh1rRLk7pkHQwZY93i7f2yMJTxcccTOzYuQuhpB8vMhi3PEdCA96y
   dGSIAj+qnjzKHrAXGsoc9GFAY3GrrTLP3KAJcUZxL/gH3bdIi8DUDG9+b
   7UaTOB5e5J5pL0c0K2r/eDjsn/XUyLMIAl5B+JnQHV+FDvVverwvzcYhz
   Jj0V97niKKhhXFR7iay4DFMc41OalzbNRhGwchqMPZcmG4mwKt5zLFep/
   W24OVcf7ozk1KQLU4rKR2sTapYsh/G++M6D9aMTjOFv9K4M9RTLt5kbAS
   Q==;
IronPort-SDR: /fy/oM7eHK0vkBHaT6Q/4T0KHOxgT/7JtDEebeutgcod+dScI9FXD2PMmPnSfRwAfEdqepLhIC
 5UuyNc/JNWZe4jzwHlBLdiKrWm3G/4PeUr3mDLfB6HiiNAE+mgp8Qra4BwPTpb0SVqRagpUQB8
 Bw7+SgEVDtPcPS/BPiblCe8piH41YtwR77konSu/PB32jO//tbHgQITxfWl632roiq6X0X65xW
 4slMuRbpQHbtISPTR1CADl5fxZMAG5xyawxJ35TPXkGlv8MvBQ8vBNYCpKwRdWnfCvs72RvYzs
 jVI=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="272628955"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 17:48:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7VedfRRmMVkvjG960B/cLo1b7xfpUxLS3UJgljTB0RejB3GKGs9q8h4sItKY9dRDuQoZtIfyHIVI0IJiVDaJpqs8kIWse2C6OPoJqIUYGfnS7+CmbkkV8CpNvl0WZId57BYU0mZVqca9nBPvd3vZVmPp6qU0eUZQ/AMy7S9Whd0vlJQ8tIKh2d8NSxkVMy0FCTXIpD+qGe0Lfr61jMNUwMemQ49ZafgkzIlLj74Bgb4ani9QOsCky3LI2q5mPk61tAxvR1JGW/wYBwUUpwEvU0ONy5nZGAHqulHrzD9ykrPRz/RHWYbzo54Ev4h2PRVOTOIkpluPRlmlrzE3RlpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BplK/ZqnPx8SOm1JFPGpBUXhBWELzMaECcR+JrngYog=;
 b=C1//Hh5hbPSMO8zmrCA1cgsCmuk3I9s1EPK0KdoBmqG4IKZKjAKyCOXk9g9FaGdGMjY53oyGWveBWIak9ieuwxOMNDfOZ7gCQckJ8F34RCxa/2M/C/XDvHMxOGg1j1bgAxg/uCFLeY+/rRvcCeDqp5vr3iirlds4bUNASZS+XmAAgocpHJSbdUA1IHXzortiHfR42ooz8mlfcmdDkCGp/zksB25/Fq93pPOFpZJnx1Gp4ouYG5PSy8OQotd1utTAXvE6i+aVowz3bpMixAC1jNedLwpQ4Urjmev/ZZCNSGsH0Y/jPK8XwewKL2Q3zTjD2TyLNxAK25C1dxec9Ohjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BplK/ZqnPx8SOm1JFPGpBUXhBWELzMaECcR+JrngYog=;
 b=M4JG66vKU3UhFF7X6qemXyymlaLZ2wOBiOTDMV8Fcq7lmVUNqC37nfRZaAruA2H4p1ijd8RCxrdbsiN+lW483jrbFsQMPgbAZJhyC2g7B54aQ8QDMqs3ilifURjnqC1bnWzWMq0CPuW7jrLf/LRNHdAxk3waIZI5BwBBudv9fIA=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB3884.namprd04.prod.outlook.com (2603:10b6:5:b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 09:48:16 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 09:48:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXTFpwS0LsVhLQQ0izn4qPVyCy/w==
Date:   Wed, 19 May 2021 09:48:15 +0000
Message-ID: <DM6PR04MB7081B7C64FA38C3DEC0C7D89E72B9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-2-damien.lemoal@wdc.com>
 <YKTb472jEYoMoQHQ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:688d:8185:801b:83a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368fcfba-5a59-467c-6e48-08d91aab39b6
x-ms-traffictypediagnostic: DM6PR04MB3884:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB388438AE6A4E1589050923CCE72B9@DM6PR04MB3884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwkSoilDCS2fP8M2LCot7JarlTV3SfmUXFHroeHVn7px6jysSH5ldXYBQ4cI789AETGGrCStlsjLO5AciMsgDDnlvbluFONAz+IMgAs30kBFWRrInxB66aaiY/26WB0ZXroaUcuFK2xjrAI3OtTKV9jbCst+pf/UYkBN27qVxrZcbWHCTAEInvsgb1puJn1RNx+fJ+VPaSu0hze3GQj4fAxRIDRdbgvPIGVUxyDptmaUG7OT6vxdPQ2IrGeZsD1PX1yZLzcPXfjmLmmOxnyX0RLut4SkcI0kZzaqEoPiwquj6flUDvG7BKdCthTEIShjuP/AkI+TYB30T+gtDj79fRZtMW/ElG3YZ0tNafaHQP5ihYqB4TtDARg6zM1KcCEsy4GwwdkUW0/6t9SagWG6Chd/1odsMv62lseEuU6nyH6Z1grnwRUaISHxUqpHp+c1gBAsyxtVA10rFO4s6LfuFJwuxTB2dH85d35tbl36JEcvA9x+WbPv2sVAqhE1wU2Va2HFD31XJCH0qR8Z4+Egxo9Aa4sRHsNdnAZJyBb1ZMssMOwhWtwWh3n0yPqNKUWRHe3odZbZS/DQtYOw+Ag/yoxEhk1N65rsYIWgLc/iRWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(5660300002)(54906003)(33656002)(186003)(8936002)(52536014)(8676002)(122000001)(83380400001)(38100700002)(71200400001)(316002)(66556008)(4326008)(2906002)(6916009)(86362001)(53546011)(6506007)(478600001)(91956017)(76116006)(55016002)(9686003)(66946007)(7696005)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pSp8NM1VDdxy5/vLgyOjvWzKDpvc3Zuf3rxcI050M7J8fvtrDb38nsStaQ5z?=
 =?us-ascii?Q?rCXWwVgllcULkR/WwpoI60Z5vXHavZk5bp6Ex47lVc6PKqb+UalJtNh6Qr6S?=
 =?us-ascii?Q?toHDI2Unf3NGyK9z6BrMrxN7poRg4oe6cNaNA6p4hafTISleh7Lks6AFnRaT?=
 =?us-ascii?Q?X4jj/o5aI/lxTP8GAe+1nrCaXNJ4rAqyAKwhlI4vAzBe4E36oQyYcvq+EmeP?=
 =?us-ascii?Q?OBQb/zkIGGHz/i5+C6luC5DVVk8QVMMBPxGYs8YwBh+TJXEITqmSETnJvnSh?=
 =?us-ascii?Q?B50I5Q4NdQnEVCgRUt29HbfbLxPfIBsE246ztgJzENClps2vGvJwDnbiUNsq?=
 =?us-ascii?Q?YHIYnaQAZ2C1uFVDK7fy2fYEFjfrBWL+soBir3BXGx8z8i+cuvbKRwgN5YZc?=
 =?us-ascii?Q?bdv6QVnekM7vSxxxbZbD1mPV7TVxgJrrs9Ogp0Huk9tU4UdC2WHZThz+0ESq?=
 =?us-ascii?Q?UJIV/y4MTgJO+zvEYY1mVUUxuZ4We4gy7BURyeTd5PKvpsX4NIDb3qQx3gvh?=
 =?us-ascii?Q?IrjR4fpGWrA7hdzQNH9liSHhc0m1qoiDLIYuG08OQ4k+sYJGJN2QNg4NnUwk?=
 =?us-ascii?Q?v+HEXxxRML4kzHS8TJTPRfUMTkflEd+RFx1dTzH2MOqC8OvXuZawvom4/wpK?=
 =?us-ascii?Q?gm7XKKAHxbStpLxspWrVVq6SNiCYMMI6GqcL6rN4Mo25FShsOl8JveXij67R?=
 =?us-ascii?Q?kWZCdqoWx0Zbyr3yv7AedW96DrAXJmtEpMLMk/gXWMQhPTuioTMnagL47PG4?=
 =?us-ascii?Q?UB0zpMbLF5t+2XgHfJL8o0X/YM0I2ZV8duP8QoylMtHKORsXGvJfb/vaNa5o?=
 =?us-ascii?Q?eQ1BqCn8EabD6yGgaJ3Cu1Ri41Pz51bD2zIcp1a9MZX/QS7qCwWN6L29mmUt?=
 =?us-ascii?Q?FUKXzn2ixnIqunZpFC2uAYspDrr76qQv880/DJQa/K0dBBkDDrexDQ/eyWQF?=
 =?us-ascii?Q?YO0C9BWg9J2TJUYqT7yQSmmLH/16/fjmB6mupMYrFnMYNjBfFFXWCcOd2nQO?=
 =?us-ascii?Q?FmTXIpJuwca1MeS5p7aJt87X37izWL00XSUp7THbZJ83IISqaIqanOZ6QWrx?=
 =?us-ascii?Q?v+1mognNPPm1Dmfrx+SB6xBVVGKUGZWPgTLuqYtRWRg7SZ3zWzDE70E1Ri+S?=
 =?us-ascii?Q?GxOXf29eo5fSlqFkbHpvVpbyXGtXWccPqGalZDZxx9MjBk+E9aJ1wFesAow/?=
 =?us-ascii?Q?YiAAIKpUBr30U5dU0aAhMeTkw0mpqtX9zMRn8ALP8ROpHhMKDRdr2LsGCm8E?=
 =?us-ascii?Q?AJDEBZ/RpNVn9JFodRAxoasjqM0V5tAgHsN96OSyHJAr02cMm8Xbw1bFsatF?=
 =?us-ascii?Q?LQPoG7+olbeaAfHaGXBn8PGl+HLpZUsE2kZlmuvu7KwXyDSDFiLWMMCtVHCp?=
 =?us-ascii?Q?tMWqOv2oWoXXYmSf8zIG5VPpX938lmTm/jMeVUxloAhmNz7Mvg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368fcfba-5a59-467c-6e48-08d91aab39b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 09:48:15.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UkWRySMxO9BO5bT/OHUeE1tnKC1t6dp2lP7GsbeC925yihK2iVHBhmA2A2r+5oBzij25MJlUaZB2XxYsbsS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/19 18:36, Christoph Hellwig wrote:=0A=
> The logic looks fine to me, but this makes blkdev_zone_mgmt extremely=0A=
> convoluted.  What do you think of the version below that splits out=0A=
> two self contained helpers instead?=0A=
=0A=
Yep, that works for me. Will use this in v2.=0A=
=0A=
> =0A=
> ---=0A=
> From 3ff31f2502cf032ac1331122c9f1a018b769b577 Mon Sep 17 00:00:00 2001=0A=
> From: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Date: Wed, 19 May 2021 11:55:19 +0900=0A=
> Subject: block: improve handling of all zones reset operation=0A=
> =0A=
> SCSI, ZNS and null_blk zoned devices support resetting all zones using=0A=
> a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device=
=0A=
> request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for=0A=
> device mapper targets creating zoned devices. In this case, a user=0A=
> request for resetting all zones of a device is processed in=0A=
> blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each=0A=
> zone of the device. This leads to different behaviors of the=0A=
> BLKRESETZONE ioctl() depending on the target device support for the=0A=
> reset all operation. E.g.=0A=
> =0A=
> blkzone reset /dev/sdX=0A=
> =0A=
> will reset all zones of a SCSI device using a single command that will=0A=
> ignore conventional, read-only or offline zones.=0A=
> =0A=
> But a dm-linear device including conventional, read-only or offline=0A=
> zones cannot be reset in the same manner as some of the single zone=0A=
> reset operations issued by blkdev_zone_mgmt() will fail. E.g.:=0A=
> =0A=
> blkzone reset /dev/dm-Y=0A=
> blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error=0A=
> =0A=
> To simplify applications and tools development, unify the behavior of=0A=
> an all-zone reset operation by modifying blkdev_zone_mgmt() to not=0A=
> issue a zone reset operation for conventional, read-only and offline=0A=
> zones, thus mimicking what an actual reset-all device command does on a=
=0A=
> device supporting REQ_OP_ZONE_RESET_ALL. The zones needing a reset are=0A=
> identified using a bitmap that is initialized using a zone report.=0A=
> Since empty zones do not need a reset, also ignore these zones.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> [hch: split into multiple functions]=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  block/blk-zoned.c | 115 +++++++++++++++++++++++++++++++++++-----------=
=0A=
>  1 file changed, 88 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 250cb76ee615..48e8376c1db8 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -161,18 +161,85 @@ int blkdev_report_zones(struct block_device *bdev, =
sector_t sector,=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
>  =0A=
> -static inline bool blkdev_allow_reset_all_zones(struct block_device *bde=
v,=0A=
> -						sector_t sector,=0A=
> -						sector_t nr_sectors)=0A=
> +static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
> +						   unsigned int nr_zones)=0A=
>  {=0A=
> -	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))=0A=
> -		return false;=0A=
> +	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),=0A=
> +			    GFP_NOIO, node);=0A=
> +}=0A=
>  =0A=
> +static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int id=
x,=0A=
> +				  void *data)=0A=
> +{=0A=
>  	/*=0A=
> -	 * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sectors=
=0A=
> -	 * of the applicable zone range is the entire disk.=0A=
> +	 * For an all-zones reset, ignore conventional, empty, read-only=0A=
> +	 * and offline zones.=0A=
>  	 */=0A=
> -	return !sector && nr_sectors =3D=3D get_capacity(bdev->bd_disk);=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_NOT_WP:=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +	case BLK_ZONE_COND_READONLY:=0A=
> +	case BLK_ZONE_COND_OFFLINE:=0A=
> +		return 0;=0A=
> +	default:=0A=
> +		set_bit(idx, (unsigned long *)data);=0A=
> +		return 0;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static int blkdev_zone_reset_all_emulated(struct block_device *bdev,=0A=
> +		     gfp_t gfp_mask)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
> +	sector_t capacity =3D get_capacity(bdev->bd_disk);=0A=
> +	sector_t zone_sectors =3D blk_queue_zone_sectors(q);=0A=
> +	unsigned long *need_reset;=0A=
> +	sector_t sector;=0A=
> +	struct bio *bio =3D NULL;=0A=
> +	int ret;=0A=
> +=0A=
> +	need_reset =3D blk_alloc_zone_bitmap(q->node, q->nr_zones);=0A=
> +	if (!need_reset)=0A=
> +		return -ENOMEM;=0A=
> +	ret =3D bdev->bd_disk->fops->report_zones(bdev->bd_disk, 0,=0A=
> +				q->nr_zones, blk_zone_need_reset_cb,=0A=
> +				need_reset);=0A=
> +	if (ret < 0)=0A=
> +		goto out_free_need_reset;=0A=
> +=0A=
> +	ret =3D 0;=0A=
> +	while (sector < capacity) {=0A=
> +		if (!test_bit(blk_queue_zone_no(q, sector), need_reset)) {=0A=
> +			sector +=3D zone_sectors;=0A=
> +			continue;=0A=
> +		}=0A=
> +		bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
> +		bio_set_dev(bio, bdev);=0A=
> +		bio->bi_opf =3D REQ_OP_ZONE_RESET | REQ_SYNC;=0A=
> +		bio->bi_iter.bi_sector =3D sector;=0A=
> +		sector +=3D zone_sectors;=0A=
> +=0A=
> +		/* This may take a while, so be nice to others */=0A=
> +		cond_resched();=0A=
> +	}=0A=
> +=0A=
> +	if (bio) {=0A=
> +		ret =3D submit_bio_wait(bio);=0A=
> +		bio_put(bio);=0A=
> +	}=0A=
> +out_free_need_reset:=0A=
> +	kfree(need_reset);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_ma=
sk)=0A=
> +{=0A=
> +	struct bio bio;=0A=
> +=0A=
> +	bio_init(&bio, NULL, 0);=0A=
> +	bio_set_dev(&bio, bdev);=0A=
> +	bio.bi_opf =3D REQ_OP_ZONE_RESET_ALL | REQ_SYNC;=0A=
> +	return submit_bio_wait(&bio);=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> @@ -200,7 +267,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum =
req_opf op,=0A=
>  	sector_t capacity =3D get_capacity(bdev->bd_disk);=0A=
>  	sector_t end_sector =3D sector + nr_sectors;=0A=
>  	struct bio *bio =3D NULL;=0A=
> -	int ret;=0A=
> +	int ret =3D 0;=0A=
>  =0A=
>  	if (!blk_queue_is_zoned(q))=0A=
>  		return -EOPNOTSUPP;=0A=
> @@ -222,20 +289,21 @@ int blkdev_zone_mgmt(struct block_device *bdev, enu=
m req_opf op,=0A=
>  	if ((nr_sectors & (zone_sectors - 1)) && end_sector !=3D capacity)=0A=
>  		return -EINVAL;=0A=
>  =0A=
> +	/*=0A=
> +	 * In the case of a zone reset operation over all zones,=0A=
> +	 * REQ_OP_ZONE_RESET_ALL can be used with devices supporting this=0A=
> +	 * command. For other devices, we emulate this command behavior by=0A=
> +	 * identifying the zones needing a reset.=0A=
> +	 */=0A=
> +	if (op =3D=3D REQ_OP_ZONE_RESET && sector =3D=3D 0 && nr_sectors =3D=3D=
 capacity) {=0A=
> +		if (!blk_queue_zone_resetall(q))=0A=
> +			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);=0A=
> +		return blkdev_zone_reset_all(bdev, gfp_mask);=0A=
> +	}=0A=
> +=0A=
>  	while (sector < end_sector) {=0A=
>  		bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
>  		bio_set_dev(bio, bdev);=0A=
> -=0A=
> -		/*=0A=
> -		 * Special case for the zone reset operation that reset all=0A=
> -		 * zones, this is useful for applications like mkfs.=0A=
> -		 */=0A=
> -		if (op =3D=3D REQ_OP_ZONE_RESET &&=0A=
> -		    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors)) {=0A=
> -			bio->bi_opf =3D REQ_OP_ZONE_RESET_ALL | REQ_SYNC;=0A=
> -			break;=0A=
> -		}=0A=
> -=0A=
>  		bio->bi_opf =3D op | REQ_SYNC;=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
>  		sector +=3D zone_sectors;=0A=
> @@ -396,13 +464,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> -static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
> -						   unsigned int nr_zones)=0A=
> -{=0A=
> -	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),=0A=
> -			    GFP_NOIO, node);=0A=
> -}=0A=
> -=0A=
>  void blk_queue_free_zone_bitmaps(struct request_queue *q)=0A=
>  {=0A=
>  	kfree(q->conv_zones_bitmap);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
