Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D8BC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D6820774
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lLJk6d9V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NR4IWyii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCYG3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:29:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7144 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYG3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 02:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585117782; x=1616653782;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=34V+ts6G+9Z6OaPNjqW0TDbBpKBTDa51MFBC81kh1s0=;
  b=lLJk6d9VddvwWaV+nTJZGx7rfCIVRHwG2tLdYGl5cMcdI/6oByleuhN1
   X37fMVfEfibaiC67Svbh2WJROfDgM0TRKG6diEiZMii2zktBABtEDc7at
   EDJ6E8LkZiVBm9bH0Dlss+OeGa3MhCCSKCdLPmcuR7ccKiTrTwcNb+ZK5
   EZ7PfdKtrI5CXOa80N2jV/OYGkRxn9CsrYQehtXbqJIWgU48ZNh1p+LvT
   kK0f/6Q/4bJ3v2RiCiekQtE14SHC2r0zfZaNFky5eI2A2iQ145Bq75DpE
   zYHRXuFWiibhfYkNeKg2fhAsxR60DjJnw14Yuds6xNaqCoOEpTlU/bj4a
   Q==;
IronPort-SDR: q23FnEucJ7PdEjbD/AiK61431djkdGVtAwO7/ksv50JvOVDqLkN21jSFwP4yRS4y389XQ4TBL9
 qwN+KN1W2ab/vnhPE7Py0sMcMUDH0T2xYJDQxxzMwf9J2YcxFNwcFF4R23p99g4/KGuThzrFRp
 O8wq3+rIgueEiwNHmatclrh/Nsktcf9qrTGsaJ8EvtSNoMmIhK1ERlAz4XO2SMlUilNX+bU308
 l4nT8/4oIDLdcZfyzahw220uFb4ggUDS61Cf4edKqduWKGx1piSGlnEN7VSTyBRHlQeIU7/g9C
 a3s=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="137829743"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 14:29:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E717y30jFqEf46HmfB3fk82jmiwgxUM+nMwtipqYnnvxKuDvh0rD6QAwNqVdcSM1zChGBeU8N3lHDa6DhjkCfxcisHehqKnL7zpMdZMiUGGnHuMZnn3jZ8UBXTQ7l9rx7F6ATQ+yrtCXhcINOWOXIXpiORibDX7wgRHbVjiRD6yYRmGEb3tF8WiIosm5KfmIimxxzW+LCNm1mleQH8pL89Nr7WJRAT6n9fSR2usvBDe81aSCRKMnLSR6rztIHWYQUQ8BijkjKtwu6TcGFLUieF+NGgIO6a/TwwqHOWXwnL10ayNaFaUrx4tos0Aqr1XMNUepuGQk8/o0vtEvN2yQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CECa11Uph1kuHeFLxmQIravOkeahz7J2b/fobIcS3ZU=;
 b=DM1UBY0aXU7dHNkgT31q+/00yXI4w8gBQtiYx31PHWQUQM45aLWoBbh7sidY1TIS1QApJlWv5aHaWP8Y4SJo0ji69mRxGuhYdvGXtbWm1lLFSOvnI0leJGBFuJJ0U83dqu44SdTu8l2vb+PpOpvq/WNQ3nii079WPF9jf0l3uPsX5ILRmtzC9gfJ2mxIuaoILrTjI13r1jcOcLnLiYPtmXbvenChWXC28B8vPqZGaSCL8O6HhKWWXyQHm0PL5KUCjtBlhWuFSXO+V40CZj0ha+YRWqxEu9gG+wNUYGE9gzDgKAO0D6n6+LMLvJMNs+mFiL/Ao6Sp4D/9GYBgUH3CmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CECa11Uph1kuHeFLxmQIravOkeahz7J2b/fobIcS3ZU=;
 b=NR4IWyiitMC2NxtKhz5FEAoww4LPeCYAkZLO19gJYSA/zTlE5WPy0hoJ296p09cMp6/KL8VhPuElgQthypZikZBGAr4WoDVZhG/SJA8sZVFYdeqjSiZln36N5ke20EbNeum01xyZmkCByCFg6ZkFvNNTCx9zZ6VXcEr2owA51MA=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2199.namprd04.prod.outlook.com (2603:10b6:102:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 06:29:29 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 06:29:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Topic: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Index: AQHWAcvtLt+lRR39/UysINFCEirB8Q==
Date:   Wed, 25 Mar 2020 06:29:29 +0000
Message-ID: <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0cd7955-1e98-4968-c47d-08d7d085df96
x-ms-traffictypediagnostic: CO2PR04MB2199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB219975D6E4981D51AC95EF3CE7CE0@CO2PR04MB2199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(30864003)(66476007)(7696005)(66446008)(9686003)(4326008)(91956017)(53546011)(55016002)(66556008)(64756008)(2906002)(316002)(76116006)(52536014)(6506007)(66946007)(478600001)(5660300002)(54906003)(8936002)(33656002)(86362001)(26005)(110136005)(8676002)(81166006)(186003)(81156014)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2199;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HeNcHp9vz3uWreNPjkcOK1VgHwSV2Ple2mimfMw5xrcpJ4lmB8n6jpZwiME8v/LHW0NKCuDU1V4+143NDy0YeQmnR4rMo0tQh3DJE9YJOGvnl7AazdIGRfh6oBr7lR4O8630y3vG8VqcNNOuyPPuH68NnZHywSGHwMS2NR5cZVxSVqnRQGBHAUwazSNWLLL4kVwFHfouHXV8YKpjPt9FRNiUbw9aeMU5Z3WJKW9WA+euNy3Tq9H5BZ0U+fz8+23XgwHBX8t9Otstj63SFyd/irFNme2ocNvF/ohVLHyM3a31CWDfvCLgrq+YJNt29SNwbuRu1Nj1Pq8fLmvt84AKRvnc6nQ7xS501rQiOgNj8UQFu1Cku7/xLbUJTCUQAw8zUKWfR4zrKBp3JbXrTGSQ3LnAqDytaT2Cz3BN9QFUUUA+ZwqY5O6zh+hC7cMghBi
x-ms-exchange-antispam-messagedata: qNDkmdMFACK+QaRdJaYwR3tFNZmbmReyeces2DecE+2mUHg0yyIE2Z1jvdlh4MLc/f5B5mKz9n/qahrho3VDwBl+JuyILwd4H51rmMp2ZtnXqKxKGkUtH1mZQKPk7eP+werK2WWx/VYhdPFbjHmLCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cd7955-1e98-4968-c47d-08d7d085df96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 06:29:29.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPV5NpGXGcUVrVSD0zzO5gbqNmB+XALnMKcp4kiOhyIhj3gBpVd9o70Dqp6zQTcfPkpZr0kjneQ4i22f/oBqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/24 20:04, Bob Liu wrote:=0A=
> This patch implemented metadata support for regular device by:=0A=
>  - Emulated zone information for regular device.=0A=
>  - Store metadata at the beginning of regular device.=0A=
> =0A=
>      | --- zoned device --- | -- regular device ||=0A=
>      ^                      ^=0A=
>      |                      |Metadata=0A=
> zone 0=0A=
> =0A=
> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
> ---=0A=
>  drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++++----=
------=0A=
>  drivers/md/dm-zoned-target.c   |   6 +-=0A=
>  drivers/md/dm-zoned.h          |   3 +-=0A=
>  3 files changed, 108 insertions(+), 36 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadat=
a.c=0A=
> index e0e8be0..a96158a 100644=0A=
> --- a/drivers/md/dm-zoned-metadata.c=0A=
> +++ b/drivers/md/dm-zoned-metadata.c=0A=
> @@ -131,6 +131,7 @@ struct dmz_sb {=0A=
>   */=0A=
>  struct dmz_metadata {=0A=
>  	struct dmz_dev		*zoned_dev;=0A=
> +	struct dmz_dev		*regu_dmz_dev;=0A=
>  =0A=
>  	sector_t		zone_bitmap_size;=0A=
>  	unsigned int		zone_nr_bitmap_blocks;=0A=
> @@ -187,6 +188,15 @@ struct dmz_metadata {=0A=
>  /*=0A=
>   * Various accessors=0A=
>   */=0A=
> +static inline struct dmz_dev *zmd_mdev(struct dmz_metadata *zmd)=0A=
> +{=0A=
> +	/* Metadata always stores in regular device if there is. */=0A=
> +	if (zmd->regu_dmz_dev)=0A=
> +		return zmd->regu_dmz_dev;=0A=
> +	else=0A=
> +		return zmd->zoned_dev;=0A=
=0A=
OK. I think we will be better off using an array of pointers to struct_dmz_=
dev=0A=
in dmz_target, i.e., a filed "struct dmz_dev	*dev[2]". Doing so, we can be =
sure=0A=
to always have the device holding metatdata in entry 0, which will always b=
e=0A=
true for the single drive case too.=0A=
With this, you will not need all these dance with "which device has metadat=
a" ?=0A=
It always will be dmz->dev[0].=0A=
=0A=
> +}=0A=
> +=0A=
>  unsigned int dmz_id(struct dmz_metadata *zmd, struct dm_zone *zone)=0A=
>  {=0A=
>  	return ((unsigned int)(zone - zmd->zones));=0A=
> @@ -194,12 +204,33 @@ unsigned int dmz_id(struct dmz_metadata *zmd, struc=
t dm_zone *zone)=0A=
>  =0A=
>  sector_t dmz_start_sect(struct dmz_metadata *zmd, struct dm_zone *zone)=
=0A=
>  {=0A=
> -	return (sector_t)dmz_id(zmd, zone) << zmd->zoned_dev->zone_nr_sectors_s=
hift;=0A=
=0A=
With the array of dev trick, most of the changes below are simplified or go=
 away.=0A=
=0A=
> +	int dmz_real_id;=0A=
> +=0A=
> +	dmz_real_id =3D dmz_id(zmd, zone);=0A=
> +	if (dmz_real_id >=3D zmd->zoned_dev->nr_zones) {=0A=
> +		/* Regular dev. */=0A=
> +		dmz_real_id -=3D zmd->zoned_dev->nr_zones;=0A=
> +		WARN_ON(!zmd->regu_dmz_dev);=0A=
> +=0A=
> +		return (sector_t)dmz_real_id << zmd->zoned_dev->zone_nr_sectors_shift;=
=0A=
> +	}=0A=
> +	return (sector_t)dmz_real_id << zmd->zoned_dev->zone_nr_sectors_shift;=
=0A=
>  }=0A=
>  =0A=
>  sector_t dmz_start_block(struct dmz_metadata *zmd, struct dm_zone *zone)=
=0A=
>  {=0A=
> -	return (sector_t)dmz_id(zmd, zone) << zmd->zoned_dev->zone_nr_blocks_sh=
ift;=0A=
> +	int dmz_real_id;=0A=
> +=0A=
> +	dmz_real_id =3D dmz_id(zmd, zone);=0A=
> +	if (dmz_real_id >=3D zmd->zoned_dev->nr_zones) {=0A=
> +		/* Regular dev. */=0A=
> +		dmz_real_id -=3D zmd->zoned_dev->nr_zones;=0A=
> +		WARN_ON(!zmd->regu_dmz_dev);=0A=
> +=0A=
> +		return (sector_t)dmz_real_id << zmd->zoned_dev->zone_nr_blocks_shift;=
=0A=
> +	}=0A=
> +=0A=
> +	return (sector_t)dmz_real_id << zmd->zoned_dev->zone_nr_blocks_shift;=
=0A=
>  }=0A=
>  =0A=
>  unsigned int dmz_nr_chunks(struct dmz_metadata *zmd)=0A=
> @@ -403,8 +434,10 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct=
 dmz_metadata *zmd,=0A=
>  	struct dmz_mblock *mblk, *m;=0A=
>  	sector_t block =3D zmd->sb[zmd->mblk_primary].block + mblk_no;=0A=
>  	struct bio *bio;=0A=
> +	struct dmz_dev *mdev;=0A=
>  =0A=
> -	if (dmz_bdev_is_dying(zmd->zoned_dev))=0A=
> +	mdev =3D zmd_mdev(zmd);=0A=
> +	if (dmz_bdev_is_dying(mdev))=0A=
>  		return ERR_PTR(-EIO);=0A=
>  =0A=
>  	/* Get a new block and a BIO to read it */=0A=
> @@ -440,7 +473,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct =
dmz_metadata *zmd,=0A=
>  =0A=
>  	/* Submit read BIO */=0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->zoned_dev->bdev);=0A=
> +	bio_set_dev(bio, mdev->bdev);=0A=
>  	bio->bi_private =3D mblk;=0A=
>  	bio->bi_end_io =3D dmz_mblock_bio_end_io;=0A=
>  	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);=0A=
> @@ -555,7 +588,7 @@ static struct dmz_mblock *dmz_get_mblock(struct dmz_m=
etadata *zmd,=0A=
>  		       TASK_UNINTERRUPTIBLE);=0A=
>  	if (test_bit(DMZ_META_ERROR, &mblk->state)) {=0A=
>  		dmz_release_mblock(zmd, mblk);=0A=
> -		dmz_check_bdev(zmd->zoned_dev);=0A=
> +		dmz_check_bdev(zmd_mdev(zmd));=0A=
>  		return ERR_PTR(-EIO);=0A=
>  	}=0A=
>  =0A=
> @@ -581,8 +614,10 @@ static int dmz_write_mblock(struct dmz_metadata *zmd=
, struct dmz_mblock *mblk,=0A=
>  {=0A=
>  	sector_t block =3D zmd->sb[set].block + mblk->no;=0A=
>  	struct bio *bio;=0A=
> +	struct dmz_dev *mdev;=0A=
>  =0A=
> -	if (dmz_bdev_is_dying(zmd->zoned_dev))=0A=
> +	mdev =3D zmd_mdev(zmd);=0A=
> +	if (dmz_bdev_is_dying(mdev))=0A=
>  		return -EIO;=0A=
>  =0A=
>  	bio =3D bio_alloc(GFP_NOIO, 1);=0A=
> @@ -594,7 +629,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd,=
 struct dmz_mblock *mblk,=0A=
>  	set_bit(DMZ_META_WRITING, &mblk->state);=0A=
>  =0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->zoned_dev->bdev);=0A=
> +	bio_set_dev(bio, mdev->bdev);=0A=
>  	bio->bi_private =3D mblk;=0A=
>  	bio->bi_end_io =3D dmz_mblock_bio_end_io;=0A=
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);=0A=
> @@ -612,8 +647,10 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd, =
int op, sector_t block,=0A=
>  {=0A=
>  	struct bio *bio;=0A=
>  	int ret;=0A=
> +	struct dmz_dev *mdev;=0A=
>  =0A=
> -	if (dmz_bdev_is_dying(zmd->zoned_dev))=0A=
> +	mdev =3D zmd_mdev(zmd);=0A=
> +	if (dmz_bdev_is_dying(mdev))=0A=
>  		return -EIO;=0A=
>  =0A=
>  	bio =3D bio_alloc(GFP_NOIO, 1);=0A=
> @@ -621,14 +658,14 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd,=
 int op, sector_t block,=0A=
>  		return -ENOMEM;=0A=
>  =0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->zoned_dev->bdev);=0A=
> +	bio_set_dev(bio, mdev->bdev);=0A=
>  	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);=0A=
>  	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);=0A=
>  	ret =3D submit_bio_wait(bio);=0A=
>  	bio_put(bio);=0A=
>  =0A=
>  	if (ret)=0A=
> -		dmz_check_bdev(zmd->zoned_dev);=0A=
> +		dmz_check_bdev(mdev);=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> @@ -661,7 +698,7 @@ static int dmz_write_sb(struct dmz_metadata *zmd, uns=
igned int set)=0A=
>  =0A=
>  	ret =3D dmz_rdwr_block(zmd, REQ_OP_WRITE, block, mblk->page);=0A=
>  	if (ret =3D=3D 0)=0A=
> -		ret =3D blkdev_issue_flush(zmd->zoned_dev->bdev, GFP_NOIO, NULL);=0A=
> +		ret =3D blkdev_issue_flush(zmd_mdev(zmd)->bdev, GFP_NOIO, NULL);=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> @@ -695,15 +732,20 @@ static int dmz_write_dirty_mblocks(struct dmz_metad=
ata *zmd,=0A=
>  			       TASK_UNINTERRUPTIBLE);=0A=
>  		if (test_bit(DMZ_META_ERROR, &mblk->state)) {=0A=
>  			clear_bit(DMZ_META_ERROR, &mblk->state);=0A=
> -			dmz_check_bdev(zmd->zoned_dev);=0A=
> +			dmz_check_bdev(zmd_mdev(zmd));=0A=
>  			ret =3D -EIO;=0A=
>  		}=0A=
>  		nr_mblks_submitted--;=0A=
>  	}=0A=
>  =0A=
>  	/* Flush drive cache (this will also sync data) */=0A=
> -	if (ret =3D=3D 0)=0A=
> -		ret =3D blkdev_issue_flush(zmd->zoned_dev->bdev, GFP_NOIO, NULL);=0A=
> +	if (ret =3D=3D 0) {=0A=
> +		/* Flush metadata device */=0A=
> +		ret =3D blkdev_issue_flush(zmd_mdev(zmd)->bdev, GFP_NOIO, NULL);=0A=
> +		if ((ret =3D=3D 0) && zmd->regu_dmz_dev)=0A=
> +			/* Flush data device. */=0A=
> +			ret =3D blkdev_issue_flush(zmd->zoned_dev->bdev, GFP_NOIO, NULL);=0A=
> +	}=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> @@ -760,7 +802,7 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)=0A=
>  	 */=0A=
>  	dmz_lock_flush(zmd);=0A=
>  =0A=
> -	if (dmz_bdev_is_dying(zmd->zoned_dev)) {=0A=
> +	if (dmz_bdev_is_dying(zmd_mdev(zmd))) {=0A=
>  		ret =3D -EIO;=0A=
>  		goto out;=0A=
>  	}=0A=
> @@ -772,7 +814,7 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)=0A=
>  =0A=
>  	/* If there are no dirty metadata blocks, just flush the device cache *=
/=0A=
>  	if (list_empty(&write_list)) {=0A=
> -		ret =3D blkdev_issue_flush(zmd->zoned_dev->bdev, GFP_NOIO, NULL);=0A=
> +		ret =3D blkdev_issue_flush(zmd_mdev(zmd)->bdev, GFP_NOIO, NULL);=0A=
>  		goto err;=0A=
>  	}=0A=
>  =0A=
> @@ -821,7 +863,7 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)=0A=
>  		list_splice(&write_list, &zmd->mblk_dirty_list);=0A=
>  		spin_unlock(&zmd->mblk_lock);=0A=
>  	}=0A=
> -	if (!dmz_check_bdev(zmd->zoned_dev))=0A=
> +	if (!dmz_check_bdev(zmd_mdev(zmd)))=0A=
>  		ret =3D -EIO;=0A=
>  	goto out;=0A=
>  }=0A=
> @@ -832,10 +874,11 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)=0A=
>  static int dmz_check_sb(struct dmz_metadata *zmd, struct dmz_super *sb)=
=0A=
>  {=0A=
>  	unsigned int nr_meta_zones, nr_data_zones;=0A=
> -	struct dmz_dev *dev =3D zmd->zoned_dev;=0A=
> +	struct dmz_dev *dev;=0A=
>  	u32 crc, stored_crc;=0A=
>  	u64 gen;=0A=
>  =0A=
> +	dev =3D zmd_mdev(zmd);=0A=
>  	gen =3D le64_to_cpu(sb->gen);=0A=
>  	stored_crc =3D le32_to_cpu(sb->crc);=0A=
>  	sb->crc =3D 0;=0A=
> @@ -1131,8 +1174,11 @@ static int dmz_init_zone(struct blk_zone *blkz, un=
signed int idx, void *data)=0A=
>  		zmd->nr_useable_zones++;=0A=
>  		if (dmz_is_rnd(zone)) {=0A=
>  			zmd->nr_rnd_zones++;=0A=
> -			if (!zmd->sb_zone) {=0A=
> -				/* Super block zone */=0A=
> +			if (!zmd->sb_zone && !zmd->regu_dmz_dev) {=0A=
> +				/*=0A=
> +				 * Super block zone goes to regular=0A=
> +				 * device by default.=0A=
> +				 */=0A=
>  				zmd->sb_zone =3D zone;=0A=
>  			}=0A=
>  		}=0A=
> @@ -1157,7 +1203,8 @@ static void dmz_drop_zones(struct dmz_metadata *zmd=
)=0A=
>  static int dmz_init_zones(struct dmz_metadata *zmd)=0A=
>  {=0A=
>  	struct dmz_dev *dev =3D zmd->zoned_dev;=0A=
> -	int ret;=0A=
> +	int ret, i;=0A=
> +	unsigned int total_nr_zones;=0A=
>  =0A=
>  	/* Init */=0A=
>  	zmd->zone_bitmap_size =3D dev->zone_nr_blocks >> 3;=0A=
> @@ -1167,7 +1214,10 @@ static int dmz_init_zones(struct dmz_metadata *zmd=
)=0A=
>  					DMZ_BLOCK_SIZE_BITS);=0A=
>  =0A=
>  	/* Allocate zone array */=0A=
> -	zmd->zones =3D kcalloc(dev->nr_zones, sizeof(struct dm_zone), GFP_KERNE=
L);=0A=
> +	total_nr_zones =3D dev->nr_zones;=0A=
> +	if (zmd->regu_dmz_dev)=0A=
> +		total_nr_zones +=3D zmd->regu_dmz_dev->nr_zones;=0A=
> +	zmd->zones =3D kcalloc(total_nr_zones, sizeof(struct dm_zone), GFP_KERN=
EL);=0A=
>  	if (!zmd->zones)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> @@ -1186,6 +1236,25 @@ static int dmz_init_zones(struct dmz_metadata *zmd=
)=0A=
>  		return ret;=0A=
>  	}=0A=
>  =0A=
> +	if (zmd->regu_dmz_dev) {=0A=
> +		/* Emulate zone information for regular device zone. */=0A=
> +		for (i =3D 0; i < zmd->regu_dmz_dev->nr_zones; i++) {=0A=
> +			struct dm_zone *zone =3D &zmd->zones[i + dev->nr_zones];=0A=
> +=0A=
> +			INIT_LIST_HEAD(&zone->link);=0A=
> +			atomic_set(&zone->refcount, 0);=0A=
> +			zone->chunk =3D DMZ_MAP_UNMAPPED;=0A=
> +=0A=
> +			set_bit(DMZ_RND, &zone->flags);=0A=
> +			zmd->nr_rnd_zones++;=0A=
> +			zmd->nr_useable_zones++;=0A=
> +			zone->wp_block =3D 0;=0A=
> +			if (!zmd->sb_zone)=0A=
> +				/* Super block zone */=0A=
> +				zmd->sb_zone =3D zone;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> @@ -1313,13 +1382,13 @@ static void dmz_get_zone_weight(struct dmz_metada=
ta *zmd, struct dm_zone *zone);=0A=
>   */=0A=
>  static int dmz_load_mapping(struct dmz_metadata *zmd)=0A=
>  {=0A=
> -	struct dmz_dev *dev =3D zmd->zoned_dev;=0A=
>  	struct dm_zone *dzone, *bzone;=0A=
>  	struct dmz_mblock *dmap_mblk =3D NULL;=0A=
>  	struct dmz_map *dmap;=0A=
>  	unsigned int i =3D 0, e =3D 0, chunk =3D 0;=0A=
>  	unsigned int dzone_id;=0A=
>  	unsigned int bzone_id;=0A=
> +	struct dmz_dev *dev =3D zmd_mdev(zmd);=0A=
>  =0A=
>  	/* Metadata block array for the chunk mapping table */=0A=
>  	zmd->map_mblk =3D kcalloc(zmd->nr_map_blocks,=0A=
> @@ -1345,7 +1414,7 @@ static int dmz_load_mapping(struct dmz_metadata *zm=
d)=0A=
>  		if (dzone_id =3D=3D DMZ_MAP_UNMAPPED)=0A=
>  			goto next;=0A=
>  =0A=
> -		if (dzone_id >=3D dev->nr_zones) {=0A=
> +		if (dzone_id >=3D dev->target->nr_zones) {=0A=
>  			dmz_dev_err(dev, "Chunk %u mapping: invalid data zone ID %u",=0A=
>  				    chunk, dzone_id);=0A=
>  			return -EIO;=0A=
> @@ -1366,7 +1435,7 @@ static int dmz_load_mapping(struct dmz_metadata *zm=
d)=0A=
>  		if (bzone_id =3D=3D DMZ_MAP_UNMAPPED)=0A=
>  			goto next;=0A=
>  =0A=
> -		if (bzone_id >=3D dev->nr_zones) {=0A=
> +		if (bzone_id >=3D dev->target->nr_zones) {=0A=
>  			dmz_dev_err(dev, "Chunk %u mapping: invalid buffer zone ID %u",=0A=
>  				    chunk, bzone_id);=0A=
>  			return -EIO;=0A=
> @@ -1398,7 +1467,7 @@ static int dmz_load_mapping(struct dmz_metadata *zm=
d)=0A=
>  	 * fully initialized. All remaining zones are unmapped data=0A=
>  	 * zones. Finish initializing those here.=0A=
>  	 */=0A=
> -	for (i =3D 0; i < dev->nr_zones; i++) {=0A=
> +	for (i =3D 0; i < dev->target->nr_zones; i++) {=0A=
>  		dzone =3D dmz_get(zmd, i);=0A=
>  		if (dmz_is_meta(dzone))=0A=
>  			continue;=0A=
> @@ -1632,7 +1701,7 @@ struct dm_zone *dmz_get_chunk_mapping(struct dmz_me=
tadata *zmd, unsigned int chu=0A=
>  		/* Allocate a random zone */=0A=
>  		dzone =3D dmz_alloc_zone(zmd, DMZ_ALLOC_RND);=0A=
>  		if (!dzone) {=0A=
> -			if (dmz_bdev_is_dying(zmd->zoned_dev)) {=0A=
> +			if (dmz_bdev_is_dying(zmd_mdev(zmd))) {=0A=
>  				dzone =3D ERR_PTR(-EIO);=0A=
>  				goto out;=0A=
>  			}=0A=
> @@ -1733,7 +1802,7 @@ struct dm_zone *dmz_get_chunk_buffer(struct dmz_met=
adata *zmd,=0A=
>  	/* Allocate a random zone */=0A=
>  	bzone =3D dmz_alloc_zone(zmd, DMZ_ALLOC_RND);=0A=
>  	if (!bzone) {=0A=
> -		if (dmz_bdev_is_dying(zmd->zoned_dev)) {=0A=
> +		if (dmz_bdev_is_dying(zmd_mdev(zmd))) {=0A=
>  			bzone =3D ERR_PTR(-EIO);=0A=
>  			goto out;=0A=
>  		}=0A=
> @@ -2360,7 +2429,8 @@ static void dmz_cleanup_metadata(struct dmz_metadat=
a *zmd)=0A=
>  /*=0A=
>   * Initialize the zoned metadata.=0A=
>   */=0A=
> -int dmz_ctr_metadata(struct dmz_dev *dev, struct dmz_metadata **metadata=
)=0A=
> +int dmz_ctr_metadata(struct dmz_dev *dev, struct dmz_dev *regu_dmz_dev,=
=0A=
> +		struct dmz_metadata **metadata)=0A=
>  {=0A=
>  	struct dmz_metadata *zmd;=0A=
>  	unsigned int i, zid;=0A=
> @@ -2372,6 +2442,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, struct dm=
z_metadata **metadata)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
>  	zmd->zoned_dev =3D dev;=0A=
> +	zmd->regu_dmz_dev =3D regu_dmz_dev;=0A=
>  	zmd->mblk_rbtree =3D RB_ROOT;=0A=
>  	init_rwsem(&zmd->mblk_sem);=0A=
>  	mutex_init(&zmd->mblk_flush_lock);=0A=
> @@ -2440,9 +2511,9 @@ int dmz_ctr_metadata(struct dmz_dev *dev, struct dm=
z_metadata **metadata)=0A=
>  		     bdev_zoned_model(dev->bdev) =3D=3D BLK_ZONED_HA ?=0A=
>  		     "aware" : "managed");=0A=
>  	dmz_dev_info(dev, "  %llu 512-byte logical sectors",=0A=
> -		     (u64)dev->capacity);=0A=
> +		     (u64)dev->capacity  + (u64)regu_dmz_dev->capacity);=0A=
>  	dmz_dev_info(dev, "  %u zones of %llu 512-byte logical sectors",=0A=
> -		     dev->nr_zones, (u64)dev->zone_nr_sectors);=0A=
> +		     dev->nr_zones + regu_dmz_dev->nr_zones, (u64)dev->zone_nr_sectors=
);=0A=
>  	dmz_dev_info(dev, "  %u metadata zones",=0A=
>  		     zmd->nr_meta_zones * 2);=0A=
>  	dmz_dev_info(dev, "  %u data zones for %u chunks",=0A=
> @@ -2488,7 +2559,7 @@ void dmz_dtr_metadata(struct dmz_metadata *zmd)=0A=
>   */=0A=
>  int dmz_resume_metadata(struct dmz_metadata *zmd)=0A=
>  {=0A=
> -	struct dmz_dev *dev =3D zmd->zoned_dev;=0A=
> +	struct dmz_dev *dev =3D zmd_mdev(zmd);=0A=
>  	struct dm_zone *zone;=0A=
>  	sector_t wp_block;=0A=
>  	unsigned int i;=0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index cae4bfe..41dbb9d 100644=0A=
> --- a/drivers/md/dm-zoned-target.c=0A=
> +++ b/drivers/md/dm-zoned-target.c=0A=
> @@ -803,7 +803,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int=
 argc, char **argv)=0A=
>  =0A=
>  	/* Initialize metadata */=0A=
>  	dev =3D dmz->zoned_dev;=0A=
> -	ret =3D dmz_ctr_metadata(dev, &dmz->metadata);=0A=
> +	ret =3D dmz_ctr_metadata(dev, dmz->regu_dmz_dev, &dmz->metadata);=0A=
>  	if (ret) {=0A=
>  		ti->error =3D "Metadata initialization failed";=0A=
>  		goto err_dev;=0A=
> @@ -852,8 +852,8 @@ static int dmz_ctr(struct dm_target *ti, unsigned int=
 argc, char **argv)=0A=
>  	}=0A=
>  	mod_delayed_work(dmz->flush_wq, &dmz->flush_work, DMZ_FLUSH_PERIOD);=0A=
>  =0A=
> -	/* Initialize reclaim */=0A=
> -	ret =3D dmz_ctr_reclaim(dev, dmz->metadata, &dmz->reclaim);=0A=
> +	/* Initialize reclaim, only reclaim from regular device. */=0A=
> +	ret =3D dmz_ctr_reclaim(dmz->regu_dmz_dev, dmz->metadata, &dmz->reclaim=
);=0A=
>  	if (ret) {=0A=
>  		ti->error =3D "Zone reclaim initialization failed";=0A=
>  		goto err_fwq;=0A=
> diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h=0A=
> index a3535bc..7aa1a30 100644=0A=
> --- a/drivers/md/dm-zoned.h=0A=
> +++ b/drivers/md/dm-zoned.h=0A=
> @@ -206,7 +206,8 @@ struct dmz_reclaim;=0A=
>  /*=0A=
>   * Functions defined in dm-zoned-metadata.c=0A=
>   */=0A=
> -int dmz_ctr_metadata(struct dmz_dev *dev, struct dmz_metadata **zmd);=0A=
> +int dmz_ctr_metadata(struct dmz_dev *dev, struct dmz_dev *regu_dmz_dev,=
=0A=
> +		struct dmz_metadata **zmd);=0A=
>  void dmz_dtr_metadata(struct dmz_metadata *zmd);=0A=
>  int dmz_resume_metadata(struct dmz_metadata *zmd);=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
