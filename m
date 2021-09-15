Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3559C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D621460F8F
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhIOGui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhIOGui (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299EC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ngp4mt8OG2XgNvPQKgO+avIHV37KM8ekIOHG1V6M0iM=; b=fYoVFfhcvWtyYlKmsaZvV8g32e
        J4m9U+QtvpY76nFPduLfB728RV12lExvMuHP5Yp57MmCqTzab9vC7INXUoe9uiD0UCtXxES81I2jX
        kZQ4m4Gx3KbcKsTQyuu8zMb5o9H5sOiObUF56U5KVir8kJKP3/JuwyuEwRHvMS7BE8Ut4u0bLMRty
        0fsk5cblR7MvSvhwLJtLbxu0Y1z/vykt3kIlBvrkEGAihnLUR6hYh8qJX/KWUOp6OkHAaLIdeoDxq
        tiD9pMADbiTXHZT7tWNjFFi3AKWq79c0H3a02bRcxvVF4uF2LxcY0Rz8wdpLYUIff+XMphKQaXmVQ
        4thoVo0A==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOi0-00FQwM-Cq; Wed, 15 Sep 2021 06:48:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/17] block: remove the unused blk_queue_state enum
Date:   Wed, 15 Sep 2021 08:40:36 +0200
Message-Id: <20210915064044.950534-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980ee..9e367509bea10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -262,11 +262,6 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
-enum blk_queue_state {
-	Queue_down,
-	Queue_up,
-};
-
 #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
 #define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
 
-- 
2.30.2

