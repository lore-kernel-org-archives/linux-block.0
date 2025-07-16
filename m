Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542D274B30
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682344; cv=none; b=AkN26o/sp99XNQ3qe69zoxSxzQ28gsufPnOkByxuU6m3SuF9MBeRCuelSR/EnRZOZynTcDKOYJf+noF0xKOimiWHSUGD8m8PKL+F9tOvN6QbloTM1O0nylHnwBGLY3qh1i7Yar7gXw4HDNJ08E1B8rNNw4+rOEa/DoGOofgkZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682344; c=relaxed/simple;
	bh=aCwphz1g1j81d6534fv7wLS9vdZNDbLwhQAcDGe5drg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0uTbGF7NcAKnkFNTTux8c2rx2PGmorw3W6lmaa9iaUOifH3EqzEwWp0nW4/VxF8v5RynBPXD71cxLiaPld1SJtBUznfMuNVqSnPSEBiNIvJtUe3ppCxvgHlWdSoIGuHvYLyVISVi6Jmia14MigIqmmJV3teBz8tjSwnF5dsMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=I4gWGQOO; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="I4gWGQOO"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bj1Kd3qDPzlgqyP;
	Wed, 16 Jul 2025 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752682340; x=1755274341; bh=jIDqQm6Ipt3Tjz7quSUGM0D+
	sCPBEHx+Nf9KJOnWqpQ=; b=I4gWGQOOxYIid3RsBy9fTuhBnw9bNGpP/R0t+VyV
	lNFW3GszlBE0hlC9gZ7x8U4RDmCHNNDGjsxNVhtoAkV+0mBBeuafVZreOZ00E21T
	dqzXSLwk/XFvN3oR+8R9NnZY3wym1hbshSbb4tE65Zbv7OtQdgBiBbGvjMo2h6CV
	6YTxwbynAR0Xu8q3hSde1z73AoXICNWcNQTUu3YWxr9fedjHV4CfM+1f/cNz7xVN
	ZFkRoF1ulS9Z1ijVJ7c3ekwrVNbRnaA9DoBQGnl/66X5d4Pqh3+jxUxMCfWPFgYJ
	z5zlP8slzWpQeud6ON7E4/ta2iTGeLGOBTpGzA3m3zNoXA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cfi1wPidnoXi; Wed, 16 Jul 2025 16:12:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bj1KW4YNQzlgqy3;
	Wed, 16 Jul 2025 16:12:14 +0000 (UTC)
Message-ID: <3b19ea31-00b4-4c01-9f6d-4374300c7a9b@acm.org>
Date: Wed, 16 Jul 2025 09:12:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250715201057.1176740-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250715201057.1176740-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 1:10 PM, Bart Van Assche wrote:
> [ ... ]

(replying to my own email)

If nobody objects I will integrate the patch below in patch 6/7 from
this series. This patch addresses all concerns about this patch series
that have been formulated so far and that I'm aware of, including
restoring inline encryption support for all block devices. This is
realized by moving the blk_crypto_bio_prep() call from
bio_submit_split() back to where it was originally, namely in
blk_crypto_bio_prep(). Because of this change it is necessary to restore
bio splitting in blk_crypto_fallback_encrypt_bio(). Instead of restoring
the custom bio splitting code, call bio_split_to_limits(). This call
takes the inline encryption fallback bio limits into account because
patch 6/7 modifies get_max_io_size().

Thanks,

Bart.


diff --git a/block/blk-core.c b/block/blk-core.c
index 5af5f8c3cd06..2c3c8576aa9b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,6 +626,10 @@ static void __submit_bio(struct bio *bio)
  	/* If plug is not used, add new plug here to cache nsecs time. */
  	struct blk_plug plug;

+	bio = blk_crypto_bio_prep(bio);
+	if (unlikely(!bio))
+		return;
+
  	blk_start_plug(&plug);

  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index b08e4d89d9a6..3b1c277e4375 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -262,12 +262,8 @@ static struct bio 
*blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
  	unsigned int i, j;
  	blk_status_t blk_st;

-	/* Verify that bio splitting has occurred. */
-	if (WARN_ON_ONCE(bio_sectors(src_bio) >
-			 blk_crypto_max_io_size(src_bio))) {
-		src_bio->bi_status = BLK_STS_IOERR;
-		return NULL;
-	}
+	/* Split the bio if it's too big for single page bvec */
+	src_bio = bio_split_to_limits(src_bio);

  	bc = src_bio->bi_crypt_context;
  	data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f4e210279cd3..990f2847c820 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -125,11 +125,10 @@ static struct bio *bio_submit_split(struct bio 
*bio, int split_sectors)
  		trace_block_split(split, bio->bi_iter.bi_sector);
  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
  		submit_bio_noacct(bio);
-
-		bio = split;
+		return split;
  	}

-	return blk_crypto_bio_prep(bio);
+	return bio;

  error:
  	bio->bi_status = errno_to_blk_status(split_sectors);

