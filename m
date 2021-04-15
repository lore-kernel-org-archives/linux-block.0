Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3945C433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 03:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7756A6113B
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 03:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbhDODsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 23:48:12 -0400
Received: from mail.wangsu.com ([123.103.51.227]:42184 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhDODsM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 23:48:12 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 23:48:11 EDT
Received: from fedora33.wangsu.com (unknown [183.253.10.81])
        by app2 (Coremail) with SMTP id 4zNnewAHX5B1tXdgWAwCAA--.5503S2;
        Thu, 15 Apr 2021 11:39:45 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com, linf@wangsu.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: bypass IO scheduler's limit_depth for passthrough request
Date:   Thu, 15 Apr 2021 11:39:20 +0800
Message-Id: <20210415033920.213963-1-linf@wangsu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewAHX5B1tXdgWAwCAA--.5503S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4UCF45KF17AF18WFy7Awb_yoW8tF1fpF
        WDAFs5CFW8XF1xKFn7t3W3uw18Xw43ury7JFW5Kr1rA3s5KFsFgr95Xr40qryfAws3KFWU
        Jrs8J3s8ur1j93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVW8
        Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjfUcLZ2DUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 01e99aeca39796003 ("blk-mq: insert passthrough request into
hctx->dispatch directly") gives high priority to passthrough requests and
bypass underlying IO scheduler. But as we allocate tag for such request it
still runs io-scheduler's callback limit_depth, while we really want is to
give full sbitmap-depth capabity to such request for acquiring available
tag.
blktrace shows PC requests(dmraid -s -c -i) hit bfq's limit_depth:
  8,0    2        0     0.000000000 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
  8,0    2        1     0.000008134 39952  D   R 4 [dmraid]
  8,0    2        2     0.000021538    24  C   R [0]
  8,0    2        0     0.000035442 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
  8,0    2        3     0.000038813 39952  D   R 24 [dmraid]
  8,0    2        4     0.000044356    24  C   R [0]

This patch introduce a new wrapper to make code not that ugly.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blkdev.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..927189a55575 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -361,11 +361,12 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 
 	if (e) {
 		/*
-		 * Flush requests are special and go directly to the
+		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
 		 * limiting, as it isn't useful.
 		 */
 		if (!op_is_flush(data->cmd_flags) &&
+		    !blk_op_is_passthrough(data->cmd_flags) &&
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 158aefae1030..0d81eed39833 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -272,6 +272,12 @@ static inline bool bio_is_passthrough(struct bio *bio)
 	return blk_op_is_scsi(op) || blk_op_is_private(op);
 }
 
+static inline bool blk_op_is_passthrough(unsigned int op)
+{
+	return (blk_op_is_scsi(op & REQ_OP_MASK) ||
+			blk_op_is_private(op & REQ_OP_MASK));
+}
+
 static inline unsigned short req_get_ioprio(struct request *req)
 {
 	return req->ioprio;
-- 
2.30.2

