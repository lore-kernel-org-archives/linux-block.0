Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB546C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0836325E
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhHPMit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhHPMii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 08:38:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B0C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4Tw09+deBI5VDKUYjLwRBJuMtwPTUJ+VTo1JLSgAdJ0=; b=ocubiOixWUu5EYQwP+FpolnCoW
        Ggtr1DXCZs9JQ1JQyYUwEXfP4w3pFgXz6ZV+rY0+7SsHdau1R/0jKi7aSsjatwTgIPj/rZDxXgj9D
        mgZ/J4xHgHgcaXci+XU0Y0vQ4VQwqUp8DrdT3eFJhdd4zpYupNLg8Bs11PmzYBC/grsn5xr7UE9EF
        cvTSxSGInryo+eI6JASXx3/s9jntQ4aClZrQk3OY8hiZp5N0VB6L/5+6INf+8xFzmdhs/E/9ZP4Iq
        OIAaXbkzXxi84a1ekTEc5VH3zA2elu6+mhFsgdYst32aDOwcTAxYR/JIJsMHOh85Yi4gTmYn1dcXC
        CtzTXt2A==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFbrG-001LZe-DO; Mon, 16 Aug 2021 12:37:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: unexport blk_register_queue
Date:   Mon, 16 Aug 2021 14:36:49 +0200
Message-Id: <20210816123649.601591-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not actually used in any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1832587dce3a..586507a5b8c2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -939,7 +939,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_register_queue);
 
 /**
  * blk_unregister_queue - counterpart of blk_register_queue()
-- 
2.30.2

