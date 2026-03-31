Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5563B2FD5
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955064; cv=none; b=IPkFSgpqpGRthEqRq9CGFBt0/OnWjaeJoGxuBmaSHYmDpsDkj+9iap++gb8jCM2uP64rURCNM9OgyggwANYmmJ0Tqf8ARXBrVM2YivHUmI1NhAn2Nu+7IkVctHGWA161Ytc0hgpB7I9h85/0OP+IIuwiMaSa34hr2w2TTGavCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955064; c=relaxed/simple;
	bh=qAynuL3yqPOX8Gj1elqIBA59+aB4/yN6HS6E5B0QPQM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OzBfW8nmtxNxSVJlsVtyAGzBcuXBgQN1YGio2NY3oEi1XUQnW4GBNbj+YWRhvg1jniTA07cFxi4Rk9hL7p+DaKYQ0f2WUme72/91bEi2og5OGRkFq2bHxMNjZcqf0jX4jUe26XBBA8V9tZVULwSvIWsbG0q2BL1gY590pXU3T/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLGGD5Cz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLGGD5Cz"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774955058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGzt74Zib4h/L6AnyCW2kFnDU2MJKavjABiMYLpiVzU=;
	b=wLGGD5CzijW5XX+nbaqIlKzbeQJpKPGKtzUN4qmamBIZ86SRZhwovr5tAF0Rla59mQ9S8A
	ox8Ul7wY/9w1ROxqqCXs+bP+5UDkzTWvyy8ZnHQgPoTEpx+bugmqN6GVJBNpnKQa0x9ykj
	ZVPN1dk8ja6xA/hyJ/XmrMh5ap5MiPk=
Date: Tue, 31 Mar 2026 11:04:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <e85e917e0b4cd90bd82d8fd0054d623eeeab0c26@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] block: fix zones_cond memory leak in
 blk_revalidate_disk_zones()
To: "Damien Le Moal" <dlemoal@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
In-Reply-To: <786d65d1-acc9-4843-995d-07f0a33c937a@kernel.org>
References: <20260331100103.82085-1-liu.yun@linux.dev>
 <786d65d1-acc9-4843-995d-07f0a33c937a@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B43=E6=9C=8831=E6=97=A5 18:56, "Damien Le Moal" <dlemoal@kerne=
l.org mailto:dlemoal@kernel.org?to=3D%22Damien%20Le%20Moal%22%20%3Cdlemoa=
l%40kernel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 3/31/26 19:01, Jackie Liu wrote:
>=20
>=20>=20
>=20> From: Jackie Liu <liuyun01@kylinos.cn>
> >=20=20
>=20>  Fix memory leaks of args.zones_cond allocated in
> >  disk_revalidate_zone_resources() on multiple error paths:
> >=20=20
>=20>  1) When disk_revalidate_zone_resources() itself fails (e.g.
> >  disk_alloc_zone_resources() returns an error), blk_revalidate_disk_z=
ones()
> >  returns directly without freeing args.zones_cond.
> >=20=20
>=20>  2) When report_zones() fails or the capacity check fails,
> >  disk_free_zone_resources() only frees the old disk->zones_cond, not
> >  the newly allocated args.zones_cond.
> >=20=20
>=20>  3) When the nr_conv_zones validation fails in disk_update_zone_res=
ources(),
> >  the code jumps to unfreeze before disk_set_zones_cond_array() transf=
ers
> >  ownership of args->zones_cond to disk->zones_cond.
> >=20=20
>=20>  Fix this by freeing args->zones_cond at each error site: in
> >  blk_revalidate_disk_zones() when disk_revalidate_zone_resources() or=
 zone
