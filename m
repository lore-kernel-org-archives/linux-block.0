Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0AC00523
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 07:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A52053B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 07:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pDBh3gT5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RKj9kRec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgAHHk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:40:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20926 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHHk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 02:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578469257; x=1610005257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zOlXL4k1MvwR3c1y+jrbGRiS3i5JOP7qb8VvFtJZREQ=;
  b=pDBh3gT51P/pO3M3cbJ68pDZTDuXS+ozSopq+3JR2SVEtvz9rzbeiTO3
   EUVoFQUH8tbMmcD9kV/gDSYurltCr3bLolaCkLZwUT9who1rg3OP8nIOS
   x/a3xyQw/RE3568h+sZLJpXK3RnKVc56/eehekgbd21raPEqkspmJQOlA
   5jWJfXr3sewq1IhZNzljPVzRzO47F+A/ahZAWNTHRYmWLHZ6mI93RB0gO
   21kH5nTOZST/BNAeSR3TPFFMvluFzp56lV8mrjtrhmtS3k4O2K1qZOxUL
   zpXpynRoSAIwn8a9dy1z0pWLFf6krxdp4hexx8WCdS4NsTdv3bq9FpUnr
   w==;
IronPort-SDR: l3H441SRCyO+7vzFu7Z2sHTvEpnxUc7/dE9UWNho34OtXyBTgG07VuuZvNVNiAPN+Hp5h6qx3D
 bJk5yYOnp+vFhUqC6BCjt3Wf9VZbex5XLQ1WiB6KnG5qnWCS5+c794eOLbIcDQJaaSDjT6yGFS
 bkBjcW4U0E1rF2y4oT5OtVPZsE3XUGCYlGlth7QgFnkBpmi6lNhAg4c+qnkbldxuyFkPOevozu
 55FJsTzRHchBaaEUX2lfA2oHxD6Gk43Hi06etfAsWEuDrEsKpiRJtmeW+YkyFxKdzRwh8GQuDX
 XcQ=
