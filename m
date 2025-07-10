Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716662253A7
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170706; cv=none; b=tggr+l6eh8Tx881UgeaZ8jBlaLC6fCTTcNfusXE2JjmePsAtnvr88l5tNk9gKe9jy+f2vTLGZ8l0v4oG1rqUc/fGvQb8lEJHvx9eRENWTtfBaj8Qkt1cpwgRLWO8I3PCaUwE30voMrQE77fwwWk6d1OOQV1e5nq8w7x12EIZWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170706; c=relaxed/simple;
	bh=dxBXusDSpUkl/Wu4Y1OP7wxnWlW6VKPT8cwyUAHpdpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5hWwXRBu9LHATRi7KU9TiaoDBHSaZvTRPylK/DqnNl5jpfwxgsyjwAJnRiNQuxMt3YmRmEu1CIrS2U7QTpe5WMOcI3ePdQC+4On5UxCdNFDo1iaqOn3qo7w2w2/34dyFcn8pv5yoZZ4L404GqwOmvFCdGOgYgGM5RRGPsebf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lwF0CKV2; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lwF0CKV2"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bdN6R2BF0zm1751;
	Thu, 10 Jul 2025 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752170701; x=1754762702; bh=IHbRf6SOfWu/DeRrSoHBpGVp
	v0NSYZ5Nhnn3HYS5XW8=; b=lwF0CKV2fCl9/MwbcybXZqN0d9HMh6fp1JWcu+9F
	26d/wf/lXq3Z4zIibRcf0qLI6ezB8DUMxc9vKcsUOnPf7IxS46mNZdlJEQJmhlUz
	8rr0FzVb+GpmFj2glzJbfttQQoMI+mENWfo6l2eI/+d6rj5t5AFgy4bCFAExmIXP
	QIT0dslhU4ReSK7e09khxfBLYPKWSH534W0K3zVYDJHVJSPwjTcUmigt5I/J0Bsp
	ldBtNvG4inAs9+fpaTtUZNhQqcXeau2DdiJ6OULozCVHuJjxxtlK7zhEojhqVFoL
	4qWlSTqtouCE/F3UADZvIotJVs/8ClFnxqrVwtvQV9BfDg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iSyS7v9srOJU; Thu, 10 Jul 2025 18:05:01 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bdN6L0MGczm174r;
	Thu, 10 Jul 2025 18:04:57 +0000 (UTC)
Message-ID: <fe36a76d-f859-4607-a09d-708472565d35@acm.org>
Date: Thu, 10 Jul 2025 11:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: Rework splitting of encrypted bios
To: Christop Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Eric Biggers <ebiggers@google.com>, Keith Busch <kbusch@kernel.org>
References: <20250625234259.1985366-1-bvanassche@acm.org>
 <20250625234259.1985366-4-bvanassche@acm.org>
 <aFzadpzYv14Qbs5K@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aFzadpzYv14Qbs5K@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 10:28 PM, Christop Hellwig wrote:
> This adds a lot of mess to work around the blk-crypto fallback code, and
> looking at it a bit more I think the fundamental problem is that we
> call into the blk-crypto fallback code from the block layer, which is
> very much against how the rest of the block layer works for submit_bio
> based driver.
> 
> So instead of piling up workarounds in the block layer code I'd suggest
> you change the blk-crypto code to work more like the rest of the block
> layer for bio based drivers, i.e. move the call into the drivers that
> you care about and stop supporting it for others.  The whole concept
> of working around the lack of features in drivers in the block layer
> is just going to cause more and more problems.

Hi Christoph,

Thanks for having proposed a path forward.

The blk-crypto-fallback code replaces a bio because it allocates a data
buffer for the encrypted or decrypted data. I think this data buffer
allocation is fundamental. Hence, the crypto fallback code must be
called before DMA mapping has happened. In case of the UFS driver, DMA
mapping happens by the SCSI core. Would it be acceptable to keep the
blk-crypto-fallback code in the block layer core instead of moving it
into the SCSI core? The patch below shows that is is possible without
the disadvantages of the patch series I'm replying to. In the patch
below the BIO_HAS_BEEN_SPLIT and BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS
flags are gone. I have verified that the patch below doesn't trigger any
write errors in combination with zoned storage.

Thanks,

Bart.


Subject: block: Rework splitting of encrypted bios

Modify splitting of encrypted bios as follows:
- Stop calling blk_crypto_bio_prep() for bio-based block drivers that do not
   call bio_split_to_limits().
- For request-based block drivers and for bio-based block drivers that call
   bio_split_to_limits(), call blk_crypto_bio_prep() after bio splitting
   happened instead of before bio splitting happened.
- In bio_split_rw(), restrict the bio size to the smaller size of what is
   supported to the block driver and the crypto fallback code.

The advantages of these changes are as follows:
- This patch fixes write errors on zoned storage caused by out-of-order
   submission of bios. This out-of-order submission happens if both the
   crypto fallback code and bio_split_to_limits() split a bio.
