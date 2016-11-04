Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752892AbcKDAD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Nov 2016 20:03:58 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA401Jrx013077
        for <linux-block@vger.kernel.org>; Thu, 3 Nov 2016 17:03:57 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 26g4uex57w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2016 17:03:57 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.222.219.45) with ESMTP id
 2d5d4f92a22211e6aa3d24be05904660-c1ff8a50 for <linux-block@vger.kernel.org>;
        Thu, 03 Nov 2016 17:03:55 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>
Subject: [PATCH V2 2/2] blk-mq: immediately dispatch big size request
Date: Thu, 3 Nov 2016 17:03:54 -0700
Message-ID: <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
In-Reply-To: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
References: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
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
index f3d27a6..a72538a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1401,13 +1401,18 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	 */
 	plug = current->plug;
 	if (plug) {
+		struct request *last = NULL;
+
 		blk_mq_bio_to_request(rq, bio);
 		if (!request_count)
 			trace_block_plug(q);
+		else
+			last = list_entry_rq(plug->mq_list.prev);
 
 		blk_mq_put_ctx(data.ctx);
 
-		if (request_count >= BLK_MAX_REQUEST_COUNT) {
+		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
+		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
 			blk_flush_plug_list(plug, false);
 			trace_block_plug(q);
 		}
-- 
2.9.3

