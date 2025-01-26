Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF96194080;
	Sun, 26 Jan 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902940; cv=none; b=HrcSXD1Q5gOjwM5pBtKNAliFYFm+6eifMRvI5B1jATG1UnCR1sX8HuqBZu51b1IKfQFJfPCLtJNGaovGp/TVKOj4xILJ9MZroafo8qTCO9SR57xBeE7pHTJ8JC7bS+YmMoboWAyPA4eLAELxaUHwRzk4vklXMzqiR2nQxq9TiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902940; c=relaxed/simple;
	bh=pSyI6sYQUIy8age47j4+sm2JuPCMfmeGvUHk9jzoqy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uC3wvXHUbA9u/AMhbiT/dmSyARx/3DEfkPlLeL2h0tqKp3P2W+YO8whXiQewpAP2ICY8Od01hZ1vjtPWKwk4raiovGA+QX74wyfs4322gn3lTFk/2V1yTObFVxp9gxkYScy46w9kuZIFwH5uzQmN5XUa7u64u+ShyKZzjE17uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoVF0wXA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoVF0wXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B172C4CEE2;
	Sun, 26 Jan 2025 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902940;
	bh=pSyI6sYQUIy8age47j4+sm2JuPCMfmeGvUHk9jzoqy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoVF0wXA8jg1Fk4P/Sd8TL2RlhY/cy1hu7ODWMsTfp0GEGzhxJ+O66VBBK5nWIEq9
	 3Z8kM89Tic5ijdjaJNyIu915ta/bwxic9uoVIq7Gz/CnD2atKWJ8Nc19KiAuivKjFX
	 JnG+0LU3OmdKGP5jD0XCMcmxy3fveiYVtlTonNW8MPd9VAgkAIDU/WCJtUaYRYKEYb
	 rtX12zjBCLWMQkE90yq0yjbmfMn/NU/w/shBJvqHLyero3tOG1HkCT71xUvb9oSD8/
	 sCUmAGn9UGi6vTjW2X9v3GxnxT/N13HEiM+jxIxHGPp5CmkjphpaUqeeMI8DKpmbUW
	 iVVAeRvldor7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 3/6] block: check BLK_FEAT_POLL under q_usage_count
Date: Sun, 26 Jan 2025 09:48:50 -0500
Message-Id: <20250126144854.925377-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144854.925377-1-sashal@kernel.org>
References: <20250126144854.925377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 958148a6ac061a9a80a184ea678a5fa872d0c56f ]

Otherwise feature reconfiguration can race with I/O submission.

Also drop the bio_clear_polled in the error path, as the flag does not
matter for instant error completions, it is a left over from when we
allowed polled I/O to proceed unpolled in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20250110054726.1499538-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 22 ++++++++++++----------
 block/blk-mq.c   | 12 ++++++++++--
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4f791a3114a12..487e8cafccc55 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -629,8 +629,14 @@ static void __submit_bio(struct bio *bio)
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-		disk->fops->submit_bio(bio);
+	
+		if ((bio->bi_opf & REQ_POLLED) &&
+		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
+			bio->bi_status = BLK_STS_NOTSUPP;
+			bio_endio(bio);
+		} else {
+			disk->fops->submit_bio(bio);
+		}
 		blk_queue_exit(disk->queue);
 	}
 
@@ -805,12 +811,6 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
-	if (!(q->limits.features & BLK_FEAT_POLL) &&
-			(bio->bi_opf & REQ_POLLED)) {
-		bio_clear_polled(bio);
-		goto not_supported;
-	}
-
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		break;
@@ -935,7 +935,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 		return 0;
 
 	q = bdev_get_queue(bdev);
-	if (cookie == BLK_QC_T_NONE || !(q->limits.features & BLK_FEAT_POLL))
+	if (cookie == BLK_QC_T_NONE)
 		return 0;
 
 	blk_flush_plug(current->plug, false);
@@ -951,7 +951,9 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return 0;
-	if (queue_is_mq(q)) {
+	if (!(q->limits.features & BLK_FEAT_POLL)) {
+		ret = 0;
+	} else if (queue_is_mq(q)) {
 		ret = blk_mq_poll(q, cookie, iob, flags);
 	} else {
 		struct gendisk *disk = q->disk;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e76651e786d1..784d41eb0abba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3092,14 +3092,22 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	/*
-	 * Device reconfiguration may change logical block size, so alignment
-	 * check has to be done with queue usage counter held
+	 * Device reconfiguration may change logical block size or reduce the
+	 * number of poll queues, so the checks for alignment and poll support
+	 * have to be done with queue usage counter held.
 	 */
 	if (unlikely(bio_unaligned(bio, q))) {
 		bio_io_error(bio);
 		goto queue_exit;
 	}
 
+	if ((bio->bi_opf & REQ_POLLED) &&
+	    !(q->limits.features & BLK_FEAT_POLL)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_endio(bio);
+		goto queue_exit;
+	}
+
 	bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 	if (!bio)
 		goto queue_exit;
-- 
2.39.5

