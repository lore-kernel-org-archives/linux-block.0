Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1AC47080
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 11:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDBF613B1
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFALDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:03:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhFALDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 07:03:44 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC74A21922;
        Tue,  1 Jun 2021 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622545322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OZt2SiQbqKVL9pvYj4mGQTWSD0tVMGOogS8NZiduT00=;
        b=MWNqQQTAPWrmOlAtuvKa8WBdgp2iakD+tbr/NtWDR6pXNnAC/f3aEWeaC4cpYZMO0e01eX
        IG5j0UHFW/G9JiwC72ndoZoVYpwpwii95wm7a9fwnoVK9DWc0B12LcEEuUqRXUwBxqTUgE
        j06U5JTDpyl7WVHO71jnH62yLr+mOZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622545322;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OZt2SiQbqKVL9pvYj4mGQTWSD0tVMGOogS8NZiduT00=;
        b=0zMTSVcAlHSBbCefV3296LrJgxy2vNFojd02hazCbBlWWKVxJEfGTipOSwBi72LI87YjLo
        8hZ4VvZFZVOdyMDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C4AE1A3B83;
        Tue,  1 Jun 2021 11:02:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8FE9E516FA52; Tue,  1 Jun 2021 13:02:02 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] block/genhd: use atomic_t for disk_event->block
Date:   Tue,  1 Jun 2021 13:01:45 +0200
Message-Id: <20210601110145.113365-1-hare@suse.de>
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..07e70f0c9c25 100644
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
@@ -1467,23 +1461,19 @@ static void __disk_unblock_events(struct gendisk *disk, bool check_now)
 	unsigned long intv;
 	unsigned long flags;
 
+	if (atomic_dec_return(&ev->block) <= 0) {
+		mutex_unlock(&ev->block_mutex);
+		return;
+	}
 	spin_lock_irqsave(&ev->lock, flags);
-
-	if (WARN_ON_ONCE(ev->block <= 0))
-		goto out_unlock;
-
-	if (--ev->block)
-		goto out_unlock;
-
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
@@ -1523,10 +1513,10 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
 
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
@@ -1638,11 +1628,11 @@ static void disk_check_events(struct disk_events *ev,
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
@@ -1807,7 +1797,7 @@ static void disk_alloc_events(struct gendisk *disk)
 	ev->disk = disk;
 	spin_lock_init(&ev->lock);
 	mutex_init(&ev->block_mutex);
-	ev->block = 1;
+	atomic_set(&ev->block, 1);
 	ev->poll_msecs = -1;
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
@@ -1851,6 +1841,6 @@ static void disk_del_events(struct gendisk *disk)
 static void disk_release_events(struct gendisk *disk)
 {
 	/* the block count should be 1 from disk_del_events() */
-	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
+	WARN_ON_ONCE(disk->ev && atomic_read(&disk->ev->block) != 1);
 	kfree(disk->ev);
 }
-- 
2.29.2

