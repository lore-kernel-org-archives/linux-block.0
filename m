Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A013AA36
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067610; cv=none; b=P/+6dIHe2o31TMPkvA3N3fjVT+laXvh2vtSXMnWYzBDwmtyPuq4hK2+KMKvAOd3Ya1cP+fzDKrKVLBi0ZL7S4w3abVkzqeL9w2yVDAtoWbM9CUKKwEhdsI+XZUXOH8Go163oV4c8DjcM94pYuL7GBNMLRA2NdrYvtKig/rUG3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067610; c=relaxed/simple;
	bh=wMj73LSvJJMAZxL4shJObq4IZoFb494UHh4fQRIJeoA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=USWl53SzPgs8/8CVBHqnR2m+IhlI9cN+eRs87ynARk/A3Sde+clDdSOxp0isLgPR03ZOck045SkWjnRH+k3g+zV81wDhE6uJPuU+zul/izfmbCgDWIvs+kRMcfgT1eoY4IIZAX3TYHkFzwBzxOeZl2P/t8pf/dW7ZLNgZz2EFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 89A4A626FAEB;
	Tue, 27 Feb 2024 22:00:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0HrLx_8q8I2T; Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 869B7626FAEC;
	Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qHr-r-fSkg-s; Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 30846626FAEB;
	Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Date: Tue, 27 Feb 2024 22:00:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <254176725.106438.1709067603867.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-5-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-5-hch@lst.de>
Subject: Re: [PATCH 4/7] ubd: move setting the variable queue limits to
 ubd_add
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move setting the variable queue limits to ubd_add
Thread-Index: gszs01OAM/HMQeDXBm0jy7JIC/bqkA==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:14
> Betreff: [PATCH 4/7] ubd: move setting the variable queue limits to ubd_a=
dd

> No reason to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 9dcf41f7d49606..26bc8306356263 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -772,8 +772,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09ubd_dev->fd =3D fd;
>=20
> =09if(ubd_dev->cow.file !=3D NULL){
> -=09=09blk_queue_max_hw_sectors(ubd_dev->queue, 8 * sizeof(long));
> -
> =09=09err =3D -ENOMEM;
> =09=09ubd_dev->cow.bitmap =3D vmalloc(ubd_dev->cow.bitmap_len);
> =09=09if(ubd_dev->cow.bitmap =3D=3D NULL){
> @@ -795,10 +793,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09if(err < 0) goto error;
> =09=09ubd_dev->cow.fd =3D err;
> =09}
> -=09if (ubd_dev->no_trim =3D=3D 0) {
> -=09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> -=09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST=
);
> -=09}
> =09return 0;
>  error:
> =09os_close_file(ubd_dev->fd);
> @@ -867,6 +861,13 @@ static int ubd_add(int n, char **error_out)
> =09if(ubd_dev->file =3D=3D NULL)
> =09=09goto out;
>=20
> +=09if (ubd_dev->cow.file)
> +=09=09lim.max_hw_sectors =3D 8 * sizeof(long);
> +=09if (!ubd_dev->no_trim) {
> +=09=09lim.max_hw_discard_sectors =3D UBD_MAX_REQUEST;
> +=09=09lim.max_write_zeroes_sectors =3D UBD_MAX_REQUEST;
> +=09}
> +
> =09err =3D ubd_file_size(ubd_dev, &ubd_dev->size);
> =09if(err < 0){
> =09=09*error_out =3D "Couldn't determine size of device's file";
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
