Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D61C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654DE20673
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4BDLNKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfFXTlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:41:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50194 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfFXTlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so502283wmf.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIrEF7fqiupFIjD7AQLk7kwooWZ2ci8TyHX3uP5+Vdg=;
        b=T4BDLNKF6YXrrP3MVBJ+/3PIHBdQ84edc6MwZfSBXner3JGB43FRyGDN9aStuNm3g6
         ww3etrDOHkB2aBfCEZ9wejjBdGtQRmEJ4tu3kl6JCgrwURon4NtoOXwuDK1e5bG1RKe5
         0qzy2Nds/sNVO5RyiwzAp66e7jQbuyErF3M6K00B9ZQbwSDcMFC2EhztLwMLELzgBNe0
         ibM0urf5jU+gj3I4lGNXhLlThqPCEWr8BMG+aVSYqkap+VvnPFdfiK3Kb6zWhxxF23y8
         EfrR75gmwwZaaLyITaAZy1spIrIVA3sf3BoGrph8ltbq+S3avz+t3Lndiy76GdRvlPhC
         vKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIrEF7fqiupFIjD7AQLk7kwooWZ2ci8TyHX3uP5+Vdg=;
        b=QTEKXTuoWX1G6rBZ0qv5fIM2Z7m52FvBGs3QCjvNMrmi3Oo2INIG/kCGuQt8klKsED
         m5ilFko+0gy8UaLy8dQICg5k72Uka4BFZFesK992UoXAVqn19vjtOq9u6AJoyrKyueHd
         BvLRVZpk4OC36mVKVcLG4swD6JP/G8YiMVIeZXSLmytQirdtHu2Xzqgl6ccLp6yhUrK2
         1xoOowxTztDCFSz4ZQ9Khs8RFv5MuHFmxKVPG4vgF9CscRdsH+vBH1HKFG2WQd33XTqz
         lBVqTSdF/M459HeC616cv59PSj+cv2sjTMSfq4EdwPGTh89S5eUclxAX4URQ7K567CJG
         C6cg==
X-Gm-Message-State: APjAAAUjdldTGp+w2rf0FkFs1iEFs4TyqALwdcTI4p6X72t0n36DOTLx
        /7D4EAJjTcvrbbQkP8OCQ6ecNg==
X-Google-Smtp-Source: APXvYqyX1Rn2HL50hIj4D0Zht9T0R92lzP9hKcP2XndfQlyRHis1sbQaguVOCWncbGUEfV3LaEJuxA==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr17917503wme.94.1561405266374;
        Mon, 24 Jun 2019 12:41:06 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:05 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 1/7] block, bfq: reset inject limit when think-time state changes
Date:   Mon, 24 Jun 2019 21:40:36 +0200
Message-Id: <20190624194042.38747-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Until the base value of the request service times gets finally
computed for a bfq_queue, the inject limit does depend on the
think-time state (short|long). The limit must be 0 or 1 if the think
time is deemed, respectively, as short or long. However, such a check
and possible limit update is performed only periodically, once per
second. So, to make the injection mechanism much more reactive, this
commit performs the update also every time the think-time state
changes.

In addition, in the following special case, this commit lets the
inject limit of a bfq_queue bfqq remain equal to 1 even if bfqq's
think time is short: bfqq's I/O is synchronized with that of some
other queue, i.e., bfqq may receive new I/O only after the I/O of the
other queue is completed. Keeping the inject limit to 1 allows the
blocking I/O to be served while bfqq is in service. And this is very
convenient both for bfqq and for the total throughput, as explained
in detail in the comments in bfq_update_has_short_ttime().

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 219 ++++++++++++++++++++++++++++++--------------
 1 file changed, 151 insertions(+), 68 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 44c6bbcd7720..9bc10198ddff 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1735,6 +1735,72 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 				false, BFQQE_PREEMPTED);
 }
 
