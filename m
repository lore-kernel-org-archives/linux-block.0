Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C215C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 00:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C4B2070B
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 00:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hZfogc0U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W7oI69VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFVAvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:51:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47436 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVAvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 20:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561164699; x=1592700699;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UHjDQe+9gYA+Nd1wc0Isz2gOWgXr01ETXW0eAbKiqbY=;
  b=hZfogc0UnXA8MSiZ6a/Z8MmA3Xq600leNIW93yYXVJ1f1kGbzVH3iSgh
   wpV+yJEVq9ygUL8oeupY5TYnyQwrAQ3Ji4xB2wYe/My/I23ZuZ2oQg0Wy
   LABtV5x+GfwaDE5T3YFYoXBgCzgPjPRmdGZo/AZiEbsVnvaIeoQKSzWSb
   w/bsU7SsspWm35AGo410gTWnA+Eeq3zchX3851ctTCVl1SVnpASJrQ/1l
   48G8UKxiCyTAQrfKzdsO7BlXetu5HFoNz6uzmveEv9As2wloSic+C6EkX
   His+EsvijQ9TAK3b6gdvMJTFwl7HlHE1gqeVovRm9MK13V2ioewrVymgE
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="217567450"
Received: from mail-co1nam05lp2059.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 08:51:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kAh/kDxhhKNEzJhxqpmkx9MyjnqYFWcLhPGNukOAZY=;
 b=W7oI69VVrngKfb9Hck8avaAzO9QQlCv8sE4yXr/9gyggfEtKW3W2PNnFURweSX8TUlAo3X6sCteUdyqbsakqLJBGbY08vhk90wa5DV/yFKeAUwopsOYX2mYPTj2yBbnr23J/0XZh8OB17HdEv29iklTO5rwJituRuCICIfGVAn4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4680.namprd04.prod.outlook.com (52.135.240.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Sat, 22 Jun 2019 00:51:36 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Sat, 22 Jun 2019
 00:51:36 +0000
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
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
Thread-Topic: [PATCH 1/4] block: add zone open, close and finish support
Thread-Index: AQHVKDJPztuCEJ+OF0q7RsgYaqLWMQ==
Date:   Sat, 22 Jun 2019 00:51:36 +0000
Message-ID: <BYAPR04MB5816F7C8CA5B915DEEAF22D2E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3f8ecb7-dc39-492b-eaaf-08d6f6abc7b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4680;
x-ms-traffictypediagnostic: BYAPR04MB4680:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB46801FC20DCC462BAC49314FE7E60@BYAPR04MB4680.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(53546011)(446003)(66476007)(66574012)(91956017)(86362001)(305945005)(74316002)(229853002)(7736002)(71190400001)(66556008)(4326008)(66446008)(486006)(64756008)(66946007)(53936002)(81156014)(55016002)(9686003)(8676002)(66066001)(30864003)(72206003)(2201001)(81166006)(25786009)(71200400001)(6246003)(76116006)(476003)(26005)(99286004)(7696005)(6506007)(68736007)(73956011)(102836004)(110136005)(8936002)(14454004)(6116002)(186003)(5660300002)(52536014)(316002)(2906002)(7416002)(256004)(6436002)(76176011)(478600001)(33656002)(3846002)(2501003)(14444005)(54906003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4680;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XVJhP6uwYtHgyrgCGJg1hph1CsTSLk/kHM9YQ6IOWCzZ1rjXtlditVF/9tU1ExrxfBNhI6LqbU5QcFG6bGa/GULkyL7Zjb8ZJhaoiezBO6JFspiJn7BkSLrzn4oEnLNr5Ey/iKtpQkiq7ylmzFuJvqwMnPW4Pv+ib7giWmV7vEnekiBKk/lKa6Ht1IQNq2kL8AWXT27i5C7ikzKHppKot4TBEJrWxKyOQJP6S1c+eDPZ5uGBpChh297CAfbl68oXIWvvGFFAGUZFQJu+TsfoxpI0UQcwuHs6fkbbMrzbZzE3JwLtnvwaW+19TimUeuZ69hShS2E5omcZkmIilRSRzUFZ36c/HuC/SQteVg5yKTBx68eZnzD5t0vqkk67s6chjHORNe/rBEGGgdDPC8A3RPJEtOlN7fdCMnlUr4Ph/p4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f8ecb7-dc39-492b-eaaf-08d6f6abc7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 00:51:36.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4680
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matias,=0A=
=0A=
Some comments inline below.=0A=
=0A=
On 2019/06/21 22:07, Matias Bj=F8rling wrote:=0A=
> From: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> =0A=
> Zoned block devices allows one to control zone transitions by using=0A=
> explicit commands. The available transitions are:=0A=
> =0A=
>   * Open zone: Transition a zone to open state.=0A=
>   * Close zone: Transition a zone to closed state.=0A=
>   * Finish zone: Transition a zone to full state.=0A=
> =0A=
> Allow kernel to issue these transitions by introducing=0A=
> blkdev_zones_mgmt_op() and add three new request opcodes:=0A=
> =0A=
>   * REQ_IO_ZONE_OPEN, REQ_IO_ZONE_CLOSE, and REQ_OP_ZONE_FINISH=0A=
> =0A=
> Allow user-space to issue the transitions through the following ioctls:=
=0A=
> =0A=
>   * BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE.=0A=
> =0A=
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>=0A=
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>=0A=
> Signed-off-by: Matias Bj=F8rling <matias.bjorling@wdc.com>=0A=
> ---=0A=
>  block/blk-core.c              |  3 ++=0A=
>  block/blk-zoned.c             | 51 ++++++++++++++++++++++---------=0A=
>  block/ioctl.c                 |  5 ++-=0A=
>  include/linux/blk_types.h     | 27 +++++++++++++++--=0A=
>  include/linux/blkdev.h        | 57 ++++++++++++++++++++++++++++++-----=
=0A=
>  include/uapi/linux/blkzoned.h | 17 +++++++++--=0A=
>  6 files changed, 133 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 8340f69670d8..c0f0dbad548d 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -897,6 +897,9 @@ generic_make_request_checks(struct bio *bio)=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
>  		if (!blk_queue_is_zoned(q))=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index ae7e91bd0618..d0c933593b93 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -201,20 +201,22 @@ int blkdev_report_zones(struct block_device *bdev, =
sector_t sector,=0A=
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);=0A=
>  =0A=
>  /**=0A=
> - * blkdev_reset_zones - Reset zones write pointer=0A=
> + * blkdev_zones_mgmt_op - Perform the specified operation on the zone(s)=
=0A=
>   * @bdev:	Target block device=0A=
> - * @sector:	Start sector of the first zone to reset=0A=
> - * @nr_sectors:	Number of sectors, at least the length of one zone=0A=
> + * @op:		Operation to be performed on the zone(s)=0A=
> + * @sector:	Start sector of the first zone to operate on=0A=
> + * @nr_sectors:	Number of sectors, at least the length of one zone and=
=0A=
> + *              must be zone size aligned.=0A=
>   * @gfp_mask:	Memory allocation flags (for bio_alloc)=0A=
>   *=0A=
>   * Description:=0A=
> - *    Reset the write pointer of the zones contained in the range=0A=
> + *    Perform the specified operation contained in the range=0A=
	Perform the specified operation over the sector range=0A=
>   *    @sector..@sector+@nr_sectors. Specifying the entire disk sector ra=
nge=0A=
>   *    is valid, but the specified range should not contain conventional =
zones.=0A=
>   */=0A=
> -int blkdev_reset_zones(struct block_device *bdev,=0A=
> -		       sector_t sector, sector_t nr_sectors,=0A=
> -		       gfp_t gfp_mask)=0A=
> +int blkdev_zones_mgmt_op(struct block_device *bdev, enum req_opf op,=0A=
> +			 sector_t sector, sector_t nr_sectors,=0A=
> +			 gfp_t gfp_mask)=0A=
>  {=0A=
>  	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
>  	sector_t zone_sectors;=0A=
> @@ -226,6 +228,9 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
>  	if (!blk_queue_is_zoned(q))=0A=
>  		return -EOPNOTSUPP;=0A=
>  =0A=
> +	if (!op_is_zone_mgmt_op(op))=0A=
> +		return -EOPNOTSUPP;=0A=
=0A=
EINVAL may be better here.=0A=
=0A=
> +=0A=
>  	if (bdev_read_only(bdev))=0A=
>  		return -EPERM;=0A=
>  =0A=
> @@ -248,7 +253,7 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
>  		bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
>  		bio_set_dev(bio, bdev);=0A=
> -		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);=0A=
> +		bio_set_op_attrs(bio, op, 0);=0A=
>  =0A=
>  		sector +=3D zone_sectors;=0A=
>  =0A=
> @@ -264,7 +269,7 @@ int blkdev_reset_zones(struct block_device *bdev,=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> -EXPORT_SYMBOL_GPL(blkdev_reset_zones);=0A=
> +EXPORT_SYMBOL_GPL(blkdev_zones_mgmt_op);=0A=
>  =0A=
>  /*=0A=
>   * BLKREPORTZONE ioctl processing.=0A=
> @@ -329,15 +334,16 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> - * BLKRESETZONE ioctl processing.=0A=
> + * Zone operation (open, close, finish or reset) ioctl processing.=0A=
>   * Called from blkdev_ioctl.=0A=
>   */=0A=
> -int blkdev_reset_zones_ioctl(struct block_device *bdev, fmode_t mode,=0A=
> -			     unsigned int cmd, unsigned long arg)=0A=
> +int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev, fmode_t mode,=
=0A=
> +				unsigned int cmd, unsigned long arg)=0A=
>  {=0A=
>  	void __user *argp =3D (void __user *)arg;=0A=
>  	struct request_queue *q;=0A=
>  	struct blk_zone_range zrange;=0A=
> +	enum req_opf op;=0A=
>  =0A=
>  	if (!argp)=0A=
>  		return -EINVAL;=0A=
> @@ -358,8 +364,25 @@ int blkdev_reset_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))=0A=
>  		return -EFAULT;=0A=
>  =0A=
> -	return blkdev_reset_zones(bdev, zrange.sector, zrange.nr_sectors,=0A=
> -				  GFP_KERNEL);=0A=
> +	switch (cmd) {=0A=
> +	case BLKRESETZONE:=0A=
> +		op =3D REQ_OP_ZONE_RESET;=0A=
> +		break;=0A=
> +	case BLKOPENZONE:=0A=
> +		op =3D REQ_OP_ZONE_OPEN;=0A=
> +		break;=0A=
> +	case BLKCLOSEZONE:=0A=
> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
> +		break;=0A=
> +	case BLKFINISHZONE:=0A=
> +		op =3D REQ_OP_ZONE_FINISH;=0A=
> +		break;=0A=
> +	default:=0A=
> +		return -ENOTTY;=0A=
> +	}=0A=
> +=0A=
> +	return blkdev_zones_mgmt_op(bdev, op, zrange.sector, zrange.nr_sectors,=
=0A=
> +				    GFP_KERNEL);=0A=
>  }=0A=
>  =0A=
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,=0A=
> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
> index 15a0eb80ada9..df7fe54db158 100644=0A=
> --- a/block/ioctl.c=0A=
> +++ b/block/ioctl.c=0A=
> @@ -532,7 +532,10 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t =
mode, unsigned cmd,=0A=
>  	case BLKREPORTZONE:=0A=
>  		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);=0A=
>  	case BLKRESETZONE:=0A=
> -		return blkdev_reset_zones_ioctl(bdev, mode, cmd, arg);=0A=
> +	case BLKOPENZONE:=0A=
> +	case BLKCLOSEZONE:=0A=
> +	case BLKFINISHZONE:=0A=
> +		return blkdev_zones_mgmt_op_ioctl(bdev, mode, cmd, arg);=0A=
>  	case BLKGETZONESZ:=0A=
>  		return put_uint(arg, bdev_zone_sectors(bdev));=0A=
>  	case BLKGETNRZONES:=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 95202f80676c..067ef9242275 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -284,13 +284,20 @@ enum req_opf {=0A=
>  	REQ_OP_DISCARD		=3D 3,=0A=
>  	/* securely erase sectors */=0A=
>  	REQ_OP_SECURE_ERASE	=3D 5,=0A=
> -	/* reset a zone write pointer */=0A=
> -	REQ_OP_ZONE_RESET	=3D 6,=0A=
>  	/* write the same sector many times */=0A=
>  	REQ_OP_WRITE_SAME	=3D 7,=0A=
>  	/* write the zero filled sector many times */=0A=
>  	REQ_OP_WRITE_ZEROES	=3D 9,=0A=
>  =0A=
> +	/* reset a zone write pointer */=0A=
> +	REQ_OP_ZONE_RESET	=3D 16,=0A=
> +	/* Open zone(s) */=0A=
> +	REQ_OP_ZONE_OPEN	=3D 17,=0A=
> +	/* Close zone(s) */=0A=
> +	REQ_OP_ZONE_CLOSE	=3D 18,=0A=
> +	/* Finish zone(s) */=0A=
> +	REQ_OP_ZONE_FINISH	=3D 19,=0A=
> +=0A=
>  	/* SCSI passthrough using struct scsi_request */=0A=
>  	REQ_OP_SCSI_IN		=3D 32,=0A=
>  	REQ_OP_SCSI_OUT		=3D 33,=0A=
> @@ -375,6 +382,22 @@ static inline void bio_set_op_attrs(struct bio *bio,=
 unsigned op,=0A=
>  	bio->bi_opf =3D op | op_flags;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check if the op is zoned operation.=0A=
      Check if op is a zone management operation.=0A=
> + */=0A=
> +static inline bool op_is_zone_mgmt_op(enum req_opf op)=0A=
=0A=
Similarly to "op_is_write" pattern, "op_is_zone_mgmt" may be a better name.=
=0A=
=0A=
> +{=0A=
> +	switch (op) {=0A=
> +	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_OPEN:=0A=
> +	case REQ_OP_ZONE_CLOSE:=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
> +		return true;=0A=
> +	default:=0A=
> +		return false;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  static inline bool op_is_write(unsigned int op)=0A=
>  {=0A=
>  	return (op & 1);=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 592669bcc536..943084f9dc9c 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -348,14 +348,15 @@ extern unsigned int blkdev_nr_zones(struct block_de=
vice *bdev);=0A=
>  extern int blkdev_report_zones(struct block_device *bdev,=0A=
>  			       sector_t sector, struct blk_zone *zones,=0A=
>  			       unsigned int *nr_zones, gfp_t gfp_mask);=0A=
> -extern int blkdev_reset_zones(struct block_device *bdev, sector_t sector=
s,=0A=
> -			      sector_t nr_sectors, gfp_t gfp_mask);=0A=
>  extern int blk_revalidate_disk_zones(struct gendisk *disk);=0A=
>  =0A=
>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t =
mode,=0A=
>  				     unsigned int cmd, unsigned long arg);=0A=
> -extern int blkdev_reset_zones_ioctl(struct block_device *bdev, fmode_t m=
ode,=0A=
> -				    unsigned int cmd, unsigned long arg);=0A=
> +extern int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev, fmode_t=
 mode,=0A=
> +					unsigned int cmd, unsigned long arg);=0A=
> +extern int blkdev_zones_mgmt_op(struct block_device *bdev, enum req_opf =
op,=0A=
> +				sector_t sector, sector_t nr_sectors,=0A=
> +				gfp_t gfp_mask);=0A=
=0A=
To keep the grouping of declarations, may be declare this one where=0A=
blkdev_reset_zones() was ?=0A=
=0A=
>  =0A=
>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> @@ -376,15 +377,57 @@ static inline int blkdev_report_zones_ioctl(struct =
block_device *bdev,=0A=
>  	return -ENOTTY;=0A=
>  }=0A=
>  =0A=
> -static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,=0A=
> -					   fmode_t mode, unsigned int cmd,=0A=
> -					   unsigned long arg)=0A=
> +static inline int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev,=
=0A=
> +					     fmode_t mode, unsigned int cmd,=0A=
> +					     unsigned long arg)=0A=
> +{=0A=
> +	return -ENOTTY;=0A=
> +}=0A=
> +=0A=
> +static inline int blkdev_zones_mgmt_op(struct block_device *bdev,=0A=
> +				       enum req_opf op,=0A=
> +				       sector_t sector, sector_t nr_sectors,=0A=
> +				       gfp_t gfp_mask)=0A=
>  {=0A=
>  	return -ENOTTY;=0A=
=0A=
That should be -ENOTSUPP. This is not an ioctl. The ioctl call is above thi=
s one.=0A=
=0A=
>  }=0A=
>  =0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> +static inline int blkdev_reset_zones(struct block_device *bdev,=0A=
> +				     sector_t sector, sector_t nr_sectors,=0A=
> +				     gfp_t gfp_mask)=0A=
> +{=0A=
> +	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_RESET,=0A=
> +				    sector, nr_sectors, gfp_mask);=0A=
> +}=0A=
> +=0A=
> +static inline int blkdev_open_zones(struct block_device *bdev,=0A=
> +				    sector_t sector, sector_t nr_sectors,=0A=
> +				    gfp_t gfp_mask)=0A=
> +{=0A=
> +	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_OPEN,=0A=
> +				    sector, nr_sectors, gfp_mask);=0A=
> +}=0A=
> +=0A=
> +static inline int blkdev_close_zones(struct block_device *bdev,=0A=
> +				     sector_t sector, sector_t nr_sectors,=0A=
> +				     gfp_t gfp_mask)=0A=
> +{=0A=
> +	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_CLOSE,=0A=
> +				    sector, nr_sectors,=0A=
> +				    gfp_mask);=0A=
> +}=0A=
> +=0A=
> +static inline int blkdev_finish_zones(struct block_device *bdev,=0A=
> +				      sector_t sector, sector_t nr_sectors,=0A=
> +				      gfp_t gfp_mask)=0A=
> +{=0A=
> +	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_FINISH,=0A=
> +				    sector, nr_sectors,=0A=
> +				    gfp_mask);=0A=
> +}=0A=
> +=0A=
>  struct request_queue {=0A=
>  	/*=0A=
>  	 * Together with queue_head for cacheline sharing=0A=
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.=
h=0A=
> index 498eec813494..701e0692b8d3 100644=0A=
> --- a/include/uapi/linux/blkzoned.h=0A=
> +++ b/include/uapi/linux/blkzoned.h=0A=
> @@ -120,9 +120,11 @@ struct blk_zone_report {=0A=
>  };=0A=
>  =0A=
>  /**=0A=
> - * struct blk_zone_range - BLKRESETZONE ioctl request=0A=
> - * @sector: starting sector of the first zone to issue reset write point=
er=0A=
> - * @nr_sectors: Total number of sectors of 1 or more zones to reset=0A=
> + * struct blk_zone_range - BLKRESETZONE/BLKOPENZONE/=0A=
> + *			   BLKCLOSEZONE/BLKFINISHZONE ioctl=0A=
> + *			   request=0A=
> + * @sector: starting sector of the first zone to operate on=0A=
> + * @nr_sectors: Total number of sectors of all zones to operate on=0A=
>   */=0A=
>  struct blk_zone_range {=0A=
>  	__u64		sector;=0A=
> @@ -139,10 +141,19 @@ struct blk_zone_range {=0A=
>   *                sector range. The sector range must be zone aligned.=
=0A=
>   * @BLKGETZONESZ: Get the device zone size in number of 512 B sectors.=
=0A=
>   * @BLKGETNRZONES: Get the total number of zones of the device.=0A=
> + * @BLKOPENZONE: Open the zones in the specified sector range. The=0A=
> + *               sector range must be zone aligned.=0A=
> + * @BLKCLOSEZONE: Close the zones in the specified sector range. The=0A=
> + *                sector range must be zone aligned.=0A=
> + * @BLKFINISHZONE: Finish the zones in the specified sector range. The=
=0A=
> + *                 sector range must be zone aligned.=0A=
>   */=0A=
>  #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)=0A=
>  #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)=0A=
>  #define BLKGETZONESZ	_IOR(0x12, 132, __u32)=0A=
>  #define BLKGETNRZONES	_IOR(0x12, 133, __u32)=0A=
> +#define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)=0A=
> +#define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)=0A=
> +#define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)=0A=
>  =0A=
>  #endif /* _UAPI_BLKZONED_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
