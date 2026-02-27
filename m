Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532D41324E
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204874; cv=none; b=cLxd2tOi5921e0gN3hbRGAO/N9+UhTrnvKBlnWm3dbJf0+TbVy3FC62uAIzlk23rZPr5V0OZX/KYyqWGlxCo5cnBdVKOLDCsBGNj79us78b0gL0SQH8VB5OgeB6hw9kyFoucR+kIpv6nH3oP36pi6uw9l3tJzwz6qadukBU7+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204874; c=relaxed/simple;
	bh=n5by/7VydHZBlyVXmejs+RldCK/liqhGy2KeoVOUm+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHvlf4wtovJbVchPXcwXeUxwLMecMgWmaJyjdmWaCYCRrwW79Fsj4z96Uq7piKHlWGFIIJSD0xinv0ZtO6UtyBw4GZf1+lyc5UlVaS0Kz+j5XgTf1a1ShNt529ijbXNAXFMv1z1ftF4wrJCUo6CYCSmpYmqpcUejkMLo7DpMawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbIeZiKU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbIeZiKU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82728e5680cso1234281b3a.0
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772204872; x=1772809672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LDCMDc2QskBV2WyhBMjp2GzitMWV4MKLPEd5YXyGQM=;
        b=SbIeZiKUsa7IiJt9C4qy+BqadZocb7b74pTNOyuUPrwhcKoB+W+tJ5UWraLjJIRgQL
         ysfU5fTQ2LMEAtqmhwX1eQW3YzTFYG7AyfjNHQQ/19+0LVNfHaOfclnDgzMXaLyfeHzW
         EbyDE3qJPQ+1/4oNe04ltuwlIpn3Ptpk8eGUa/GKFOXSiHCRZkddjuUobmDMOb2HBrKq
         NcYnY5XaGU3Fd0Y82SqW1VfTHCx7xHJZVNpcc/u7eMtMQ1aex4BDD07OFVdRRZmDa3kC
         rGjR69rxM/ZqxX5m/2E+2A9HIJbrGSQY/gsw1WAaNDMhUTs37GO5hFtJEIKWJu7MAZt8
         520g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204872; x=1772809672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LDCMDc2QskBV2WyhBMjp2GzitMWV4MKLPEd5YXyGQM=;
        b=J5wAxfh2EE4nq5WddKl8XBjmoU30/fjQSNL6fJgKpW92AB+HlUBIh41uRHCN0SNGMW
         w9fI+bDBsSYzcjLhwsfRj7w9uhP9irIU3PCGKsen+ys3cR6ppCnIUS0WLZxsOyHbs7IB
         EKd7YbSaekCGDU7zv872xSeDHvW+IibU6s/EtxNUjXe+URSYSdTPGClw8WI1UtE1ikW+
         QphNCLJVSdv131dfeWbi3ZGrDfl5x7wHUgg9cOZcosZGCbYvNieow1ntJoa/dqUs9YPX
         qCXSaKMZ4Py1ruXabJO4fiu/494E6HX41SD3bvduaiw2KlLm5RY3OG32JnCtw35KpJ+g
         V82A==
X-Gm-Message-State: AOJu0YzOmsoqnYj+/sZUS4CEl9FVZ66a3JcbwbC3SvOQmssFxQiERzZI
	KVt0c+OYJ4FL05o4S8e+CcbyXjvs2QUVYheuaMtXm3fD7UyvUNFkjIoq
X-Gm-Gg: ATEYQzy8aEjgqwVH/pDOQTf+jqb/LSok3szHvdRz+4/2X9CdKl3xVSdYPNNXmiypG/o
	vTWnyW2+fXwsm4BBz1k8PzLyS8A0gUO3Kp9BjlKQHClIkEz1s/w5nYKDdHLwRyqvR6WEUDrtXFt
	FaqJ1Uq4tMBwEl9KXaV4WfQuRmujXPhFZ0xu5RiczeTQL1trhKVz1icdAOkClDfa6U0HlThoinP
	16DQbQUSdKpOi6cLgxlmkj5efYxArzt+zx3wpJ4Jr145I1ntuR/9Qp+SCleCt8K3j/mhe69GKyV
	M8WZTTLStf3slShfEjR/h/dx4UY10DFp1rFLp3qWJ/C1T45B4u5hDr6Pl7cK6BAXr9WxTdj9jOn
	RX85SIR8+G16SUUvz6o3piWelnGJi7DRmg0X2P+m4LiHnay7/i3CF1CERQcYJQBidZ8uB2qDTva
	Pw0QPQWSHpdNTi6R1lsin5yA+xWrauDne8SQ==
X-Received: by 2002:a05:6a21:4d89:b0:35e:c55b:9203 with SMTP id adf61e73a8af0-395c3ac9858mr3240110637.33.1772204872340;
        Fri, 27 Feb 2026 07:07:52 -0800 (PST)
Received: from Alone ([2404:7c00:52:ab73:3d93:3341:c649:9374])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm4997307a12.16.2026.02.27.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:07:51 -0800 (PST)
From: Alone Dangal <yogeshdangal66@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alone Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] block: cleanup various NULL pointer comparisons
Date: Fri, 27 Feb 2026 20:51:41 +0545
Message-ID: <20260227150641.28735-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove open-coded NULL comparisons to follow kernel coding style
guidelines. While at it, remove a trailing whitespace in blk-core.c.

Signed-off-by: Alone Dangal <yogeshdangal66@gmail.com>
---
 block/badblocks.c     | 2 +-
 block/bio.c           | 2 +-
 block/blk-core.c      | 4 ++--
 block/blk-iolatency.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76f..d409e6b6e 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1374,7 +1374,7 @@ EXPORT_SYMBOL_GPL(badblocks_clear);
  */
 void ack_all_badblocks(struct badblocks *bb)
 {
-	if (bb->page == NULL || bb->changed)
+	if (!bb->page || bb->changed)
 		/* no point even trying */
 		return;
 	write_seqlock_irq(&bb->lock);
diff --git a/block/bio.c b/block/bio.c
index d80d5d268..e15f30a5c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -762,7 +762,7 @@ static int __bio_alloc_cache_prune(struct bio_alloc_cache *cache,
 	unsigned int i = 0;
 	struct bio *bio;
 
-	while ((bio = cache->free_list) != NULL) {
+	while ((bio = cache->free_list)) {
 		cache->free_list = bio->bi_next;
 		cache->nr--;
 		bio_free(bio);
diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffa..ae075a95b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -635,7 +635,7 @@ static void __submit_bio(struct bio *bio)
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
-	
+
 		if ((bio->bi_opf & REQ_POLLED) &&
 		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
 			bio->bi_status = BLK_STS_NOTSUPP;
@@ -695,7 +695,7 @@ static void __submit_bio_noacct(struct bio *bio)
 		 */
 		bio_list_init(&lower);
 		bio_list_init(&same);
-		while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
+		while ((bio = bio_list_pop(&bio_list_on_stack[0])))
 			if (q == bdev_get_queue(bio->bi_bdev))
 				bio_list_add(&same, bio);
 			else
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 53e8dd2df..dbd951e8c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -689,7 +689,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 		 * We scaled down but don't have a scale_grp, scale up and carry
 		 * on.
 		 */
-		if (lat_info->scale_grp == NULL) {
+		if (!lat_info->scale_grp) {
 			scale_cookie_change(iolat->blkiolat, lat_info, true);
 			goto next_lock;
 		}
-- 
2.53.0

