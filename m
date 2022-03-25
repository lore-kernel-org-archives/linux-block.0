Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6519C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 06:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358473AbiCYGmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358474AbiCYGmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5485649
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MuFp2PEYVgAJNpwoksEBN8g5TKJG7AFoiRM8TdlFZDA=; b=3I8MW2iZSEm4q1aLu9uS2wql7U
        k8sdW2YHrwu/hrXQn8o0nKyH22L6KvKS/I0aRbNkfIz7XLorzoe3+4d3N5soJJW0KaXFtfVFV43/q
        5kKPYm1ANldpXxk89kAIUefAkKUTFICmeObrFfnxTU2WvxKk5baaDQLVRQIM6CWumgwcwngQA0npn
        xCOACVdRcN2G359BH/dZcKLGBtqA2gz8PriTnjYc/Kxhq7WMkGJUa5qn6fnW7FJysLRWAcRg+kMbb
        4uKyxu3W8atYX47uWwR3Me70V6j1B6sWajoJNZ9E8FC3KiVqluy2/Xh31NKM6RH4K2gG35BLJlgwf
        SR1hLopg==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdcM-001HR2-IS; Fri, 25 Mar 2022 06:40:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 11/14] loop: implement ->free_disk
Date:   Fri, 25 Mar 2022 07:39:26 +0100
Message-Id: <20220325063929.1773899-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure that the lo_device which is stored in the gendisk private
data is valid until the gendisk is freed.  Currently the loop driver
uses a lot of effort to make sure a device is not freed when it is
still in use, but to to fix a potential deadlock this will be relaxed
a bit soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a5dd259958ee2..b3170e8cdbe95 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1765,6 +1765,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void lo_free_disk(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	mutex_destroy(&lo->lo_mutex);
+	kfree(lo);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
@@ -1773,6 +1781,7 @@ static const struct block_device_operations lo_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
 #endif
+	.free_disk =	lo_free_disk,
 };
 
 /*
@@ -2064,15 +2073,14 @@ static void loop_remove(struct loop_device *lo)
 {
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
-	blk_cleanup_disk(lo->lo_disk);
+	blk_cleanup_queue(lo->lo_disk->queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	mutex_unlock(&loop_ctl_mutex);
-	/* There is no route which can find this loop device. */
-	mutex_destroy(&lo->lo_mutex);
-	kfree(lo);
+
+	put_disk(lo->lo_disk);
 }
 
 static void loop_probe(dev_t dev)
-- 
2.30.2

