Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC1C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F863266
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhHPM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhHPM37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 08:29:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D6CC061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2DeTMhk+GK/sXecRfF8lGXe9iXfwaMAdCxq9HuiMAeY=; b=QmSuLW1NRmbTgMCtIF/YPiaeod
        GkOOxkOPfDrtJb8zPLh0Lz+1rD40/poqUqsLEZzbR69Irp84oIPHE7OB3PhB5fnIQLezCAFO3FuI/
        TJptMHrSmln/YXsbaMglDqlEJL3lEi8DAxd5gBdjaIEjGGFpC3ZZJNnLJBiT2aUPAwDx/ErooSuU+
        V7+xpEd7miwhDgMf4LxfJIwyAPlujiFWbLK0nQGtzWrNaSLy5B5j01lbfrFqkIOrBJOvJFlnfAUR3
        mACP3cAF1DqNQSouKcuTO6dE0qiQoY2EZahDK90DdReZT/WOv4idF0r78t0yVnVrGfvv68zyFyAyR
        ivNGNvRA==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFbj7-001LCo-Ge; Mon, 16 Aug 2021 12:28:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-block@vger.kernel.org,
        syzbot <syzbot+1fb38bb7d3ce0fa3e1c4@syzkaller.appspotmail.com>
Subject: [PATCH 2/2] block: ensure the bdi is freed after inode_detach_wb
Date:   Mon, 16 Aug 2021 14:26:14 +0200
Message-Id: <20210816122614.601358-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816122614.601358-1-hch@lst.de>
References: <20210816122614.601358-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

inode_detach_wb references the "main" bdi of the inode.  With the
recent change to move the bdi from the request_queue to the gendisk
this causes a guaranteed use after free when using certain cgroup
configurations.  The big itself is older through as any non-default
inode reference (e.g. an open file descriptor) could have injected
this use after free even before that.

Fixes: 52ebea749aae ("writeback: make backing_dev_info host cgroup-specific bdi_writebacks")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Reported-by: syzbot <syzbot+1fb38bb7d3ce0fa3e1c4@syzkaller.appspotmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c  | 1 -
 fs/block_dev.c | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ed58ddf6258b..731a46063132 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1084,7 +1084,6 @@ static void disk_release(struct device *dev)
 
 	might_sleep();
 
-	bdi_put(disk->bdi);
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4bd2a632c79c..d3a8062302a0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -812,8 +812,11 @@ static void bdev_free_inode(struct inode *inode)
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 
-	if (!bdev_is_partition(bdev))
+	if (!bdev_is_partition(bdev)) {
+		if (bdev->bd_disk && bdev->bd_disk->bdi)
+			bdi_put(bdev->bd_disk->bdi);
 		kfree(bdev->bd_disk);
+	}
 
 	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(bdev->bd_dev));
@@ -833,8 +836,6 @@ static void bdev_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
-	/* Detach inode from wb early as bdi_put() may free bdi->wb */
-	inode_detach_wb(inode);
 }
 
 static const struct super_operations bdev_sops = {
-- 
2.30.2

