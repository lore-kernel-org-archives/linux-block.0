Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78C8C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiCHIKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiCHIKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 03:10:13 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA73D1F6
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646726956; x=1678262956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E3EYnuHZyaqiqzZjLt6atcZ1/acwEX2xx65aYJjkxFE=;
  b=r0cntbs5J/V9ImQPYKCj95Qd+rNl/kplZfhUWKA1AKVt6fohPpW10fNp
   Y0LwvwCu24mDbCkdaxOgLvybEjAoAbCmYlgez48TtyrC0bLMbNxNoD/pA
   fcj6s3GweWk86YpcnG0JbiHX8gtWCTYV09gx4HtIBaR/bn3/fvp/72klB
   V+S04R9EiOrY5sodR7ibJcqmZoOK/BvkNECdKYzIebReLoof6cviFhZPn
   5lrCBcpClrJ7LKaz/EKhazioDVlPla3l3iAYQIpD5UU/VrnjHz2dkwN6S
   BdqH70R4HLPKiO88MVqOksD+r3bi0oKZOUEO3JyeMTL0lGejaZJO4iU/J
   w==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643644800"; 
   d="scan'208";a="199583901"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 16:09:15 +0800
IronPort-SDR: ett7TJd5NQIz5Ea7a7EDVeYYnL17lgi1rh+cpCPAmmDAoJ5qmEoGQ19CjZlkh7WxeaVwCAz28p
 jWKdKCud1vIGdlk8dkZrsUb3J0wxq7zOmvjp3zlEi5cqXfT1VHA+RTg+09I2E2Nagl/YP4v942
 M/XNnchOr/KzXcMk0QQbimnjOW1YOFtY8O/LWhkpkcv3MFDXZgCa9g45NqZavLCg0M1J9O+Oca
 PqYPxtbrhUM53qg9aS0n9/CPEbXIGmxy+YbgQ+3gki3UzU4z2hAJlS0Z40p15WAbiBgwkqY7fv
 fL9LQ4Iuh2gfLFtLwoL+G+KS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 23:40:33 -0800
IronPort-SDR: zHGdOyH49xEDPAyryDjk6J8wNf4zcvQ/3dvZOTecNYboNKLi/rVUePtPUFtEU0sIWz+tGDCee3
 lrPcUbgYIeVhZ8VYI/Ac3KFBryKG/WPiQCiEDYd+hqhXgmTVEDbHt7iu25euAv7o8yIVxDPK7W
 /Xyx7PgZhhW5FJRwEMHVwuqT6ICkLVC+5d87mi3EitsAhiwmztav4a9oCHAT+XfHG7n/xCgvJI
 V18uGbQ8mHThXnfYSbCYKes2mbYrtL/EaBbF6QwhQMTJGEyt+3JuKAllmyCPt4ebZndQ/J0CYD
 cLY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2022 00:09:16 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection
Date:   Tue,  8 Mar 2022 17:09:15 +0900
Message-Id: <20220308080915.3473689-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
q_usage_counter") moved blk_mq_attempt_bio_merge and rq_qos_throttle
calls out of q_usage_counter protection. However, these functions require
q_usage_counter protection. The blk_mq_attempt_bio_merge call without
the protection resulted in blktests block/005 failure with KASAN null-
ptr-deref or use-after-free at bio merge. The rq_qos_throttle call
without the protection caused kernel hang at qos throttle.

To fix the failures, move the blk_mq_attempt_bio_merge and
rq_qos_throttle calls back to q_usage_counter protection.

Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 block/blk-mq.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d69ca91fbc8b..9a9185a0a2d1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2718,7 +2718,8 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
-					       struct bio *bio)
+					       struct bio *bio,
+					       unsigned int nsegs)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
@@ -2730,6 +2731,11 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
 
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+		goto queue_exit;
+
+	rq_qos_throttle(q, bio);
+
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
 		plug->nr_ios = 1;
@@ -2742,12 +2748,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
+queue_exit:
 	blk_queue_exit(q);
 	return NULL;
 }
 
 static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio *bio)
+		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
 {
 	struct request *rq;
 
@@ -2757,12 +2764,19 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	if (!rq || rq->q != q)
 		return NULL;
 
-	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
+	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
+		*bio = NULL;
+		return NULL;
+	}
+
+	rq_qos_throttle(q, *bio);
+
+	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
 		return NULL;
 
-	rq->cmd_flags = bio->bi_opf;
+	rq->cmd_flags = (*bio)->bi_opf;
 	plug->cached_rq = rq_list_next(rq);
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
@@ -2800,14 +2814,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
-		return;
-
-	rq_qos_throttle(q, bio);
-
-	rq = blk_mq_get_cached_request(q, plug, bio);
+	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
-		rq = blk_mq_get_new_requests(q, plug, bio);
+		if (!bio)
+			return;
+		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
 			return;
 	}
-- 
2.34.1