X-IronPort-AV: E=Sophos;i="5.69,409,1571673600"; 
   d="scan'208";a="127673569"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 15:40:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJoLxU+Z7afz8b+Z6MnNtSstEuDi84r7bOfy2slTU0eBYmR8/0gfiQLR/crsZFeMz3zQ6eY7B3RtAHTJOaqOQeT26GykZd3Ja6nolAAa8mr2kJcp1VU7Qhzo9SDIdJ/vroqt5zXp4l92ynozCrI7eadZPpCFFOC+2S+RqIezXncmBwmcsn5JrvO+7nRqfQgHGLihwpINQdeFSb6YXySF/fC+DsPf8F33hnAl7WnPThWmhOM2H4lYrkWZeP47sYh/OBn8TStQRf5OxJKceupAxRlTIKD+DQl+5OaaSy37SbG2hdd0hGiYjz2OIgRU4vc1qETw+6NEQmBVYwvoDSROFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG3xH4LrQ+BlaHssjjRxV6o7KTckz2soSyvRJ3JyfYY=;
 b=od8/8JDnPndDfl7YRQBJN6l1Bk/SE0Bh3E1H64ZE75vePgMra/259SNvkyAIqIcK88/U8ObGFcusigkqdgM1FOksDgECuwF4mnCM/pwy4enkm/UjldBvx9euWEftKflP9BrKkyP5K2SIVJ1oTHzCHIAz7nBVbj3tXS1tmbn7hcT1LwumMkLFohGLIQ61/BlIWenaVlwWEZIKIToEqHW+ln0SSGfp7H1QEycw1gdw/kyV7y30sFbAMaO/LLWramoxdtpD5FlUMZqb+Eh4Qa6m40a5d8XylTj21mqw128MtveSUXaZiY6yQpDmLZqRbWOMWW1ELUndNq1pRX9W1EOvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG3xH4LrQ+BlaHssjjRxV6o7KTckz2soSyvRJ3JyfYY=;
 b=RKj9kRecMkEDIx2VcxjP7HZ2XnWkLLbntN59YqgCgLritkhHrIjiGUyE54rxafUTJewWLxjR4eRhNUDZcl2rP+IJtcRfbJ7DLFtaLDKbzxpSmLt2Z3gJtcB7kERW8UcFQFd4MptAYE8639nV0u6nWFfM8zuKUIPqh/8dR18t2NM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5606.namprd04.prod.outlook.com (20.179.58.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 07:40:54 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 07:40:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Nobody <Nobody@nobody.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "shirley.ma@oracle.com" <shirley.ma@oracle.com>,
        Bob Liu <bob.liu@oracle.com>
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Topic: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Index: AQHVxfMPtnSx9ygQV0yw4PguyV00/g==
Date:   Wed, 8 Jan 2020 07:40:54 +0000
Message-ID: <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be7ae671-b883-423f-df73-08d7940e178e
x-ms-traffictypediagnostic: BYAPR04MB5606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5606703132E96C00DAF80EE2E73E0@BYAPR04MB5606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(110136005)(2906002)(5660300002)(86362001)(33656002)(54906003)(316002)(26005)(66946007)(6506007)(7696005)(53546011)(186003)(8676002)(9686003)(66556008)(81166006)(64756008)(91956017)(55016002)(71200400001)(8936002)(76116006)(66446008)(52536014)(66476007)(81156014)(4326008)(478600001)(16250700002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5606;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OeZKUAnuQsEQ7Mx+OrvGChhRiZbBMYeZU1nmC4Y0VTihA5Rr8xYMBMB5/lhJS+mq7YeGIDf6Sn4ECPXbe/1o7Ca3rJMIOoIyjQBuONEQhX13wIQ+m+pruHdbTr32X+pL62wTgNZQWsnxmucF+/jlvpYI4NuM+UNi6DRAttAhCacyrl2rlaSlthmUMUd8RtasB7JF0ghhHeYENtb7lc9i2wqfiVJGc5BCD9LgA80VjexNawmDfqJ8BEa/LgcacM92KeTZagLETq+S/RGDxdOkyitTBf0blq8dxWljPubyhwqUWjm4JJipls0e/Uh3nVNaT8VZqvqFHl6cNh85nghU9HH4Xd14xzVARZi07/y2cPV6qGpJPDK9j9n45Zj+omPfWbfIUaeJeAyZ6XOqcXLZj9ChxwMZ0a7Amkvy2pGk7PFKD1L6dXT/tT/6oj9tGD4/mEwC6nNj1ZL1wtGzI8Hc2i6/2EItmmKJDfcp6RearBsR6x+CnaUKB68a4XF/e8OO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7ae671-b883-423f-df73-08d7940e178e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 07:40:54.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwbuCkcDGGXdl75MXzhNby5YtLzdBBZaNNkCuW7VwCOXGE2VIceTcYuH49F9beHn7ZMKRNX832mA5/E0z+z1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5606
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/01/08 16:13, Nobody wrote:=0A=
> From: Bob Liu <bob.liu@oracle.com>=0A=
> =0A=
> Motivation:=0A=
> Now the dm-zoned device mapper target exposes a zoned block device(ZBC) a=
s a=0A=
> regular block device by storing metadata and buffering random writes in=
=0A=
> conventional zones.=0A=
> This way is not very flexible, there must be enough conventional zones an=
d the=0A=
> performance may be constrained.=0A=
> By putting metadata(also buffering random writes) in separated device we =
can get=0A=
> more flexibility and potential performance improvement e.g by storing met=
adata=0A=
> in faster device like persistent memory.=0A=
> =0A=
> This patch try to split the metadata of dm-zoned to an extra block=0A=
> device instead of zoned block device itself.=0A=
> (Buffering random writes also in the todo list.)=0A=
> =0A=
> Patch is at the very early stage, just want to receive some feedback abou=
t=0A=
> this extension.=0A=
> Another option is to create an new md-zoned device with separated metadat=
a=0A=
> device based on md framework.=0A=
=0A=
For metadata only, it should not be hard at all to move to another=0A=
conventional zone device. It will however be a little more tricky for=0A=
conventional zones used for data since dm-zoned assumes that this random=0A=
write space is also zoned. Moving this space to a conventional device=0A=
requires implementing a zone emulation (fake zones) for the regular=0A=
drive, using a zone size that matches the size of sequential zones.=0A=
=0A=
Beyond this, dm-zoned also needs to be changed to accept partial drives=0A=
and the dm core code to accept mixing of regular and zoned disks (that=0A=
is forbidden now).=0A=
=0A=
Another approach worth exploring is stacking dm-zoned as is on top of a=0A=
modified dm-linear with the ability to emulate conventional zones on top=0A=
of a regular block device (you only need report zones method=0A=
implemented). That is much easier to do. We actually hacked something=0A=
like that last month to see the performance change and saw a jump from=0A=
56 MB/s to 250 MB/s for write intensive workloads (file creation on=0A=
ext4). I am not so warm in this approach though as it modifies dm-linear=0A=
and we want to keep it very lean and simple. Modifying dm-zoned to allow=0A=
support for a device pair is a better approach I think.=0A=
=0A=
> =0A=
> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
> ---=0A=
>  drivers/md/dm-zoned-metadata.c |  6 +++---=0A=
>  drivers/md/dm-zoned-target.c   | 15 +++++++++++++--=0A=
>  drivers/md/dm-zoned.h          |  1 +=0A=
>  3 files changed, 17 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadat=
a.c=0A=
> index 22b3cb0..89cd554 100644=0A=
> --- a/drivers/md/dm-zoned-metadata.c=0A=
> +++ b/drivers/md/dm-zoned-metadata.c=0A=
> @@ -439,7 +439,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct =
dmz_metadata *zmd,=0A=
>  =0A=
>  	/* Submit read BIO */=0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->dev->bdev);=0A=
> +	bio_set_dev(bio, zmd->dev->meta_bdev);=0A=
>  	bio->bi_private =3D mblk;=0A=
>  	bio->bi_end_io =3D dmz_mblock_bio_end_io;=0A=
>  	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);=0A=
> @@ -593,7 +593,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd,=
 struct dmz_mblock *mblk,=0A=
