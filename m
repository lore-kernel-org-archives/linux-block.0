Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE183C4332F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7D5610E8
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhI0WHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbhI0WGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:34 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE54C051745;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=12aNYf4JHxFW0Gi214P/st+WALXaltwzcvDZhKyLh8I=; b=eMCejdfAb0OnOB6/IaIv32IYTO
        lZf95UD2Ein1I+q88HO/mWKNgHacbiOD76ESwgJtxQ2wiLPEL/GQO8iqmM6elSNfkp0jXg2xZzBti
        jtuNdVzwokFJVENq8jSnNdJXt58hPXbQ6PAys9og0Hy59KiBBEFFvSY3Ie19Lp62OriwTA5KmA+Cf
        KzHdl260QVtcXNu5s4RR/C7na5xsSgYNSHqfPMQ1V1iCjzrfAwdUjK2sXF9ZnZIBBlAZrQ1/wHOf0
        yujstVQ7lm0oGgElD15PmYfMVmkynSsXUAplPkX71848og/8Z+Hr5asxybAWzGCT2uzN4kCTp44Yv
        zXFZtIUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VIL-M8; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 07/14] swim: simplify using blk_cleanup_disk() on swim_remove()
Date:   Mon, 27 Sep 2021 15:02:55 -0700
Message-Id: <20210927220302.1073499-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can simplify swim_remove() by using one call instead of two,
just as other drivers do. Use that pattern.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7ccc8d2a41bc..f085ea982bb7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -911,9 +911,8 @@ static int swim_remove(struct platform_device *dev)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
-		blk_cleanup_queue(swd->unit[drive].disk->queue);
+		blk_cleanup_disk(swd->unit[drive].disk);
 		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
-		put_disk(swd->unit[drive].disk);
 	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
2.30.2

