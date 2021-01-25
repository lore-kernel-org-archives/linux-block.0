Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94EC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 19:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B61D2067B
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 19:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbhAYTFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbhAYTFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06ACC06178B
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p15so7436347wrq.8
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3N9Fc9Oym1a/uSXoPjk2H2RgyHj8WV7XIwzdfEee54=;
        b=aSRERs4AkNneRj0RmPWLV03SycGYdHxwG1cq6GOgodsaPX4VY1olaYz37kZGHA8Vdh
         ctrahRmB7MbwOQao585A4TjlLBdoLU3C/l67U4bz/qwmkaR6cHFxIYMSfIeCdxT4K1a3
         VRUwrlgnZdKVIyhB8meFItX0n6xS5rjc5A5A81xQ9z7d+ErHgdl4Mhl29Is2hTNXG5AD
         OiYo8DudLASRR4Fgoqcu+y38TQmttdkiqJYh2q+giBtn4Rq0+CpjPpG6vF86PcZt5EVm
         jHfkFcfAfc/Paxz0OfHshMxWfZJt9LQYq9D6hgMjSHtU8hWfmvl1ewO1JLtdEE63knJ4
         20nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3N9Fc9Oym1a/uSXoPjk2H2RgyHj8WV7XIwzdfEee54=;
        b=oAYSNyJ73PUdxw/9iyzlDtNSRtv/DDbWz3WXb46VqejtwLx+iaBq0Z8o6QHoDl1Lio
         D6VTINrSEf5D3L37dA6Lpy8G+QAaf8mi/L8/OGfoaMztOYSNhWPVHAr44E1BZkHUPljh
         tywT6v9md6MlGACtnF50/qEnOjqtjHMrb2RnUhmmJirU+kNy9DHGjZo3mArI8FNnPRqz
         wOdf1p52xg1HSn2myGXMaKIf5j+rQBJk3+nLUCGUSPfPEe9GrhYEWHyLFaadIqMhhc+H
         iZzScoXfyuSP/Jp4CDP8WwutDhl+H7gXFvQ7GFRZNZ7C/6wZi/gPsGrLzaz1Qvc7CwEy
         htnw==
X-Gm-Message-State: AOAM533yc8w0XTOWiIimNCQsmnbCvEaSJqPONYIxhKYma4qzEQ9qfLe4
        ZEizgpE0BzsPSy0q1btbXq+aJg==
X-Google-Smtp-Source: ABdhPJxwcZ2dcN1I/y1hi9Lq/ZxxKwclSEVGgd921GuPKSsEsHU54wwyDcs3IEFHCU6qxvfnrGnyXw==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr2632482wrt.164.1611601399469;
        Mon, 25 Jan 2021 11:03:19 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/6] block, bfq: save also weight-raised service on queue merging
Date:   Mon, 25 Jan 2021 20:02:46 +0100
Message-Id: <20210125190248.49338-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prevent weight-raising information from being lost on bfq_queue merging,
also the amount of service that a bfq_queue receives must be saved and
restored when the bfq_queue is merged and split, respectively.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e5242b2788a..56ad6067d41d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1029,6 +1029,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	bfqq->io_start_time = bic->saved_io_start_time;
 	bfqq->tot_idle_time = bic->saved_tot_idle_time;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
+	bfqq->service_from_wr = bic->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
 	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
@@ -2775,6 +2776,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 		bic->saved_wr_coeff = bfqq->wr_coeff;
 		bic->saved_wr_start_at_switch_to_srt =
 			bfqq->wr_start_at_switch_to_srt;
+		bic->saved_service_from_wr = bfqq->service_from_wr;
 		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
 		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 	}
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index c913b06016b3..d15299d59f89 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -440,6 +440,7 @@ struct bfq_io_cq {
 	 */
 	unsigned long saved_wr_coeff;
 	unsigned long saved_last_wr_start_finish;
+	unsigned long saved_service_from_wr;
 	unsigned long saved_wr_start_at_switch_to_srt;
 	unsigned int saved_wr_cur_max_time;
 	struct bfq_ttime saved_ttime;
-- 
2.20.1

