Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC6C4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhKWS4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbhKWS4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA594C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UESKk3x2lEoxghuiQeFJpKV4NbO8aiDL7xVa8DnX880=; b=Yy8RbdQ6xUUMAy8sCkmZFhQpG9
        Xptqibuz+cTediMVUIk9SE4eQnp+PDzExyYXd5Rw7g+Jhl37ENLqLGWyQbwhMM97f0jeAAJxQjBSa
        2xBIbN7cjXNNR7dvhELNINpkGYYb3CvI3D4whDIO08BVERbtMsHFpt5r+TYm5tC6OeYZlB5C6F2XX
        mKMfV5QvHfeodpEjDdLrlWubUulxyPkXMEkOhxhpbNuphKrkD40waW5wlHef2BqZ9m3fyM7+3Uw0w
        D7xca8HnD8Zui7sdtVAd8JGu+WB4G0yaNCgQQMLQjlgjdy55ll9Z7XkI7yRTc5VzPKz9AvtmwzIvG
        CNGUjmBQ==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauy-00FzTL-7q; Tue, 23 Nov 2021 18:53:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: don't include <linux/idr.h> in blk.h
Date:   Tue, 23 Nov 2021 19:53:11 +0100
Message-Id: <20211123185312.1432157-8-hch@lst.de>
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
index a6e9ce3767802..4089aeffca4b0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -2,7 +2,6 @@
 #ifndef BLK_INTERNAL_H
 #define BLK_INTERNAL_H
 
-#include <linux/idr.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
-- 
2.30.2

