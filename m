Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595462;
	b=oLf1htP505eQ1NKUuTJO27p4J4GCJIlJKsHh/sm9xb0ezzMkAs0pVQLWo8Ao6hn+NfhJ
	 nePMsjYKTDWAZMGg4SstUJCNcF7wFh8MdsNEXkQLH2vADQXnRU9L2UIpjRpPogXhPsTZF
	 Ft09f2lxqEohZsMGhLM2mBCbFSwPdd2Q0LXjIoty7PryfS+U+Vct84W0EcPzGPFDmMsBM
	 OJilbesjeHAt/SCZTtdZZxV0bQn0LSQSqLZGJ06uUAtSNcCqbBWZG2ynl8ceptcoB7JjT
	 JdG7gPt0D1wh+DGuVjTD4B9/ltGR4EDhcOU6v85c4gY6F4Llksq6fK3402RyDXLBCuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hIuOVUahjDjLCV13jNZLJjC384QFFAm1IMrjIYZhdao=;
	b=A1cNjV7dbTOYVKGLnZktxNE6Xt3HiWLvqtMOI26ZBSEtmYtC/FhzKCRVLU0FGomm3txr
	 D7plzQTKGxg4xBHfUXkHAsOUQNBlt2/uQ2Tx5SDFV8ACKaLuZOcZZyY+mLbjVZVBId/Iq
	 mScp1EqIk3IJEPGdxBGUAfNIfEe90nNSx46LYmREj/ounJeG/TUModmXaNIJ6OPnytvSC
	 cTqvWy/hKSyR/mPOe+zkR+gQ5LdzOOjSey0Vhovp2XahaABJ12rkJoIbttQrgsbPTlJR5
	 Ns6T+wpSCjZCjtXThlh5+d2uezWKRe9SxZeAw1nqju+ff1O3nLesKd7Kf63rtU3wcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GsknMUZR;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECE606A31A
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 15:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06ECE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GsknMUZR
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06454116eso406169b3a.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792595460; x=1793200260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIuOVUahjDjLCV13jNZLJjC384QFFAm1IMrjIYZhdao=;
        b=GsknMUZRHa+I8UIU7lxkjPSrz8MJ0naYAq3l9DCLv6fizgXPzSJP/58BChFMRUKKC3
         ePJnHJWAYDCfMEuQWZ6CCIS1LFLo5nUEXYEBaIiD7uFYuNYwhJ4K5EKE9MOQM1E67v2Z
         xf1IDYWX5K6sWIbgLN7Wzdek/Z18JjytFgbYY25KZlwBdWvpd/yLzae6k/KQ/9qdmk3s
         lwfuvATaQOitVq5+7gQo4t+rRy50fGNBW3eNdp7PbgCi44OX8ink3mAWnw9paFlrX967
         OyH14DNOy3gry/ip+mxR3WFTWfH5+VTr4hdw9bStfS9edSJb8MT/BV73I7X2QvFNZNWX
         ZXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595460; x=1793200260;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIuOVUahjDjLCV13jNZLJjC384QFFAm1IMrjIYZhdao=;
        b=PhGIXDw0mmHPfOZ3VcBxqubqsTRsLqGLibpnIS0T4V2JuDaN5uv6zdj0UJcmZPsnyL
         0Kl26uwwxHY2TSfPu/EbaWnkqKHwdV9aUUiV24vcXfzZZpENaRpaWEDtbYlKFUPnczGZ
         n8fK42Bx+E16dYfLyf2HzNRiaz5g770scdBGa3l6DFsY7e7B7+yKZivt1oe4oEcuSYaT
         cPbd0FvlSF9YQjdvmZJqmZ+hiJEmCfypXjVxU8GxbWIlMak4qry1beragyO0r/b8233L
         mS66pWNTy3Jj3DG/bYUAkWATjEcqgfdq/xeYi3NgGVPHWz77S8gapwuMt0f+SnD0zCWn
         M5sQ==
X-Gm-Message-State: AFq9FYLqNaqngnmSSJEITZ8XnNGd5vWiEVMea+Jis2nlD8gFcXao5eeJ
	fcsihcucUbcoodzvBiTHKbgLwLmJarFVIaw7G1GZgBRRjQG2WbVgym+d46audsMdhuFBaPRO3yC
	dfwOgJeQ=