- Less code duplication. The crypto fallback code now calls
   bio_split_to_limits() instead of open-coding it.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..5af5f8c3cd06 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,9 +626,6 @@ static void __submit_bio(struct bio *bio)
  	/* If plug is not used, add new plug here to cache nsecs time. */
  	struct blk_plug plug;

-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
  	blk_start_plug(&plug);

  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..3b9ae57141b0 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,9 +209,12 @@ blk_crypto_fallback_alloc_cipher_req(struct 
blk_crypto_keyslot *slot,
  	return true;
  }

-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
+/*
+ * The encryption fallback code allocates bounce pages individually. 
Hence this
+ * function that calculates an upper limit for the bio size.
+ */
+unsigned int blk_crypto_max_io_size(struct bio *bio)
  {
-	struct bio *bio = *bio_ptr;
  	unsigned int i = 0;
  	unsigned int num_sectors = 0;
  	struct bio_vec bv;
@@ -222,21 +225,8 @@ static bool 
blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
  		if (++i == BIO_MAX_VECS)
  			break;
  	}
-	if (num_sectors < bio_sectors(bio)) {
-		struct bio *split_bio;
-
-		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
-				      &crypto_bio_split);
-		if (IS_ERR(split_bio)) {
-			bio->bi_status = BLK_STS_RESOURCE;
-			return false;
-		}
-		bio_chain(split_bio, bio);
-		submit_bio_noacct(bio);
-		*bio_ptr = split_bio;
-	}

-	return true;
+	return num_sectors;
  }

  union blk_crypto_iv {
@@ -257,8 +247,10 @@ static void blk_crypto_dun_to_iv(const u64 
dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
   * The crypto API fallback's encryption routine.
   * Allocate a bounce bio for encryption, encrypt the input bio using 
crypto API,
   * and replace *bio_ptr with the bounce bio. May split input bio if 
it's too
- * large. Returns true on success. Returns false and sets bio->bi_status on
- * error.
+ * large. Returns %true on success. On error, %false is returned and one of
+ * these two actions is taken:
+ * - Either @bio_ptr->bi_status is set and *@bio_ptr is not modified.
+ * - Or bio_endio() is called and *@bio_ptr is changed into %NULL.
   */
  static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
  {
@@ -275,9 +267,12 @@ static bool blk_crypto_fallback_encrypt_bio(struct 
bio **bio_ptr)
  	bool ret = false;
  	blk_status_t blk_st;

-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
+	/* Verify that bio splitting has occurred. */
+	if (WARN_ON_ONCE(bio_sectors(*bio_ptr) >
+			 blk_crypto_max_io_size(*bio_ptr))) {
+		src_bio->bi_status = BLK_STS_IOERR;
  		return false;
+	}

  	src_bio = *bio_ptr;
  	bc = src_bio->bi_crypt_context;
@@ -475,9 +470,8 @@ static void blk_crypto_fallback_decrypt_endio(struct 
bio *bio)
   * @bio_ptr: pointer to the bio to prepare
   *
   * If bio is doing a WRITE operation, this splits the bio into two 
parts if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then 
allocates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to 
point to
- * the bounce bio.
+ * too big. It then allocates a bounce bio for the first part, encrypts 
it, and
+ * updates bio_ptr to point to the bounce bio.
   *
   * For a READ operation, we mark the bio for decryption by using 
bi_private and
   * bi_end_io.
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..443ba1fd82e6 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -223,6 +223,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);

  int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);

+unsigned int blk_crypto_max_io_size(struct bio *bio);
+
  #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */

  static inline int
@@ -245,6 +247,11 @@ blk_crypto_fallback_evict_key(const struct 
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
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..caaec70477bb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
  #include <linux/blk-integrity.h>
  #include <linux/part_stat.h>
  #include <linux/blk-cgroup.h>
+#include <linux/blk-crypto.h>

  #include <trace/events/block.h>

@@ -124,9 +125,14 @@ static struct bio *bio_submit_split(struct bio 
*bio, int split_sectors)
  		trace_block_split(split, bio->bi_iter.bi_sector);
  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
  		submit_bio_noacct(bio);
-		return split;
+
+		bio = split;
  	}

+	WARN_ON_ONCE(!bio);
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return NULL;
+
  	return bio;
  error:
  	bio->bi_status = errno_to_blk_status(split_sectors);
@@ -355,9 +361,12 @@ EXPORT_SYMBOL_GPL(bio_split_rw_at);
  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
  		unsigned *nr_segs)
  {
+	u32 max_sectors =
+		min(get_max_io_size(bio, lim), blk_crypto_max_io_size(bio));
+
  	return bio_submit_split(bio,
  		bio_split_rw_at(bio, lim, nr_segs,
-			get_max_io_size(bio, lim) << SECTOR_SHIFT));
+				(u64)max_sectors << SECTOR_SHIFT));
  }

  /*

