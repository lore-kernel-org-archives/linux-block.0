Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1462084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8SwCMBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfA2LHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfA2LHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so17345068wmb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/L0sIFrF4VuBSatFaX/8mVU9i1rVnBBzRyuN7LWEkY0=;
        b=T8SwCMBxHn6msupWEQMC7s4HLPYVlg1FbZACnt/EPRze8AUAKrACng21WGluOoVdo2
         L7cL+ds9pHdQQ2VaaL4qtXOdX7QcYXDB4xr7IgGJ4/SanZvahBsefcbqgUZLDb0WY7fX
         j5Vk+mwVIseQWtHLXWsOlAwYh9i8eN/GHSiBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/L0sIFrF4VuBSatFaX/8mVU9i1rVnBBzRyuN7LWEkY0=;
        b=OTLFxHL07c3jHlEGSewM5/GUzmejEl9/lZRlauTVo7+eD+aPLiW/ttuoxPbj5f+uWf
         P5fqhfunL5dDeY9aRsyV/jAvTMazMA7uVTUOA9okrgu3GOBhE7RtaM8rjM9VhxUJgF7/
         b4Dgt2cW/uX41eTEwpvZ7E5dfSE4bwPN3ekuTjgUayjXxzY+a4n//TXK4dGPalvIdYtk
         KTaTlJ2WJ1462nxXMv2S6aM3EibD7pjif4r0+xOaoaLb/7HB6kdsq8N5yRJH4TC8H7iJ
         W/i54ODF8XkjOpcwXu9OT8uxnf7tcFPsa8005MC40dlc/X8iy7G1FN03a/4qW8TPlvnG
         Npmw==
X-Gm-Message-State: AJcUukdmF6qd0VzUzNC9k7g/hzVWYNV24J6Q4tU/EBBySC8egId00c17
        I6pwMQt1VourS9yfTiHCz6yQ2A==
X-Google-Smtp-Source: ALg8bN6gizgOIgUL0g87ugnhrkKHTPSLL8sSU9ok3wSDOxDILpGfEIUV2yu20GRFSfV5y2M1u4idFQ==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr20407313wmc.7.1548760031541;
        Tue, 29 Jan 2019 03:07:11 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:10 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 11/14] block, bfq: reduce threshold for detecting command queueing
Date:   Tue, 29 Jan 2019 12:06:35 +0100
Message-Id: <20190129110638.12652-12-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bfq borrowed from cfq a simple heuristic for detecting whether the
drive performs command queueing: check whether the average number of
in-flight requests is above a given threshold. Unfortunately this
heuristic does fail to detect queueing (on drives with queueing) if
processes doing I/O are few and issue I/O with a low depth.

To reduce false negatives, this commit lowers the threshold.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index bf585ad29bb5..48b579032d14 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -230,7 +230,7 @@ static struct kmem_cache *bfq_pool;
 #define BFQ_MIN_TT		(2 * NSEC_PER_MSEC)
 
 /* hw_tag detection: parallel requests threshold and min samples needed. */
-#define BFQ_HW_QUEUE_THRESHOLD	4
+#define BFQ_HW_QUEUE_THRESHOLD	3
 #define BFQ_HW_QUEUE_SAMPLES	32
 
 #define BFQQ_SEEK_THR		(sector_t)(8 * 100)
@@ -4798,7 +4798,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	 * sum is not exact, as it's not taking into account deactivated
 	 * requests.
 	 */
-	if (bfqd->rq_in_driver + bfqd->queued < BFQ_HW_QUEUE_THRESHOLD)
+	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
 		return;
 
 	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
-- 
2.20.1

