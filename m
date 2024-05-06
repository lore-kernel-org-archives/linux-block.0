Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D64503B
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969244; cv=none; b=fhThIEAe1Wz8HX3f4GaC67/PM9oXEk2VscbsbzRwdcy2N3c1xewJb+oc/v8BunEF6+Wjd1jZfn/tZMhLCKikOdtG0b3nrFRg3LiAF5Fo/QXdmQV3eOjNta4aSJeeB5PqHuLXeBfucyt7QI/Xz3jYeQ9UaCOZu5ZnHHTtdS8SyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969244; c=relaxed/simple;
	bh=QhqhFXk85lPTTZsdhSj7N4YrSdpQ4Fu8FYAmOTsD/hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deijMCxVQ/9P9M6PDfs4zZNIvoijW9VWygqG2jbxK5fVGDfvC/ogzXIuvetwVXmABbWhJkUJW0gelbr8460GCdQWmPzpAppazH1QCI4QrmX93Sk4SOb66sKhsSpt0uGRR58FptnpUrt5U0vPSpzeJ0ce3C/i8K8BadArRrOXiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JPgOBDRG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPgOBDRG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tV22VCmL8WFPyjffeM+IMToxy9rDQt+mlWu4HhQ2xus=; b=JPgOBDRGUS3veosPRjyUUDRQsJ
	QHtAM1JjGN51rUytbYhj0O1K5mO56/qiX+V5jtgwaxkIr+LMzQoKEx5T0Sspl1S4rRTTWk/1UXPty
	5RruUbvyq8JjweVT+8GgfS3B0+rSWxt4UuhoJgPBkl8zODUvOUT8iN1gLB7Oxseuo8b2rtTMoZo22
	yryU9foOzfa64tIbwaXztt4ESHZhkq1gGWXX0ZlerZeZCJCidIu+xgaAU3FSPLq3z80yBBLm2p1L/
	I1kCopR4eQcv/VhjFXOt0ilKWsT0Klxa90kjKI3ROg3eOkbxqU0tglBn3j0hq4R+qrhvrMI8tfRJd
	8bkJrw1w==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pqD-000000060Me-3zYu;
	Mon, 06 May 2024 04:20:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: add a bio_await_chain helper
Date: Mon,  6 May 2024 06:20:26 +0200
Message-Id: <20240506042027.2289826-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506042027.2289826-1-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Keith Busch <kbusch@kernel.org>

Add a helper to wait for an entire chain of bios to complete.

Signed-off-by: Keith Busch <kbusch@kernel.org>
[hch: split from a larger patch, moved and changed the name now that it
 is non-static]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 20 ++++++++++++++++++++
 block/blk.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index d82ef4fd545cb2..dce12a0efdead2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1395,6 +1395,26 @@ int submit_bio_wait(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_wait);
 
+static void bio_wait_end_io(struct bio *bio)
+{
+	complete(bio->bi_private);
+	bio_put(bio);
+}
+
+/*
+ * bio_await_chain - ends @bio and waits for every chained bio to complete
+ */
+void bio_await_chain(struct bio *bio)
+{
+	DECLARE_COMPLETION_ONSTACK_MAP(done,
+			bio->bi_bdev->bd_disk->lockdep_map);
+
+	bio->bi_private = &done;
+	bio->bi_end_io = bio_wait_end_io;
+	bio_endio(bio);
+	blk_wait_io(&done);
+}
+
 void __bio_advance(struct bio *bio, unsigned bytes)
 {
 	if (bio_integrity(bio))
diff --git a/block/blk.h b/block/blk.h
index ee4f782d149662..d5107e65355e27 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -38,6 +38,7 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
+void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.39.2

