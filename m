Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B83C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F2623AAC
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbhAVSjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbhAVSWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:22:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E17C0617A7
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kg20so8518462ejc.4
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgVql/JRS43dj+W0ld1vynp9FcuzTEJ43layP8Y7y0c=;
        b=AGf8N892FuK8FQWkL+ZqYoe9BCoOhK1TDiEKUsmlOsmgQzcL67OEdloOPRaNe1hHuz
         Gmfo4kEsGoEJMsAXjThReYSYkodZ8DjJAdDnSOZet7F294wYEocpiyfHC4htFIx9Wvta
         G9Fsk0wZDxXsjCWMcMluh8Uix4pMGwhZgd8C002swiz5iiDThchdTUhCszHzqNbPvSiz
         bUQdaC8CgJmuRTTYQZ8sYatn1g7d3Fpo/SnsfV/LOBP3dlnvojuJV55p5GyEIqiwlEkb
         NPn2VTF6MNUo8OVcDRNopFrVrgjgTnhMVTGjKkI3d1QSQnjfMnSW5ceznrJpwM47V5d7
         MqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgVql/JRS43dj+W0ld1vynp9FcuzTEJ43layP8Y7y0c=;
        b=XlHGLMuTJJpIZM0NlAasjVp9DycFpiUJflwEgSw51xkq39hnXqHfGBEznU3zE1+eOA
         3xxAHZv0Cs1xhXqWrgsUbIFlKsAUFkW9bvA7xZeE5UmXJVjfyUIUDQNUSAFfAF4QwZoX
         1PoWAa6Gh8uikmbiXp5u6l/uTXz74kve4UYxXxw6cr7KhsqjCVwgA6znrNJpi3/b6IfD
         nqymRXsq7LgsVeBNADhpxbUT5vDoQfr/5TEAFX/wAjsmXCahdsmLrINOWsQrlHbG9g3Y
         fnmDubmLcX535fs3pdCdiazxT4fLyAr5x63oWbSV7FotxIvDpkwiQnH3bgQmYy8/KuLd
         vXfQ==
X-Gm-Message-State: AOAM532cZPaw28+hqlSMg+p45fUlMf6yA6cDJz4jvUbteGP/R2zStXRl
        I2AfHn0WCroB2+JH1g8DNrUlCA==
X-Google-Smtp-Source: ABdhPJxxlmLudPi8MnmDeE9sqQS2PZnLxn840lWcQdf4uG/dYwL3F2T4ZP7X2Lt2lL+191Rsk3nR7A==
X-Received: by 2002:a17:906:478a:: with SMTP id cw10mr3734136ejc.533.1611339636708;
        Fri, 22 Jan 2021 10:20:36 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:36 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Cheng Hu <jia.jiachenghu@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: set next_rq to waker_bfqq->next_rq in waker injection
Date:   Fri, 22 Jan 2021 19:19:44 +0100
Message-Id: <20210122181948.35660-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jia Cheng Hu <jia.jiachenghu@gmail.com>

Since commit c5089591c3ba ("block, bfq: detect wakers and
unconditionally inject their I/O"), when the in-service bfq_queue, say
Q, is temporarily empty, BFQ checks whether there are I/O requests to
inject (also) from the waker bfq_queue for Q. To this goal, the value
pointed by bfqq->waker_bfqq->next_rq must be controlled. However, the
current implementation mistakenly looks at bfqq->next_rq, which
instead points to the next request of the currently served queue.

This mistake evidently causes losses of throughput in scenarios with
waker bfq_queues.

This commit corrects this mistake.

Fixes: c5089591c3ba ("block, bfq: detect wakers and unconditionally inject their I/O")
Signed-off-by: Jia Cheng Hu <jia.jiachenghu@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index eb2ca32d5b63..fdc5e163b2fe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4499,7 +4499,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfqq = bfqq->bic->bfqq[0];
 		else if (bfq_bfqq_has_waker(bfqq) &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
-			   bfqq->next_rq &&
+			   bfqq->waker_bfqq->next_rq &&
 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
 					      bfqq->waker_bfqq) <=
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
-- 
2.20.1

