Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C0322A83
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbhAZFd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbhAYTFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472FAC061793
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p15so7436417wrq.8
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uemGCY4/316d8GBRWMu2x2DHphVSGyL2sreD9v73IaY=;
        b=tWxtMW8Cz4ayJUVqWs2aqwqtCLJwusxbOqpBiLFCZDJ9nxUC8sXT3a8RsrdC0RGD4A
         LhpOgHOSEIYWqHbFqTlrpT/GgvPAi99nMaTuWSC1+ObZbWlxukmgQPkMnRBHF4RMk7V+
         BJUVjJ51c/n73FnFmuRyOLLA/JIg1PAGjJtNWK1yvMfl5nm1myE4dzk3i2DtujZdq5O3
         nSN5d4T/OQUOZx3TH0yxML+f/SwouhbnsRc8ER3RrK3pI+YrDiOYSPHDF6g8Dedrfy13
         Vo8OK99KQqS27gvQ24Z75kSv3+VBvuGPlQ+fly+FYo1vxqqHnAlc+sk+syUJ0Nlwnga7
         DRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uemGCY4/316d8GBRWMu2x2DHphVSGyL2sreD9v73IaY=;
        b=Y4JpCS6S8qtqN9EwZYc35gaTKFvtAFP5lyQMYMp00mv8lFzI/W3NBf41r9M3O37K1/
         +x+KqlYm2imVDJS8/g9F0TiP7vi+UPFWbFFVwG8Gpb67Yh7c4zaSl8T15EPOXWwkkwK4
         10HpiDJ28zca2n7dH/4bCESpullqK3ZdKaQ7LMcIKrtSCX3Ernmk/W5vkM23siFA/Bm8
         E//l/TbR1gnvbqYP/i4zzKPiUt3iDrdyN+hnJ6x9QfZ9QA5V5PQ3lrdAp1fVajBv99Os
         VHYHbBvHkJFjKExN0vPHUNo0Bw8Ca8WyrzMTrEJcy209NYzjXMeNUrgQhiuULW/zouo8
         SeQw==
X-Gm-Message-State: AOAM530UJPPeSEy/yKTKb5AAPy/zIMCHJX+mET0PlYgFZB5W5HXSFlUF
        JcLqMhui4Zb98xD+coNU0jTGeA==
X-Google-Smtp-Source: ABdhPJxrzx3VM5nd+6B4NAg/5ad3yjMTjSwlywag1cH6B40RsYY5iCAXFuH2UwP6jr5IzPSgFpIdcg==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr2593302wry.254.1611601401012;
        Mon, 25 Jan 2021 11:03:21 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:20 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 5/6] block, bfq: save also injection state on queue merging
Date:   Mon, 25 Jan 2021 20:02:47 +0100
Message-Id: <20210125190248.49338-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prevent injection information from being lost on bfq_queue merging,
also the amount of service that a bfq_queue receives must be saved and
restored when the bfq_queue is merged and split, respectively.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 8 ++++++++
 block/bfq-iosched.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 56ad6067d41d..e56ee60df014 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1024,6 +1024,10 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
+	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
+	bfqq->inject_limit = bic->saved_inject_limit;
+	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
+
 	bfqq->entity.new_weight = bic->saved_weight;
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->io_start_time = bic->saved_io_start_time;
@@ -2748,6 +2752,10 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	bic->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
+	bic->saved_inject_limit = bfqq->inject_limit;
+	bic->saved_decrease_time_jif = bfqq->decrease_time_jif;
+
 	bic->saved_weight = bfqq->entity.orig_weight;
 	bic->saved_ttime = bfqq->ttime;
 	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index d15299d59f89..3f350fa3c5fd 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -444,6 +444,11 @@ struct bfq_io_cq {
 	unsigned long saved_wr_start_at_switch_to_srt;
 	unsigned int saved_wr_cur_max_time;
 	struct bfq_ttime saved_ttime;
+
+	/* Save also injection state */
+	u64 saved_last_serv_time_ns;
+	unsigned int saved_inject_limit;
+	unsigned long saved_decrease_time_jif;
 };
 
 /**
-- 
2.20.1

