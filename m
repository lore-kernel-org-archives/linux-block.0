Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6841EC33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9520661
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfpBpPqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgBCKlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38670 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgBCKlW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so17335369wrh.5
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=mfpBpPqmwAcPO0e1BueHHoL83GQn+u39S5fzLWe3sm5x6q5ch5+7z+JZBr4ud9N0ka
         hlCWy6oQ6MXEvBvTA8Q+j+u28FVALLwfiLqQx7aIal1Ejk3ATshmevA5ZWy9nfGeA07n
         6y6mFC7QPC8xUMujiRmFt0sG3zlgNQ7Gi9EReoaRy3Yshq+V4b2MZmGIJrv2/xpIMUpA
         xhDin3yzdFtWzB9QeaGkIcW+DKXTuvfOlUdjgia27BH37xhmkX5GBHnLVoiGQw25/Pq6
         U4mfRfzrL9gTtnfZ8Cr7P8f4pVg+ugLieOD+Eb91fD8v0VQp9ph0V2zYweLoCT/0rDJi
         iuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=TsAcTJUG0skyvCoqA//Jfm6Oklq3dclnRH6zcbZn2RxQ4yjItpw//iCskT9Z2tV1Uv
         nZqQymJ8txAfaAwFinIccQ8QGeJnreKHmUEJspvAtVv7gfKmIUg/SI89yZz/Ppi4JKCQ
         j1H8hhx9DugNE8PxYRk4AuLbKCoX5HKcM/takuVoPRFR3/AnjL4Pzdp476HDSP3IkjHY
         TcmD494Vsl3EM3AcRpkqzaf70jV401biTZokNYTMbadL/uWPuFgfZPIfy8Gp0XoPlLx0
         B8MD2l5vvuo8J497tqTklqda9igcFJoMhrSlgcjcHlkW38yrYUhRyFOlYgtlpP4C8h6q
         Jo2A==
X-Gm-Message-State: APjAAAW5Mo8e6xUU+oLP0hnO8EaXjXt9k0oBNrsnFFISA/59uFyQOx7Q
        xF8zlflP5mufvHnsH2/dDRu55g==
X-Google-Smtp-Source: APXvYqzvjhTRZEZ5VF4yVYhrSP28dia4+T4/m+hIu2Fuz4jmFCuGLvFyyZMHxuYLNAm7vCE7ys+TmQ==
X-Received: by 2002:adf:b352:: with SMTP id k18mr14456202wrd.242.1580726478647;
        Mon, 03 Feb 2020 02:41:18 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 3/7] block, bfq: get extra ref to prevent a queue from being freed during a group move
Date:   Mon,  3 Feb 2020 11:40:56 +0100
Message-Id: <20200203104100.16965-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
may happen to be deactivated in the scheduling data structures of the
source group (and then activated in the destination group). If Q is
referred only by the data structures in the source group when the
deactivation happens, then Q is freed upon the deactivation.

This commit addresses this issue by getting an extra reference before
the possible deactivation, and releasing this extra reference after Q
has been moved.

Tested-by: Chris Evich <cevich@redhat.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e1419edde2ec..8ab7f18ff8cb 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
+	/*
+	 * get extra reference to prevent bfqq from being freed in
+	 * next possible deactivate
+	 */
+	bfqq->ref++;
+
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
@@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
+	/* release extra ref taken above */
+	bfq_put_queue(bfqq);
 }
 
 /**
-- 
2.20.1

