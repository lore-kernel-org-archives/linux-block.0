Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E1BC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499B2147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS0RXPUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCLJAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfCLJAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id g20so1662374wmh.5
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4uFtyzA18u5b8FpMac6NfiN9aYKDmVQAs2/t+LEouQ=;
        b=iS0RXPUBY1WOA6OUxZAMoN+2kbxJkGL3Hjr3CPiqg/6XmRhyCkplfWh2Mdf2I/dXX7
         zNmdB/ScIRo8GjCF/czzFwN4K6V+UCCeiSvxz+WyWD1az6KokzfCRSKT0NoNlCq2s53S
         hIEyeC8rOxD8od8zs2k6ADNGwbGJ0O1Gv7DXJ+KXeznNxcRyaixzDoFQqbFuF3HPE3ed
         q/L9BqpmSzzNUkifD/tpnUjuscSrCFbc6gRR2gHMPTCp4PtaslXe9pQE6TvXKzJSOx5K
         2xHUswb/EIZeP5FFOezsXVgiFgIfnLkPIn7UMypsxLLbLZyKvCWiLKYix3qxt2I/XzoZ
         mgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4uFtyzA18u5b8FpMac6NfiN9aYKDmVQAs2/t+LEouQ=;
        b=F8hITRNSv2zRM58WxQf82k7KFXDJZ8C5WrJSZreFkIPfCKP3IdHbhB8o1sTBUujeVi
         1Kun8LU7PNYxQ6gL2N6C/9nQgsjWcN6m2WLQhnzJoMxSjyGfOh5ckpmheO3XnpwlEwpH
         m8k2XEBJKWG7WuLyCKYPZBRsGtD9zE6p22G10TbyiQ+E4foVCQGGPkN5kOw1B280QHwS
         4pPgXimlCk74Rn8zEpJh8etsDei3eidZ8jxJmO/MlXWeMpXWqwl/tF5e6U1KFbPAPD5b
         EPhgjcRLH0O+Y4gLZHCu0fHt+BFPPDRXUAmYFnBmjR69QO8QVF/oLlpvWB9fxsrt2Suc
         hrsQ==
X-Gm-Message-State: APjAAAXPNdRcp84xBSm2oVMHe6DKuganeAJCFHRAugpK8+vU0c56Lo87
        fDq0qaUFOni9EcRgsp8hhuCXdg==
X-Google-Smtp-Source: APXvYqwMDeQFIV+BAnqHkvh0W6ZD4CpzG6YriiHI53Z8NXqXoZq/C1N1rRYGdAdnBSi5GStGId55LQ==
X-Received: by 2002:a1c:a007:: with SMTP id j7mr1493311wme.25.1552381210260;
        Tue, 12 Mar 2019 02:00:10 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:09 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 6/9] block, bfq: always protect newly-created queues from existing active queues
Date:   Tue, 12 Mar 2019 09:59:32 +0100
Message-Id: <20190312085935.11340-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If many bfq_queues belonging to the same group happen to be created
shortly after each other, then the processes associated with these
queues have typically a common goal. In particular, bursts of queue
creations are usually caused by services or applications that spawn
many parallel threads/processes. Examples are systemd during boot, or
git grep. If there are no other active queues, then, to help these
processes get their job done as soon as possible, the best thing to do
is to reach a high throughput. To this goal, it is usually better to
not grant either weight-raising or device idling to the queues
associated with these processes. And this is exactly what BFQ
currently does.

There is however a drawback: if, in contrast, some other queues are
already active, then the newly created queues must be protected from
the I/O flowing through the already existing queues. In this case, the
best thing to do is the opposite as in the other case: it is much
better to grant weight-raising and device idling to the newly-created
queues, if they deserve it. This commit addresses this issue by doing
so if there are already other active queues.