> >  reporting fails, and in disk_update_zone_resources() before jumping =
to
> >  the unfreeze label.
> >=20=20
>=20>  Fixes: 6e945ffb6555 ("block: use zone condition to determine conve=
ntional zones")
> >  Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >  ---
> >  block/blk-zoned.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20=20
>=20>  diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> >  index 9d1dd6ccfad7..be99ab785dcd 100644
> >  --- a/block/blk-zoned.c
> >  +++ b/block/blk-zoned.c
> >  @@ -1960,6 +1960,7 @@ static int disk_update_zone_resources(struct g=
endisk *disk,
> >  queue_limits_cancel_update(q);
> >  pr_warn("%s: Invalid number of conventional zones %u / %u\n",
> >  disk->disk_name, args->nr_conv_zones, disk->nr_zones);
> >  + kfree(args->zones_cond);
> >=20
>=20Let's keep the cleanups together. So move this before pr_warn().
> Also, the call to queue_limits_commit_update() may fail, so you need a =
free
> after the unfreeze label in that function too.
>=20
>=20>=20
>=20> ret =3D -ENODEV;
> >  goto unfreeze;
> >  }
> >  @@ -2239,6 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *=
disk)
> >  ret =3D disk_revalidate_zone_resources(disk, &args);
> >  if (ret) {
> >  memalloc_noio_restore(noio_flag);
> >  + kfree(args.zones_cond);
> >=20
>=20This should be in disk_revalidate_zone_resources().
>=20
>=20>=20
>=20> return ret;
> >  }
> >=20=20
>=20>  @@ -2264,6 +2266,7 @@ int blk_revalidate_disk_zones(struct gendisk=
 *disk)
> >=20=20
>=20>  pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
> >=20=20
>=20>  + kfree(args.zones_cond);
> >  memflags =3D blk_mq_freeze_queue(q);
> >  disk_free_zone_resources(disk);
> >  blk_mq_unfreeze_queue(q, memflags);
> >=20
>=20I thinks something like this may be cleaner as it avoids having that =
kfree() all
> over the place:
>=20
>=20diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 10655213e8e1..18cd9a1c6c53 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -2028,6 +2028,7 @@ static int disk_revalidate_zone_resources(struct =
gendisk
> *disk,
>  {
>  struct queue_limits *lim =3D &disk->queue->limits;
>  unsigned int pool_size;
> + int ret =3D 0;
>=20
>=20 args->disk =3D disk;
>  args->nr_zones =3D
> @@ -2050,10 +2051,13 @@ static int disk_revalidate_zone_resources(struc=
t gendisk
> *disk,
>  pool_size =3D
>  min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);
>=20
>=20- if (!disk->zone_wplugs_hash)
> - return disk_alloc_zone_resources(disk, pool_size);
> + if (!disk->zone_wplugs_hash) {
> + ret =3D disk_alloc_zone_resources(disk, pool_size);
> + if (ret)
> + kfree(args->zones_cond);
> + }
>=20
>=20- return 0;
> + return ret;
>  }
>=20
>=20 /*
> @@ -2085,6 +2089,7 @@ static int disk_update_zone_resources(struct gend=
isk *disk,
>  disk->zone_capacity =3D args->zone_capacity;
>  disk->last_zone_capacity =3D args->last_zone_capacity;
>  disk_set_zones_cond_array(disk, args->zones_cond);
> + args->zones_cond =3D NULL;
>=20
>=20 /*
>  * Some devices can advertise zone resource limits that are larger than
> @@ -2365,21 +2370,30 @@ int blk_revalidate_disk_zones(struct gendisk *d=
isk)
>  }
>  memalloc_noio_restore(noio_flag);
>=20
>=20+ if (ret <=3D 0)
> + goto free_resources;
> +
>  /*
>  * If zones where reported, make sure that the entire disk capacity
>  * has been checked.
>  */
> - if (ret > 0 && args.sector !=3D capacity) {
> + if (args.sector !=3D capacity) {
>  pr_warn("%s: Missing zones from sector %llu\n",
>  disk->disk_name, args.sector);
>  ret =3D -ENODEV;
> + goto free_resources;
>  }
>=20
>=20- if (ret > 0)
> - return disk_update_zone_resources(disk, &args);
> + ret =3D disk_update_zone_resources(disk, &args);
> + if (ret)
> + goto free_resources;
> +
> + return 0;
>=20
>=20+free_resources:
>  pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>=20
>=20+ kfree(args.zones_cond);
>  memflags =3D blk_mq_freeze_queue(q);
>  disk_free_zone_resources(disk);
>  blk_mq_unfreeze_queue(q, memflags);
>=20

Haha,=20the patch I wrote at the beginning had similar advantages to your=
s.=20
I=20also wanted to refactor it so that the correct path wouldn't be hidde=
n,=20
but=20that would involve more code than it does now, so I didn't do it. S=
ince
you mentioned it, I'll use your method, which is actually quite good.

Thanks.

--=20
Jackie=20Liu

> --=20
>=20Damien Le Moal
> Western Digital Research
>
