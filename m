Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92643C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 08:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6090A2080A
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 08:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rSrGEQtc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b+ihrerN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436780AbfFLIFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:05:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64882 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFLIFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 04:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560326701; x=1591862701;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yhmqNlfKuQuvCBa7d885j5+b3PdzWELqV+WF+j17fqg=;
  b=rSrGEQtcRtJv3PlbU/9JaQadt5mTb29B8v+lX527L550V6XbAWlHOI8C
   8mI201XBAlfeHMqWKVzryOMivZlwlm3XZdftyIimWr/RXDagxUOt4958o
   ea/+gNA2HbdyiLsSQHtrHLdpv/syAuNqlnKUIyCOyJoJewGIgL+HM1Y1n
   OuWmbJL1Q9aaBUuQOQWdEhq/7EgDf+35F+TPVMmHqIdWca5ls5SaCva1/
   cS0fjt0T/SoKos4nucBT5nSI2P6bKUeI+lq88KWqI2xpKd1jzJkE16Q1K
   pn9Q5BaHb2wZAHKrGIdgq1Ip3HTAjsF6IcK0KqxZZCIl2zdR1pVo7wMmq
   A==;
X-IronPort-AV: E=Sophos;i="5.63,363,1557158400"; 
   d="scan'208";a="111627970"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 16:05:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUkdzTWxOuKFqBO9XqXQCYCwcsjYOMsinQgsvmvTicQ=;
 b=b+ihrerNN29I9qWz609znj3PKKp7DWoQ/dZlSXuAe3fmU+FZrmPyfPaVLbQHPiV3Kt0P2za148Fqf/HCHFi1yW/4pvgy5FBFAiXFPr70bkSy//RybDNElO/7qsH9VnMxer79nqB0Syba0NUjuMPw7kGGKVzipm+OaolR5BvZZJM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3799.namprd04.prod.outlook.com (52.135.214.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Wed, 12 Jun 2019 08:04:59 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 08:04:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: remove duplicate check for report zone
Thread-Topic: [PATCH] null_blk: remove duplicate check for report zone
Thread-Index: AQHVIKJ5L4UxV0i54kOhjzYRlZskbA==
Date:   Wed, 12 Jun 2019 08:04:59 +0000
Message-ID: <BYAPR04MB5816224DDFF15E5BB339A1D8E7EC0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [82.130.71.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23444e8f-1866-4ba5-fb31-08d6ef0caa5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3799;
x-ms-traffictypediagnostic: BYAPR04MB3799:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB37996C77CDFE23E5E9503BB3E7EC0@BYAPR04MB3799.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(136003)(376002)(189003)(199004)(3846002)(229853002)(6436002)(110136005)(53936002)(6116002)(5660300002)(486006)(64756008)(7696005)(478600001)(102836004)(71190400001)(86362001)(72206003)(66476007)(71200400001)(53546011)(9686003)(446003)(66556008)(99286004)(55016002)(476003)(76176011)(186003)(66446008)(26005)(6506007)(2501003)(66066001)(14454004)(14444005)(8676002)(68736007)(66946007)(81166006)(25786009)(7736002)(256004)(8936002)(91956017)(76116006)(2906002)(81156014)(52536014)(316002)(74316002)(33656002)(73956011)(305945005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3799;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JDLTyARXQI1McuoxF37o+fMwSpfsAQpXbPZr+WreXUm6QP2fdOkAtjCkdV2zU1QkuOO62aHw62RCOJPCmWzSYehKqGKTAkFl+I0EltNKd1d1kvZf5d6fMuRH5V5a6SBQ1vrcZI0cCOVIVbdavA2gEBFlxXOZihz5RVOe1u1GT0MTDHov//EtRp4kQX28L5UjlUgJ0qldOVjZP95AqldnQrN6HlqZId+3vb1ZN4CWtiweLYf+tQYWIHWTL/vpFtscZDbHgwKSdB7F/l6FHJ/TTZNgdE2mGZZG+Yif1dY9fVfQNkoARgryTtwLryGbAZ5DKKJSo/khT223gbjMLcnmNvvEDiw7p3IJfKmP1JtZvzg/YTuqt1fDDT2GxO2xEl92CoN/9YiarUnZ8y0HpPXgCuL4dM+ujLWmdJy+eUQLjBE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23444e8f-1866-4ba5-fb31-08d6ef0caa5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 08:04:59.4342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3799
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/12 7:10, Chaitanya Kulkarni wrote:=0A=
> This patch removes the check in the null_blk_zoned for report zone=0A=
> command, where it checks for the dev-,>zoned before executing the report=
=0A=
> zone.=0A=
> =0A=
> The null_zone_report() function is a block_device operation callback=0A=
> which is initialized in the null_blk_main.c and gets called as a part=0A=
> of blkdev for report zone IOCTL (BLKREPORTZONE).=0A=
> =0A=
> blkdev_ioctl()=0A=
> blkdev_report_zones_ioctl()=0A=
>         blkdev_report_zones()=0A=
>                 blk_report_zones()=0A=
>                         disk->fops->report_zones()=0A=
>                                 nullb_zone_report();=0A=
> =0A=
> The null_zone_report() will never get executed on the non-zoned block=0A=
> device, in the non zoned block device blk_queue_is_zoned() will always=0A=
> be false which is first check the blkdev_report_zones_ioctl()=0A=
> before actual low level driver report zone callback is executed.=0A=
> =0A=
> Here is the detailed scenario:-=0A=
> =0A=
> 1. modprobe null_blk=0A=
> null_init=0A=
> null_alloc_dev=0A=
>         dev->zoned =3D 0 =0A=
> null_add_dev=0A=
>         dev->zoned =3D=3D 0=0A=
>                 so we don't set the q->limits.zoned =3D BLK_ZONED_HR=0A=
> =0A=
> 2. blkzone report /dev/nullb0=0A=
> =0A=
> blkdev_ioctl()=0A=
> blkdev_report_zones_ioctl()=0A=
>         blk_queue_is_zoned()=0A=
>                 blk_queue_is_zoned=0A=
>                         q->limits.zoned =3D=3D 0=0A=
>                         return false=0A=
>         if (!blk_queue_is_zoned(q)) <--- true=0A=
>                 return -ENOTTY;              =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Looks good. The SCSI layer has a similar check too. But since there are scs=
i=0A=
layer internal execution of the report zones driver function (e.g. device s=
can),=0A=
we need to keep that check there. But I think it is safe to remove in nullb=
lk=0A=
since revalidate is the only pass other than the user ioctl that would call=
=0A=
report zones.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
> ---=0A=
>  drivers/block/null_blk_zoned.c | 4 ----=0A=
>  1 file changed, 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 5d1c261a2cfd..fca0c97ff1aa 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -74,10 +74,6 @@ int null_zone_report(struct gendisk *disk, sector_t se=
ctor,=0A=
>  	struct nullb_device *dev =3D nullb->dev;=0A=
>  	unsigned int zno, nrz =3D 0;=0A=
>  =0A=
> -	if (!dev->zoned)=0A=
> -		/* Not a zoned null device */=0A=
> -		return -EOPNOTSUPP;=0A=
> -=0A=
>  	zno =3D null_zone_no(dev, sector);=0A=
>  	if (zno < dev->nr_zones) {=0A=
>  		nrz =3D min_t(unsigned int, *nr_zones, dev->nr_zones - zno);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
