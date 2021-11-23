Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhKWS4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhKWS4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D2C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BOhFCSsN7Tj4qRXS7Cf1DxkGwujJC8gEz/+lq9bREE4=; b=J0jcOvqXI/30itCY5evd7kbboB
        zLaP2cYK1ETQBctdRKq7zP0zaFu4TzByyuZwSRyWBjSICV6T8eGfM2J7/DUbDY3uAVYMhcLv2QOIT
        D+SY080+xlLDxTXSOXaayCwZORTWLWhRpiOgYFN6tqj0ss5xA1v6r6N0GLfSJXP+LVsrw5YM+UdPL
        tDagdy3SxE2Dbxx8sxEmd0UgnBTRAaTQqFGEIpzNZmhOXKDqaRGYx5fWCZV/b8skODtUxWwS+fBTm
        yHtnwrZhsUKrftqvNHPnRFgblZE+js4KUtXyYXp0T+xvA8kJnapr4MB2QRnzzyVCYfMAHwB0iIjgU
        oFno6r3w==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauu-00FzST-E6; Tue, 23 Nov 2021 18:53:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/8] block: don't include blk-mq.h in blk.h
Date:   Tue, 23 Nov 2021 19:53:09 +0100
Message-Id: <20211123185312.1432157-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No needed, shift a blk-stat.h include into the source file that needs it
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c | 1 +
 block/blk.h          | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e68a9a29..7c462c006b269 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -13,6 +13,7 @@
 #include <linux/blk-cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
+#include "blk-stat.h"
 #include "blk-throttle.h"
 
 /* Max dispatch from a group in 1 round */
diff --git a/block/blk.h b/block/blk.h
index db6efa351d3ec..0f9472bea6167 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -9,7 +9,6 @@
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
-#include "blk-mq.h"
 
 struct elevator_type;
 
-- 
2.30.2

