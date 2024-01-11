Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FE3C478
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="leQX+Jvf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cloQDKaagUKu7ceMnYi2IROF/T7xvNgp8jO47XB8hu4=; b=leQX+JvfWPP2cGxb2pEcwKIlHc
	2Q4Gabdih+0DvtmYXiD3uKEL2kZanBuAwC7Ot5puPzG549EC619t6czlgJZEN8DWabc4T3CwNBtCK
	QPZCxt+8fQx6WLwX52IOuLh9yMhkQz2Zr4kpoR+ncdI0lof/AT4cz0CM+tyDdVMBVgyOhHIJtLbG2
	KM6gFcojnOmWC2uK2ou8HTZLzHtmC9aG9007SSFeymCVMD/3owXQ1TYRyOGnZSE8aR0K3neS6E1zs
	2qIqkmoBYJKqdNXPYooZikYWW3uT8jOvvaK90ca7QpYgG02tH0QDHikHz5XJk+HGeA3ubKv/YEBUW
	enWts9cA==;
Received: from [2001:4bb8:191:2f6b:63ff:a340:8ed1:7cd5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNvYX-000ETc-0T;
	Thu, 11 Jan 2024 13:57:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: rename blk_mq_can_use_cached_rq
Date: Thu, 11 Jan 2024 14:57:04 +0100
Message-Id: <20240111135705.2155518-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111135705.2155518-1-hch@lst.de>
References: <20240111135705.2155518-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_mq_can_use_cached_rq doesn't just check if we can use the request,
but also performs the work to actually use it.  Remove the _can in the
naming, and improve the comment describing the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa9a05fdd02377..a6731cacd0132c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2884,8 +2884,11 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	return NULL;
 }
 
-/* return true if this @rq can be used for @bio */
-static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
+/*
+ * Check if we can use the passed on request for submitting the passed in bio,
+ * and remove it from the request list if it can be used.
+ */
+static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 		struct bio *bio)
 {
 	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
@@ -2963,7 +2966,7 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 			return;
-		if (blk_mq_can_use_cached_rq(rq, plug, bio))
+		if (blk_mq_use_cached_rq(rq, plug, bio))
 			goto done;
 		percpu_ref_get(&q->q_usage_counter);
 	} else {
-- 
2.39.2

