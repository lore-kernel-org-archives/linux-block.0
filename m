Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD96995B
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520342; cv=none; b=RX/5GKGwGdUcMkjOl+6eghiyU8AMsyl/CWQTHyBFz7wCo6zZLN+lPACtiezicW/zj861OwYOJ1tam2Wj1iRLJ2CRavfa07DwOeCvyXfJ06fi0jHyFrTnX8ZX7Xo4NmLHRPBvyKvapHzUYtONHhmm5lYRTw+d78h8WkReysNjMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520342; c=relaxed/simple;
	bh=5od+8AwIZ4zR2rY/yfqZmOpexzIBbzNIhrsqln3L/mw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN77jDKpCgatmZMwd2jdrGpGSWs74jFRLW5ZX3B1WL+sCETqzYx7ZLf9lLKii0Hu7cgFH2leWPYr9iX75/K23f8GjPfh9auru6jlBOXEoGOYJAPqSDafVTiyOPY0d4K4SeDCMo6FLEIH9ARjWPdPbWf/rkNE5fGaMlciLO2CggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XeCr1flD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XeCr1flD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=2bzGn47cjUdgN+x/FL0i0dqH9SVUpthf30bI0lT03/8=; b=XeCr1flD8EXP6yvVh2cqn3wx1r
	cpqVTcboC5Q7w6b9DjTaqoQQVy2vjQ3SsPPdLq6P1FpHNVzOqrR4WOj9+RIbWgwbJKzs9DjwHhOog
	dR8jo0Q5bmgAuH/eqJD6sZYXkafMp8LYbF7U8VtO/5NwXtQymU6GqHIouoYxytvNIFpYv7NbtKiH/
	ScPvL4Yn1BCrYfXn4CYGc2DDSZf8IlB4rASU66L3wde0FZtfA7WCGheu9dnmYxoO6q5v+cAFUJPkJ
	o5LWzv45IGz7c9Asx7N53BismN8ObaC/zgUuaCaBFQXvIdGE5FzHNdGJCLSNr3ISXDED+Hi0HZoZL
	jE5LCtYQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmBf-00000000wFJ-0P7d;
	Wed, 21 Feb 2024 12:58:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] xen-blkfront: don't redundantly set max_sements in blkif_recover
Date: Wed, 21 Feb 2024 13:58:44 +0100
Message-Id: <20240221125845.3610668-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blkif_set_queue_limits already sets the max_sements limits, so don't do
it a second time.  Also remove a comment about a long fixe bug in
blk_mq_update_nr_hw_queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkfront.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 1258f24b285500..7664638a0abbfa 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2008,14 +2008,10 @@ static int blkif_recover(struct blkfront_info *info)
 	struct request *req, *n;
 	int rc;
 	struct bio *bio;
-	unsigned int segs;
 	struct blkfront_ring_info *rinfo;
 
 	blkfront_gather_backend_features(info);
-	/* Reset limits changed by blk_mq_update_nr_hw_queues(). */
 	blkif_set_queue_limits(info);
-	segs = info->max_indirect_segments ? : BLKIF_MAX_SEGMENTS_PER_REQUEST;
-	blk_queue_max_segments(info->rq, segs / GRANTS_PER_PSEG);
 
 	for_each_rinfo(info, rinfo, r_index) {
 		rc = blkfront_setup_indirect(rinfo);
@@ -2035,7 +2031,9 @@ static int blkif_recover(struct blkfront_info *info)
 	list_for_each_entry_safe(req, n, &info->requests, queuelist) {
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
-		BUG_ON(req->nr_phys_segments > segs);
+		BUG_ON(req->nr_phys_segments >
+		       (info->max_indirect_segments ? :
+			BLKIF_MAX_SEGMENTS_PER_REQUEST));
 		blk_mq_requeue_request(req, false);
 	}
 	blk_mq_start_stopped_hw_queues(info->rq, true);
-- 
2.39.2