This change also helps eliminating false positives, which occur when
the newly-created queues do not belong to an actual large burst of
creations, but some background task (e.g., a service) happens to
trigger the creation of new queues in the middle, i.e., very close to
when the victim queues are created. These false positive may cause
total loss of control on process latencies.

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 64 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d34b80e5c47d..500b04df9efa 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1075,8 +1075,18 @@ static void bfq_reset_burst_list(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	hlist_for_each_entry_safe(item, n, &bfqd->burst_list, burst_list_node)
 		hlist_del_init(&item->burst_list_node);
-	hlist_add_head(&bfqq->burst_list_node, &bfqd->burst_list);
-	bfqd->burst_size = 1;
+
+	/*
+	 * Start the creation of a new burst list only if there is no
+	 * active queue. See comments on the conditional invocation of
+	 * bfq_handle_burst().
+	 */
+	if (bfq_tot_busy_queues(bfqd) == 0) {
+		hlist_add_head(&bfqq->burst_list_node, &bfqd->burst_list);
+		bfqd->burst_size = 1;
+	} else
+		bfqd->burst_size = 0;
+
 	bfqd->burst_parent_entity = bfqq->entity.parent;
 }
 
@@ -1132,7 +1142,8 @@ static void bfq_add_to_burst(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * many parallel threads/processes. Examples are systemd during boot,
  * or git grep. To help these processes get their job done as soon as
  * possible, it is usually better to not grant either weight-raising
- * or device idling to their queues.
+ * or device idling to their queues, unless these queues must be
+ * protected from the I/O flowing through other active queues.
  *
  * In this comment we describe, firstly, the reasons why this fact
  * holds, and, secondly, the next function, which implements the main
@@ -1144,7 +1155,10 @@ static void bfq_add_to_burst(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * cumulatively served, the sooner the target job of these queues gets
  * completed. As a consequence, weight-raising any of these queues,
  * which also implies idling the device for it, is almost always
- * counterproductive. In most cases it just lowers throughput.
+ * counterproductive, unless there are other active queues to isolate
+ * these new queues from. If there no other active queues, then
+ * weight-raising these new queues just lowers throughput in most
+ * cases.
  *
  * On the other hand, a burst of queue creations may be caused also by
  * the start of an application that does not consist of a lot of
@@ -1178,14 +1192,16 @@ static void bfq_add_to_burst(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * are very rare. They typically occur if some service happens to
  * start doing I/O exactly when the interactive task starts.
  *
- * Turning back to the next function, it implements all the steps
- * needed to detect the occurrence of a large burst and to properly
- * mark all the queues belonging to it (so that they can then be
- * treated in a different way). This goal is achieved by maintaining a
- * "burst list" that holds, temporarily, the queues that belong to the
- * burst in progress. The list is then used to mark these queues as
- * belonging to a large burst if the burst does become large. The main
- * steps are the following.
+ * Turning back to the next function, it is invoked only if there are
+ * no active queues (apart from active queues that would belong to the
+ * same, possible burst bfqq would belong to), and it implements all
+ * the steps needed to detect the occurrence of a large burst and to
+ * properly mark all the queues belonging to it (so that they can then
+ * be treated in a different way). This goal is achieved by
+ * maintaining a "burst list" that holds, temporarily, the queues that
+ * belong to the burst in progress. The list is then used to mark
+ * these queues as belonging to a large burst if the burst does become
+ * large. The main steps are the following.
  *
  * . when the very first queue is created, the queue is inserted into the
  *   list (as it could be the first queue in a possible burst)
@@ -5695,7 +5711,29 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		}
 	}
 
-	if (unlikely(bfq_bfqq_just_created(bfqq)))
+	/*
+	 * Consider bfqq as possibly belonging to a burst of newly
+	 * created queues only if:
+	 * 1) A burst is actually happening (bfqd->burst_size > 0)
+	 * or
+	 * 2) There is no other active queue. In fact, if, in
+	 *    contrast, there are active queues not belonging to the
+	 *    possible burst bfqq may belong to, then there is no gain
+	 *    in considering bfqq as belonging to a burst, and
+	 *    therefore in not weight-raising bfqq. See comments on
+	 *    bfq_handle_burst().
+	 *
+	 * This filtering also helps eliminating false positives,
+	 * occurring when bfqq does not belong to an actual large
+	 * burst, but some background task (e.g., a service) happens
+	 * to trigger the creation of new queues very close to when
+	 * bfqq and its possible companion queues are created. See
+	 * comments on bfq_handle_burst() for further details also on
+	 * this issue.
+	 */
+	if (unlikely(bfq_bfqq_just_created(bfqq) &&
+		     (bfqd->burst_size > 0 ||
+		      bfq_tot_busy_queues(bfqd) == 0)))
 		bfq_handle_burst(bfqd, bfqq);
 
 	return bfqq;
-- 
2.20.1

