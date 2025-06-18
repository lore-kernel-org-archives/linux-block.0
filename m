Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143F27A455
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285687; cv=none; b=Fqgez32cuOVQrmD9EruFxTDJeHDhqsrXVpx2L6t0wZVECDO79az43ZTbqQbYpSHrkeoWAN+URXke/KUSofPtzm4W6+/mLm6JwZTVC2TyvN5PFdWytwTjPTCcIanRwbZFlMGjVmirkhlpGLQDI9hdvMUhWFiM2+MdS7yR+TyFZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285687; c=relaxed/simple;
	bh=wKXd7EZAfe5P6gQoHJLuRcy/mVpACrN0xAT9af5q8vs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xy7z2syRVJaEUOOiS0b/EPq8x8jnDcxGzBmEMHRpFu07rpQkNpZPColkTu8LIIn75NPyxXDMEKveW2QanbFvcit1zA0M9ycr2yGHd9dHno2GgWJSEW+6lhjEaD2K0SrYYMaAxdzQsDLtyvMEWlq0pAvH4EnHvS1r4pgMBdr09cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i7fkUJyI; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i7fkUJyI"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bMyzy0hnkzm0pL3;
	Wed, 18 Jun 2025 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750285675; x=1752877676; bh=atcaHiiQwjYchwelGlpUA9+j
	/Ye9PghvHv0Zo1o6VWk=; b=i7fkUJyI0WZDY+ned59uW8lXe92EiCAuDlJIB2Oc
	TVuoKxKffkl5tBXr+WQHGLecl+zN8s5j16XhoHCIF3bw259JTw4H/xnKYaFmXypE
	B094+nP6kaz1pNovdp/LcQU1321e5FFRV/vidTKnkGCfaiN5PgrZgrCHz1jx5YNg
	wPhFmI1jG34y+gzZw6hNUpLP6f1Fipoft52KrzxCciKVbxz2j6PoIpRXzj96PjXO
	4KyBSkooXkQRhn+65kmuIfA5MFJg37ccb0pRVNE6B3HkH8WmWCMdhtENX6nBwAUW
	QCdSet4880JWKk7xGHMsnDgD3D3w6g35AlGUppqtsfw6MQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4L4E4wvAsw84; Wed, 18 Jun 2025 22:27:55 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bMyzn42jczm0yQS;
	Wed, 18 Jun 2025 22:27:48 +0000 (UTC)
Message-ID: <559021b9-b1c2-48a4-8b13-fbd94098f775@acm.org>
Date: Wed, 18 Jun 2025 15:27:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
From: Bart Van Assche <bvanassche@acm.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <20250611034031.GA2704@lst.de> <20250611042148.GC1484147@sol>
 <1853d37f-b7b1-4266-b47f-8c2063f36b7d@acm.org> <20250611181551.GB1254@sol>
 <42af0af1-8e9d-4da7-b3da-b48152c6604f@acm.org>
Content-Language: en-US
In-Reply-To: <42af0af1-8e9d-4da7-b3da-b48152c6604f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/11/25 12:43 PM, Bart Van Assche wrote:
> On 6/11/25 11:15 AM, Eric Biggers wrote:
>> Well, again it needs to work on any block device.=C2=A0 If the encrypt=
ion=20
>> might just
>> not be done and plaintext ends up on-disk, then blk-crypto-fallback=20
>> would be
>> unsafe to use.
>>
>> It would be preferable to have blk-crypto-fallback continue to be=20
>> handled in the
>> block layer so that drivers don't need to worry about it.
>=20
> This concern could be addressed by introducing a new flag in struct
> block_device_operations or struct queue_limits - a flag that indicates
> that bio_split_to_limits() will be called by the block driver. If that
> flag is set, blk_crypto_bio_prep() can be called from
> bio_submit_split(). If that flag is not set, blk_crypto_bio_prep()
> should be called from __submit_bio(). The latter behavior is is the
> current behavior for the upstream kernel.

(replying to my own email)

The patch below seems to work but needs further review and testing:


block: Rework splitting of encrypted bios

     Modify splitting of encrypted bios as follows:
     - Introduce a new block device flag BD_SPLITS_BIO_TO_LIMITS that=20
allows bio-
       based drivers to report that they call bio_split_to_limits() for=20
every bio.
     - For request-based block drivers and for bio-based block drivers=20
that call
       bio_split_to_limits(), call blk_crypto_bio_prep() after bio splitt=
ing
       happened instead of before bio splitting happened.
     - For bio-based block drivers of which it is not known whether they=20
call
       bio_split_to_limits(), call blk_crypto_bio_prep() before=20
.submit_bio() is
       called.
     - In blk_crypto_fallback_encrypt_bio(), prevent infinite recursion=20
by only
       trying to split a bio if this function is not called from inside
       bio_split_to_limits().
     - Since blk_crypto_fallback_encrypt_bio() may clear *bio_ptr, in=20
its caller
       (__blk_crypto_bio_prep()), check whether or not this pointer is NU=
LL.
     - In bio_split_rw(), restrict the bio size to the smaller size of=20
