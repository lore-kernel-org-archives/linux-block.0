Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796B1D6A8
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067392; cv=none; b=inI6xNITZUhuwRiphvGHiXK2pyR3br6x5teISNwqAjeOHTCXqSRkevyFot0OXBq5YSClgGrSl60VJ00CUWj8YnzAGEw+nrXU1XD1hzIfcR30f77owqbDpZN/IZoGbKQ1Hl6LUyLtVK4BgMnVL4oGZdmWbtrt3bi8q8v0ciFu9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067392; c=relaxed/simple;
	bh=9zKhqZASpvlCIJUT0ouLR8ko8uA95/By2rS5hCNz/i0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=s2g/Oq1YctOIW7703hMoarCTbBEkzyT77rFImCukuwx/WtlDpUTUGorn6v8Kzjs9qsxuxelL7/DBITab76Y8FgawjSTEm+T9cfaDQ0nXnecgmfyBYoixKIMhZvHqcirc1s2AiBbhLZY+hgcM3QIf+OxXRUcqNUxAUPvpy3fKKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6A8CF626FAEC;
	Tue, 27 Feb 2024 21:56:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dtcQozzQnhL2; Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9C9D0626FAED;
	Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SqyNk_nJrkyY; Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 77208626FAEB;
	Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Date: Tue, 27 Feb 2024 21:56:26 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <306297747.106429.1709067386425.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-3-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-3-hch@lst.de>
Subject: Re: [PATCH 2/7] ubd: remove ubd_disk_register
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove ubd_disk_register
Thread-Index: rutuY9luSWaac74DXZFMS4wfUpai5g==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:12
> Betreff: [PATCH 2/7] ubd: remove ubd_disk_register

> Fold it into the only caller to remove lots of references to the
> global ubd_devs array.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 37 +++++++++++++++----------------------
> 1 file changed, 15 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index b203ebb1785125..ef05157acd6b02 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -849,27 +849,6 @@ static const struct attribute_group *ubd_attr_groups=
[] =3D {
> =09NULL,
> };
>=20
> -static int ubd_disk_register(int major, u64 size, int unit,
> -=09=09=09     struct gendisk *disk)
> -{
> -=09disk->major =3D major;
> -=09disk->first_minor =3D unit << UBD_SHIFT;
> -=09disk->minors =3D 1 << UBD_SHIFT;
> -=09disk->fops =3D &ubd_blops;
> -=09set_capacity(disk, size / 512);
> -=09sprintf(disk->disk_name, "ubd%c", 'a' + unit);
> -
> -=09ubd_devs[unit].pdev.id   =3D unit;
> -=09ubd_devs[unit].pdev.name =3D DRIVER_NAME;
> -=09ubd_devs[unit].pdev.dev.release =3D ubd_device_release;
> -=09dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
> -=09platform_device_register(&ubd_devs[unit].pdev);
> -
> -=09disk->private_data =3D &ubd_devs[unit];
> -=09disk->queue =3D ubd_devs[unit].queue;
> -=09return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_group=
s);
> -}
> -
> #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
>=20
> static const struct blk_mq_ops ubd_mq_ops =3D {
> @@ -916,7 +895,21 @@ static int ubd_add(int n, char **error_out)
> =09ubd_dev->queue =3D disk->queue;
>=20
> =09blk_queue_write_cache(ubd_dev->queue, true, false);
> -=09err =3D ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
> +=09disk->major =3D UBD_MAJOR;
> +=09disk->first_minor =3D n << UBD_SHIFT;
> +=09disk->minors =3D 1 << UBD_SHIFT;
> +=09disk->fops =3D &ubd_blops;
> +=09set_capacity(disk, ubd_dev->size / 512);
> +=09sprintf(disk->disk_name, "ubd%c", 'a' + n);
> +=09disk->private_data =3D ubd_dev;
> +
> +=09ubd_dev->pdev.id =3D n;
> +=09ubd_dev->pdev.name =3D DRIVER_NAME;
> +=09ubd_dev->pdev.dev.release =3D ubd_device_release;
> +=09dev_set_drvdata(&ubd_dev->pdev.dev, ubd_dev);
> +=09platform_device_register(&ubd_dev->pdev);
> +
> +=09err =3D device_add_disk(&ubd_dev->pdev.dev, disk, ubd_attr_groups);
> =09if (err)
> =09=09goto out_cleanup_disk;
>=20
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
