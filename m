Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966EC11D25
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C1F222C4
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgBUDWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:22:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:22:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so474071pfc.1
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzxine3G1GCtDYs+i7zBL+3PmcTRWigNPPzWowk8ylI=;
        b=a2rom9uwpxe/3AAoY91uZrrlN2l7VGtoxojQoG9kechlHHCy3gs4Fv40ZXDGu/Iyb8
         tTo6yX9EVv6ARloLMyo6hh0rg8LW/7hUAt4WMN1PimXHOqY0UB/hk18nIwLILvQsTpvu
         ZNGSH9Aad98WpsJsLQRdHsYlAaiRbhki6iLKA4vf03+xK952r6PdvpQj+bqC5JIIRWXa
         nGaSR7fUfdWromefpFqArLEC5S8iasUK+6s+JQ44LvRA+u2zXaSQm/cwSIM4RkxHWrvR
         oBZk7UejFtkqSOk3+M6maKKNCYSMSKK2XRQQFzMxaEFvDphmXjg+omiUnVOGAZA6M9Jj
         bNzA==
X-Gm-Message-State: APjAAAWOoLc3JUlo7A7u3uBTZCbtzTlOpMDpV4b+JLuk5bgFJXoZu3ML
        Wu83MCmNKvoKdOGIZvOTPls=
X-Google-Smtp-Source: APXvYqyajh8usucBMRrU9acyt4D2jWYv3mHBFJve15AzLXZcTxk8RFEg74CLJgyt1og0pKYZIZHlSw==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr36211236pfb.184.1582255374758;
        Thu, 20 Feb 2020 19:22:54 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:22:54 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 1/8] blk-mq: Fix a comment in include/linux/blk-mq.h
Date:   Thu, 20 Feb 2020 19:22:36 -0800
Message-Id: <20200221032243.9708-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
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
