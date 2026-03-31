Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE633ECBEE
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950445; cv=none; b=kIAeAnQj0lYlB23iyxjuFCReb0I/zKUSfDauRJzqVEl9WxZ8iOjgUBE35NXgAH3Cr+ECvhnHXJI3RvUXi7vp8C5EgTQEmItl3oeWHs36hT9qps9rIUG7SFrrDs0SrpOYzT9BvALE8OA20p+/MD4XOL2ChuGy1gPGzCFeZfdwnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950445; c=relaxed/simple;
	bh=G2l5P0tZ441POOrT5DRPb65c1bD6XRAN0e5q2mzGMus=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=slzsoNsB61o1rzNtEKBCjWgdTpzr2tRx+8piyQQvpGf32rcoj20Y8IJcwdAH10ca53wQjQeGJeGIpV6aULB21nlIotHNnsohOZ9bu3RuXoLkvX86Crj9u6eomNB7mTU1w3IzfHPccEscyRMrDq8WsxLOKDWSe1DONErkWhasjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6a329By; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6a329By"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774950441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RacpWi0XWOSLO0d2EwgRx7q56Bj9CU68uRFg2wpCoQI=;
	b=X6a329By1TMZpBTYSOdaPhUm1VtqvAny2deecQkCsa44sGWtZodrDMemPn7WDUg98eD6vv
	8uvi0PcH80arV4yV3P81xw/yh2B3FcE2uRhBa1GXd67tIKO6VEEwjq2OM1i7Th6m92Lg8f
	uj9pGJtn0kVqM8u8Vf3cQxubL3+/Ekk=
Date: Tue, 31 Mar 2026 09:47:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <db3b585abda63bd1a959c457aaf95572652ebeb5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] block: fix zones_cond memory leak in
 blk_revalidate_disk_zones()
To: "Damien Le Moal" <dlemoal@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
In-Reply-To: <2e91b857-4edd-4a8a-a75c-d1569fc6f1e3@kernel.org>
References: <20260331084731.45283-1-liu.yun@linux.dev>
 <2e91b857-4edd-4a8a-a75c-d1569fc6f1e3@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B43=E6=9C=8831=E6=97=A5 17:18, "Damien Le Moal" <dlemoal@kerne=
l.org mailto:dlemoal@kernel.org?to=3D%22Damien%20Le%20Moal%22%20%3Cdlemoa=
l%40kernel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 3/31/26 17:47, Jackie Liu wrote:
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
>=20>  Fix cases 1 and 2 by adding a free_zones_cond label at the end of
> >  blk_revalidate_disk_zones() to centralize the cleanup. Fix case 3 by
> >  moving disk_set_zones_cond_array() before the nr_conv_zones check in
> >  disk_update_zone_resources() so that ownership is transferred early =
and
> >  disk_free_zone_resources() at the unfreeze label properly frees it.
> >=20=20
>=20>  Fixes: 6e945ffb6555 ("block: use zone condition to determine conve=
ntional zones")
> >  Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >  ---
> >  block/blk-zoned.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> >  index 9d1dd6ccfad7..2ea790e4f320 100644
> >  --- a/block/blk-zoned.c
> >  +++ b/block/blk-zoned.c
> >  @@ -1956,6 +1956,8 @@ static int disk_update_zone_resources(struct g=
endisk *disk,
> >  memflags =3D blk_mq_freeze_queue(q);
> >=20=20
>=20>  disk->nr_zones =3D args->nr_zones;
> >  + disk_set_zones_cond_array(disk, args->zones_cond);
> >  +
> >  if (args->nr_conv_zones >=3D disk->nr_zones) {
> >  queue_limits_cancel_update(q);
> >  pr_warn("%s: Invalid number of conventional zones %u / %u\n",
> >  @@ -1966,7 +1968,6 @@ static int disk_update_zone_resources(struct g=
endisk *disk,
> >=20=20
>=20>  disk->zone_capacity =3D args->zone_capacity;
> >  disk->last_zone_capacity =3D args->last_zone_capacity;
> >  - disk_set_zones_cond_array(disk, args->zones_cond);
> >=20=20
>=20>  /*
> >  * Some devices can advertise zone resource limits that are larger th=
an
> >  @@ -2239,7 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *=
disk)
> >  ret =3D disk_revalidate_zone_resources(disk, &args);
> >  if (ret) {
> >  memalloc_noio_restore(noio_flag);
> >  - return ret;
> >  + goto free_zones_cond;
> >  }
> >=20=20
>=20>  ret =3D disk->fops->report_zones(disk, 0, UINT_MAX, &rep_args);
> >  @@ -2268,6 +2269,8 @@ int blk_revalidate_disk_zones(struct gendisk *=
disk)
> >  disk_free_zone_resources(disk);
> >  blk_mq_unfreeze_queue(q, memflags);
> >=20=20
>=20>  +free_zones_cond:
> >  + kfree(args.zones_cond);
> >=20
>=20This does not look correct: on success case, this will free the array=
 despite
> that array being set already. So rather than this, I think it is better=
 to
> change disk_revalidate_zone_resources() to free the array it allocated =
in the
> case of an error. That will be a lot cleaner than this.

Thanks for the review.

Actually, the free_zones_cond label is only reachable on error paths
(ret <=3D 0). On the success path (ret > 0), the function returns
directly via "return disk_update_zone_resources(disk, &args)" and never
reaches this label. So the logic should be correct.

That said, I agree that having disk_revalidate_zone_resources() free
the array itself on error is cleaner and easier to follow. I'll send
a v2 with that approach.

--=20
Jackie

>=20
> >=20
>=20> return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
> >=20
>=20--=20
>=20Damien Le Moal
> Western Digital Research
>
