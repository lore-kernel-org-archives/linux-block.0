Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46831 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756744AbcJ1Wwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 18:52:39 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9SMnhd3005336
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2016 15:52:38 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 26cbr42ba1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2016 15:52:38 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.236.87) with ESMTP id
 38fbbc789d6111e6b97e0002c9521c9e-f0ff6a50 for <linux-block@vger.kernel.org>;
        Fri, 28 Oct 2016 15:52:37 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>
Subject: [PATCH 2/2] blk-mq: immediately dispatch big size request
Date: Fri, 28 Oct 2016 15:52:36 -0700
Message-ID: <8896812b5cb9bd32e35e91d7f9aad4ccc368b2fc.1477694963.git.shli@fb.com>
In-Reply-To: <a42409a1a37e819e0497c091ab49461370b34989.1477694963.git.shli@fb.com>
References: <a42409a1a37e819e0497c091ab49461370b34989.1477694963.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is corresponding part for blk-mq. Disk with multiple hardware
queues doesn't need this as we only hold 1 request at most.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3d27a6..9612306 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1401,13 +1401,18 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	 */
 	plug = current->plug;
 	if (plug) {
+		struct request *first = NULL;
+
 		blk_mq_bio_to_request(rq, bio);
 		if (!request_count)
 			trace_block_plug(q);
+		else
+			first = list_entry_rq(plug->mq_list.next);
 
 		blk_mq_put_ctx(data.ctx);
 
-		if (request_count >= BLK_MAX_REQUEST_COUNT) {
+		if (request_count >= BLK_MAX_REQUEST_COUNT || (first &&
+		    blk_rq_bytes(first) >= BLK_PLUG_FLUSH_SIZE)) {
 			blk_flush_plug_list(plug, false);
 			trace_block_plug(q);
 		}
-- 
2.9.3

