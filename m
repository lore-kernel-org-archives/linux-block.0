Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7AD60F0F
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 20:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1Uie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1Uie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 16:38:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0BC061570;
        Thu, 28 Oct 2021 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LX6K9oTgNbH+UMBpyJZsK97HkfDlA20CVm5u+Vv4f3E=; b=32L6dRGIMGbYnYxVZLsriMubkW
        nzw7Knt3nRE7Fv6kpBPY+RAqS3+eiiayJxQQ4y3Dto7quWrYM3fxgwk5lFo7Z/BU/bA2zqcLFAGOT
        xefHURRhmruyq+4C81a47La954GM+/05xztPqn3NBPOBAUZ/pBW2aH7eOS9yzZ+vLJMZCiLIb9EDp
        Sj0rf0Aej+DkA9wQi0F4aPnO3VO98uOjfPEIifYVUzmG+uZuDaYa+tJ9qKqYun/uKFtVnK5vSxiXM
        uMvFHFuCGyjR1LiO4bKL8i4HXZxCu1+hvRizuYyILCytWMBT9pdPh1ybatDrEoJMZmCrgCHlDmCuQ
        sSl9MUmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgC84-0093FY-U8; Thu, 28 Oct 2021 20:36:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] zram: use ATTRIBUTE_GROUPS
Date:   Thu, 28 Oct 2021 13:36:00 -0700
Message-Id: <20211028203600.2157356-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Embrace ATTRIBUTE_GROUPS to avoid boiler plate code.
This should not introduce any functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..268f727f7cba 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1874,14 +1874,7 @@ static struct attribute *zram_disk_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group zram_disk_attr_group = {
-	.attrs = zram_disk_attrs,
-};
-
-static const struct attribute_group *zram_disk_attr_groups[] = {
-	&zram_disk_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(zram_disk);
 
 /*
  * Allocate and initialize new zram device. the function returns
@@ -1953,7 +1946,7 @@ static int zram_add(void)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
-	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+	device_add_disk(NULL, zram->disk, zram_disk_groups);
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
-- 
2.33.0

