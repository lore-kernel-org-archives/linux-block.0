Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641614EFDD
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067665; cv=none; b=cya9Uayo0JLM406hKmO5D6pnEh/Rcxi/EcwyJfKhS13/3jCra+/D1V007ro90ATvd+Bhh82Uo5McvBuOs7dpEAeblGGcM0LrQBlCXbD4Yq9SuT9IWdMYl0JsWe+dubEjVGnxJgs49B1qvu+8GR2fIXUkDZ50hct+HvkPj6e3VII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067665; c=relaxed/simple;
	bh=eNHvNTPjAf2BcKVNlj1XiUAeeg+PuV9WuAs0hX5itZU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OQR652z3nbi4C+iHY1XAydoXsFcV0B7rErPR7q1RJUqcBXa/G2K2kjTUXQLD4VjbbhtRNdfnJLIIFTLjUQJYjvbCUJ8JE+v9LNLRuV8ifRq+BkhQBYdQArVbdm+HeMfLvciK4WDq2CgaSA2ajR9vBZx7NpePSHQ7a9ouAHv8Smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 49F98626FAED;
	Tue, 27 Feb 2024 22:01:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id haZ2ZmOR4y2P; Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D30E2626FAEC;
	Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wFPCRLT6xrlv; Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B700A626FAEB;
	Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Date: Tue, 27 Feb 2024 22:01:01 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1568393451.106442.1709067661698.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-7-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-7-hch@lst.de>
Subject: Re: [PATCH 6/7] ubd: remove the queue pointer in struct ubd
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove the queue pointer in struct ubd
Thread-Index: PfkHaHr5LY6oKbXnCFFct3EjiOb5Ew==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:16
> Betreff: [PATCH 6/7] ubd: remove the queue pointer in struct ubd

> No need for it now, everything goes through the gendisk.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index c5d32e75426366..9bf1d6a88bae59 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -163,7 +163,6 @@ struct ubd {
> =09struct cow cow;
> =09struct platform_device pdev;
> =09struct gendisk *disk;
> -=09struct request_queue *queue;
> =09struct blk_mq_tag_set tag_set;
> =09spinlock_t lock;
> };
> @@ -892,10 +891,9 @@ static int ubd_add(int n, char **error_out)
> =09=09err =3D PTR_ERR(disk);
> =09=09goto out_cleanup_tags;
> =09}
> -=09ubd_dev->queue =3D disk->queue;
>=20
> =09blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> -=09blk_queue_write_cache(ubd_dev->queue, true, false);
> +=09blk_queue_write_cache(disk->queue, true, false);
> =09disk->major =3D UBD_MAJOR;
> =09disk->first_minor =3D n << UBD_SHIFT;
> =09disk->minors =3D 1 << UBD_SHIFT;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
