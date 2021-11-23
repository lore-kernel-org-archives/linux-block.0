Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB22C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhKWS4d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhKWS4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20643C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z+C8hU5IIRYVBDDY7I4QhqwiQ7xGLFUtoSEeBohsWQs=; b=BczhmE6UtEvAObv/PUQ78dX/ZK
        r41Knai+yqiZZd2PmViAkYIYoIRnr9NoYj6tR6/Sr7nl8xrQV2mmf690yBFegXR6GHp/50ZRFF3fU
        mjdyR5XigkXwiGzr6b03jJJFwuqk8pqE1BA5wTB+yNQDY7Az3qPVWtbRWwrFD512KTLRrN6SHdDQ2
        FSRGiukhaLRanbqGjRI4Jfep4PJVQ/RCyRAYSsJh14E1dUYLY4RL/iuoTITSVAMcJpwMxY9kjziKU
        G2AVKFwA/BlicuznfeQYRyDd+tjHi6zE/2R8GCy6k37UgA9oVpPnRXaOEhOKlIrlobfHkKSyDxzFH
        GFagNCfg==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauw-00FzSx-KD; Tue, 23 Nov 2021 18:53:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/8] block: don't include <linux/blk-mq.h> in blk.h
Date:   Tue, 23 Nov 2021 19:53:10 +0100
Message-Id: <20211123185312.1432157-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 0f9472bea6167..a6e9ce3767802 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -3,7 +3,6 @@
 #define BLK_INTERNAL_H
 
 #include <linux/idr.h>
-#include <linux/blk-mq.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
-- 
2.30.2

