Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF1C3402B
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941E220725
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgBQVIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40993 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so7202631plr.8
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2020 13:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzxine3G1GCtDYs+i7zBL+3PmcTRWigNPPzWowk8ylI=;
        b=CbK1E1DWl5d3OipljFSTGT7N9zWrEsgwnGgA6mRo4iA3dc6aEmvEe8R0lWGq4O5mPt
         OMqSGfDfA7rI7ZiajFaURWTCvgKMtjiBd8XNoJbLCkOQDn35YW7hI+3nfL3QMaAAiYEt
         MJQIdsKZnZjjAGGJzv2+VlKUFNpdxZiJtDMCg1KSO/3ucYetj3RndziFnyAt17Ws1KuJ
         Ww52v5CVvUWcID1O3QeHeBr6IK0n+tLGn4f7DVcnBbupi41HZOiDPIHRxB/Ew2uKn9ZX
         Lyj1CdqS0JWfu/dC3qRWh4E34W/dN/nI8SqoiMTl+FySPY/9fSo9rcVc1njvuiI/mcHM
         weRQ==
X-Gm-Message-State: APjAAAVFfpH2Dja8b3KC37/WpgUdbRksCihdvDpi7ezC4olWgUZGpA9B
        KKjfYjntsVbfQMwTDMoWp7PyQTsDWtQ=
X-Google-Smtp-Source: APXvYqz2uwh7HwnDwGQ2jQxdl4c8W6BEFFHne1Lw/k9RspUQPAFzjQzHF/jvNnlQocZf6uteMzxaOw==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr1068662pjq.115.1581973727263;
        Mon, 17 Feb 2020 13:08:47 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id h13sm362952pjc.9.2020.02.17.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:08:46 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/5] blk-mq: Fix a comment in include/linux/blk-mq.h
Date:   Mon, 17 Feb 2020 13:08:35 -0800
Message-Id: <20200217210839.28535-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217210839.28535-1-bvanassche@acm.org>
References: <20200217210839.28535-1-bvanassche@acm.org>
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
