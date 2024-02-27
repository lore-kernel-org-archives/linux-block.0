Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509414EFED
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067421; cv=none; b=naS2Qt1c8R8HZWIa06+rahcYnW9O74Kr6xJyKQ2elVWaFecO0TnWXf1fvu5VTOXTjA8uj8vb2urA2b+eV/AXWwjtHW4wmiRLh+em69A1hUbFNQjjOVhDGf8SugeN8fIYNzaDngQVGbbi9LOYEGFiKDhPhxbi6+dV9GM3UDAHZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067421; c=relaxed/simple;
	bh=ekZJVWf4kC4Gv5BzMtu8F81XEGZpkl69BhmxjY0U4p8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I8BmHarKWJZL7oiL5071yHCGYuQCChVRcwG9xR4TfZfMuhd3Gltk/Zc+PXLL6tIC1oxNySgSU3Un+o3YqsSitjD+roQPah4sr43YAubun4NhHYdNfwtX2e26QI3wHaMJLBjKdZRzdqOb682kJBBq9XeAts8dALgaa8Xpfovd6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F1EA8626FAEB;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RVSmNgG98wh8; Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7C546626FAEC;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 62E8tI1qTf8e; Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 62824626FAEB;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Date: Tue, 27 Feb 2024 21:56:56 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <111902167.106431.1709067416335.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-4-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-4-hch@lst.de>
Subject: Re: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move setting the nonrot flag to ubd_add
Thread-Index: x3CSSu93fOe0aYDkXECY8+iHhLZ0rw==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:13
> Betreff: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add

> No reason to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef05157acd6b02..9dcf41f7d49606 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> =09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST)=
;
> =09}
> -=09blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
> =09return 0;
>  error:
> =09os_close_file(ubd_dev->fd);
> @@ -894,6 +893,7 @@ static int ubd_add(int n, char **error_out)
> =09}
> =09ubd_dev->queue =3D disk->queue;
>=20
> +=09blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> =09blk_queue_write_cache(ubd_dev->queue, true, false);
> =09disk->major =3D UBD_MAJOR;
> =09disk->first_minor =3D n << UBD_SHIFT;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
