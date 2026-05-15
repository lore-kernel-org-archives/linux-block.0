Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD513DA7C9
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820965; cv=none; b=HtVRSyl/FRyRLlqjO+U19TamrlNJvbWzLlZg2ERksww4S6Bsjkp0rYWTvenzM+Id0Ww29vPrl3vCT/2EJXB/iEuCEnzJ9X4ndUwZBrp4jE++EQz9qKCoxPDWORTj4itpUM5vBWsrQCaK7bWRHzavklR3zMHBALxgQzt+iQA9P8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820965; c=relaxed/simple;
	bh=g9Ii8RYKuBYw8kVB+iTRyrtBh/GPycuHAc2i5h/Wkl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfx8kK9zjfy6m9fLWTjA28sXXhUTn4mYYn1O+kPrcRrYz42J8LrRqSWihTOQEa6JeOjrqpTpgp0AGRl8jR92UqQs8/4vEbXHo6Rt/+2RiE97AZdRHLcMyJCoe6FXFWJSMKNZjsXmH9l3DoQxgAnHxJRAuKCxAObY9awosdwWHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v0sulI7o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v0sulI7o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dl/k1uI9hHpBDe8yq8mlXPEwoMHr2lCTam0mC5Gh1jg=; b=v0sulI7oi4AVmVuuVJsnHsSpeQ
	MYlimNJOPSwhVhEhougxvegLqrYPJKDWVDiWSg2exh3iNgOXrnuIu1IXOfWIlPfq6ZALDWxY6lddN
	kCmeIPEQnt8OBxULM8wnDHcDubZITzYBQLd98HZ4jrh8/Ex5S3Z0heFAKSNFW0Qs/lfiUMxr9X7JO
	E4cdtd7vvvOGTDuzLAcDZmzC9gTlBdabwuIrYkKRbVglYlapnOg+VUikmvsJSjQS3PFDQkoWCib6f
	/aTPuxT0nqXC1Xrm7TR6lvsDmYCq0rsZfY4mm9iMMFyComcVDj31Z+zIIiVe0Z7T2ubq1kgNwDtV+
	LgCQiXWw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkag-00000007Lwu-2gFm;
	Fri, 15 May 2026 04:56:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: unexport blk_status_to_str
Date: Fri, 15 May 2026 06:55:33 +0200
Message-ID: <20260515045547.3790129-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515045547.3790129-1-hch@lst.de>
References: <20260515045547.3790129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only used in core block code, so unexport and move the prototype to
blk.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 1 -
 block/blk.h            | 2 ++
 include/linux/blkdev.h | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d7de87e86994..22af5dec112b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -197,7 +197,6 @@ const char *blk_status_to_str(blk_status_t status)
 		return "<null>";
 	return blk_errors[idx].name;
 }
-EXPORT_SYMBOL_GPL(blk_status_to_str);
 
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf..bf1a80493ff1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -49,6 +49,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
+const char *blk_status_to_str(blk_status_t status);
+
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..17270a28c66d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1040,7 +1040,6 @@ extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
-const char *blk_status_to_str(blk_status_t status);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
-- 
2.53.0

