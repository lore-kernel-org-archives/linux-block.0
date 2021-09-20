Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2799610A0
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhITMmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhITMms (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:42:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1603C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=opY5yNG9aaBSMMSQn/Gu6NHBK9MuMIt+xgH/pqHpWWY=; b=GK0Bl5Wy9SMDuNs/w3jJUajhYF
        v4b1L4gJ5ia0oj+5j56UNO0wBWzhC040myUL1/DLrN9zWh9izzJSoYus7o0HcXgsIxwwV9m29vRB0
        c4ow/spXep768cr0yURtil76JW+Krl/3UFIVp/pS3qO+/63d/yFMzX9ObiOGcUpaN5C699U6x9lTF
        RUucduDXYixNxD8WvcbqJzwC8LcQzagMyQOyVZPwnJuNh+mAPjV8UhTWKky3BVLBKp1U1cfc1DCGb
        J08sKjXij+y9TYwEcwl6RZOBYfS9nI3ZeiDHGa4vfLrkdBd74uC3Sga2DJTYQnv7vhLUMYaBxnXpu
        CLVNuPEQ==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIbN-002fN8-Tt; Mon, 20 Sep 2021 12:41:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/17] block: remove the struct blk_queue_ctx forward declaration
Date:   Mon, 20 Sep 2021 14:33:22 +0200
Message-Id: <20210920123328.1399408-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This type doesn't exist at all, so no need to forward declare it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6737e484280d3..4bcbb1ae2d66a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -253,8 +253,6 @@ static inline unsigned short req_get_ioprio(struct request *req)
 
 #include <linux/elevator.h>
 
-struct blk_queue_ctx;
-
 struct bio_vec;
 
 enum blk_eh_timer_return {
-- 
2.30.2

