Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A6C5ACC4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E021D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBTCot (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:44:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBTCot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1122402pfh.10
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzxine3G1GCtDYs+i7zBL+3PmcTRWigNPPzWowk8ylI=;
        b=TJEQAglbHqAMfF/49EF5HSYBda0nd3ZY77KFkcyKh1txgH7J8Q9EC6GsRwsVfpSiE4
         qsNjoSTpArRH6OH745RNwh/8gdI2TM2ipUDi1ucVGel/I8bNCAwKnMnvRDwuLo2emG4B
         nKCpYhe+ouWomCp7OuKB1z71cw9j8N6stoolVpBTfHuTUktcDpN8q8xujhq1FFMAkage
         QyoJbdGqZI4s7cyLpO3WHkBe7U4LOR2k/mzvNo0JEJbWaBXDNbTbQOYhMoNmdeaoBgBy
         dY5lm8KR2sOmyUnWGrKGJRyfhCJk6/9aIoyXVK09zhJM2SfI3lKGsHymn4IgS/sAZerf
         WW3g==
X-Gm-Message-State: APjAAAVRHw5P9WEse7/hB1kMt/kl4XxPCvI1qB0hCSX84AfIf2a3Zqpe
        82zs7itS6p0wlC8FbU+MQqoeA2sYWcU=
X-Google-Smtp-Source: APXvYqwJgO6qrayOt18h+rtaiEKMjsBnGp+KvzQ0f04LJ9xfJxHk80jB2/nqU1tEqZRXjb3n1SpiAw==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr1672521pgm.316.1582166688368;
        Wed, 19 Feb 2020 18:44:48 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:47 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 1/8] blk-mq: Fix a comment in include/linux/blk-mq.h
Date:   Wed, 19 Feb 2020 18:44:34 -0800
Message-Id: <20200220024441.11558-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'hctx_list' member of struct blk_mq_hw_ctx is not a list head but
instead an entry in q->unused_hctx_list. Fix the comment above this
struct member.

Cc: André Almeida <andrealmeid@collabora.com>
Fixes: d386732bc142 ("blk-mq: fill header with kernel-doc")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..31344d5f83e2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -162,7 +162,10 @@ struct blk_mq_hw_ctx {
 	struct dentry		*sched_debugfs_dir;
 #endif
 
-	/** @hctx_list:	List of all hardware queues. */
+	/**
+	 * @hctx_list: if this hctx is not in use, this is an entry in
+	 * q->unused_hctx_list.
+	 */
 	struct list_head	hctx_list;
 
 	/**