+static void bfq_reset_inject_limit(struct bfq_data *bfqd,
+				   struct bfq_queue *bfqq)
+{
+	/* invalidate baseline total service time */
+	bfqq->last_serv_time_ns = 0;
+
+	/*
+	 * Reset pointer in case we are waiting for
+	 * some request completion.
+	 */
+	bfqd->waited_rq = NULL;
+
+	/*
+	 * If bfqq has a short think time, then start by setting the
+	 * inject limit to 0 prudentially, because the service time of
+	 * an injected I/O request may be higher than the think time
+	 * of bfqq, and therefore, if one request was injected when
+	 * bfqq remains empty, this injected request might delay the
+	 * service of the next I/O request for bfqq significantly. In
+	 * case bfqq can actually tolerate some injection, then the
+	 * adaptive update will however raise the limit soon. This
+	 * lucky circumstance holds exactly because bfqq has a short
+	 * think time, and thus, after remaining empty, is likely to
+	 * get new I/O enqueued---and then completed---before being
+	 * expired. This is the very pattern that gives the
+	 * limit-update algorithm the chance to measure the effect of
+	 * injection on request service times, and then to update the
+	 * limit accordingly.
+	 *
+	 * However, in the following special case, the inject limit is
+	 * left to 1 even if the think time is short: bfqq's I/O is
+	 * synchronized with that of some other queue, i.e., bfqq may
+	 * receive new I/O only after the I/O of the other queue is
+	 * completed. Keeping the inject limit to 1 allows the
+	 * blocking I/O to be served while bfqq is in service. And
+	 * this is very convenient both for bfqq and for overall
+	 * throughput, as explained in detail in the comments in
+	 * bfq_update_has_short_ttime().
+	 *
+	 * On the opposite end, if bfqq has a long think time, then
+	 * start directly by 1, because:
+	 * a) on the bright side, keeping at most one request in
+	 * service in the drive is unlikely to cause any harm to the
+	 * latency of bfqq's requests, as the service time of a single
+	 * request is likely to be lower than the think time of bfqq;
+	 * b) on the downside, after becoming empty, bfqq is likely to
+	 * expire before getting its next request. With this request
+	 * arrival pattern, it is very hard to sample total service
+	 * times and update the inject limit accordingly (see comments
+	 * on bfq_update_inject_limit()). So the limit is likely to be
+	 * never, or at least seldom, updated.  As a consequence, by
+	 * setting the limit to 1, we avoid that no injection ever
+	 * occurs with bfqq. On the downside, this proactive step
+	 * further reduces chances to actually compute the baseline
+	 * total service time. Thus it reduces chances to execute the
+	 * limit-update algorithm and possibly raise the limit to more
+	 * than 1.
+	 */
+	if (bfq_bfqq_has_short_ttime(bfqq))
+		bfqq->inject_limit = 0;
+	else
+		bfqq->inject_limit = 1;
+
+	bfqq->decrease_time_jif = jiffies;
+}
+
 static void bfq_add_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
