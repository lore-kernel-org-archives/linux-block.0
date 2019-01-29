Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA4C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C553E2084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaAV8QPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfA2LH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfA2LHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so17406294wmt.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6mbkxYARjOVWPicsF+8F1IWlVh58inCJzHv80eeZ00=;
        b=WaAV8QPFZ1BYtgx4VTqu89ErSb86GwumiYIkwW57mgQfl7Nl8icwCI+CpZ6V/iKbv0
         99j6c8j7vc8VEpAnOX39pOSRzg09Sv85zsy1n2cOa9URAETvg/4YZ621WnoNUPCzDTCp
         ATa00BVE+iqnjy+Teq0mqD9PtsCE6+Kx6VCCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6mbkxYARjOVWPicsF+8F1IWlVh58inCJzHv80eeZ00=;
        b=js07Pxm7G0MV4FurD2hM3cXmiPAerYOAQM/BNuwFvaT7rsCAnozJ51qMeAtF/D1OZu
         4dlbcPhJUI2543NjTRbdYcDVdNqdr4qhg15bquOocFTBkqsIDeQn62ZYQQIwdyLAMQ+W
         rRuOLPFfd7Pd/ztNvwYE7DkSrJHdPseJeXjYSjy60O31w1lb7VKV+emUvBCyKtHbMh6z
         +ZnKlV6FOc5QwYwjRNMYDnYhvgV07CpUfHc5XmjJVW2v0cUI1hCSHhx7hvwNS9TWKQai
         AnrcOh8TodEdp37AgH/n39JnECylJ8UdvRikjkplZiOv27hqZ1YfqsKDJ9uQCVY7KNmN
         DIRg==
X-Gm-Message-State: AJcUukcHJgJ7YFMsLtxHhso0ZPZw4suXg3mqMA52REb+7PZwax1xoOFQ
        wnMiVgQxlvSnGwpSG8AZuk/7WQ==
X-Google-Smtp-Source: ALg8bN4WpmkB3JOAr6mfsrbaLi4/0RCbgabv9YQ6/z5XVQzxXWYhMQNk9CKSBxw001ahO5aDFGbDsQ==
X-Received: by 2002:a1c:ef11:: with SMTP id n17mr20436112wmh.112.1548760035222;
        Tue, 29 Jan 2019 03:07:15 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:14 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 14/14] block, bfq: fix in-service-queue check for queue merging
Date:   Tue, 29 Jan 2019 12:06:38 +0100
Message-Id: <20190129110638.12652-15-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a new I/O request arrives for a bfq_queue, say Q, bfq checks
whether that request is close to
(a) the head request of some other queue waiting to be served, or
(b) the last request dispatched for the in-service queue (in case Q
itself is not the in-service queue)

If a queue, say Q2, is found for which the above condition holds, then
bfq merges Q and Q2, to hopefully get a more sequential I/O in the
resulting merged queue, and thus a possibly higher throughput.

Case (b) is checked by comparing the new request for Q with the last
request dispatched, assuming that the latter necessarily belonged to
the in-service queue. Unfortunately, this assumption is no longer
always correct, since commit d0edc2473be9 ("block, bfq: inject
other-queue I/O into seeky idle queues on NCQ flash").

When the assumption does not hold, queues that must not be merged may
be merged, causing unexpected loss of control on per-queue service
guarantees.

This commit solves this problem by adding an extra field, which stores
the actual last request dispatched for the in-service queue, and by
using this new field to correctly check case (b).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 5 ++++-
 block/bfq-iosched.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 06268449d2ca..4c592496a16a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2251,7 +2251,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (in_service_bfqq && in_service_bfqq != bfqq &&
 	    likely(in_service_bfqq != &bfqd->oom_bfqq) &&
-	    bfq_rq_close_to_sector(io_struct, request, bfqd->last_position) &&
+	    bfq_rq_close_to_sector(io_struct, request,
+				   bfqd->in_serv_last_pos) &&
 	    bfqq->entity.parent == in_service_bfqq->entity.parent &&
 	    bfq_may_be_close_cooperator(bfqq, in_service_bfqq)) {
 		new_bfqq = bfq_setup_merge(bfqq, in_service_bfqq);
@@ -2791,6 +2792,8 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 	bfq_update_rate_reset(bfqd, rq);
 update_last_values:
 	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	if (RQ_BFQQ(rq) == bfqd->in_service_queue)
+		bfqd->in_serv_last_pos = bfqd->last_position;
 	bfqd->last_dispatch = now_ns;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 30be669be465..062e1c4787f4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -538,6 +538,9 @@ struct bfq_data {
 	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* position of the last served request for the in-service queue */
+	sector_t in_serv_last_pos;
+
 	/* time of last request completion (ns) */
 	u64 last_completion;
 
-- 
2.20.1

