Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96D14E2CD
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067634; cv=none; b=StaaYb3UojfKS66/Dl9L7NBKI64BGppBR5GYG26mCtwZrTBR03JPjRaNBfd2buA1ZtZKyPyu3RfPC0Tr7UJXUzXihVqL0eZeHA7424QTLj+CV4uJREPdrmxDtsUxYdmNXY0jVIuPF8f6X2ZezD7b37xTPvwO0EzUXxEz7sgS04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067634; c=relaxed/simple;
	bh=HQ+mHhaLMsv/MEQAB1IEDqgz7dJ8ERVc3qKvdFAqAgQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gcA9/MuUmz68zTBJ+BOlN9DsZYWLN3LvRL0XHbkrAre3+dlj9DjdkQA8YZEea48nRGpvIIf8jeOhw+cUEeGRZtT/KeIGzTOa/8dzLv+2WwSqJuxi9vvT7LUTVB+GTs2Zhk90JMEWazUIjezTz9MDuqK8K45N4slwELIXREsGbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9596E626FAEB;
	Tue, 27 Feb 2024 22:00:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A0PH3mjREBeo; Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7F520626FAF1;
	Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J_Ima3NF1Lb4; Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5412D626FAEC;
	Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Date: Tue, 27 Feb 2024 22:00:29 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1952234687.106440.1709067629021.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-6-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-6-hch@lst.de>
Subject: Re: [PATCH 5/7] ubd: move set_disk_ro to ubd_add
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move set_disk_ro to ubd_add
Thread-Index: FrXUZ/VQAI2jGYuAi8vt9J/4AtPUXw==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:15
> Betreff: [PATCH 5/7] ubd: move set_disk_ro to ubd_add

> No need to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 26bc8306356263..c5d32e75426366 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -903,6 +903,7 @@ static int ubd_add(int n, char **error_out)
> =09set_capacity(disk, ubd_dev->size / 512);
> =09sprintf(disk->disk_name, "ubd%c", 'a' + n);
> =09disk->private_data =3D ubd_dev;
> +=09set_disk_ro(disk, !ubd_dev->openflags.w);
>=20
> =09ubd_dev->pdev.id =3D n;
> =09ubd_dev->pdev.name =3D DRIVER_NAME;
> @@ -1159,7 +1160,6 @@ static int ubd_open(struct gendisk *disk, blk_mode_=
t mode)
> =09=09}
> =09}
> =09ubd_dev->count++;
> -=09set_disk_ro(disk, !ubd_dev->openflags.w);
> out:
> =09mutex_unlock(&ubd_mutex);
> =09return err;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
