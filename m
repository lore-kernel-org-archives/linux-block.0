Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F414E2C2
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067169; cv=none; b=HQ/+NuoLZsEk3oL2FMRSQTTFXFzxhAoTklbwpn8Wd5X2USKKGe2SBOsWpUL+4BByfq4n/PW5R7UJ583+FPRpR5ZMhSHH1UBEXM0aF1PJ24r+2Mr5RMqi7GDrp7xJcoGk5wmufBI68P0ThjeQGVw5AzKq4/VRtLEAp4fmJRRCT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067169; c=relaxed/simple;
	bh=aUquLlW0AITQ80jfbVkD6Bw5E1g69IurU+CVZBc41Ew=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iej3a/Ewe9EKHSPzQadlORC4VfSsbfLRapBZQV9HgBe3UGJ8UFzni9u6sdqVVI8DZELYs9yczunKkuUpyhGaTm/+WojjCAoVHHqU00fs8vnUknuozxSlgc7fSbIxnxxueFrgc6fGKdq8KdxDDY3mdco9tHjr2b4atJjSh1ejVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 19047626FAEB;
	Tue, 27 Feb 2024 21:52:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xm0VuJW7DFlB; Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6036C626FAEC;
	Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ggZPpoQ8IXPq; Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 31C89626FAEB;
	Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Date: Tue, 27 Feb 2024 21:52:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1749218520.106417.1709067157062.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-2-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-2-hch@lst.de>
Subject: Re: [PATCH 1/7] ubd: remove the ubd_gendisk array
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove the ubd_gendisk array
Thread-Index: cQzJaZjzWfjjT+4tdF6umrFdswpj1g==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:11
> Betreff: [PATCH 1/7] ubd: remove the ubd_gendisk array

> And add a disk pointer to the ubd structure instead to keep all
> the per-device information together.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 48e11f073551b4..b203ebb1785125 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -125,9 +125,6 @@ static const struct block_device_operations ubd_blops=
 =3D {
> =09.getgeo=09=09=3D ubd_getgeo,
> };
>=20
> -/* Protected by ubd_lock */
> -static struct gendisk *ubd_gendisk[MAX_DEV];
> -
> #ifdef CONFIG_BLK_DEV_UBD_SYNC
> #define OPEN_FLAGS ((struct openflags) { .r =3D 1, .w =3D 1, .s =3D 1, .c=
 =3D 0, \
> =09=09=09=09=09 .cl =3D 1 })
> @@ -165,6 +162,7 @@ struct ubd {
> =09unsigned no_trim:1;
> =09struct cow cow;
> =09struct platform_device pdev;
> +=09struct gendisk *disk;
> =09struct request_queue *queue;
> =09struct blk_mq_tag_set tag_set;
> =09spinlock_t lock;
> @@ -922,7 +920,6 @@ static int ubd_add(int n, char **error_out)
> =09if (err)
> =09=09goto out_cleanup_disk;
>=20
> -=09ubd_gendisk[n] =3D disk;
> =09return 0;
>=20
> out_cleanup_disk:
> @@ -1014,7 +1011,6 @@ static int ubd_id(char **str, int *start_out, int
> *end_out)
>=20
> static int ubd_remove(int n, char **error_out)
> {
> -=09struct gendisk *disk =3D ubd_gendisk[n];
> =09struct ubd *ubd_dev;
> =09int err =3D -ENODEV;
>=20
> @@ -1030,10 +1026,9 @@ static int ubd_remove(int n, char **error_out)
> =09if(ubd_dev->count > 0)
> =09=09goto out;
>=20
> -=09ubd_gendisk[n] =3D NULL;
> -=09if(disk !=3D NULL){
> -=09=09del_gendisk(disk);
> -=09=09put_disk(disk);
> +=09if (ubd_dev->disk) {
> +=09=09del_gendisk(ubd_dev->disk);
> +=09=09put_disk(ubd_dev->disk);
> =09}

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
