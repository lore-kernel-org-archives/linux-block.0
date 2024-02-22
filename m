Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A81799A
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587414; cv=none; b=JIGYluejLQZ8wKbtIgxuLPwWm0iB2Im1HDCrLc+Pbj/VVL+Er4m2tdrFyxjYb3PsiXiOplDB3fCxJ3p6BTu1XjL+6KRlGeeBvrjtk8KJLXwQHlgbRW3nlqTuk0S7a0jbTKdYwFsZmhwLacPkanYdf879YWwaaLIEqZYtIY96adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587414; c=relaxed/simple;
	bh=X5Tvs1a2HQKezqrg0JDZFNPYVhzjonmPmJ8rjJOB0uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgmiupTsN0YJRquak0jrlQEBIOHlxbAYy442jD6wC6lpBTf1WsyOqAj7kKmbzIeExS9ojECbhE1NLlWH1G5+xQkqADyjGOBw7hA/MU7MpeZ1Mfc2xunLg4PmCoeRjnVMve1PsR2uXvSCmtiAQ6se4yRXu8pI4FfTABlef4jp58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bry81xqQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bry81xqQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B8V4aaBVv5s4vJov13/hXqBfk95hxUybkZxyKAE3IRg=; b=bry81xqQG3iFQtRBZt9d/cMoF/
	Ok1THD78xJ35jsdBXzopSGet+yj8aeYfVqeD7ENZQ04pj11CBYS6ADPrUT/nuVHHVnmvce08LloO4
	Okbfg//Fuv2xlusSO60Lm/TldXyAyC3FzsXBoEq0y+IToLyzI1XsdsW4c/uTsh7FjKsdHhu3HW7R2
	lEP39TFYdWORecNo7rJZH9aDIYy9gYDcb7GtJ2iCHw6Fzz+q0ap24GEXPwWikZZhSI5GZoajhTIUa
	tAaIJkm1TCm7QU6SIZvgZGg0B/sQ7zTanp7kqpTx2LKlQfY77C+e3s/+2fc2oBc5jAP5XBecYN4M6
	CJzR11og==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3dT-00000003ps8-3PYl;
	Thu, 22 Feb 2024 07:36:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] pktcdvd: stop setting q->queuedata
Date: Thu, 22 Feb 2024 08:36:46 +0100
Message-Id: <20240222073647.3776769-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222073647.3776769-1-hch@lst.de>
References: <20240222073647.3776769-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The two users can get the private data from the gendisk with one less
pointer dereference, and we can drop the useless q parameter from
pkt_make_request_write.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index abb82926b1c935..0cd65b27c19717 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2338,9 +2338,9 @@ static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
 	pkt_queue_bio(pd, cloned_bio);
 }
 
-static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
+static void pkt_make_request_write(struct bio *bio)
 {
-	struct pktcdvd_device *pd = q->queuedata;
+	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->private_data;
 	sector_t zone;
 	struct packet_data *pkt;
 	int was_empty, blocked_bio;
@@ -2432,7 +2432,7 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 
 static void pkt_submit_bio(struct bio *bio)
 {
-	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->queue->queuedata;
+	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->private_data;
 	struct device *ddev = disk_to_dev(pd->disk);
 	struct bio *split;
 
@@ -2476,7 +2476,7 @@ static void pkt_submit_bio(struct bio *bio)
 			split = bio;
 		}
 
-		pkt_make_request_write(bio->bi_bdev->bd_disk->queue, split);
+		pkt_make_request_write(split);
 	} while (split != bio);
 
 	return;
@@ -2490,7 +2490,6 @@ static void pkt_init_queue(struct pktcdvd_device *pd)
 
 	blk_queue_logical_block_size(q, CD_FRAMESIZE);
 	blk_queue_max_hw_sectors(q, PACKET_MAX_SECTORS);
-	q->queuedata = pd;
 }
 
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
-- 
2.39.2

