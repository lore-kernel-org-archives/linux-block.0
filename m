Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F6C64EC7
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 00:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCAAHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAAHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 19:07:19 -0500
Received: from mail-oa1-x61.google.com (mail-oa1-x61.google.com [IPv6:2001:4860:4864:20::61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7DE2A6C2
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 16:07:17 -0800 (PST)
Received: by mail-oa1-x61.google.com with SMTP id 586e51a60fabf-1720433ba75so12754417fac.5
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 16:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOMQhF/sH9JXA0O/3+AXuQxVnIBs73dSZjVTlEU+U2Y=;
        b=WfwqX0VfYm63/bsSajmHVDKt0x6T4xjQ2JIxTqRbRitYqu5qqkT1WQ1Q+N8KZYe53E
         Er8ohR3y8Al6Ncc/U729Y9aAjNnhogYJj2HNC6xSusk8dXHlpZY7AOvpfGZIpLN4x4Ad
         D7eUcO6o4OPC6vsJ8MCPDCj9HhmSWUSrac7YtBDq4M1PwFo1eGwGLQRuLcY3suXlozmm
         eXvw54cr2vu8mJJwtaLeoLxfX8zapo9nmYA9NH9FrkOvif2EC/hlkqMxcoZmhTMJl2M2
         Kxtmdi05Twp6kXJtt2iyY2pBgXg3QIkEfj8C24A/BNccrl3Fx+22mY+gNp7oqocEkV0T
         Pyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOMQhF/sH9JXA0O/3+AXuQxVnIBs73dSZjVTlEU+U2Y=;
        b=U/P6o5PvYavcn6VrmSVLfEssyC6qS1LM8E8sMTp9rJMacrdw2N8AI9trKV9IWBy36G
         fAZDqtFnBnSwC/zHt+lO4gDeA4IwYt0WEOwmSW3FIJ3W7guv0DabukTXX6HC3q9MO+v2
         4DxxKphV3twJnoXPi/gCwXwLpNZ3X+1ioNJH9JrQ2JLtqhvIpix0qIDY0GCRIUcGhLT4
         uvc8LdfkCqyklfRIoWFrfu4/qSZY6UOvOALD19nTQhDXDh3dRJ+wY7IJTh4EjyDndjOh
         oDeg/brFir7nomCFayDgsjVGeST17qVQiEUk5gY7BWk+06YbbRSVIBOtvpCtGuDtmLIL
         RjYA==
X-Gm-Message-State: AO0yUKWKPJYIrdreIxhU98QyCbnMlsJAz18Wd/PukOoYahd71jPAMOBW
        RJzoeqoVnxL5Uk3oxOZdTVPVdBp4BA8J7hUM0ilF2CoZRI8nWoDWW6fOpPJkJ5gsgQ==
X-Google-Smtp-Source: AK7set83EGGEx4Gtvz8XTLvtgE3w2Y6/DJ78cVT0IPvfAU2EunoiFrSo2mkWCWfJ5m1B6SfYuwyFaebXUk7m
X-Received: by 2002:a05:6870:17aa:b0:172:4d65:d176 with SMTP id r42-20020a05687017aa00b001724d65d176mr2230426oae.11.1677629236781;
        Tue, 28 Feb 2023 16:07:16 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id z22-20020a05687042d600b001727c3968d1sm45584oah.38.2023.02.28.16.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 16:07:16 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev5.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 98152220F7;
        Tue, 28 Feb 2023 17:07:15 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 930C4E4021C; Tue, 28 Feb 2023 17:07:15 -0700 (MST)
From:   Uday Shankar <ushankar@purestorage.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Uday Shankar <ushankar@purestorage.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] blk-mq: enforce op-specific segment limits in blk_insert_cloned_request
Date:   Tue, 28 Feb 2023 17:06:55 -0700
Message-Id: <20230301000655.48112-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer might merge together discard requests up until the
max_discard_segments limit is hit, but blk_insert_cloned_request checks
the segment count against max_segments regardless of the req op. This
can result in errors like the following when discards are issued through
a DM device and max_discard_segments exceeds max_segments for the queue
of the chosen underlying device.

blk_insert_cloned_request: over max segments limit. (256 > 129)

Fix this by looking at the req_op and enforcing the appropriate segment
limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
everything else.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes v1-v2:
- Fixed format specifier type mismatch
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302162040.FaI25ul2-lkp@intel.com/
Changes v2-v3:
- Refactor: move pre-existing blk_rq_get_max_segments to blk.h and use
  it instead of introducing a new function

 block/blk-merge.c | 7 -------
 block/blk-mq.c    | 7 ++++---
 block/blk.h       | 7 +++++++
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1ac782fdc..6460abdb2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -587,13 +587,6 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
 
-static inline unsigned int blk_rq_get_max_segments(struct request *rq)
-{
-	if (req_op(rq) == REQ_OP_DISCARD)
-		return queue_max_discard_segments(rq->q);
-	return queue_max_segments(rq->q);
-}
-
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d3494a796..d0cb2ef18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3000,6 +3000,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
 	if (blk_rq_sectors(rq) > max_sectors) {
@@ -3026,9 +3027,9 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	 * original queue.
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
-	if (rq->nr_phys_segments > queue_max_segments(q)) {
-		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
-			__func__, rq->nr_phys_segments, queue_max_segments(q));
+	if (rq->nr_phys_segments > max_segments) {
+		printk(KERN_ERR "%s: over max segments limit. (%u > %u)\n",
+			__func__, rq->nr_phys_segments, max_segments);
 		return BLK_STS_IOERR;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index e835f21d4..cc4e8873d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -156,6 +156,13 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
+static inline unsigned int blk_rq_get_max_segments(struct request *rq)
+{
+	if (req_op(rq) == REQ_OP_DISCARD)
+		return queue_max_discard_segments(rq->q);
+	return queue_max_segments(rq->q);
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     enum req_op op)
 {

base-commit: bdc9c96cfce220e972136493f4c031f28ecb9f36
-- 
2.25.1

