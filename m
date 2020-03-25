Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A6BC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72B720719
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yv8nDke7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ksRBi6lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCYGUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:20:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38286 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYGUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 02:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585117260; x=1616653260;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/uelMTCmucSJluGPSTFM2JnWTQbTqpE3hEaM4MwyPwo=;
  b=Yv8nDke7g7vtrFKnkUvGgQmOjJ7ey8C6KmAxyKAafs19fSNQ+pjKFVqB
   vMy0EXknRPJgAgQ8kSbl1K7Ubei20+3lY+iBibONy5YB77cDYzIWJDUgq
   VFoMtm+8qcGJn0vFFg/m6cw3Y2scufJPmUv3fcLUtryHov6PmX3UTb1Fb
   DqKVAcgi3JU4gOlaN5D2CpD4X1TfBanBMgbRLQhC6ihtg1HGr3SeIN2+4
   MRiMNQO6cMW1E++ovJEctbWfm9uYUgmrwRqD630K0r03gkL2h/bPsdIdl
   psM8Urg5BHH1fYPNu5Sukw8G1s61idzLDBsP/yW4imGGu1YaSPZ96XE2U
   A==;
IronPort-SDR: irj5fw7Bic7YTlJ3S1T51p3I6Nm80yp74l8QlVzw39NmY2X4d4zdegUkgYW1vXL3zwU8gZDvbm
 zGR9QUgHge8oPFf9cJsetuVry3pK+TvNR0NtH8QnM7a44ypbfcCndtcRznb1MvraiYVB9DMeNn
 oA2KXYwbnpgK8bGf94ZRN4tMbrdx2cynifzyGSmdZdYG0up3o4Whe2aBQ4dljgjjwfAzMyVgjt
 ofOdx0dAQwjN5G9/9cU52kNXuVWEI78C6r3AyfsnYSWqnZu5+LSX8hlxT3YkYdstIc8FT60G+w
 Z/M=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235664077"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 14:20:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVCpiixzPeuHxpf/xPoQoLGZcO+cJVjCIn+6esUa/IqmG4pOgJL2Y3wgwRGLOQ6OD0R7yqYZrsRs6DCwpHRk9PX9vcWlMHKOZmOxS4qL4RZji/Fhox61mMFNA7IFxOwCzvWFQdudTO7qjulTt6Dwj5aK4iO0hdVYqIVVfRghDSCnS7GHZV0FxI8deguqkDmnO7ipn1lZXsxknZcqj2+wm1mCOnz940ba2rVpubDg5AUHsEPBxFntcYhyk0cTtNWEjXISDEpGbsvc401GhAz8OPaALKEBjEYogj1mopkrGrQkHk1Q3proGfq+i98idm9MCdlC98E6FZ9CnzyEZJ+7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r6Zw8MN35D99nr4wgOIyP2orbgIJ/TjpSqCMH9PCGk=;
 b=j4v5ZVFcVIcv4S/m/WuLPI6i4N5hni0qmMbJRuo56ROtbshPxyDpS4XsL7hKkJ2ifOY+0voihTHYvxc+1/FSCmc6VYW6YRvF+Yqz3dYA7ItARzLvuiyabs0lfArSbC0ZTE3ivvFdeyXKNHqxqfkKXBBD2pfSvXKoOX31yXycShrLxix/QNLRRukwnoJu+PxdHBlt9Pvigk+VuEA4q0XYIFLxAHtKy5vwAHeggmKmmN3OEW2a60A8Cb/ZgN3++bvL2QtRmseyN7NngknAbRtD/cM5XhhkWGzACLqjvqEP/1wiwBvWBMh9ymT7+NUit0tK5+xoSx/AbZOqZynyGXA6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r6Zw8MN35D99nr4wgOIyP2orbgIJ/TjpSqCMH9PCGk=;
 b=ksRBi6lRjBierwEf/Gh7fJsKkj0MrCwNNBBleB1XDRr0rwcPF9HgK2jNL5ZKEQhUU5AIYSxrDddkcK4milCVtPO/akYMfdYB4E7607re65AWh3XD41qBrxuJMv2bXe17Z79vCwuZZoHOSIkKopsykOOdlk/NrbxFwxevrBuG6MM=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2199.namprd04.prod.outlook.com (2603:10b6:102:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 06:20:47 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 06:20:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [RFC PATCH v2 2/3] dm zoned: introduce regular device to
 dm-zoned-target
Thread-Topic: [RFC PATCH v2 2/3] dm zoned: introduce regular device to
 dm-zoned-target
Thread-Index: AQHWAcvoaWeO+PbNHEKzSPSdKEVGAg==
Date:   Wed, 25 Mar 2020 06:20:47 +0000
Message-ID: <CO2PR04MB23437670CA0BD671AB008754E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-3-bob.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 478e87ba-4515-4ab4-0544-08d7d084a88a
x-ms-traffictypediagnostic: CO2PR04MB2199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB219915030357EE16625F1451E7CE0@CO2PR04MB2199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(54906003)(33656002)(8936002)(186003)(81166006)(71200400001)(81156014)(26005)(110136005)(8676002)(7696005)(66446008)(9686003)(53546011)(55016002)(66556008)(91956017)(4326008)(30864003)(66476007)(478600001)(5660300002)(66946007)(316002)(64756008)(2906002)(76116006)(52536014)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2199;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iad1fXtoIxzWU43RSLew70MDL9OICjZ6ifimfqrXx7fOBrg3D6/nRrnR2sU1BSIiKJVtARwJhzxomHcpQxAo7HYRZ9BQspyVLJap9rNwArHX0p266hvLvLiaeMEhZZ6D7ZTTSrVjLaRKrkMFgYG+E9DU84P9uvKvBUw9gTiyGOod1ZXf2f2Vsl4Vdu7NSh/imHnKQ9tOvGhkR8H2UFPMj+HQQlEy2JtPhTrgMkEpjMix9hGBvidwYVbQJgGfTiVy+zBmDNV3+de83R2WurKhEgtcfWXJOjeQFf4UufvDRM3DvRz+MhjZevh8zrD4uZm9BYKzhKE2ejpl0QhyHpWMi0wR3ai/BLw4vqOVLv72Bwar21mRwR+ji9RFLcB9vekOhLuebZhqrGZL/Up9Y57fjym9o5wlN5Df3tQKV74EZr/pURtWQUK9eN5BMnv5uz+D
x-ms-exchange-antispam-messagedata: YRXCeKZegtZMRUs2++l4ml/703ymK3n3H9B/xcXg1RF42ygVBV/b0VdFSblYNUC5AJK2x6pc25IhaJPOPWmR9Y+EJLX3b2cKpN8acadr3yeqECrHnm965ZgSKshmwNyqjQb1RdZ2/zCNF0C6UsGRwQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478e87ba-4515-4ab4-0544-08d7d084a88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 06:20:47.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KQhVdOgrpLwDpUC8kTi7KgLw4p9O24GGzCFpj5tKyBnkguDGK9LIqgnam9Lh6Q/uPN5aBF4wBu/jbD5NrO/Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/24 20:03, Bob Liu wrote:=0A=
> Introduce a regular device for storing metadata and buffer write, zoned=
=0A=
> device is used by default if no regular device was set by dmsetup.=0A=
> =0A=
> The corresponding dmsetup cmd is:=0A=
> echo "0 $size zoned $regular_device $zoned_device" | dmsetup create $dm-z=
oned-name=0A=
> =0A=
> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
> ---=0A=
>  drivers/md/dm-zoned-target.c | 141 +++++++++++++++++++++++++------------=
------=0A=
>  drivers/md/dm-zoned.h        |  50 +++++++++++++--=0A=
>  2 files changed, 127 insertions(+), 64 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index 28f4d00..cae4bfe 100644=0A=
> --- a/drivers/md/dm-zoned-target.c=0A=
> +++ b/drivers/md/dm-zoned-target.c=0A=
> @@ -35,38 +35,6 @@ struct dm_chunk_work {=0A=
>  };=0A=
>  =0A=
>  /*=0A=
> - * Target descriptor.=0A=
> - */=0A=
> -struct dmz_target {=0A=
> -	struct dm_dev		*ddev;=0A=
> -=0A=
> -	unsigned long		flags;=0A=
> -=0A=
> -	/* Zoned block device information */=0A=
> -	struct dmz_dev		*zoned_dev;=0A=
> -=0A=
> -	/* For metadata handling */=0A=
> -	struct dmz_metadata     *metadata;=0A=
> -=0A=
> -	/* For reclaim */=0A=
> -	struct dmz_reclaim	*reclaim;=0A=
> -=0A=
> -	/* For chunk work */=0A=
> -	struct radix_tree_root	chunk_rxtree;=0A=
> -	struct workqueue_struct *chunk_wq;=0A=
> -	struct mutex		chunk_lock;=0A=
> -=0A=
> -	/* For cloned BIOs to zones */=0A=
> -	struct bio_set		bio_set;=0A=
> -=0A=
> -	/* For flush */=0A=
> -	spinlock_t		flush_lock;=0A=
> -	struct bio_list		flush_list;=0A=
> -	struct delayed_work	flush_work;=0A=
> -	struct workqueue_struct *flush_wq;=0A=
> -};=0A=
=0A=
I am not sure I understand why this needs to be moved from here=0A=
into dm-zoned.h...=0A=
=0A=
> -=0A=
> -/*=0A=
>   * Flush intervals (seconds).=0A=
>   */=0A=
>  #define DMZ_FLUSH_PERIOD	(10 * HZ)=0A=
> @@ -679,7 +647,7 @@ static int dmz_map(struct dm_target *ti, struct bio *=
bio)=0A=
>  /*=0A=
>   * Get zoned device information.=0A=
>   */=0A=
> -static int dmz_get_zoned_device(struct dm_target *ti, char *path)=0A=
> +static int dmz_get_device(struct dm_target *ti, char *path, bool zoned)=
=0A=
=0A=
I do not think you need the zoned argument here. You can easily detect this=
=0A=
using bdev_is_zoned() once you get the bdev.=0A=
=0A=
>  {=0A=
>  	struct dmz_target *dmz =3D ti->private;=0A=
>  	struct request_queue *q;=0A=
> @@ -688,11 +656,22 @@ static int dmz_get_zoned_device(struct dm_target *t=
i, char *path)=0A=
>  	int ret;=0A=
>  =0A=
>  	/* Get the target device */=0A=
> -	ret =3D dm_get_device(ti, path, dm_table_get_mode(ti->table), &dmz->dde=
v);=0A=
> -	if (ret) {=0A=
> -		ti->error =3D "Get target device failed";=0A=
> -		dmz->ddev =3D NULL;=0A=
> -		return ret;=0A=
> +	if (zoned) {=0A=
> +		ret =3D dm_get_device(ti, path, dm_table_get_mode(ti->table),=0A=
> +				&dmz->ddev);=0A=
> +		if (ret) {=0A=
> +			ti->error =3D "Get target device failed";=0A=
> +			dmz->ddev =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
> +	} else {=0A=
> +		ret =3D dm_get_device(ti, path, dm_table_get_mode(ti->table),=0A=
> +				&dmz->regu_dm_dev);=0A=
> +		if (ret) {=0A=
> +			ti->error =3D "Get target device failed";=0A=
> +			dmz->regu_dm_dev =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
=0A=
If you use a local variable ddev, you do not need to duplicate this hunk.=
=0A=
All you need is:=0A=
=0A=
if (zoned)=0A=
	dmz->zddev =3D ddev;=0A=
else=0A=
	dmz->cddev =3D ddev;=0A=
=0A=
>  	}=0A=
>  =0A=
>  	dev =3D kzalloc(sizeof(struct dmz_dev), GFP_KERNEL);=0A=
> @@ -701,39 +680,61 @@ static int dmz_get_zoned_device(struct dm_target *t=
i, char *path)=0A=
>  		goto err;=0A=
>  	}=0A=
>  =0A=
> -	dev->bdev =3D dmz->ddev->bdev;=0A=
> -	(void)bdevname(dev->bdev, dev->name);=0A=
> -=0A=
> -	if (bdev_zoned_model(dev->bdev) =3D=3D BLK_ZONED_NONE) {=0A=
> -		ti->error =3D "Not a zoned block device";=0A=
> -		ret =3D -EINVAL;=0A=
> -		goto err;=0A=
> +	if (zoned) {=0A=
> +		dev->bdev =3D dmz->ddev->bdev;=0A=
> +		if (bdev_zoned_model(dev->bdev) =3D=3D BLK_ZONED_NONE) {=0A=
> +			ti->error =3D "Not a zoned block device";=0A=
> +			ret =3D -EINVAL;=0A=
> +			goto err;=0A=
> +		}=0A=
>  	}=0A=
> +	else=0A=
> +		dev->bdev =3D dmz->regu_dm_dev->bdev;=0A=
> +=0A=
> +	(void)bdevname(dev->bdev, dev->name);=0A=
> +	dev->target =3D dmz;=0A=
>  =0A=
>  	q =3D bdev_get_queue(dev->bdev);=0A=
>  	dev->capacity =3D i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;=0A=
>  	aligned_capacity =3D dev->capacity &=0A=
>  				~((sector_t)blk_queue_zone_sectors(q) - 1);=0A=
> -	if (ti->begin ||=0A=
> -	    ((ti->len !=3D dev->capacity) && (ti->len !=3D aligned_capacity))) =
{=0A=
> -		ti->error =3D "Partial mapping not supported";=0A=
> -		ret =3D -EINVAL;=0A=
> -		goto err;=0A=
> -	}=0A=
>  =0A=
> -	dev->zone_nr_sectors =3D blk_queue_zone_sectors(q);=0A=
> -	dev->zone_nr_sectors_shift =3D ilog2(dev->zone_nr_sectors);=0A=
> +	if (zoned) {=0A=
> +		if (ti->begin || ((ti->len !=3D dev->capacity) &&=0A=
> +					(ti->len !=3D aligned_capacity))) {=0A=
> +			ti->error =3D "Partial mapping not supported";=0A=
> +			ret =3D -EINVAL;=0A=
> +			goto err;=0A=
> +		}=0A=
> +		dev->zone_nr_sectors =3D blk_queue_zone_sectors(q);=0A=
> +		dev->zone_nr_sectors_shift =3D ilog2(dev->zone_nr_sectors);=0A=
> +=0A=
> +		dev->zone_nr_blocks =3D dmz_sect2blk(dev->zone_nr_sectors);=0A=
> +		dev->zone_nr_blocks_shift =3D ilog2(dev->zone_nr_blocks);=0A=
>  =0A=
> -	dev->zone_nr_blocks =3D dmz_sect2blk(dev->zone_nr_sectors);=0A=
> -	dev->zone_nr_blocks_shift =3D ilog2(dev->zone_nr_blocks);=0A=
> +		dev->nr_zones =3D blkdev_nr_zones(dev->bdev->bd_disk);=0A=
>  =0A=
> -	dev->nr_zones =3D blkdev_nr_zones(dev->bdev->bd_disk);=0A=
> +		dmz->zoned_dev =3D dev;=0A=
> +	} else {=0A=
> +		/* Emulate regular device zone info by using the same zone size.*/=0A=
> +		dev->zone_nr_sectors =3D dmz->zoned_dev->zone_nr_sectors;=0A=
> +		dev->zone_nr_sectors_shift =3D ilog2(dev->zone_nr_sectors);=0A=
>  =0A=
> -	dmz->zoned_dev =3D dev;=0A=
> +		dev->zone_nr_blocks =3D dmz_sect2blk(dev->zone_nr_sectors);=0A=
> +		dev->zone_nr_blocks_shift =3D ilog2(dev->zone_nr_blocks);=0A=
> +=0A=
> +		dev->nr_zones =3D (get_capacity(dev->bdev->bd_disk) >>=0A=
> +				ilog2(dev->zone_nr_sectors));=0A=
> +=0A=
> +		dmz->regu_dmz_dev =3D dev;=0A=
> +	}=0A=
>  =0A=
>  	return 0;=0A=
>  err:=0A=
> -	dm_put_device(ti, dmz->ddev);=0A=
> +	if (zoned)=0A=
> +		dm_put_device(ti, dmz->ddev);=0A=
> +	else=0A=
> +		dm_put_device(ti, dmz->regu_dm_dev);=0A=
=0A=
A local ddev variable will avoid the need for the if/else here.=0A=
=0A=
>  	kfree(dev);=0A=
>  =0A=
>  	return ret;=0A=
> @@ -746,6 +747,12 @@ static void dmz_put_zoned_device(struct dm_target *t=
i)=0A=
>  {=0A=
>  	struct dmz_target *dmz =3D ti->private;=0A=
>  =0A=
> +	if (dmz->regu_dm_dev)=0A=
> +		dm_put_device(ti, dmz->regu_dm_dev);=0A=
> +	if (dmz->regu_dmz_dev) {=0A=
> +		kfree(dmz->regu_dmz_dev);=0A=
> +		dmz->regu_dmz_dev =3D NULL;=0A=
> +	}=0A=
>  	dm_put_device(ti, dmz->ddev);=0A=
>  	kfree(dmz->zoned_dev);=0A=
>  	dmz->zoned_dev =3D NULL;=0A=
> @@ -761,7 +768,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int=
 argc, char **argv)=0A=
>  	int ret;=0A=
>  =0A=
>  	/* Check arguments */=0A=
> -	if (argc !=3D 1) {=0A=
> +	if ((argc !=3D 1) && (argc !=3D 2)) {=0A=
>  		ti->error =3D "Invalid argument count";=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> @@ -775,12 +782,25 @@ static int dmz_ctr(struct dm_target *ti, unsigned i=
nt argc, char **argv)=0A=
>  	ti->private =3D dmz;=0A=
>  =0A=
>  	/* Get the target zoned block device */=0A=
> -	ret =3D dmz_get_zoned_device(ti, argv[0]);=0A=
> +	ret =3D dmz_get_device(ti, argv[0], 1);=0A=
>  	if (ret) {=0A=
>  		dmz->ddev =3D NULL;=0A=
>  		goto err;=0A=
>  	}=0A=
>  =0A=
> +	snprintf(dmz->name, BDEVNAME_SIZE, "%s", dmz->zoned_dev->name);=0A=
> +	dmz->nr_zones =3D dmz->zoned_dev->nr_zones;=0A=
> +	if (argc =3D=3D 2) {=0A=
> +		ret =3D dmz_get_device(ti, argv[1], 0);=0A=
> +		if (ret) {=0A=
> +			dmz->regu_dm_dev =3D NULL;=0A=
> +			goto err;=0A=
> +		}=0A=
> +		snprintf(dmz->name, BDEVNAME_SIZE * 2, "%s:%s",=0A=
> +				dmz->zoned_dev->name, dmz->regu_dmz_dev->name);=0A=
> +		dmz->nr_zones +=3D dmz->regu_dmz_dev->nr_zones;=0A=
> +	}=0A=
> +=0A=
>  	/* Initialize metadata */=0A=
>  	dev =3D dmz->zoned_dev;=0A=
>  	ret =3D dmz_ctr_metadata(dev, &dmz->metadata);=0A=
> @@ -962,6 +982,7 @@ static int dmz_iterate_devices(struct dm_target *ti,=
=0A=
>  	struct dmz_dev *dev =3D dmz->zoned_dev;=0A=
>  	sector_t capacity =3D dev->capacity & ~(dev->zone_nr_sectors - 1);=0A=
>  =0A=
> +	/* Todo: fn(dmz->regu_dm_dev) */=0A=
>  	return fn(ti, dmz->ddev, 0, capacity, data);=0A=
>  }=0A=
>  =0A=
> diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h=0A=
> index 5b5e493..a3535bc 100644=0A=
> --- a/drivers/md/dm-zoned.h=0A=
> +++ b/drivers/md/dm-zoned.h=0A=
> @@ -46,9 +46,51 @@=0A=
>  #define dmz_bio_blocks(bio)	dmz_sect2blk(bio_sectors(bio))=0A=
>  =0A=
>  /*=0A=
> + * Target descriptor.=0A=
> + */=0A=
> +struct dmz_target {=0A=
> +	struct dm_dev		*ddev;=0A=
> +	/*=0A=
> +	 * Regular device for store metdata and buffer write, use zoned device=
=0A=
> +	 * by default if no regular device was set.=0A=
> +	 */=0A=
> +	struct dm_dev           *regu_dm_dev;=0A=
=0A=
rddev is shorter...=0A=
=0A=
> +	struct dmz_dev          *regu_dmz_dev;=0A=
=0A=
And rdev here ? Or "cdev" with the c standing for "cache" and "conventional=
=0A=
(=3Dnot zoned)" at the same time.=0A=
=0A=
> +	/* Total nr_zones. */=0A=
> +	unsigned int            nr_zones;=0A=
> +	char                    name[BDEVNAME_SIZE * 2];=0A=
=0A=
I would define 2 fields rather than doubling the nbame length. The field na=
mes=0A=
can follow the same pattern and zdev/cdev, you add zname and cname. Anyway,=
 this=0A=
string is already in dmz_dev, so why add it ?=0A=
=0A=
> +=0A=
> +	unsigned long		flags;=0A=
=0A=
Flags are currently for target and backedn device. This needs to sorted out=
=0A=
because there will be a need for per backend device (e.g. dying flag etc) f=
lags,=0A=
so this needs to be split, one flag field for each cache and zoned dev.=0A=
=0A=
> +=0A=
> +	/* Zoned block device information */=0A=
> +	struct dmz_dev		*zoned_dev;=0A=
=0A=
Similarly to regu_dmz_dev, it would be better to pair this one with struct=
=0A=
dm_dev *ddev above and rename ddev field to zddev.=0A=
=0A=
And to simplify everything, you could move ddev to struct dmz_dev and add a=
=0A=
flags field there. Then all you need in struct dmz_target is:=0A=
=0A=
struct dm_dev           *cdev;=0A=
struct dm_dev           *zdev;=0A=
=0A=
> +=0A=
> +	/* For metadata handling */=0A=
> +	struct dmz_metadata     *metadata;=0A=
> +=0A=
> +	/* For reclaim */=0A=
> +	struct dmz_reclaim	*reclaim;=0A=
> +=0A=
> +	/* For chunk work */=0A=
> +	struct radix_tree_root	chunk_rxtree;=0A=
> +	struct workqueue_struct *chunk_wq;=0A=
> +	struct mutex		chunk_lock;=0A=
> +=0A=
> +	/* For cloned BIOs to zones */=0A=
> +	struct bio_set		bio_set;=0A=
> +=0A=
> +	/* For flush */=0A=
> +	spinlock_t		flush_lock;=0A=
> +	struct bio_list		flush_list;=0A=
> +	struct delayed_work	flush_work;=0A=
> +	struct workqueue_struct *flush_wq;=0A=
> +};=0A=
> +=0A=
> +/*=0A=
>   * Zoned block device information.=0A=
>   */=0A=
>  struct dmz_dev {=0A=
> +	struct dmz_target       *target;=0A=
>  	struct block_device	*bdev;=0A=
>  =0A=
>  	char			name[BDEVNAME_SIZE];=0A=
> @@ -147,16 +189,16 @@ enum {=0A=
>   * Message functions.=0A=
>   */=0A=
>  #define dmz_dev_info(dev, format, args...)	\=0A=
> -	DMINFO("(%s): " format, (dev)->name, ## args)=0A=
> +	DMINFO("(%s): " format, (dev)->target->name, ## args)=0A=
>  =0A=
>  #define dmz_dev_err(dev, format, args...)	\=0A=
> -	DMERR("(%s): " format, (dev)->name, ## args)=0A=
> +	DMERR("(%s): " format, (dev)->target->name, ## args)=0A=
>  =0A=
>  #define dmz_dev_warn(dev, format, args...)	\=0A=
> -	DMWARN("(%s): " format, (dev)->name, ## args)=0A=
> +	DMWARN("(%s): " format, (dev)->target->name, ## args)=0A=
>  =0A=
>  #define dmz_dev_debug(dev, format, args...)	\=0A=
> -	DMDEBUG("(%s): " format, (dev)->name, ## args)=0A=
> +	DMDEBUG("(%s): " format, (dev)->target->name, ## args)=0A=
>  =0A=
>  struct dmz_metadata;=0A=
>  struct dmz_reclaim;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
