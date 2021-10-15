Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D2C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CDF611C2
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 23:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhJOXzP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 19:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbhJOXzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 19:55:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A9C061762;
        Fri, 15 Oct 2021 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=omBKsWTl8Q/WM0k3AiOvEAjN+m9JDz574ka/nFE6G1U=; b=d3DuD+ntkjsX5wdLWBQUee/Kd4
        Ka8WmB4Njz7ZuaQfe42890YC5Ei+XlqIQYf4otyg27DZOBzEGweA/XIOCjKPda0mlZIzkM7zD/S89
        iRhbQwv0j63NfvXxDgtGtbzvfUTCh27v8rZE+AF0P6syYrDRfKVk9jlkvpepJhtdx6+Jm1HCpnzga
        j2DB1Xq9POr6uTmUluGCTwaiWICaNRsoR0OOUh3SceEzWf+EyVjAqPcSSSigfoLZxnBoBvzU3+Qbq
        r8FvoHNO6DLtHVeHtR3K3mezUwJnnmY7WWf9Llyug1fVocMzeKBs7pTKHfPacFnLhenLwBhkZDZgh
        toPZ4UoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbWzt-009C3A-7r; Fri, 15 Oct 2021 23:52:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/13] zram: add error handling support for add_disk()
Date:   Fri, 15 Oct 2021 16:52:14 -0700
Message-Id: <20211015235219.2191207-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0a9309a2ef54..bdbded107e6b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1983,7 +1983,9 @@ static int zram_add(void)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
-	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+	ret = device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+	if (ret)
+		goto out_cleanup_disk;
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
@@ -1991,6 +1993,8 @@ static int zram_add(void)
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
+out_cleanup_disk:
+	blk_cleanup_disk(zram->disk);
 out_free_idr:
 	idr_remove(&zram_index_idr, device_id);
 out_free_dev:
-- 
2.30.2

