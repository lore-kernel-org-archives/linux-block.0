Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB4C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6539520821
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 01:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nerdp9U3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dusbQxU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFVBPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:15:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60471 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFVBPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 21:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561166167; x=1592702167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gGa8jvmGG3lwGCAYzw62szrsezSH8eJysHqEY8JDW9c=;
  b=Nerdp9U3Kk1jxmQvqjz96XWZ37OdYlL3CpXxY9MGayoDZPjQGC+X1qpO
   1Qw8LN/g8gkIuU+ImSFYjK8gRnwZCFfGgKv99DKXEX0Wm71I+6Xu1h1FM
   JdFBMfcp9OAPmGJM3KhgiiyWqMGkQeKyuDL2uOSR2f9sdyBfgjMMyci83
   mbtYyXVKZNCo8JUzCHingiP/L3ezcEnpQJaCkjGFf46CgJXOO+Tjy6oRn
   AarCqLiGU99V0k42SVBzJk9/bctM3P5NEMyNzUhnPlEIA6i9rxQ4x4nbd
   I1v9ym2gz+WbgW00Qq56711gnYfPtmSxOgBlEJnrQamXsZOaqQzRZ2X6h
   w==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="210966714"
Received: from mail-by2nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 09:16:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b33dyQNTS3E9ndnKaizXjDvbdCqpvsEt4HZQu/7I5uo=;
 b=dusbQxU8+zlXYcpo4e2i7FmN2LFUj4jPDCAdAvbnu6JQeivnRBBN4syHM9w0TdppT1kdxNDwvHTpjmUipo69J1mRjtgoTyMns31WO0XQpI2j+KawfyI2gF7yYXLoVhCx7zh8R/xqRUEtfEfghSpi6U+yE+g53JuC/08cK9nlNT4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4135.namprd04.prod.outlook.com (20.176.250.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 22 Jun 2019 01:15:30 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Sat, 22 Jun 2019
 01:15:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 4/4] dm: add zone open, close and finish support
