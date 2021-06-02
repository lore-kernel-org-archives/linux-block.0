Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE6CC47092
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC886121D
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 06:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhFBGWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 02:22:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFBGWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 02:22:03 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26C331FD49;
        Wed,  2 Jun 2021 06:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622614820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oLUpoRLLvxuZBzEdtKINYg1RrKnb5TlkKe2Pg3mgTJI=;
        b=CunjXEnsnQm85l2FuXBAYaVCB7HopXt7sioDE/7/nn9KHAYvxrw8iFjZgBLWamISyM7/CP
        ElXaJ2r9lUIfK/yFNiEWqeMOq20W4HFIcIjwAmRj37kF4HwIyCQ2mEtqKRFI67S+8WgTYs
        haNFzwXU8Z3VG3ZSSDX1DPE2v//Fxto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622614820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oLUpoRLLvxuZBzEdtKINYg1RrKnb5TlkKe2Pg3mgTJI=;
        b=LtI956xwpwO9ssG8NzgPzasGlxFHck86hd/1JBFHdcvWQHiEC+lQQ6/GIcl2PkabQgYCgS
        FvUmjZLrlAuw51AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0B7B4A3B91;
        Wed,  2 Jun 2021 06:20:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id F1437516FAC7; Wed,  2 Jun 2021 08:20:19 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] block/genhd: use atomic_t for disk_event->block
Date:   Wed,  2 Jun 2021 08:20:15 +0200
Message-Id: <20210602062015.33605-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__disk_unblock_events() will call queue_delayed_work() with a '0' argument
under a spin lock. This might cause the queue_work item to be executed
immediately, and run into a deadlock in disk_check_events() waiting for
the lock to be released.

This patch converts the 'blocked' counter into an atomic variable, so we don't
need to hold a spinlock anymore when scheduling the workqueue function.

Changes to v1:
- Fixup wrong mutex_unlock detected by 0-day robot

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..a18a3058728b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1379,7 +1379,7 @@ struct disk_events {
 	spinlock_t		lock;
 
 	struct mutex		block_mutex;	/* protects blocking */
-	int			block;		/* event blocking depth */
+	atomic_t		block;		/* event blocking depth */
 	unsigned int		pending;	/* events already sent out */
 	unsigned int		clearing;	/* events being cleared */
 
@@ -1439,8 +1439,6 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
 void disk_block_events(struct gendisk *disk)
 {
 	struct disk_events *ev = disk->ev;
-	unsigned long flags;
-	bool cancel;
 
 	if (!ev)
 		return;
@@ -1451,11 +1449,7 @@ void disk_block_events(struct gendisk *disk)
 	 */
 	mutex_lock(&ev->block_mutex);
 
-	spin_lock_irqsave(&ev->lock, flags);
-	cancel = !ev->block++;
-	spin_unlock_irqrestore(&ev->lock, flags);
-
-	if (cancel)
+	if (atomic_inc_return(&ev->block) == 1)
 		cancel_delayed_work_sync(&disk->ev->dwork);
 
 	mutex_unlock(&ev->block_mutex);
@@ -1467,23 +1461,18 @@ static void __disk_unblock_events(struct gendisk *disk, bool check_now)
 	unsigned long intv;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ev->lock, flags);
-
-	if (WARN_ON_ONCE(ev->block <= 0))
-		goto out_unlock;
-
-	if (--ev->block)
-		goto out_unlock;
+	if (atomic_dec_return(&ev->block) <= 0)
+		return;
 
+	spin_lock_irqsave(&ev->lock, flags);
 	intv = disk_events_poll_jiffies(disk);
+	spin_unlock_irqrestore(&ev->lock, flags);
 	if (check_now)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, 0);
 	else if (intv)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, intv);
-out_unlock:
-	spin_unlock_irqrestore(&ev->lock, flags);
 }
 
 /**
@@ -1523,10 +1512,10 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
 
 	spin_lock_irq(&ev->lock);
 	ev->clearing |= mask;
-	if (!ev->block)
+	spin_unlock_irq(&ev->lock);
+	if (!atomic_read(&ev->block))
 		mod_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, 0);
-	spin_unlock_irq(&ev->lock);
 }
 
 /**
@@ -1638,11 +1627,11 @@ static void disk_check_events(struct disk_events *ev,
 	*clearing_ptr &= ~clearing;
 
 	intv = disk_events_poll_jiffies(disk);
-	if (!ev->block && intv)
+	spin_unlock_irq(&ev->lock);
+	if (!atomic_read(&ev->block) && intv)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, intv);
 
-	spin_unlock_irq(&ev->lock);
 
 	/*
 	 * Tell userland about new events.  Only the events listed in
@@ -1807,7 +1796,7 @@ static void disk_alloc_events(struct gendisk *disk)
 	ev->disk = disk;
 	spin_lock_init(&ev->lock);
 	mutex_init(&ev->block_mutex);
-	ev->block = 1;
+	atomic_set(&ev->block, 1);
 	ev->poll_msecs = -1;
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
@@ -1851,6 +1840,6 @@ static void disk_del_events(struct gendisk *disk)
 static void disk_release_events(struct gendisk *disk)
 {
 	/* the block count should be 1 from disk_del_events() */
-	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
+	WARN_ON_ONCE(disk->ev && atomic_read(&disk->ev->block) != 1);
 	kfree(disk->ev);
 }
-- 
2.26.2