X-Gm-Gg: AYBFou0+5c6uYZ7qimjWWd8riPJBjzNCcFuBxuEcKOxAVxYyvd7wPsOScGkg7ZJ3Nvw
	4ARv/8RU5L42LTOlAv7KONFEHWxy25a7HBsFkvmqANDwxBgHYyCMFWOvKPNA5oUN4wVwIL9N8HV
	4IlvHA+JBbG+mcMf+Pjw7p+xx0aE1OUJiXDeo6YIK532mFlRJ21GIgJFr3FeArOUkP4iTVrFbrZ
	wjZX5bZd+IiL1TvcmDw7/Gqa1XyVhhzpsAxn0aqrwdaoAo/HSOkY1gQFTXr8Pim5B+N0KTTMnzH
	SJyGga4hNKpgjQGYz6zyQVaZHhdstbrpgykKPIWxXI8K+xJT0/HMcgczgQn3O6oYdHWA/A43Yre
	YWVr4cSEvPtnPe1XE+oGPNh/TrehjQcNFHbI1ISmUZ4ttzNsCvYGEP05JkzLALzRolKv0DbHRY0
	LOw/0uf1+KCDjUoaZqMHx9Ami+4DZ1otx/WHVCCz/MXKBR6JXRTQwL4mEXbFPE/VGr6y/h3bqbf
	hvDKdPsHJ6a2qmCJnL+Ulduf+K+Jcjd1uR7UpXD308Sl0YQ1bFv3Nw0ILpdCKe9BYxRc6X5xWFp
	7VoFpQtNCGfUVjzeSqcBy214A9XdKNKW72pHIHc=
X-Received: by 2002:a05:6a00:1749:b0:851:8bde:7873 with SMTP id d2e1a72fcca58-8a089c47c80mr1829411b3a.8.1792595460096;
        Wed, 21 Oct 2026 08:11:00 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895fb005sm1045949b3a.49.2026.10.21.08.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:10:59 -0700 (PDT)
Message-ID: <efe0abd7-edf4-4d2e-a8e8-be4203d7ac3b@kernel.dk>
Date: Wed, 21 Oct 2026 09:10:58 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 7.4-rc
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
Content-Language: en-US
In-Reply-To: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 8:43 AM, Jens Axboe wrote:
> Hi Linus,
> 
> Here are the block updates and fixes queued up for the 7.4 merge
> window. This pull request contains:

Completely forgot to mention that this merge will throw conflicts. Both
block/bio.c and block/blk-zoned.c will need resolving. Details:

bio.c hits bounce-buffering changes already in your tree. The resolution
keeps the maxlen parameter, uses the atomic-write failure path, and
keeps the multi-page unpinning in align_down() - which loses the bvec
argument it grew here, as it derives that internally again.

blk-zoned.c is Damien's zone revalidation rework colliding with the zone
report fixes that went in during 7.3.

Resolved as below, which matches what I've had in linux-next for a
while:

diff --cc block/bio.c
index b48091c7663f,41d9f1c5992d..06f805d3866a
--- a/block/bio.c
+++ b/block/bio.c
@@@ -1223,10 -1218,10 +1238,11 @@@ static void bvec_unpin(struct bio_vec *
   * for the next iteration.
   */
  static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 -				   struct bio_vec *bv, unsigned len_align_mask)
 +				   unsigned len_align_mask)
  {
 +	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
  	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
+ 	unsigned int npages;

  	if (!nbytes)
  		return 0;
@@@ -1304,10 -1308,11 +1330,12 @@@ static inline bool bio_iov_bvec_aligned
   * is returned only if 0 pages could be pinned.
   */
  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 -			   unsigned mem_align_mask, unsigned len_align_mask)
 +			   unsigned maxlen, unsigned mem_align_mask,
 +			   unsigned len_align_mask)
  {
  	iov_iter_extraction_t flags = 0;
+ 	struct iov_iter saved_iter;
+ 	int ret;

  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
  		return -EIO;
@@@ -1328,34 -1331,50 +1356,49 @@@
  	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
  		flags |= ITER_ALLOW_P2PDMA;

+ 	saved_iter = *iter;
  	do {
- 		ssize_t ret;
+ 		ssize_t size;

- 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
+ 		size = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 -				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 +				maxlen - bio->bi_iter.bi_size,
  				&bio->bi_vcnt, bio->bi_max_vecs,
  				mem_align_mask, flags);
- 		if (ret <= 0) {
- 			/*
- 			 * A misaligned vector fails the whole I/O.  Release any
- 			 * pages pinned by earlier iterations before returning
- 			 * since this bio won't be submitted to release them.
- 			 */
- 			if (ret == -EINVAL) {
- 				bio_release_pages(bio, false);
- 				bio_clear_flag(bio, BIO_PAGE_PINNED);
- 				bio->bi_vcnt = 0;
- 			}
+ 		if (size <= 0) {
+ 			/* A misaligned vector fails the whole I/O */
+ 			if (size == -EINVAL)
+ 				goto out_release_pages;
  			if (!bio->bi_vcnt)
- 				return ret;
+ 				return size;
  			break;
  		}
- 		bio->bi_iter.bi_size += ret;
+ 		bio->bi_iter.bi_size += size;
  	} while (iov_iter_count(iter) && !bio_full(bio, 0));

  	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
  		bio->bi_opf |= REQ_NOMERGE;
- 	return bio_iov_iter_align_down(bio, iter, len_align_mask);
 -	ret = bio_iov_iter_align_down(bio, iter,
 -			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
++	ret = bio_iov_iter_align_down(bio, iter, len_align_mask);
+ 	if (ret)
+ 		return ret;
+
+ 	/*
+ 	 * An atomic write is submitted as a single bio, so it has to cover
+ 	 * the whole iterator or it would be torn.
+ 	 */
+ 	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter))
+ 		goto out_release_pages;
+ 	return 0;
+
+ out_release_pages:
+ 	/*
+ 	 * Release the pages pinned so far before failing, since this bio won't
+ 	 * be submitted to release them.
+ 	 */
+ 	bio_release_pages(bio, false);
+ 	bio_clear_flag(bio, BIO_PAGE_PINNED);
+ 	bio->bi_vcnt = 0;
+ 	*iter = saved_iter;
+ 	return -EINVAL;
  }