Thread-Topic: [PATCH 4/4] dm: add zone open, close and finish support
Thread-Index: AQHVKDJPZf/FnpeWOkmi6Il1fuZYGw==
Date:   Sat, 22 Jun 2019 01:15:30 +0000
Message-ID: <BYAPR04MB581688295FDAAF91805CD871E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-5-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3c13c7-af57-4660-d531-08d6f6af1e08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4135;
x-ms-traffictypediagnostic: BYAPR04MB4135:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4135E419320740677340E3C4E7E60@BYAPR04MB4135.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(14454004)(81166006)(14444005)(26005)(256004)(3846002)(25786009)(6116002)(53936002)(71200400001)(446003)(71190400001)(476003)(486006)(66946007)(55016002)(186003)(66574012)(7696005)(74316002)(6506007)(81156014)(8676002)(5660300002)(9686003)(64756008)(66476007)(66446008)(53546011)(66556008)(102836004)(99286004)(76116006)(73956011)(229853002)(91956017)(8936002)(305945005)(76176011)(7736002)(52536014)(6436002)(4326008)(33656002)(66066001)(6246003)(72206003)(2201001)(2501003)(86362001)(478600001)(2906002)(110136005)(316002)(7416002)(68736007)(54906003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4135;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E8L15gAswm/xuI5MPfOeMcUUb5/ras4ZQT0XsSlV2THzMx1QhrjBhP0cjZIsEIi9dWsazOxiVtOfN5yTdldEyWTLv+FdEIHKiKg03LJS7frdxeYoh9OhlJOYj6bnMmeXMdqylvaMJPjrH5uLEKWDBYePkOUUzOyH9FUMPJ+xI10U7yJqNzqrXyEfXsNVufr757OZuRKe3oG/1x4YzoafnoNxGsHXCNhHri+v/8Sbpt5wfKjUac/MPsG+FRNQrERuCEd7QKVO8AfkPCzL0mSsaTiighKrUiEhd5M62fEUr/P0u63PJl/oyJ2d4R+5El3E5btlNPwHT9kvqdDBnFmCYzlXIEAAJ9zpO84vHo148hZerVmnPRHkebS8NsgFPKRYwG5zCTW75lEHiGSP1PbPzIeeEY2o6Aqa/txWhlE6ST8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3c13c7-af57-4660-d531-08d6f6af1e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 01:15:30.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/21 22:07, Matias Bj=F8rling wrote:=0A=
> From: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> =0A=
> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH=0A=
> support to allow explicit control of zone states.=0A=
> =0A=
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> ---=0A=
>  drivers/md/dm-flakey.c    | 7 +++----=0A=
>  drivers/md/dm-linear.c    | 2 +-=0A=
>  drivers/md/dm.c           | 5 +++--=0A=
>  include/linux/blk_types.h | 8 ++++++++=0A=
>  4 files changed, 15 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c=0A=
> index a9bc518156f2..fff529c0732c 100644=0A=
> --- a/drivers/md/dm-flakey.c=0A=
> +++ b/drivers/md/dm-flakey.c=0A=
> @@ -280,7 +280,7 @@ static void flakey_map_bio(struct dm_target *ti, stru=
ct bio *bio)=0A=
>  	struct flakey_c *fc =3D ti->private;=0A=
>  =0A=
>  	bio_set_dev(bio, fc->dev->bdev);=0A=
> -	if (bio_sectors(bio) || bio_op(bio) =3D=3D REQ_OP_ZONE_RESET)=0A=
> +	if (bio_sectors(bio) || bio_is_zone_mgmt_op(bio))=0A=
>  		bio->bi_iter.bi_sector =3D=0A=
>  			flakey_map_sector(ti, bio->bi_iter.bi_sector);=0A=
>  }=0A=
> @@ -322,8 +322,7 @@ static int flakey_map(struct dm_target *ti, struct bi=
o *bio)=0A=
>  	struct per_bio_data *pb =3D dm_per_bio_data(bio, sizeof(struct per_bio_=
data));=0A=
>  	pb->bio_submitted =3D false;=0A=
>  =0A=
> -	/* Do not fail reset zone */=0A=
> -	if (bio_op(bio) =3D=3D REQ_OP_ZONE_RESET)=0A=
> +	if (bio_is_zone_mgmt_op(bio))=0A=
>  		goto map_bio;=0A=
>  =0A=
>  	/* Are we alive ? */=0A=
> @@ -384,7 +383,7 @@ static int flakey_end_io(struct dm_target *ti, struct=
 bio *bio,=0A=
>  	struct flakey_c *fc =3D ti->private;=0A=
>  	struct per_bio_data *pb =3D dm_per_bio_data(bio, sizeof(struct per_bio_=
data));=0A=
>  =0A=
> -	if (bio_op(bio) =3D=3D REQ_OP_ZONE_RESET)=0A=
> +	if (bio_is_zone_mgmt_op(bio))=0A=
>  		return DM_ENDIO_DONE;=0A=
>  =0A=
>  	if (!*error && pb->bio_submitted && (bio_data_dir(bio) =3D=3D READ)) {=
=0A=
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c=0A=
> index ad980a38fb1e..217a1dee8197 100644=0A=
> --- a/drivers/md/dm-linear.c=0A=
> +++ b/drivers/md/dm-linear.c=0A=
> @@ -90,7 +90,7 @@ static void linear_map_bio(struct dm_target *ti, struct=
 bio *bio)=0A=
>  	struct linear_c *lc =3D ti->private;=0A=
>  =0A=
>  	bio_set_dev(bio, lc->dev->bdev);=0A=
> -	if (bio_sectors(bio) || bio_op(bio) =3D=3D REQ_OP_ZONE_RESET)=0A=
> +	if (bio_sectors(bio) || bio_is_zone_mgmt_op(bio))=0A=
>  		bio->bi_iter.bi_sector =3D=0A=
>  			linear_map_sector(ti, bio->bi_iter.bi_sector);=0A=
>  }=0A=
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
> index 5475081dcbd6..f4507ec20a57 100644=0A=
> --- a/drivers/md/dm.c=0A=
> +++ b/drivers/md/dm.c=0A=
> @@ -1176,7 +1176,8 @@ static size_t dm_dax_copy_to_iter(struct dax_device=
 *dax_dev, pgoff_t pgoff,=0A=
>  =0A=
>  /*=0A=
>   * A target may call dm_accept_partial_bio only from the map routine.  I=
t is=0A=
> - * allowed for all bio types except REQ_PREFLUSH and REQ_OP_ZONE_RESET.=
=0A=
> + * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,=0A=
> + * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.=0A=
>   *=0A=
>   * dm_accept_partial_bio informs the dm that the target only wants to pr=
ocess=0A=
>   * additional n_sectors sectors of the bio and the rest of the data shou=
ld be=0A=
> @@ -1629,7 +1630,7 @@ static blk_qc_t __split_and_process_bio(struct mapp=
ed_device *md,=0A=
>  		ci.sector_count =3D 0;=0A=
>  		error =3D __send_empty_flush(&ci);=0A=
>  		/* dec_pending submits any data associated with flush */=0A=
> -	} else if (bio_op(bio) =3D=3D REQ_OP_ZONE_RESET) {=0A=
> +	} else if (bio_is_zone_mgmt_op(bio)) {=0A=
>  		ci.bio =3D bio;=0A=
>  		ci.sector_count =3D 0;=0A=
>  		error =3D __split_and_process_non_flush(&ci);=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 067ef9242275..fd2458cd1a49 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -398,6 +398,14 @@ static inline bool op_is_zone_mgmt_op(enum req_opf o=
p)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check if the bio is zoned operation.=0A=
> + */=0A=
> +static inline bool bio_is_zone_mgmt_op(struct bio *bio)=0A=
> +{=0A=
> +	return op_is_zone_mgmt_op(bio_op(bio));=0A=
> +}=0A=
> +=0A=
>  static inline bool op_is_write(unsigned int op)=0A=
>  {=0A=
>  	return (op & 1);=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
