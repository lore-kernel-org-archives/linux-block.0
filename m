Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C1C76192
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C145206B8
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVCcrEcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfGOK5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:57:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbfGOK5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:57:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so16614806wrm.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaB1byT4JsbLlwfkX3CoW4ge37EsFViei1bqZF3vhgQ=;
        b=PVCcrEcgXD4t/PHRjKm5ZBTSDivX6rZVBaO78lCNdM+qKjD4LDcSHq3mY5LQxt0XUJ
         njJiWST37pPTRWN7bErirw/FVkhMJi0Pbc/1au4rmRa7s6kyZblDFxgc82MWz6DPRiDb
         a+C5fG2RgdItSoK4E6PxsaVQ2x6xEWXRA/ctcf2TG96hkkP8xikLpzPf/t/A83dYYT6c
         5ab7HDkL96Gx1mR5isouM5OvTlHwyJex4m2BjOqej8Z+ADRCbdZ/w7NakgXMAxE4WITl
         tEkP/3LK/sxuV9S56gVkz2PehcAIGEbsPd0ttOivgIU0Od0p+btuh+4UjJPg78lTXxZr
         XbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaB1byT4JsbLlwfkX3CoW4ge37EsFViei1bqZF3vhgQ=;
        b=XWslRdADr9MujhEKRmICtncwd0Nrzi4b2feRtQ5vxKMfkmnthTQ0eUKcZ98mOEjTsB
         7hhfFqISVXngXPKVymh+J0B8CLh6GJDmUpPmE6VdgX/ULqd1XXATjx6xmHpeHXa0X/mR
         25Rl/+pNx3xy61Uo+vTMky8m4QxfMHIN5vj+jLFUEvejfg115Ic4JX1sxQYxeeEMVrHR
         xHmV/CE1h7ox4wMX3WcW+wuAueiM79gHdRqUHiBD3qgrN4Ej3Uo9Y0DYwiKNGfotACCS
         I2Rlhc70x7MsuUyZ0gLq4txHxUr/DeqvH79TFCkJfNja9j7afE72oYRvrraezEYkPDyt
         w2+g==
X-Gm-Message-State: APjAAAXCGj1BW+2NJFMFWfHDkub/4CI0GJWbVZN9QLbQf6GSqTfU3gRI
        6o/tMQn66DVbzMHezleXnwuWuA==
X-Google-Smtp-Source: APXvYqzF6bNJQqXNJGaP06qZDyUQawckQyA7evyJkYptGT6S7Hyl9i1bpRNAF5VD2OvNqKW7ds56UA==
X-Received: by 2002:adf:80e1:: with SMTP id 88mr27801008wrl.127.1563188254593;
        Mon, 15 Jul 2019 03:57:34 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id z1sm18186559wrv.90.2019.07.15.03.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:57:34 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 1/1] block, bfq: check also in-flight I/O in dispatch plugging
Date:   Mon, 15 Jul 2019 12:57:19 +0200
Message-Id: <20190715105719.20353-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715105719.20353-1-paolo.valente@linaro.org>
References: <20190715105719.20353-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider a sync bfq_queue Q that remains empty while in service, and
suppose that, when this happens, there is a fair amount of already
in-flight I/O not belonging to Q. This situation is not considered
when deciding whether to plug I/O dispatching (until new I/O arrives
for Q). But it has to be checked, for the following reason.

The drive may decide to serve in-flight non-Q's I/O requests before
Q's ones, thereby delaying the arrival of new I/O requests for Q
(recall that Q is sync). If I/O-dispatching is not plugged, then,
while Q remains empty, a basically uncontrolled amount of I/O from
other queues may be dispatched too, possibly causing the service of
Q's I/O to be delayed even longer in the drive. This problem gets more
and more serious as the speed and the queue depth of the drive grow,
because, as these two quantities grow, the probability to find no
queue busy but many requests in flight grows too.

This commit performs I/O-dispatch plugging in this scenario.  Plugging
minimizes the delay induced by already in-flight I/O, and enables Q to
recover the bandwidth it may lose because of this delay.

