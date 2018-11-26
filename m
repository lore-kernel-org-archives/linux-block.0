Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C28C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8120659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c5Si/kEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF8120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK0Dap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35891 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dap (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:45 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so28699308itj.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLWOXWk+blJHoTtHNBJpfBgQguikfitnIRG4gEI4XWw=;
        b=c5Si/kEKF/yRyk2CG3Eu0e+qLMV/MgLni0l5CEIqIiQnu/vB90IVjpDBBw7rwviK4c
         EnET2LUkl+/cmF2O4NmnjjmN1+MXNr8mnFXdgMlCwDREb0Db2DyJ7Jlc3TTp6xtDEurt
         hdRMcSs+QkAd9t83CWP5cAwtfY6kBFE+NOBFyWyjzkoaEJLDkb+GQsE1F9ZpywftwPDo
         VlsT+TNKGUF7u5PcvSyytlVjw+Cr4s/wL59cxCKwjzJCi0x0oDn6oBkRAdx0r+1JySji
         V9y1KMmTtToqxM0EMurUflMLyU66iitwZx2bB6AfRNcvR1FKzGknMQgyOkqiDPpo6dNX
         Z4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLWOXWk+blJHoTtHNBJpfBgQguikfitnIRG4gEI4XWw=;
        b=NmyZ/zSRzeISdAgoMvzaBWh40XuntDGY1iP/bKHJ4KwpEeo1V0xhQDPfz1y2o3MBlw
         cAoM4l4z1hcVQ7W3XbygL2vp+8MuIQQccLWecf0oW4+wzvaLpEmVt6zKsQ/2TlDrv4qI
         DHkoBEPQo0Dm7SQsqitWptG8InxeFo9aRm/1t8EkIZTFTJJWEe7n3NLb3ocyG1bnF32n
         ewE+psA5rDYJSYLftvt9+fhI2wVjSLB2pnQrMLgqbQBI+E4V7tYjFzasYknNdY5ctFc9
         ks7y47jtgSwXc2ELtpMllx+v34c6qXd7B5HBLRa5S5L5ztkz4+t+am+W8EGY5K6sFNZq
         yvoA==
X-Gm-Message-State: AA+aEWYEtURTY5Ft9/IDN1oIc3moKQH9H/inlZA7rn7a7RrDrQSvgd4y
        YJfsShdnINX+zwHuH87sBVLo/Mk+cMg=
X-Google-Smtp-Source: AJdET5fF+XzT2t210RKA1bZC/Q71WxmtBlJ2JIQ/Euf3r2IyP0NFnH801RCZqsYcEjBGSpLZLNACRA==
X-Received: by 2002:a02:93c2:: with SMTP id z60mr23380443jah.51.1543250166950;
        Mon, 26 Nov 2018 08:36:06 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
Date:   Mon, 26 Nov 2018 09:35:51 -0700
Message-Id: <20181126163556.5181-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq passes information to the hardware about any given request being
the last that we will issue in this sequence. The point is that hardware
can defer costly doorbell type writes to the last request. But if we run
into errors issuing a sequence of requests, we may never send the request
with bd->last == true set. For that case, we need a hook that tells the
hardware that nothing else is coming right now.

For failures returned by the drivers ->queue_rq() hook, the driver is
responsible for flushing pending requests, if it uses bd->last to
optimize that part. This works like before, no changes there.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk-mq.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ca0520ca6437..1fd139b65a6e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -117,6 +117,7 @@ struct blk_mq_queue_data {
 
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
+typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
 /* takes rq->cmd_flags as input, returns a hardware type index */
 typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
 typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
@@ -144,6 +145,15 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
+	/*
+	 * If a driver uses bd->last to judge when to submit requests to
+	 * hardware, it must define this function. In case of errors that
+	 * make us stop issuing further requests, this hook serves the
+	 * purpose of kicking the hardware (which the last request otherwise
+	 * would have done).
+	 */
+	commit_rqs_fn		*commit_rqs;
+
 	/*
 	 * Return a queue map type for the given request/bio flags
 	 */
-- 
2.17.1