>  	set_bit(DMZ_META_WRITING, &mblk->state);=0A=
>  =0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->dev->bdev);=0A=
> +	bio_set_dev(bio, zmd->dev->meta_bdev);=0A=
>  	bio->bi_private =3D mblk;=0A=
>  	bio->bi_end_io =3D dmz_mblock_bio_end_io;=0A=
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);=0A=
> @@ -620,7 +620,7 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd, i=
nt op, sector_t block,=0A=
>  		return -ENOMEM;=0A=
>  =0A=
>  	bio->bi_iter.bi_sector =3D dmz_blk2sect(block);=0A=
> -	bio_set_dev(bio, zmd->dev->bdev);=0A=
> +	bio_set_dev(bio, zmd->dev->meta_bdev);=0A=
>  	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);=0A=
>  	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);=0A=
>  	ret =3D submit_bio_wait(bio);=0A=
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c=
=0A=
> index 70a1063..55c64fe 100644=0A=
> --- a/drivers/md/dm-zoned-target.c=0A=
> +++ b/drivers/md/dm-zoned-target.c=0A=
> @@ -39,6 +39,7 @@ struct dm_chunk_work {=0A=
>   */=0A=
>  struct dmz_target {=0A=
>  	struct dm_dev		*ddev;=0A=
> +	struct dm_dev           *metadata_dev;=0A=
=0A=
This naming would be confusing as it implies metadata only. If you also=0A=
want to move the random write zones to a regular device, then I would=0A=
suggest names like:=0A=
=0A=
ddev -> zoned_bdev (the zoned device, e.g. SMR disk)=0A=
metadata_dev -> reg_bdev (regular block device, e.g. an SSD)=0A=
=0A=
The metadata+random write (fake) zones space can use the regular block=0A=
device, and all sequential zones are assumed to be on the zoned device.=0A=
Care must be taken to handle the case of a zoned device that has=0A=
conventional zones: these could be used as is, not needing any reclaim,=0A=
so potentially contributing to further optimization.=0A=
=0A=
>  =0A=
>  	unsigned long		flags;=0A=
>  =0A=
> @@ -701,6 +702,7 @@ static int dmz_get_zoned_device(struct dm_target *ti,=
 char *path)=0A=
>  		goto err;=0A=
>  	}=0A=
>  =0A=
> +	dev->meta_bdev =3D dmz->metadata_dev->bdev;=0A=
>  	dev->bdev =3D dmz->ddev->bdev;=0A=
>  	(void)bdevname(dev->bdev, dev->name);=0A=
>  =0A=
> @@ -761,7 +763,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int=
 argc, char **argv)=0A=
>  	int ret;=0A=
>  =0A=
>  	/* Check arguments */=0A=
> -	if (argc !=3D 1) {=0A=
> +	if (argc !=3D 2) {=0A=
>  		ti->error =3D "Invalid argument count";=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> @@ -774,8 +776,16 @@ static int dmz_ctr(struct dm_target *ti, unsigned in=
t argc, char **argv)=0A=
>  	}=0A=
>  	ti->private =3D dmz;=0A=
>  =0A=
> +	/* Get the metadata block device */=0A=
> +	ret =3D dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),=0A=
> +			&dmz->metadata_dev);=0A=
> +	if (ret) {=0A=
> +		dmz->metadata_dev =3D NULL;=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
>  	/* Get the target zoned block device */=0A=
> -	ret =3D dmz_get_zoned_device(ti, argv[0]);=0A=
> +	ret =3D dmz_get_zoned_device(ti, argv[1]);=0A=
>  	if (ret) {=0A=
>  		dmz->ddev =3D NULL;=0A=
>  		goto err;=0A=
> @@ -856,6 +866,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int=
 argc, char **argv)=0A=
>  err_dev:=0A=
>  	dmz_put_zoned_device(ti);=0A=
>  err:=0A=
> +	dm_put_device(ti, dmz->metadata_dev);=0A=
>  	kfree(dmz);=0A=
>  =0A=
>  	return ret;=0A=
> diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h=0A=
> index 5b5e493..e789ff5 100644=0A=
> --- a/drivers/md/dm-zoned.h=0A=
> +++ b/drivers/md/dm-zoned.h=0A=
> @@ -50,6 +50,7 @@=0A=
>   */=0A=
>  struct dmz_dev {=0A=
>  	struct block_device	*bdev;=0A=
> +	struct block_device     *meta_bdev;=0A=
>  =0A=
>  	char			name[BDEVNAME_SIZE];=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
