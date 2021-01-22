Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11086C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7163233FA
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbhAVS0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbhAVSZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:25:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45045C06121C
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so8951000ejf.11
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yCgqi7f2roNb4s5kP0Oap9h52ux6bvqmo8LLvwwwI4=;
        b=X3QmT+eTFnpj46VwDNdj5PJQHwwQyi8jw+LjbgnrE+X03Us0A/Dik7iimtDDTeFGtk
         Z/1NV+K8YtlgtjxnUB7jgyE1qB0i+lo1xQDmtQ0qGe+8NphATxuZr9HfhejcFoCJyeMh
         H9G4Aiwh0CxScKK1RMyvwRkwrUyVoKTnkxddvBlcLtWuA1qqNFHJJtjtIxx7z8rEBO+S
         Fhl1Je1AHsB3t/gcSnHgkEnaXNs735rQBn2fnxZB0fz+m5j0TUp+djnxd0oVpXKZuyEx
         XdvMiURlJJoeZxzcAIDYOX/Fxpr1Z0wKA2CIaK28sumQ+Dsyg38CgBLTw0tCfLt3ksTS
         Kxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yCgqi7f2roNb4s5kP0Oap9h52ux6bvqmo8LLvwwwI4=;
        b=VmFY85eWcMB5kdocWx7Uqp9NDKFhighEX1e5CEUoiDfHBtmk/7ypCG51/BvJO4C2tT
         OjtpZVP6meph+QHSGhxPFZYRETnYMGglTxaD/wVEND7cEXrrO4G+z75KhuUaEPSvjcz6
         ghkqmXupZszkrxIJMbtcRL6R4Eb25+3gMNTdKLUIZRMmR4YgCoVqQ7seMjd5E6j5Qjgw
         9rlbOhC7+TNn1yaa8mIcExceh4shHFQ4b06JBJsaqJMby9leezfLL571amiPMnoqTEUy
         erohz+DAv7Us7p6C2o5fNSO5uesjUc/+pAk4h5oZ4nZv66gNZytbdjtnDJqt4KgFlElu
         K5yA==
X-Gm-Message-State: AOAM531CTzj/ZO6e7C2GSXk8kt4Qgd4PfJFVHaaAuywx9DXUYi5N8TeG
        M4Gr5XgeqU6hHyG/fZ2CQZO9CQ==
X-Google-Smtp-Source: ABdhPJxXPmVqwY1t4uXcCkP9lVxbR/zI4nKGts8fMBhxsSI/fR63+SvIJKhuF88EgHN37UnKRqKZ4A==
X-Received: by 2002:a17:906:29d4:: with SMTP id y20mr3859274eje.294.1611339642885;
        Fri, 22 Jan 2021 10:20:42 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:42 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 6/6] block, bfq: do not expire a queue when it is the only busy one
Date:   Fri, 22 Jan 2021 19:19:48 +0100
Message-Id: <20210122181948.35660-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This commits preserves I/O-dispatch plugging for a special symmetric
case that may suddenly turn into asymmetric: the case where only one
bfq_queue, say bfqq, is busy. In this case, not expiring bfqq does not
cause any harm to any other queues in terms of service guarantees. In
contrast, it avoids the following unlucky sequence of events: (1) bfqq
is expired, (2) a new queue with a lower weight than bfqq becomes busy
(or more queues), (3) the new queue is served until a new request
arrives for bfqq, (4) when bfqq is finally served, there are so many
requests of the new queue in the drive that the pending requests for
bfqq take a lot of time to be served. In particular, event (2) may
case even already dispatched requests of bfqq to be delayed, inside
the drive. So, to avoid this series of events, the scenario is
preventively declared as asymmetric also if bfqq is the only busy
queues. By doing so, I/O-dispatch plugging is performed for bfqq.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 003c96fa01ad..c045613ce927 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3464,20 +3464,38 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
  * order until all the requests already queued in the device have been
  * served. The last sub-condition commented above somewhat mitigates
  * this problem for weight-raised queues.
+ *
+ * However, as an additional mitigation for this problem, we preserve
+ * plugging for a special symmetric case that may suddenly turn into
+ * asymmetric: the case where only bfqq is busy. In this case, not
+ * expiring bfqq does not cause any harm to any other queues in terms
+ * of service guarantees. In contrast, it avoids the following unlucky
+ * sequence of events: (1) bfqq is expired, (2) a new queue with a
+ * lower weight than bfqq becomes busy (or more queues), (3) the new
+ * queue is served until a new request arrives for bfqq, (4) when bfqq
+ * is finally served, there are so many requests of the new queue in
+ * the drive that the pending requests for bfqq take a lot of time to
+ * be served. In particular, event (2) may case even already
+ * dispatched requests of bfqq to be delayed, inside the drive. So, to
+ * avoid this series of events, the scenario is preventively declared
+ * as asymmetric also if bfqq is the only busy queues
  */
 static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
+	int tot_busy_queues = bfq_tot_busy_queues(bfqd);
+
 	/* No point in idling for bfqq if it won't get requests any longer */
 	if (unlikely(!bfqq_process_refs(bfqq)))
 		return false;
 
 	return (bfqq->wr_coeff > 1 &&
 		(bfqd->wr_busy_queues <
-		 bfq_tot_busy_queues(bfqd) ||
+		 tot_busy_queues ||
 		 bfqd->rq_in_driver >=
 		 bfqq->dispatched + 4)) ||
-		bfq_asymmetric_scenario(bfqd, bfqq);
+		bfq_asymmetric_scenario(bfqd, bfqq) ||
+		tot_busy_queues == 1;
 }
 
 static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-- 
2.20.1

