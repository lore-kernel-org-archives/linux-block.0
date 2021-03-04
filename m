Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1252C4332E
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF0B64F5E
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbhCDRq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbhCDRqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 12:46:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A8C0613E6
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 09:45:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id h7so1197274wmf.3
        for <linux-block@vger.kernel.org>; Thu, 04 Mar 2021 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqoAgrq4fJR4HLR5WghEXfCAYNkU/FugUfR5Q3syhNI=;
        b=qlMH0cAiJPI42edwa7vSynVTvwlt7RzKWBRJnfYew+7ItSFTZGvO+GflZH1ioB75VE
         7KwH/80xPrc6XmRzh+f9o1EuaBrM6O74hIx/arXEb6VSZTJuDVYKhc95T54asR64a5mx
         KDZuxHPG9+0fobf971+p3EgR6WvX4G44xnZSTSWgLKu+3EwLbJWTyEzyk6MB8pK8txhR
         S1cuFiOdYZX8UOfdssdUyHI/IxVhFdtmYvrDbELV/FRQZFvt6BiuQHuLTkCcpjH0iv8c
         dHrvHnJKyp4gdkVHTkXa44MOzxze864WvQpo2+jdOciSJANxt6Hl+4jk40ZpX7O/SvJc
         XQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqoAgrq4fJR4HLR5WghEXfCAYNkU/FugUfR5Q3syhNI=;
        b=Qf0LZLinfH9uLTRWjLqDDx3DXsJ/5TXK3b0enoObcLGiaYspBRDSM6ZvpSJ0HTDfkb
         z11oUIzUFUMwPDkt/KnI9xGFxnFB/TmD7UpPQz3bAg7pOp6JBHWDN4MbW1qU4kWxSieO
         hvVR1kI2DvH6qrpKjlVoEJuAeLbe4EoPWDhDPWeU/HneM8VG4bZLdJL6cx3DxcB+Z6uU
         1im1i8ylbHHUqCu7x/0DET2TAhJYsosLqFzAII29FLRH6SxfVWylSuWHcy/OGnlDfXNa
         lgootNfJuog6a0eyFjxRjRQJ14Wvn+RtQ1tFK021p+Jchglskuj8snHdhljalOej9rwn
         R7Vw==
X-Gm-Message-State: AOAM533DxPP5VxSuu0A9Iz07D/hlTm1HJJ6VZhOnPsU5lHzg1QoJ5/Zh
        wCIXFCSTZhok3Yetf+SIHbKn2Q==
X-Google-Smtp-Source: ABdhPJzUjkxf4oTl38XpoTuIZ90ldSKeCXuYNmoMUkpEQWZP8didLAO2Ul56bAwAhDv2VYbyZkl84w==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr5107660wmc.51.1614879931659;
        Thu, 04 Mar 2021 09:45:31 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:31 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 5/6] block, bfq: keep shared queues out of the waker mechanism
Date:   Thu,  4 Mar 2021 18:46:26 +0100
Message-Id: <20210304174627.161-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Shared queues are likely to receive I/O at a high rate. This may
deceptively let them be considered as wakers of other queues. But a
false waker will unjustly steal bandwidth to its supposedly woken
queue. So considering also shared queues in the waking mechanism may
cause more control troubles than throughput benefits. This commit
keeps shared queues out of the waker-detection mechanism.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8497d0803d74..c62dbbe9cc33 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5852,7 +5852,17 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 			1UL<<(BFQ_RATE_SHIFT - 10))
 		bfq_update_rate_reset(bfqd, NULL);
 	bfqd->last_completion = now_ns;
-	bfqd->last_completed_rq_bfqq = bfqq;
+	/*
+	 * Shared queues are likely to receive I/O at a high
+	 * rate. This may deceptively let them be considered as wakers
+	 * of other queues. But a false waker will unjustly steal
+	 * bandwidth to its supposedly woken queue. So considering
+	 * also shared queues in the waking mechanism may cause more
+	 * control troubles than throughput benefits. Then do not set
+	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
+	 */
+	if (!bfq_bfqq_coop(bfqq))
+		bfqd->last_completed_rq_bfqq = bfqq;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
-- 
2.20.1