what is
       supported to the block driver and the crypto fallback code.

     The advantages of these changes are as follows:
     - This patch fixes write errors on zoned storage caused by out-of-or=
der
       submission of bios. This out-of-order submission happens if both t=
he
       crypto fallback code and bio_split_to_limits() split a bio.
     - Less code duplication. The crypto fallback code now calls
       bio_split_to_limits() instead of open-coding it.

diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..d597cef6d228 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1682,6 +1682,11 @@ struct bio *bio_split(struct bio *bio, int sectors=
,
  	if (!split)
  		return ERR_PTR(-ENOMEM);

+	/*
+	 * Tell blk_crypto_fallback_encrypt_bio() not to split this bio further=
.
+	 */
+	bio_set_flag(split, BIO_BEING_SPLIT);
+
  	split->bi_iter.bi_size =3D sectors << 9;

  	if (bio_integrity(split))
diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..78b555ceea77 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,16 +626,22 @@ static void __submit_bio(struct bio *bio)
  	/* If plug is not used, add new plug here to cache nsecs time. */
  	struct blk_plug plug;

-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
  	blk_start_plug(&plug);

  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
  		blk_mq_submit_bio(bio);
  	} else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
  		struct gendisk *disk =3D bio->bi_bdev->bd_disk;
-=09
+
+		/*
+		 * Only call blk_crypto_bio_prep() before .submit_bio() if
+		 * the block driver won't call bio_split_to_limits().
+		 */
+		if (unlikely(!bdev_test_flag(bio->bi_bdev,
+					     BD_SPLITS_BIO_TO_LIMITS) &&
+			     !blk_crypto_bio_prep(&bio)))
+			goto exit_queue;
+
  		if ((bio->bi_opf & REQ_POLLED) &&
  		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
  			bio->bi_status =3D BLK_STS_NOTSUPP;
@@ -643,6 +649,8 @@ static void __submit_bio(struct bio *bio)
  		} else {
  			disk->fops->submit_bio(bio);
  		}
+
+exit_queue:
  		blk_queue_exit(disk->queue);
  	}

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..f2012368ac9e 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,9 +209,12 @@ blk_crypto_fallback_alloc_cipher_req(struct=20
blk_crypto_keyslot *slot,
  	return true;
  }

-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
+/*
+ * The encryption fallback code allocates bounce pages individually.=20
Hence this
+ * function that calculates an upper limit for the bio size.
+ */
+unsigned int blk_crypto_max_io_size(struct bio *bio)
  {
-	struct bio *bio =3D *bio_ptr;
  	unsigned int i =3D 0;
  	unsigned int num_sectors =3D 0;
  	struct bio_vec bv;
@@ -222,21 +225,8 @@ static bool=20
blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
  		if (++i =3D=3D BIO_MAX_VECS)
  			break;
  	}
-	if (num_sectors < bio_sectors(bio)) {
-		struct bio *split_bio;
-
-		split_bio =3D bio_split(bio, num_sectors, GFP_NOIO,
-				      &crypto_bio_split);
-		if (IS_ERR(split_bio)) {
-			bio->bi_status =3D BLK_STS_RESOURCE;
-			return false;
-		}
-		bio_chain(split_bio, bio);
-		submit_bio_noacct(bio);
-		*bio_ptr =3D split_bio;
-	}

-	return true;
+	return num_sectors;
  }

  union blk_crypto_iv {
@@ -257,8 +247,10 @@ static void blk_crypto_dun_to_iv(const u64=20
dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
   * The crypto API fallback's encryption routine.
   * Allocate a bounce bio for encryption, encrypt the input bio using=20
crypto API,
   * and replace *bio_ptr with the bounce bio. May split input bio if=20
it's too
- * large. Returns true on success. Returns false and sets bio->bi_status=
 on
- * error.
+ * large. Returns %true on success. On error, %false is returned and one=
 of
+ * these two actions is taken:
+ * - Either @bio_ptr->bi_status is set and *@bio_ptr is not modified.
+ * - Or bio_endio() is called and *@bio_ptr is changed into %NULL.
   */
  static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
  {
@@ -275,11 +267,17 @@ static bool blk_crypto_fallback_encrypt_bio(struct=20
bio **bio_ptr)
  	bool ret =3D false;
  	blk_status_t blk_st;

-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
-		return false;
+	if (!bio_flagged(*bio_ptr, BIO_BEING_SPLIT)) {
+		/* Split the bio if it's too big for single page bvec */
+		src_bio =3D bio_split_to_limits(*bio_ptr);
+		if (!src_bio) {
+			*bio_ptr =3D NULL;
+			return false;
+		}
+	} else {
+		src_bio =3D *bio_ptr;
+	}

-	src_bio =3D *bio_ptr;
  	bc =3D src_bio->bi_crypt_context;
  	data_unit_size =3D bc->bc_key->crypto_cfg.data_unit_size;

@@ -475,9 +473,8 @@ static void blk_crypto_fallback_decrypt_endio(struct=20
bio *bio)
   * @bio_ptr: pointer to the bio to prepare
   *
   * If bio is doing a WRITE operation, this splits the bio into two=20
parts if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then=20
allocates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to=20
point to
- * the bounce bio.
+ * too big. It then allocates a bounce bio for the first part, encrypts=20
it, and
+ * updates bio_ptr to point to the bounce bio.
   *
   * For a READ operation, we mark the bio for decryption by using=20
bi_private and
   * bi_end_io.
@@ -495,6 +492,12 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_p=
tr)
  	struct bio_crypt_ctx *bc =3D bio->bi_crypt_context;
  	struct bio_fallback_crypt_ctx *f_ctx;

+	/*
+	 * Check whether blk_crypto_fallback_bio_prep() has already been called=
.
+	 */
+	if (bio->bi_end_io =3D=3D blk_crypto_fallback_encrypt_endio)
+		return true;
+
  	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
  		/* User didn't call blk_crypto_start_using_key() first */
  		bio->bi_status =3D BLK_STS_IOERR;
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..443ba1fd82e6 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -223,6 +223,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_pt=
r);

  int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);

