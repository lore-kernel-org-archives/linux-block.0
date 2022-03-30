Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC56C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiC3Fb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiC3Fbz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1823C1C9B4B
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MuFp2PEYVgAJNpwoksEBN8g5TKJG7AFoiRM8TdlFZDA=; b=OZp2DQSYOmf7uBkzH5buwuK6eo
        TjHODBgAsiiYLrKZjBnqdY097SC41tRar3dyJlLwfk4O5WR6YDkseqbvkuTCopbmbIoy3JQc0g6rg
        SBjWUQtKdDyH4QbV/ZVVkeAKtpFugU7sqpGZq7TuHiXR5FmFJWm2nZ0AFulm5FTiN0Y0kYwl4drwb
        TisumE0K4RjjDmy5joA9GRr9NWvsdyFeDttlhA80A3xBYZDBZfz7oK3IQJlkrpIuytzTbL81w/cU9
        afZlFMsdSkNI8pz8B9NDS2BUx5KvBnowB0jyQk+vltH5lzq9Z6SEnsqBwWaZV2NoOCwm0rqyOAmpr
        cSWZ9PQA==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQuB-00ELRA-9Q; Wed, 30 Mar 2022 05:30:03 +0000
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
Subject: [PATCH 11/15] loop: implement ->free_disk
Date:   Wed, 30 Mar 2022 07:29:13 +0200
Message-Id: <20220330052917.2566582-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
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

