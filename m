Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAABC05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 12:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBIM40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 07:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBIM4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 07:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1BE387
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675947337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CM/sfV6oyjxgc/nsENOBqYgNwXyA5JtEoGtl95uTz0w=;
        b=KMN+B2+syOGD5CVwgzhIkPFU7TotvLjLe7TbEqwNLgi7f84s71CG4MnmgOUmETAdUKm0yz
        qKZL7Wpe7fM6QhDijWgBJUY8So0HP0+otMJnINo377mOLJFi5hTNJ64Jem+ivUj6+6RY13
        ACMdzyCWkfuZAbRwL8ya8i9NxtneeyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-eCKB3U0BNMWtCGj7Bs6KzQ-1; Thu, 09 Feb 2023 07:55:36 -0500
X-MC-Unique: eCKB3U0BNMWtCGj7Bs6KzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E3B4802314;
        Thu,  9 Feb 2023 12:55:36 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 397462026D4B;
        Thu,  9 Feb 2023 12:55:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] block: sync mixed merged request's failfast with 1st bio's
Date:   Thu,  9 Feb 2023 20:55:27 +0800
Message-Id: <20230209125527.667004-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We support mixed merge for requests/bios with different fastfail
settings. When request fails, each time we only handle the portion
with same failfast setting, then bios with failfast can be failed
immediately, and bios without failfast can be retried.

The idea is pretty good, but the current implementation has several
defects:

1) initially RA bio doesn't set failfast, however bio merge code
doesn't consider this point, and just check its failfast setting for
deciding if mixed merge is required. Fix this issue by adding helper
of bio_failfast().

2) when merging bio to request front, if this request is mixed
merged, we have to sync request's faifast setting with 1st bio's
failfast. Fix it by calling blk_update_mixed_merge().

3) when merging bio to request back, if this request is mixed
merged, we have to mark the bio as failfast, because blk_update_request
simply updates request failfast with 1st bio's failfast. Fix
it by calling blk_update_mixed_merge().

Fixes one normal EXT4 READ IO failure issue, because it is observed
that the normal READ IO is merged with RA IO, and the mixed merged
request has different failfast setting with 1st bio's, so finally
the normal READ IO doesn't get retried.

Cc: Tejun Heo <tj@kernel.org>
Fixes: 80a761fd33cf ("block: implement mixed merge of different failfast requests")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b7c193d67185..30e4a99c2276 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -757,6 +757,33 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	rq->rq_flags |= RQF_MIXED_MERGE;
 }
 
+static inline unsigned int bio_failfast(const struct bio *bio)
+{
+	if (bio->bi_opf & REQ_RAHEAD)
+		return REQ_FAILFAST_MASK;
+
+	return bio->bi_opf & REQ_FAILFAST_MASK;
+}
+
+/*
+ * After we are marked as MIXED_MERGE, any new RA bio has to be updated
+ * as failfast, and request's failfast has to be updated in case of
+ * front merge.
+ */
+static inline void blk_update_mixed_merge(struct request *req,
+		struct bio *bio, bool front_merge)
+{
+	if (req->rq_flags & RQF_MIXED_MERGE) {
+		if (bio->bi_opf & REQ_RAHEAD)
+			bio->bi_opf |= REQ_FAILFAST_MASK;
+
+		if (front_merge) {
+			req->cmd_flags &= ~REQ_FAILFAST_MASK;
+			req->cmd_flags |= bio->bi_opf & REQ_FAILFAST_MASK;
+		}
+	}
+}
+
 static void blk_account_io_merge_request(struct request *req)
 {
 	if (blk_do_io_stat(req)) {
@@ -954,7 +981,7 @@ enum bio_merge_status {
 static enum bio_merge_status bio_attempt_back_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
-	const blk_opf_t ff = bio->bi_opf & REQ_FAILFAST_MASK;
+	const blk_opf_t ff = bio_failfast(bio);
 
 	if (!ll_back_merge_fn(req, bio, nr_segs))
 		return BIO_MERGE_FAILED;
@@ -965,6 +992,8 @@ static enum bio_merge_status bio_attempt_back_merge(struct request *req,
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
 
+	blk_update_mixed_merge(req, bio, false);
+
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
@@ -978,7 +1007,7 @@ static enum bio_merge_status bio_attempt_back_merge(struct request *req,
 static enum bio_merge_status bio_attempt_front_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
-	const blk_opf_t ff = bio->bi_opf & REQ_FAILFAST_MASK;
+	const blk_opf_t ff = bio_failfast(bio);
 
 	if (!ll_front_merge_fn(req, bio, nr_segs))
 		return BIO_MERGE_FAILED;
@@ -989,6 +1018,8 @@ static enum bio_merge_status bio_attempt_front_merge(struct request *req,
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
 
+	blk_update_mixed_merge(req, bio, true);
+
 	bio->bi_next = req->bio;
 	req->bio = bio;
 
-- 
2.31.1

