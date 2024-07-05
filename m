Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4D13C8F9
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184229; cv=none; b=eQIc2gt9MzMBbv1u4oWumQyJEYGXIKMxnfyDK8OG1meZv+aadso2d2fF6rpUF4SzvrlkE2iwSbsEr1kld1mb5kCnyILgWw7CM4zSCFTVYzUxmr4cZ7uRX0ijgQDqdGznayu7z34Bwq4jRcnN5ZSBG+Afuv59Iw3kGPPx5utg8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184229; c=relaxed/simple;
	bh=1UzgERYKqIQJwcG5+jHgxYypfLgPJ6yukH4yDdtMA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijY5JGaAtvf7LqjcFBTdP1V25yu+9jOjscp5T4FH8yUHP1fzwo0fNriHi46GXBoYrhHmQdjjVqLM+UGsGSyy2BnPbo0XIXPjnZzkqHXqhGLSrsg6cZb/HeE2d0Ybd29vRJ9NVkcr3Bpk2bXCad9JPBeHQUV7MmL/0F4UX/6mK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ggXdVE9Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggXdVE9Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nEoJjgtGOYh6Q1jDCXemfdA/HKNdBMo7UkSV/4LnRGQ=; b=ggXdVE9ZWbRRStVZ87G/k83m4k
	gqDYezT0XLHc6o3qgVVOHYByhWk90dwx2ijKTQXV6wFz7s5k64WFUVN2HHOTvuSEyMNHWVB+Cnedk
	Fx0jHscJc4l9E2+K6Ruq5QBcw7Bc8o8SzSKtoW8OYaa5xGfn9hpyyRjOxXISUzHmqNJUk+aehovFr
	YCgU7GXl/UxY3YMomMOco3idi8fc2V1mHhWcsvchjCr7Duaeg6lvj2kQUeP0zF6ip9zOtf7HvQV/M
	aWP6YzRyBdb3BbI1EO1zuelPf4S3eaiskcODPovvGY5YrTH8tdY1lmeWUGWEs5pYEw9aRoqNBbpi/
	W7oV9GmA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPiUt-0000000FyZ2-0ZKs;
	Fri, 05 Jul 2024 12:57:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: also check bio alignment for bio based drivers
Date: Fri,  5 Jul 2024 14:56:50 +0200
Message-ID: <20240705125700.2174367-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705125700.2174367-1-hch@lst.de>
References: <20240705125700.2174367-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Extend the checks added in 0676c434a99b ("block: check bio alignment
in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
all the same reasons apply for them as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c |  7 +++++--
 block/blk-mq.c   | 11 -----------
 block/blk.h      | 11 +++++++++++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 71b7622c523a30..ffb55d8843a121 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -615,8 +615,11 @@ static void __submit_bio(struct bio *bio)
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-		disk->fops->submit_bio(bio);
+	
+		if (unlikely(bio_unaligned(bio, disk->queue)))
+			bio_io_error(bio);
+		else
+			disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b5536..94a102abb88055 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2909,17 +2909,6 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	INIT_LIST_HEAD(&rq->queuelist);
 }
 
-static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
-{
-	unsigned int bs_mask = queue_logical_block_size(q) - 1;
-
-	/* .bi_sector of any zero sized bio need to be initialized */
-	if ((bio->bi_iter.bi_size & bs_mask) ||
-	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask))
-		return true;
-	return false;
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
diff --git a/block/blk.h b/block/blk.h
index 8e8936e97307c6..d099ef1df5f64a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -40,6 +40,17 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
 
+static inline bool bio_unaligned(const struct bio *bio, struct request_queue *q)
+{
+	unsigned int bs_mask = queue_logical_block_size(q) - 1;
+
+	/* .bi_sector of any zero sized bio need to be initialized */
+	if ((bio->bi_iter.bi_size & bs_mask) ||
+	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask))
+		return true;
+	return false;
+}
+
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
 	rcu_read_lock();
-- 
2.43.0