diff --cc block/blk-zoned.c
index 475aa16bc41a,ec510d66dfe2..d8688a3d8314
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@@ -1860,6 -2028,16 +2028,21 @@@ void disk_init_zone_resources(struct ge
  	init_completion(&disk->zone_wplugs_worker_bio_done);
  }

+ static unsigned int disk_get_nr_zones(struct gendisk *disk, sector_t capacity)
+ {
+ 	struct queue_limits *lim = &disk->queue->limits;
++	unsigned long long nr_zones;
+
+ 	if (!capacity || !lim->chunk_sectors)
+ 		return 0;
+
 -	return DIV_ROUND_UP_ULL(capacity, lim->chunk_sectors);
++	nr_zones = DIV_ROUND_UP_ULL(capacity, lim->chunk_sectors);
++	if (nr_zones > UINT_MAX)
++		return 0;
++
++	return nr_zones;
+ }
+
  /*
   * For the size of a disk zone write plug hash table, use the size of the
   * zone write plug mempool, which is the maximum of the disk open zones and
@@@ -2014,46 -2192,18 +2197,20 @@@ struct blk_revalidate_zone_args
  	sector_t	sector;
  };

- static int disk_revalidate_zone_resources(struct gendisk *disk,
- 				struct blk_revalidate_zone_args *args)
+ static int disk_init_revalidate_args(struct gendisk *disk,
+ 				     struct blk_revalidate_zone_args *args)
  {
- 	struct queue_limits *lim = &disk->queue->limits;
- 	unsigned long long nr_zones;
- 	unsigned int pool_size;
- 	int ret = 0;
-
  	args->disk = disk;
- 	nr_zones = DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
- 	if (nr_zones > UINT_MAX) {
- 		pr_warn("%s: Too many zones (%llu)\n", disk->disk_name, nr_zones);
- 		return -EINVAL;
- 	}
- 	args->nr_zones = nr_zones;
+ 	args->nr_zones = disk_get_nr_zones(disk, args->capacity);
++	if (!args->nr_zones)
++		return -ENODEV;

  	/* Cached zone conditions: 1 byte per zone */
- 	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
- 	if (!args->zones_cond)
+ 	args->zones_state = kzalloc(args->nr_zones, GFP_NOIO);
+ 	if (!args->zones_state)
  		return -ENOMEM;

- 	if (!disk_need_zone_resources(disk))
- 		return 0;
-
- 	/*
- 	 * If the device has no limit on the maximum number of open and active
- 	 * zones, use BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE.
- 	 */
- 	pool_size = max(lim->max_open_zones, lim->max_active_zones);
- 	if (!pool_size)
- 		pool_size =
- 			min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);
-
- 	if (!disk->zone_wplugs_hash) {
- 		ret = disk_alloc_zone_resources(disk, pool_size);
- 		if (ret)
- 			kfree(args->zones_cond);
- 	}
-
- 	return ret;
+ 	return 0;
  }

  /*

-- 
Jens Axboe