+unsigned int blk_crypto_max_io_size(struct bio *bio);
+
  #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */

  static inline int
@@ -245,6 +247,11 @@ blk_crypto_fallback_evict_key(const struct=20
blk_crypto_key *key)
  	return 0;
  }

+static inline unsigned int blk_crypto_max_io_size(struct bio *bio)
+{
+	return UINT_MAX;
+}
+
  #endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */

  #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..76278e23193d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -306,7 +306,8 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
  	if (blk_crypto_fallback_bio_prep(bio_ptr))
  		return true;
  fail:
-	bio_endio(*bio_ptr);
+	if (*bio_ptr)
+		bio_endio(*bio_ptr);
  	return false;
  }

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e55a8ec219c9..df65231be543 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
  #include <linux/blk-integrity.h>
  #include <linux/part_stat.h>
  #include <linux/blk-cgroup.h>
+#include <linux/blk-crypto.h>

  #include <trace/events/block.h>

@@ -125,9 +126,14 @@ static struct bio *bio_submit_split(struct bio=20
*bio, int split_sectors)
  				  bio->bi_iter.bi_sector);
  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
  		submit_bio_noacct(bio);
-		return split;
+
+		bio =3D split;
  	}

+	WARN_ON_ONCE(!bio);
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return NULL;
+
  	return bio;
  error:
  	bio->bi_status =3D errno_to_blk_status(split_sectors);
@@ -356,9 +362,12 @@ EXPORT_SYMBOL_GPL(bio_split_rw_at);
  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *li=
m,
  		unsigned *nr_segs)
  {
+	u32 max_sectors =3D
+		min(get_max_io_size(bio, lim), blk_crypto_max_io_size(bio));
+
  	return bio_submit_split(bio,
  		bio_split_rw_at(bio, lim, nr_segs,
-			get_max_io_size(bio, lim) << SECTOR_SHIFT));
+				(u64)max_sectors << SECTOR_SHIFT));
  }

  /*
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..8db804f32896 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -367,6 +367,11 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
  		lim->min_segment_size;
  }

+static void bio_clear_split_flag(struct bio **bio)
+{
+	bio_clear_flag(*bio, BIO_BEING_SPLIT);
+}
+
  /**
   * __bio_split_to_limits - split a bio to fit the queue limits
   * @bio:     bio to be split
@@ -383,6 +388,10 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
  static inline struct bio *__bio_split_to_limits(struct bio *bio,
  		const struct queue_limits *lim, unsigned int *nr_segs)
  {
+	struct bio *clear_split_flag __cleanup(bio_clear_split_flag) =3D bio;
+
+	bio_set_flag(bio, BIO_BEING_SPLIT);
+
  	switch (bio_op(bio)) {
  	case REQ_OP_READ:
  	case REQ_OP_WRITE:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5facb06e5924..c79195de2669 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2316,6 +2316,8 @@ static struct mapped_device *alloc_dev(int minor)
  	md->disk->private_data =3D md;
  	sprintf(md->disk->disk_name, "dm-%d", minor);

+	bdev_set_flag(md->disk->part0, BD_SPLITS_BIO_TO_LIMITS);
+
  	dax_dev =3D alloc_dax(md, &dm_dax_ops);
  	if (IS_ERR(dax_dev)) {
  		if (PTR_ERR(dax_dev) !=3D -EOPNOTSUPP)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..25b789830b75 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -54,6 +54,8 @@ struct block_device {
  #ifdef CONFIG_FAIL_MAKE_REQUEST
  #define BD_MAKE_IT_FAIL		(1u<<12)
  #endif
+	/* Set this flag if the driver calls bio_split_to_limits(). */
+#define BD_SPLITS_BIO_TO_LIMITS	(1u<<13)
  	dev_t			bd_dev;
  	struct address_space	*bd_mapping;	/* page cache */

@@ -308,6 +310,7 @@ enum {
  	BIO_REMAPPED,
  	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
  	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_BEING_SPLIT,
  	BIO_FLAG_LAST
  };


