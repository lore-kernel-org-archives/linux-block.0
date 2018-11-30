Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6AC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8151520863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8151520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeLAJdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4143281F0E;
        Fri, 30 Nov 2018 22:22:36 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E04360C67;
        Fri, 30 Nov 2018 22:22:33 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 2/6] dm rq: leverage blk_mq_queue_busy() to check for outstanding IO
Date:   Fri, 30 Nov 2018 17:22:22 -0500
Message-Id: <20181130222226.77216-3-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 30 Nov 2018 22:22:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that request-based dm-multipath only supports blk-mq, make use of
the newly introduced blk_mq_queue_busy() to check for outstanding IO --
rather than (ab)using the block core's in_flight counters.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-rq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1f1fe9a618ea..d2397d8fcbd1 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -130,11 +130,11 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
  */
 static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
 {
-	atomic_dec(&md->pending[rw]);
-
 	/* nudge anyone waiting on suspend queue */
-	if (!md_in_flight(md))
-		wake_up(&md->wait);
+	if (unlikely(waitqueue_active(&md->wait))) {
+		if (!blk_mq_queue_busy(md->queue))
+			wake_up(&md->wait);
+	}
 
 	/*
 	 * dm_put() must be at the end of this function. See the comment above
@@ -436,7 +436,6 @@ ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
 static void dm_start_request(struct mapped_device *md, struct request *orig)
 {
 	blk_mq_start_request(orig);
-	atomic_inc(&md->pending[rq_data_dir(orig)]);
 
 	if (unlikely(dm_stats_used(&md->stats))) {
 		struct dm_rq_target_io *tio = tio_from_request(orig);
-- 
2.15.0