@@ -1755,71 +1821,8 @@ static void bfq_add_request(struct request *rq)
 		 * bfq_update_inject_limit().
 		 */
 		if (time_is_before_eq_jiffies(bfqq->decrease_time_jif +
-					     msecs_to_jiffies(1000))) {
-			/* invalidate baseline total service time */
-			bfqq->last_serv_time_ns = 0;
-
-			/*
-			 * Reset pointer in case we are waiting for
-			 * some request completion.
-			 */
-			bfqd->waited_rq = NULL;
-
-			/*
-			 * If bfqq has a short think time, then start
-			 * by setting the inject limit to 0
-			 * prudentially, because the service time of
-			 * an injected I/O request may be higher than
-			 * the think time of bfqq, and therefore, if
-			 * one request was injected when bfqq remains
-			 * empty, this injected request might delay
-			 * the service of the next I/O request for
-			 * bfqq significantly. In case bfqq can
-			 * actually tolerate some injection, then the
-			 * adaptive update will however raise the
-			 * limit soon. This lucky circumstance holds
-			 * exactly because bfqq has a short think
-			 * time, and thus, after remaining empty, is
-			 * likely to get new I/O enqueued---and then
-			 * completed---before being expired. This is
-			 * the very pattern that gives the
-			 * limit-update algorithm the chance to
-			 * measure the effect of injection on request
-			 * service times, and then to update the limit
-			 * accordingly.
-			 *
-			 * On the opposite end, if bfqq has a long
-			 * think time, then start directly by 1,
-			 * because:
-			 * a) on the bright side, keeping at most one
-			 * request in service in the drive is unlikely
-			 * to cause any harm to the latency of bfqq's
-			 * requests, as the service time of a single
-			 * request is likely to be lower than the
-			 * think time of bfqq;
-			 * b) on the downside, after becoming empty,
-			 * bfqq is likely to expire before getting its
-			 * next request. With this request arrival
-			 * pattern, it is very hard to sample total
-			 * service times and update the inject limit
-			 * accordingly (see comments on
-			 * bfq_update_inject_limit()). So the limit is
-			 * likely to be never, or at least seldom,
-			 * updated.  As a consequence, by setting the
-			 * limit to 1, we avoid that no injection ever
-			 * occurs with bfqq. On the downside, this
-			 * proactive step further reduces chances to
-			 * actually compute the baseline total service
-			 * time. Thus it reduces chances to execute the
-			 * limit-update algorithm and possibly raise the
-			 * limit to more than 1.
-			 */
-			if (bfq_bfqq_has_short_ttime(bfqq))
-				bfqq->inject_limit = 0;
-			else
-				bfqq->inject_limit = 1;
-			bfqq->decrease_time_jif = jiffies;
-		}
+					     msecs_to_jiffies(1000)))
+			bfq_reset_inject_limit(bfqd, bfqq);
 
 		/*
 		 * The following conditions must hold to setup a new
@@ -4855,7 +4858,7 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 				       struct bfq_queue *bfqq,
 				       struct bfq_io_cq *bic)
 {
-	bool has_short_ttime = true;
+	bool has_short_ttime = true, state_changed;
 
 	/*
 	 * No need to update has_short_ttime if bfqq is async or in
@@ -4880,13 +4883,93 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 	     bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle))
 		has_short_ttime = false;
 
-	bfq_log_bfqq(bfqd, bfqq, "update_has_short_ttime: has_short_ttime %d",
-		     has_short_ttime);
+	state_changed = has_short_ttime != bfq_bfqq_has_short_ttime(bfqq);
 
 	if (has_short_ttime)
 		bfq_mark_bfqq_has_short_ttime(bfqq);
 	else
 		bfq_clear_bfqq_has_short_ttime(bfqq);
+
+	/*
+	 * Until the base value for the total service time gets
+	 * finally computed for bfqq, the inject limit does depend on
+	 * the think-time state (short|long). In particular, the limit
+	 * is 0 or 1 if the think time is deemed, respectively, as
+	 * short or long (details in the comments in
+	 * bfq_update_inject_limit()). Accordingly, the next
+	 * instructions reset the inject limit if the think-time state
+	 * has changed and the above base value is still to be
+	 * computed.
+	 *
+	 * However, the reset is performed only if more than 100 ms
+	 * have elapsed since the last update of the inject limit, or
+	 * (inclusive) if the change is from short to long think
+	 * time. The reason for this waiting is as follows.
+	 *
+	 * bfqq may have a long think time because of a
+	 * synchronization with some other queue, i.e., because the
+	 * I/O of some other queue may need to be completed for bfqq
+	 * to receive new I/O. This happens, e.g., if bfqq is
+	 * associated with a process that does some sync. A sync
+	 * generates extra blocking I/O, which must be completed
+	 * before the process associated with bfqq can go on with its
+	 * I/O.
+	 *
+	 * If such a synchronization is actually in place, then,
+	 * without injection on bfqq, the blocking I/O cannot happen
+	 * to served while bfqq is in service. As a consequence, if
+	 * bfqq is granted I/O-dispatch-plugging, then bfqq remains
+	 * empty, and no I/O is dispatched, until the idle timeout
+	 * fires. This is likely to result in lower bandwidth and
+	 * higher latencies for bfqq, and in a severe loss of total
+	 * throughput.
+	 *
+	 * On the opposite end, a non-zero inject limit may allow the
+	 * I/O that blocks bfqq to be executed soon, and therefore
+	 * bfqq to receive new I/O soon. But, if this actually
+	 * happens, then the next think-time sample for bfqq may be
+	 * very low. This in turn may cause bfqq's think time to be
+	 * deemed short. Without the 100 ms barrier, this new state
+	 * change would cause the body of the next if to be executed
+	 * immediately. But this would set to 0 the inject
+	 * limit. Without injection, the blocking I/O would cause the
+	 * think time of bfqq to become long again, and therefore the
+	 * inject limit to be raised again, and so on. The only effect
+	 * of such a steady oscillation between the two think-time
+	 * states would be to prevent effective injection on bfqq.
+	 *
+	 * In contrast, if the inject limit is not reset during such a
+	 * long time interval as 100 ms, then the number of short
+	 * think time samples can grow significantly before the reset
+	 * is allowed. As a consequence, the think time state can
+	 * become stable before the reset. There will be no state
+	 * change when the 100 ms elapse, and therefore no reset of
+	 * the inject limit. The inject limit remains steadily equal
+	 * to 1 both during and after the 100 ms. So injection can be
+	 * performed at all times, and throughput gets boosted.
+	 *
+	 * An inject limit equal to 1 is however in conflict, in
+	 * general, with the fact that the think time of bfqq is
+	 * short, because injection may be likely to delay bfqq's I/O
+	 * (as explained in the comments in
+	 * bfq_update_inject_limit()). But this does not happen in
+	 * this special case, because bfqq's low think time is due to
+	 * an effective handling of a synchronization, through
+	 * injection. In this special case, bfqq's I/O does not get
+	 * delayed by injection; on the contrary, bfqq's I/O is
+	 * brought forward, because it is not blocked for
+	 * milliseconds.
+	 *
+	 * In addition, during the 100 ms, the base value for the
+	 * total service time is likely to get finally computed,
+	 * freeing the inject limit from its relation with the think
+	 * time.
+	 */
+	if (state_changed && bfqq->last_serv_time_ns == 0 &&
+	    (time_is_before_eq_jiffies(bfqq->decrease_time_jif +
+				      msecs_to_jiffies(100)) ||
+	     !has_short_ttime))
+		bfq_reset_inject_limit(bfqd, bfqq);
 }
 
 /*
-- 
2.20.1

