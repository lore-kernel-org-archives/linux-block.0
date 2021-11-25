Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DE2C433FE
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355060AbhKYNmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355184AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4656E1FD3D;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYmlFBYL40DvStsHobyBun7mCuDBKQ/RWYQzs2sFqig=;
        b=2ubSAXqmlEn0ywMklyv4FE0IpZzKfuwwyj/HKPk5d00ofGCyPl7rky91eyz6bx61CbUG0y
        zp3z+FR1TxEXT9RrTtAYJEi2Kv8jPQgBHKwdc/TglctMtDbDqRdS2BFqWMSgp3IncDRvJQ
        RA2AnhZWtv/VZjbpYzALOo5QUeKRZes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYmlFBYL40DvStsHobyBun7mCuDBKQ/RWYQzs2sFqig=;
        b=3nKCaD39Nv+mUSonneNQ8oG7vwCEn3nnFr2yBylq3SIwadfOxtcNccyccHTeB6gs8sgjBi
        jPmLsyEu9tDhdYBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3B283A3B8F;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F42111F2CE5; Thu, 25 Nov 2021 14:36:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] bfq: Limit waker detection in time
Date:   Thu, 25 Nov 2021 14:36:38 +0100
Message-Id: <20211125133645.27483-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5592; h=from:subject; bh=PHyV+U6QDYRlvtvBP9xp6tMKx82XNhZs6vG2t+94tl8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5Fm7qPC668wGS1mN6XtUbqxZOUd+vsQeMuW3CO8 Q2ek9Q6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RZgAKCRCcnaoHP2RA2dXfCA CKfr4FSDhX5SrFR9UFRBw/fhH1K0kDDNeFsyMiewzcDrDQdDkc9XBExDBX43SOaGlvPGyNBUw7Z3Dt vUBzbthU5q3Fnl7ABz5nh5OgFwxOWA6jvf0R0viH3azBHFAy+SgV0N96N6OJdColNv1CpPeyvQINcP uESS1+BWJIvsGmSYcmtDihZNdKa6gojxjas/LhiUfDnjM8Uwd6Pn/llbUwpPv4UiFxuKa4lEuykPb1 hKS38MiIIq/pGzrM1Igy8XayB7f67qsahki5ZjmiNHgCyFbPy1zpglRGJ79wo4YMOgPC6fJSxATGpD lOtQUe/8b/ibiUQhKA6x6DZLnmMCjP
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
index 95a19d1fbedf..83a2225e407b 100644
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

