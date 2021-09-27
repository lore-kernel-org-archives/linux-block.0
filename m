Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247AEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0650160EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhI0WGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbhI0WG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:28 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DDC051740;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PhsefcTyzBYmTELi91sPT5fpjIKsUhTq4DdmWtknBpg=; b=a4KXvFDJvErJXxwdSUoo6tyyX4
        /uQVS2LqEdjgNgJ/DEVzlihvRBQgaSFhbSnHTu4fMvAAbQfBkFN2gkiIB1NFTorDyuswnRe85KxFU
        D1o/FsIgbkq2FyNh/GWwfHDTVIXtKjVfXuYDM7EfGNivBUryPpINpRkzDlD0JyNCd2JgtLJy2B3Es
        /syBSEgYQDG8LKZ+ucr3BaEYOFbw2oSYyT9iV7xUcXUswf0SpyLaYAWqtblNeR3sMCw19Gc7dlhfl
        1xdeyqqvvf2jq4HjYZD6bWNUgh0zr9L6uBiwnynmRQs4oCi5jOP9DLRnNhBvsKm4TjnZYy/7RzQ7R
        1IbLzJbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VI0-FJ; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 03/14] floppy: use blk_cleanup_disk()
Date:   Mon, 27 Sep 2021 15:02:51 -0700
Message-Id: <20210927220302.1073499-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the blk_cleanup_queue() followed by put_disk() can be
replaced with blk_cleanup_disk(). No need for two separate
loops.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3e6390fd5f2b..9538146e520e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4950,13 +4950,9 @@ static void __exit floppy_module_exit(void)
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-				blk_cleanup_queue(disks[drive][i]->queue);
+				blk_cleanup_disk(disks[drive][i]);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
-		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
-			if (disks[drive][i])
-				put_disk(disks[drive][i]);
-		}
 	}
 
 	cancel_delayed_work_sync(&fd_timeout);
-- 
2.30.2

