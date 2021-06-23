Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B4C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B92608FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWPEA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:04:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC5C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XoP6Zb5BQuNW2F1akvMlxvEeo0gegatxAw2D0HU3vAg=; b=CjCFpFElncU+IxxVpKk51fbn7y
        tx/ktsuxRuSSQK2Jnc2qywCPXiiJKGrAWf2JCYWf1D6fpxsApwmLSSaJ7xAtQsKbbMzpWC3ArxQ1L
        D6Km+n1m1Y/C5/SVwtXZ14aIebunh0osM+2plHCSf05uFmMYSTG6ZZEnlpfV0JqEIQCNfzLtHloXe
        SAjKwcKus+Xh/IR47eiTf9VSjrSMY8kDWJolM22a/h4sG+EI8jK2ta8D3LxlNheg7T0P0HjQswWci
        Lt478vkv44CFQitNrxzl3xp1SyVB9RjFs5jWiFrMbQo4TD72AepoaNvEu4/3/pakgYFd5H/u3zrax
        VdaLKYDw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4NL-00FXwY-38; Wed, 23 Jun 2021 15:01:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/9] loop: remove the l argument to loop_add
Date:   Wed, 23 Jun 2021 16:59:02 +0200
Message-Id: <20210623145908.92973-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of the callers cares about the allocated struct loop_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

