Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C08C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9855611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUK2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUK2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:28:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA292C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FmHY8u3NROG/h9Lhq2XGuuCYJfPHXAKrl8fd20WEY5s=; b=p2siIeqUNcpbOWz2hOCPkOw8Bo
        DGvmBUnEp5VPionQbC4oR36ldZHw3OV3EIsS1vpgBoA/xrV27zNQb+cQx5fMGD/BM1CSpVHIYOQQ+
        IU7HzS2z0AUyz/bnexjMVxYQN+O2w1OwfyykXFnq3DZSgJKdje/9VDAI4Ta9Gir5cG6dO4OegTUYJ
        PyxGj8bnGkvWe/cftepb51Nnn4yDUBiPza8GWdp7LsGZw/nY3L08FVqzhs247bXqJvXj0LxXsnDzV
        PhnTYIc4A6j+AtAA4gpCbX6Mps6kUbizIN2v3Qc2+uHgvYvkxDVIWAnmxfCxvsxjdyffwl5cHkxoZ
        IfKUzO5g==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvH7x-00CyzQ-EF; Mon, 21 Jun 2021 10:26:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/9] loop: remove the l argument to loop_add
Date:   Mon, 21 Jun 2021 12:15:41 +0200
Message-Id: <20210621101547.3764003-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of the callers cares about the allocated struct loop_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9df9fb490f87..8392722d0e12 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2069,7 +2069,7 @@ static const struct blk_mq_ops loop_mq_ops = {
 	.complete	= lo_complete_rq,
 };
 
-static int loop_add(struct loop_device **l, int i)
+static int loop_add(int i)
 {
 	struct loop_device *lo;
 	struct gendisk *disk;
@@ -2157,7 +2157,6 @@ static int loop_add(struct loop_device **l, int i)
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
-	*l = lo;
 	return lo->lo_number;
 
 out_cleanup_tags:
@@ -2227,7 +2226,7 @@ static void loop_probe(dev_t dev)
 
 	mutex_lock(&loop_ctl_mutex);
 	if (loop_lookup(&lo, idx) < 0)
-		loop_add(&lo, idx);
+		loop_add(idx);
 	mutex_unlock(&loop_ctl_mutex);
 }
 
@@ -2249,7 +2248,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			ret = -EEXIST;
 			break;
 		}
-		ret = loop_add(&lo, parm);
+		ret = loop_add(parm);
 		break;
 	case LOOP_CTL_REMOVE:
 		ret = loop_lookup(&lo, parm);
@@ -2277,7 +2276,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, -1);
 		if (ret >= 0)
 			break;
-		ret = loop_add(&lo, -1);
+		ret = loop_add(-1);
 	}
 	mutex_unlock(&loop_ctl_mutex);
 
@@ -2304,7 +2303,6 @@ MODULE_ALIAS("devname:loop-control");
 static int __init loop_init(void)
 {
 	int i, nr;
-	struct loop_device *lo;
 	int err;
 
 	part_shift = 0;
@@ -2358,7 +2356,7 @@ static int __init loop_init(void)
 	/* pre-create number of devices given by config or max_loop */
 	mutex_lock(&loop_ctl_mutex);
 	for (i = 0; i < nr; i++)
-		loop_add(&lo, i);
+		loop_add(i);
 	mutex_unlock(&loop_ctl_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
-- 
2.30.2

