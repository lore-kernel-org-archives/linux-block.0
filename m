Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85833C4332F
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6A0610C8
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhJFRd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 089932256E;
        Wed,  6 Oct 2021 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1+iBGtWdd4cv2WUeSuSUAx2YoUEbTzBZFGF9Ks1J0c=;
        b=znkHKpBtbOOhl4kGLL35Hk/IvLFpYyuO8oit1nANxBhBmIWNm9kynCtAaXdZZO16NoOenr
        8fAtG+zed0fMwoVHLjgfyg62LbLYcCSBK5SJ7xSbrvPk1rwtrlPPO05aUPHh5kUrx+dkqS
        +1Vqjg/sCINBbO1E8WoZCdqa3abiJUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1+iBGtWdd4cv2WUeSuSUAx2YoUEbTzBZFGF9Ks1J0c=;
        b=7Jl67OR3UPd0Z76rtVP6AiUTd3RArXTZAwv97UBzRO7rXKTcCzFuvmEDzL5TuxktPRRIfS
        jxGVZahIA4lFOTAg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E8F5FA3B8F;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E0AC1F2CA2; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] bfq: Limit waker detection in time
Date:   Wed,  6 Oct 2021 19:31:44 +0200
Message-Id: <20211006173157.6906-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5540; h=from:subject; bh=0R6Ye5qtwSa+uxam/6Tko8iyfbFlRl6KbpDDzt7xH5w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd2A4zUhdC9dUSqYN1CT3H7+Op1+ZUt9mR7ISjmt cMs8wUKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dgAAKCRCcnaoHP2RA2c4HB/ 978x9IbeatAQaiGo+hgsU1+PLN5p8EaeJwe4NJgnQIlFa3WehAZZRGKWbWY8s0TBHsR7lQ0MlFu6zm J7CI6h0mW6ND82kD97xy3StNWmHhy6bxISRGTUPZVAfa14fk1u32bCwxHssywITa0fwW6QPVPIUEDC grJQb4vgANx2dYMWTWhiI5gfqVK82FV+OSwHk8gg3vfwanpQnS7l5RJazcdbpkBezr0gn49BzY3SX4 PJXJC1beQcF24/HAo1NtOgVdVBQx1XwQHkFg1FUNUGl8pFqE+AqLp/qau1foC0L5Wpst94g0PYhxTe Pg8GMrIvX0Xwd7vdTMB3t8GPYB3IaL
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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 38 +++++++++++++++++++++++---------------
 block/bfq-iosched.h |  2 ++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3806409610ca..6c5e9bafdb5d 100644
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