As a practical example, under write load on a Samsung SSD 970 PRO,
gnome-terminal starts in 1.5 seconds after this fix, against 15
seconds before the fix (as a reference, gnome-terminal takes about 35
seconds to start with any of the other I/O schedulers).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50c9d2598500..b627e3fc6d53 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3354,38 +3354,57 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
  * there is no active group, then the primary expectation for
  * this device is probably a high throughput.
  *
- * We are now left only with explaining the additional
- * compound condition that is checked below for deciding
- * whether the scenario is asymmetric. To explain this
- * compound condition, we need to add that the function
+ * We are now left only with explaining the two sub-conditions in the
+ * additional compound condition that is checked below for deciding
+ * whether the scenario is asymmetric. To explain the first
+ * sub-condition, we need to add that the function
  * bfq_asymmetric_scenario checks the weights of only
- * non-weight-raised queues, for efficiency reasons (see
- * comments on bfq_weights_tree_add()). Then the fact that
- * bfqq is weight-raised is checked explicitly here. More
- * precisely, the compound condition below takes into account
- * also the fact that, even if bfqq is being weight-raised,
- * the scenario is still symmetric if all queues with requests
- * waiting for completion happen to be
- * weight-raised. Actually, we should be even more precise
- * here, and differentiate between interactive weight raising
- * and soft real-time weight raising.
+ * non-weight-raised queues, for efficiency reasons (see comments on
+ * bfq_weights_tree_add()). Then the fact that bfqq is weight-raised
+ * is checked explicitly here. More precisely, the compound condition
+ * below takes into account also the fact that, even if bfqq is being
+ * weight-raised, the scenario is still symmetric if all queues with
+ * requests waiting for completion happen to be
+ * weight-raised. Actually, we should be even more precise here, and
+ * differentiate between interactive weight raising and soft real-time
+ * weight raising.
+ *
+ * The second sub-condition checked in the compound condition is
+ * whether there is a fair amount of already in-flight I/O not
+ * belonging to bfqq. If so, I/O dispatching is to be plugged, for the
+ * following reason. The drive may decide to serve in-flight
+ * non-bfqq's I/O requests before bfqq's ones, thereby delaying the
+ * arrival of new I/O requests for bfqq (recall that bfqq is sync). If
+ * I/O-dispatching is not plugged, then, while bfqq remains empty, a
+ * basically uncontrolled amount of I/O from other queues may be
+ * dispatched too, possibly causing the service of bfqq's I/O to be
+ * delayed even longer in the drive. This problem gets more and more
+ * serious as the speed and the queue depth of the drive grow,
+ * because, as these two quantities grow, the probability to find no
+ * queue busy but many requests in flight grows too. By contrast,
+ * plugging I/O dispatching minimizes the delay induced by already
+ * in-flight I/O, and enables bfqq to recover the bandwidth it may
+ * lose because of this delay.
  *
  * As a side note, it is worth considering that the above
- * device-idling countermeasures may however fail in the
- * following unlucky scenario: if idling is (correctly)
- * disabled in a time period during which all symmetry
- * sub-conditions hold, and hence the device is allowed to
- * enqueue many requests, but at some later point in time some
- * sub-condition stops to hold, then it may become impossible
- * to let requests be served in the desired order until all
- * the requests already queued in the device have been served.
+ * device-idling countermeasures may however fail in the following
+ * unlucky scenario: if I/O-dispatch plugging is (correctly) disabled
+ * in a time period during which all symmetry sub-conditions hold, and
+ * therefore the device is allowed to enqueue many requests, but at
+ * some later point in time some sub-condition stops to hold, then it
+ * may become impossible to make requests be served in the desired
+ * order until all the requests already queued in the device have been
+ * served. The last sub-condition commented above somewhat mitigates
+ * this problem for weight-raised queues.
  */
 static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
 	return (bfqq->wr_coeff > 1 &&
-		bfqd->wr_busy_queues <
-		bfq_tot_busy_queues(bfqd)) ||
+		(bfqd->wr_busy_queues <
+		 bfq_tot_busy_queues(bfqd) ||
+		 bfqd->rq_in_driver >=
+		 bfqq->dispatched + 4)) ||
 		bfq_asymmetric_scenario(bfqd, bfqq);
 }
 
-- 
2.20.1

