Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0708C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C19246B5
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GzsEM8jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1PGG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so1349011plp.7
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZlBfuXtP5k02GMiIbPSOAEi56vHJXlT1WiKn/fekYvs=;
        b=GzsEM8jv8UN0hv1bdw2lhxTiSYF+0+jdAb0JhSGNXn5SI+I2jIoXnXot9KW1SwU0uL
         vokIFTCNZ1R21Npfe7uHyWSabzwk1SFkUUYNpAENS9jKb8FyApr6xQPjmuKfFaEzWff4
         /UhvnVJeCtLRFdOHSFMSsLSoSPZTQUIGQMgnJeALpegUBrIDM0hL2HZERItTDiT3NP3A
         9w1bQKOdgXMElyCa9eIjD9qnR0YFwmysIYDUfh4YAuH/hEaePls+MZGK7RqCJzVS6ZQH
         SpqWlNIU5d3Dt92kKnQtGeTaVjgjrP0cCS0Z9TGU4lwJIr0ysETGJ/s3s9nF+o7tvwJU
         tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZlBfuXtP5k02GMiIbPSOAEi56vHJXlT1WiKn/fekYvs=;
        b=fP6m7j6KRFfu9EtHIH7vZZW2qTrYb2VfOIbbKNOWtBZ5o4biiczEac6mZuX8ZFZ7OQ
         Mu0XHfIRBMmSlkngopoDlzalR3Au9B+LPOEHb/x1Lc6NiHOX3oGuawJMctf7VIhJghBH
         jZ0KrTRY/DQbfiZou26N7MvdLax5xX/3oBpY0FHcWiGaWw8FyNHk+nGKW+8klSC7t3qO
         tWe1fYpzvxtWsZ9JPIA8nbbHKPPwiwNrrIjJypJyGFmniIT0EF0kwLbvt2EflGaP1KHX
         GLjlKyrm34le6roIQyoKRdFKc5QjuxWhY5qf6pLti0yIQfWTpcgm3TRFYSBMZ4TmqyMb
         seEQ==
X-Gm-Message-State: APjAAAWVzV39z5ELCOypiRqP04I6hS77XD4LFxhNxZ5wE92tkBRvEA2n
        mZ9/aZQJ20Rm+BdoMDjqIDtX19dqn4jM00Je
X-Google-Smtp-Source: APXvYqzAoXpCPtf9Ukg9y39Au4yGkEmQTnrgp2R9a119EP/Obutqur9sqVu4XtF5ye+XQPEZZvGyxg==
X-Received: by 2002:a17:90a:c388:: with SMTP id h8mr5001156pjt.83.1582902364809;
        Fri, 28 Feb 2020 07:06:04 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:04 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/6] block: fix comment for blk_cloned_rq_check_limits
Date:   Fri, 28 Feb 2020 16:05:13 +0100
Message-Id: <20200228150518.10496-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the later description mentioned "checked against the new queue
limits", so make the change to avoid confusion.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..fd43266029be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL(submit_bio);
 
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
- *                              for new the queue limits
+ *                              for the new queue limits
  * @q:  the queue
  * @rq: the request being checked
  *
-- 
2.17.1

