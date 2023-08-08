Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90BC05052
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHHR5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHHR4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F17BF57C
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F3E86237E
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90529C433C7;
        Tue,  8 Aug 2023 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503024;
        bh=Lzsg1DbcdMpSBtuF1sBjXJJgfjAquf8gIoL8FIwzV/Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UltWsrzB7Okj6k13VzOJPyMPLe37HnxcQZ90d/BaWqotNrvemCdA3Te9LuH0I++4j
         UxiyC/saI1jEwvLG0VSHotBAEGKglJszyD2g5p9UttXOYWzdeQMdEn3HkUfTjmN/U9
         eNWuohYW0uvgopS2tjFtxi4yJMKrCKo4h+2JqW7O7gWgXM+4I3PMHFe7QAsEJnYNfP
         1VlL+baW8zsGC5jgDr4RarRd7KexnL/kQaZ33PaJ4aiYKwAaDlw1IMUus+8IfXflSh
         1DEvhEUYWsNtHMYiA8hkLR/u+TzVcdMq2i/6gYToxSe+hmGTZzz6V1ygkBL1VY/b9C
         iGKzC84M9ucCQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Date:   Tue,  8 Aug 2023 22:56:58 +0900
Message-ID: <20230808135702.628588-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808135702.628588-1-dlemoal@kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace occurences of "PAGE_SHIFT - 9" in blk-settings.c with the
cleaner PAGE_SECTORS_SHIFT macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..5e2dbd34436b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -126,7 +126,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	unsigned int max_sectors;
 
 	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+		max_hw_sectors = 1 << PAGE_SECTORS_SHIFT;
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_hw_sectors);
 	}
@@ -148,7 +148,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 
 	if (!q->disk)
 		return;
-	q->disk->bdi->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	q->disk->bdi->io_pages = max_sectors >> PAGE_SECTORS_SHIFT;
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
@@ -398,7 +398,7 @@ void disk_update_readahead(struct gendisk *disk)
 	 */
 	disk->bdi->ra_pages =
 		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
-	disk->bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
+	disk->bdi->io_pages = queue_max_sectors(q) >> PAGE_SECTORS_SHIFT;
 }
 EXPORT_SYMBOL_GPL(disk_update_readahead);
 
-- 
2.41.0

