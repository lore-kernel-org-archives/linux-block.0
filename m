Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379586;
	b=D2BiqZRbk2P6rDoI7QrWuK5X15d9sran+eAl+7G2LM45dPjhDPn7aVcCslJkcoKKHVLd
	 RTYQZKgwFfPKfi8k40cSDGOVGnPK2ky8Lq6e40Da5by7IcTv8D+jBZYNqCamFjdKNuH2f
	 U7HD7phl/cAwuamODwsxXEiPWNOrGvyN7XuczCY8XcWp8FwailsHX75XZN2w0jYpLKdRj
	 5GGiXwOMwOR7DjbMdhJkkGQ0cZVGWfvH++m4g7/s7c+RMQ/FUcb1QcsaNtujHTVVQZCG/
	 EAD8yvJ4UgImVeUe00hX6vrQX3S0ucrptWzohV0tyHD+4JqrKC4p1E0/y/gRuCuXZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379586;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mdpbRJa4xEQl9IMVl9SpzGjK3VaJkNxSaT48yT2kaOk=;
	b=v/OS0KhCbnzTMHmHlhXk6Z0nzBWK7il/AzfoK9Vv8SxWYVLbMlROJGOwXXbvhgRgtv7o
	 GlU3oHoRcw/V1za0myxxARJmuxi05TxOjMPH4+AekJW3vHOZST6+Xabhby4kta03fLafz
	 7MuOElo7BCWvlQfp1vKw4LLKDyswtMHEK1XX1sPIGr6uUNc0/PkWveJVcz7980TvKU5it
	 CTvfr+msCbLEZl3I124FY6XQyZc6psMc70xChOmMhRupH+TX5JvTIQ60qU7ewYxfqnisb
	 JfQjvqY9NTdvYHkPkJELPLcH15+YEZF303aWXiIRWDXuiKmDflYs7iumugt5PBrcWKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YXfLNqjs;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD6606A335;
	Wed, 11 Nov 2026 06:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BD6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YXfLNqjs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YXfLNqjsVbddR7yDDoLozJ8CvOzNWYNKPtRIVon/YicrRW80NL1fluGsfxLOirHoFUvV/2xgZYFvz
	 IhOnxu89/vL5GsDOttsAjD0Erj8L1U08yq0xxQgGHzfWQUHi4m+fK2DBKbC3R8WxeqiirsJVic8Ylg
	 /UM/LORrcTyaCBOc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af40f3d515-da878;
	Wed, 11 Nov 2026 14:46:22 +0800 (CST)
X-RM-TRANSID:2ee96af40f3d515-da878
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af40f3cee1-d200e;
	Wed, 11 Nov 2026 14:46:22 +0800 (CST)
X-RM-TRANSID:2ee26af40f3cee1-d200e
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+106207df4f48565a7c02@syzkaller.appspotmail.com,
	syzbot+815c724e19b74bfd0c9d@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] blk-mq: mark request tag accesses racing with busy iteration
Date: Wed, 11 Nov 2026 14:46:20 +0800
Message-ID: <20261111064620.17057-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Busy tag iteration can encounter a request retained in tags->rqs after
it releases its driver tag. The tag comparison in blk_mq_find_and_get_req()
therefore races with driver tag allocation and release, as KCSAN reports.

Mark the iterator's tag snapshot with READ_ONCE() and the corresponding
tag stores with WRITE_ONCE(), including the flush request stores. The
existing request reference and tag-set lifetime rules continue to govern
whether the request can be passed to the iterator callback.

Fixes: 67f3b2f822b7 ("blk-mq: avoid to iterate over stale request")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 block/blk-flush.c  | 4 ++--
 block/blk-mq-tag.c | 2 +-
 block/blk-mq.c     | 8 ++++----
 block/blk-mq.h     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 38bd4ae5d9e7..f8cea46775db 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -236,7 +236,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	}
 
 	if (!q->elevator) {
-		flush_rq->tag = BLK_MQ_NO_TAG;
+		WRITE_ONCE(flush_rq->tag, BLK_MQ_NO_TAG);
 	} else {
 		blk_mq_put_driver_tag(flush_rq);
 		flush_rq->internal_tag = BLK_MQ_NO_TAG;
@@ -317,7 +317,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
 	if (!q->elevator)
-		flush_rq->tag = first_rq->tag;
+		WRITE_ONCE(flush_rq->tag, first_rq->tag);
 	else
 		flush_rq->internal_tag = first_rq->internal_tag;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3515031b3226..84eea85f9217 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -271,7 +271,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 	struct request *rq;
 
 	rq = tags->rqs[bitnr];
-	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
+	if (!rq || READ_ONCE(rq->tag) != bitnr || !req_ref_inc_not_zero(rq))
 		rq = NULL;
 	return rq;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..95de1e4d015f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -387,7 +387,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->phys_gap_bit = 0;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
-	rq->tag = BLK_MQ_NO_TAG;
+	WRITE_ONCE(rq->tag, BLK_MQ_NO_TAG);
 	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = blk_time_get_ns();
 	blk_crypto_rq_set_defaults(rq);
@@ -432,10 +432,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->rq_flags = data->rq_flags;
 
 	if (data->rq_flags & RQF_SCHED_TAGS) {
-		rq->tag = BLK_MQ_NO_TAG;
+		WRITE_ONCE(rq->tag, BLK_MQ_NO_TAG);
 		rq->internal_tag = tag;
 	} else {
-		rq->tag = tag;
+		WRITE_ONCE(rq->tag, tag);
 		rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 	rq->timeout = 0;
@@ -1877,7 +1877,7 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (tag == BLK_MQ_NO_TAG)
 		return false;
 
-	rq->tag = tag + tag_offset;
+	WRITE_ONCE(rq->tag, tag + tag_offset);
 	blk_mq_inc_active_requests(rq->mq_hctx);
 	return true;
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1e64236d34d4..b21fba720225 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -358,7 +358,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 {
 	blk_mq_dec_active_requests(hctx);
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = BLK_MQ_NO_TAG;
+	WRITE_ONCE(rq->tag, BLK_MQ_NO_TAG);
 }
 
 static inline void blk_mq_put_driver_tag(struct request *rq)
-- 
2.51.0


