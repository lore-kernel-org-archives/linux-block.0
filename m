Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80633610A2
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbhI0WHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbhI0WGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:38 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099DC05174B;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FdGB7r/+MH6CVRDebnTYZstZWp3M+pSCw3Ya01FZoLE=; b=zwg6OSsnDGKEu0CbDkParc8ZVe
        S8pfz2lRLa7PQ/UrwpWw/JXEbsgnY10xWEgES39KlsN68N0245vFeLzyCk3UaS7SaGnzIVn0w/Il0
        Tp7OzwiuMc9vBojnalPUCECfJEGkQI/Or95zoh3FVkuwhURvSOLFslU2dfe/lXKB30D3+xOklxyuC
        jRSfu1ZAEE+hasihE37hjOPIhvkm2HnIDFD5AYzDOJnBkBoFCv+U6FMnL1vHSzcE3Z/HoZnKHIoZ+
        eJsKKx10AgCvtEbEk7MSXvN0etswMcR5UUc7Ikz3V+D6IkjqLUf9Ss9s0wApzVLqyQfKXOImyFR3M
        /xkg0i8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiG-004VIg-0o; Mon, 27 Sep 2021 22:03:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 11/14] block/ataflop: use the blk_cleanup_disk() helper
Date:   Mon, 27 Sep 2021 15:02:59 -0700
Message-Id: <20210927220302.1073499-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the helper to replace two lines with one.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..6a865d42b1fd 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2076,8 +2076,7 @@ static int __init atari_floppy_init (void)
 
 err:
 	while (--i >= 0) {
-		blk_cleanup_queue(unit[i].disk[0]->queue);
-		put_disk(unit[i].disk[0]);
+		blk_cleanup_disk(unit[i].disk[0]);
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
 
@@ -2135,8 +2134,7 @@ static void __exit atari_floppy_exit(void)
 			if (!unit[i].disk[type])
 				continue;
 			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_queue(unit[i].disk[type]->queue);
-			put_disk(unit[i].disk[type]);
+			blk_cleanup_disk(unit[i].disk[type]);
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
-- 
2.30.2

