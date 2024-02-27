Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A551C4C
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067942; cv=none; b=nUzkXm1NjHe8rCOYSEA6JyOCvGbenYDzUlmmrvG8P3M3Oj8uYpkiumyCltOW5YXsixfdVNPW1kxVLgd2btIN+ir/QA6UY6p2Bm9+puhHdNS8ttHvSeEnOZRJILqznYwEvYAAJSJDPg0/vlftvBsDjB0BaVMwxRF+tFokpU81is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067942; c=relaxed/simple;
	bh=S3a73C7AgPaFyjnrNANXnv3fmfknKRtSZ9K+Lr5Hjgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=B16psqE7Fx6pLwN/2tGAqsG483pMCgpmkB3n7L6su8t+VOnBGU1oJNCPYPPoRDs8h2Kse9kLIhjle2e+Vw4myskSxUoxE/Gj7eodIfOMH8QtITA6MUKUaMVktqo5pGNoW8zp72QTodV0U5058bTn01GedVqsJzEV9blHy9AC75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6E45A626FAF1;
	Tue, 27 Feb 2024 22:05:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5NYJLZ7MCa07; Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A65C7626FAED;
	Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U7r3dMuPsTXu; Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 75234626FAEB;
	Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Date: Tue, 27 Feb 2024 22:05:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1234843955.106458.1709067937370.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-8-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-8-hch@lst.de>
Subject: Re: [PATCH 7/7] ubd: open the backing files in ubd_add
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: open the backing files in ubd_add
Thread-Index: T7WeHNIdjCvMp/xgr2quB8Fgwlt/Ig==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:17
> Betreff: [PATCH 7/7] ubd: open the backing files in ubd_add

> Opening the backing device only when the block device is opened is
> a bit weird as no one configures block devices to not use them.

Agreed. I guess this is a strange optimization from the old days.

> Opend them at add time, close them at remove time and remove the
> now superflous opened counter as remove can simply check for
> disk_openers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 58 +++++++++++---------------------------
> 1 file changed, 16 insertions(+), 42 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 9bf1d6a88bae59..63fc062add708c 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -108,8 +108,6 @@ static inline void ubd_set_bit(__u64 bit, unsigned ch=
ar
> *data)
> static DEFINE_MUTEX(ubd_lock);
> static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
>=20
> -static int ubd_open(struct gendisk *disk, blk_mode_t mode);
> -static void ubd_release(struct gendisk *disk);
> static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
> =09=09     unsigned int cmd, unsigned long arg);
> static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)=
;
> @@ -118,8 +116,6 @@ static int ubd_getgeo(struct block_device *bdev, stru=
ct
> hd_geometry *geo);
>=20
> static const struct block_device_operations ubd_blops =3D {
>         .owner=09=09=3D THIS_MODULE,
> -        .open=09=09=3D ubd_open,
> -        .release=09=3D ubd_release,
>         .ioctl=09=09=3D ubd_ioctl,
>         .compat_ioctl=09=3D blkdev_compat_ptr_ioctl,
> =09.getgeo=09=09=3D ubd_getgeo,
> @@ -152,7 +148,6 @@ struct ubd {
> =09 * backing or the cow file. */
> =09char *file;
> =09char *serial;
> -=09int count;
> =09int fd;
> =09__u64 size;
> =09struct openflags boot_openflags;
> @@ -178,7 +173,6 @@ struct ubd {
> #define DEFAULT_UBD { \
> =09.file =3D =09=09NULL, \
> =09.serial =3D=09=09NULL, \
> -=09.count =3D=09=090, \
> =09.fd =3D=09=09=09-1, \
> =09.size =3D=09=09=09-1, \
> =09.boot_openflags =3D=09OPEN_FLAGS, \
> @@ -873,6 +867,13 @@ static int ubd_add(int n, char **error_out)
> =09=09goto out;
> =09}
>=20
> +=09err =3D ubd_open_dev(ubd_dev);
> +=09if (err) {
> +=09=09pr_err("ubd%c: Can't open \"%s\": errno =3D %d\n",
> +=09=09=09'a' + n, ubd_dev->file, -err);
> +=09=09goto out;
> +=09}
> +
> =09ubd_dev->size =3D ROUND_BLOCK(ubd_dev->size);
>=20
> =09ubd_dev->tag_set.ops =3D &ubd_mq_ops;
> @@ -884,7 +885,7 @@ static int ubd_add(int n, char **error_out)
>=20
> =09err =3D blk_mq_alloc_tag_set(&ubd_dev->tag_set);
> =09if (err)
> -=09=09goto out;
> +=09=09goto out_close;
>=20
> =09disk =3D blk_mq_alloc_disk(&ubd_dev->tag_set, &lim, ubd_dev);
> =09if (IS_ERR(disk)) {
> @@ -919,6 +920,8 @@ static int ubd_add(int n, char **error_out)
> =09put_disk(disk);
> out_cleanup_tags:
> =09blk_mq_free_tag_set(&ubd_dev->tag_set);
> +out_close:
> +=09ubd_close_dev(ubd_dev);
> out:
> =09return err;
> }
> @@ -1014,13 +1017,14 @@ static int ubd_remove(int n, char **error_out)
> =09if(ubd_dev->file =3D=3D NULL)
> =09=09goto out;
>=20
> -=09/* you cannot remove a open disk */
> -=09err =3D -EBUSY;
> -=09if(ubd_dev->count > 0)
> -=09=09goto out;
> -
> =09if (ubd_dev->disk) {
> +=09=09/* you cannot remove a open disk */
> +=09=09err =3D -EBUSY;
> +=09=09if (disk_openers(ubd_dev->disk))
> +=09=09=09goto out;
> +
> =09=09del_gendisk(ubd_dev->disk);
> +=09=09ubd_close_dev(ubd_dev);
> =09=09put_disk(ubd_dev->disk);
> =09}
>=20
> @@ -1143,36 +1147,6 @@ static int __init ubd_driver_init(void){
>=20
> device_initcall(ubd_driver_init);
>=20
> -static int ubd_open(struct gendisk *disk, blk_mode_t mode)
> -{
> -=09struct ubd *ubd_dev =3D disk->private_data;
> -=09int err =3D 0;
> -
> -=09mutex_lock(&ubd_mutex);
> -=09if(ubd_dev->count =3D=3D 0){
> -=09=09err =3D ubd_open_dev(ubd_dev);
> -=09=09if(err){
> -=09=09=09printk(KERN_ERR "%s: Can't open \"%s\": errno =3D %d\n",
> -=09=09=09       disk->disk_name, ubd_dev->file, -err);
> -=09=09=09goto out;
> -=09=09}
> -=09}
> -=09ubd_dev->count++;
> -out:
> -=09mutex_unlock(&ubd_mutex);
> -=09return err;
> -}
> -
> -static void ubd_release(struct gendisk *disk)
> -{
> -=09struct ubd *ubd_dev =3D disk->private_data;
> -
> -=09mutex_lock(&ubd_mutex);
> -=09if(--ubd_dev->count =3D=3D 0)
> -=09=09ubd_close_dev(ubd_dev);
> -=09mutex_unlock(&ubd_mutex);
> -}
> -
> static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow=
_mask,
> =09=09=09  __u64 *cow_offset, unsigned long *bitmap,
> =09=09=09  __u64 bitmap_offset, unsigned long *bitmap_words,
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
