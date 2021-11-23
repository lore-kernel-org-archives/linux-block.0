Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3DC43219
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhKWKfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49846 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B2253218D9;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BH7S/OpH+gkhMsrqND9Xt/TftQRsgfuZzb4OF6N9Mzc=;
        b=KsCzrLjJRLsM15i2TXuuyH0hllw6Pb/0unHLmDpTm6EycMd/Vy0hm59Kv7GMGlYXbtMuFt
        PJRDDkmh9P9pLBJw/oHRebderaDkUhTqehItTgSxKe5/xygCNa0OPXyWmA+B5hZiR6zntl
        9W8S7yCanKwTjzUIzhZZu2m66rcZp0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BH7S/OpH+gkhMsrqND9Xt/TftQRsgfuZzb4OF6N9Mzc=;
        b=m1By3R5Xi6g86VDl/knmdpiVoTe/lKPSDYGMHhXFnk4dZjwfD3mjtu/Kzk3JCHGsHLLjnZ
        ftNUpvC5U93EfbAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A2AEEA3B8A;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 720F51E37A2; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] bfq: Limit waker detection in time
Date:   Tue, 23 Nov 2021 11:29:17 +0100
Message-Id: <20211123103158.17284-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5592; h=from:subject; bh=+TxTo74N+Fa0vjyIwPePiBNaNXYsNQXaNsWpa1qw9Co=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ8kMMwsCxBGiOdvWCx7HlKkh/OT4xt7JWvdKhj /Xmr6xSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCfAAKCRCcnaoHP2RA2ZthB/ 9MH8CCaaL5AKGRpexkCTs3yCxjZmMEhcACaQfMAk9tEI3sop+Y2p7bnm3atP2vf9BX8Lc5cB55K7YD NKOCD9ijfX4JsvbURAweqdQLAHcfEMsA9CaP7sIf87ZBoEB8oQWMZHiR/SxuTOCWY+J5ogYvHSisPF ge5fxG33ApHtBoVQ150WMRjYpzetzTSYlgud0IIoOfxbcfou8GiKC2l57NdWlYgyxgDAgq/pluO2H6 lsWg2WUVVSy0ECthRHbBUDi7ZLbJs8TOPuCWCjmJ0w/Bu9I9CMEb5jQoo+fzNgpX2SRCiMgSyEOHEO S/KLvI+4tylls8tJNGyF0i83vIvdiN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, when process A starts issuing requests shortly after process
B has completed some IO three times in a row, we decide that B is a
"waker" of A meaning that completing IO of B is needed for A to make
progress and generally stop separating A's and B's IO much. This logic
is useful to avoid unnecessary idling and thus throughput loss for cases
where workload needs to switch e.g. between the process and the
journaling thread doing IO. However the detection heuristic tends to
frequently give false positives when A and B are fighting IO bandwidth
and other processes aren't doing much IO as we are basically deemed to
eventually accumulate three occurences of a situation where one process
starts issuing requests after the other has completed some IO. To reduce
these false positives, cancel the waker detection also if we didn't
accumulate three detected wakeups within given timeout. The rationale is
that if wakeups are really rare, the pointless idling doesn't hurt
throughput that much anyway.

This significantly reduces false waker detection for workload like:

[global]
directory=/mnt/repro/
rw=write
size=8g
time_based
runtime=30
ramp_time=10
blocksize=1m
direct=0
ioengine=sync

[slowwriter]
numjobs=1
fsync=200

[fastwriter]
numjobs=1
fsync=200

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 38 +++++++++++++++++++++++---------------
 block/bfq-iosched.h |  2 ++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 36ee407cebc6..73eab70cefdb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2091,20 +2091,19 @@ static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
  * aspect, see the comments on the choice of the queue for injection
  * in bfq_select_queue().
  *
- * Turning back to the detection of a waker queue, a queue Q is deemed
- * as a waker queue for bfqq if, for three consecutive times, bfqq
- * happens to become non empty right after a request of Q has been
- * completed. In this respect, even if bfqq is empty, we do not check
- * for a waker if it still has some in-flight I/O. In fact, in this
- * case bfqq is actually still being served by the drive, and may
- * receive new I/O on the completion of some of the in-flight
- * requests. In particular, on the first time, Q is tentatively set as
- * a candidate waker queue, while on the third consecutive time that Q
- * is detected, the field waker_bfqq is set to Q, to confirm that Q is
- * a waker queue for bfqq. These detection steps are performed only if
- * bfqq has a long think time, so as to make it more likely that
- * bfqq's I/O is actually being blocked by a synchronization. This
- * last filter, plus the above three-times requirement, make false
+ * Turning back to the detection of a waker queue, a queue Q is deemed as a
+ * waker queue for bfqq if, for three consecutive times, bfqq happens to become
+ * non empty right after a request of Q has been completed within given
+ * timeout. In this respect, even if bfqq is empty, we do not check for a waker
+ * if it still has some in-flight I/O. In fact, in this case bfqq is actually
+ * still being served by the drive, and may receive new I/O on the completion
+ * of some of the in-flight requests. In particular, on the first time, Q is
+ * tentatively set as a candidate waker queue, while on the third consecutive
+ * time that Q is detected, the field waker_bfqq is set to Q, to confirm that Q
+ * is a waker queue for bfqq. These detection steps are performed only if bfqq
+ * has a long think time, so as to make it more likely that bfqq's I/O is
+ * actually being blocked by a synchronization. This last filter, plus the
+ * above three-times requirement and time limit for detection, make false
  * positives less likely.
  *
  * NOTE
@@ -2136,8 +2135,16 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
 		return;
 
+	/*
+	 * We reset waker detection logic also if too much time has passed
+ 	 * since the first detection. If wakeups are rare, pointless idling
+	 * doesn't hurt throughput that much. The condition below makes sure
+	 * we do not uselessly idle blocking waker in more than 1/64 cases. 
+	 */
 	if (bfqd->last_completed_rq_bfqq !=
-	    bfqq->tentative_waker_bfqq) {
+	    bfqq->tentative_waker_bfqq ||
+	    now_ns > bfqq->waker_detection_started +
+					128 * (u64)bfqd->bfq_slice_idle) {
 		/*
 		 * First synchronization detected with a
 		 * candidate waker queue, or with a different
@@ -2146,6 +2153,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfqq->tentative_waker_bfqq =
 			bfqd->last_completed_rq_bfqq;
 		bfqq->num_waker_detections = 1;
+		bfqq->waker_detection_started = now_ns;
 	} else /* Same tentative waker queue detected again */
 		bfqq->num_waker_detections++;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 820cb8c2d1fe..bb8180c52a31 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -388,6 +388,8 @@ struct bfq_queue {
 	struct bfq_queue *tentative_waker_bfqq;
 	/* number of times the same tentative waker has been detected */
 	unsigned int num_waker_detections;
+	/* time when we started considering this waker */
+	u64 waker_detection_started;
 
 	/* node for woken_list, see below */
 	struct hlist_node woken_list_node;
-- 
2.26.2

