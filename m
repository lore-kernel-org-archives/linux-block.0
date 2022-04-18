Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA2C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiDRPL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbiDRPLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 11:11:21 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAD985B1
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 07:03:53 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23IE3jol036151;
        Mon, 18 Apr 2022 23:03:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 18 Apr 2022 23:03:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23IE3jCp036148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Apr 2022 23:03:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9d1759e0-2f93-d49f-48b3-12b8d47e95cd@I-love.SAKURA.ne.jp>
Date:   Mon, 18 Apr 2022 23:03:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: [PATCH] aoe: Avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_wq with local aoe_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

 drivers/block/aoe/aoe.h     | 2 ++
 drivers/block/aoe/aoeblk.c  | 2 +-
 drivers/block/aoe/aoecmd.c  | 2 +-
 drivers/block/aoe/aoedev.c  | 4 ++--
 drivers/block/aoe/aoemain.c | 9 ++++++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 84d0fcebd6af..749ae1246f4c 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -244,3 +244,5 @@ void aoenet_exit(void);
 void aoenet_xmit(struct sk_buff_head *);
 int is_aoe_netif(struct net_device *ifp);
 int set_aoe_iflist(const char __user *str, size_t size);
+
+extern struct workqueue_struct *aoe_wq;
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 8a91fcac6f82..348adf335217 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -435,7 +435,7 @@ aoeblk_gdalloc(void *vp)
 err:
 	spin_lock_irqsave(&d->lock, flags);
 	d->flags &= ~DEVFL_GD_NOW;
-	schedule_work(&d->work);
+	queue_work(aoe_wq, &d->work);
 	spin_unlock_irqrestore(&d->lock, flags);
 }
 
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 384073ef2323..d7317425be51 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -968,7 +968,7 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 		d->flags |= DEVFL_NEWSIZE;
 	else
 		d->flags |= DEVFL_GDALLOC;
-	schedule_work(&d->work);
+	queue_work(aoe_wq, &d->work);
 }
 
 static void
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index c5753c6bfe80..b381d1c3ef32 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -321,7 +321,7 @@ flush(const char __user *str, size_t cnt, int exiting)
 			specified = 1;
 	}
 
-	flush_scheduled_work();
+	flush_workqueue(aoe_wq);
 	/* pass one: do aoedev_downdev, which might sleep */
 restart1:
 	spin_lock_irqsave(&devlist_lock, flags);
@@ -520,7 +520,7 @@ freetgt(struct aoedev *d, struct aoetgt *t)
 void
 aoedev_exit(void)
 {
-	flush_scheduled_work();
+	flush_workqueue(aoe_wq);
 	flush(NULL, 0, EXITING);
 }
 
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 1e4e2971171c..892d627a2379 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -35,6 +35,7 @@ aoe_exit(void)
 	aoechr_exit();
 	aoedev_exit();
 	aoeblk_exit();		/* free cache after de-allocating bufs */
+	destroy_workqueue(aoe_wq);
 }
 
 static int __init
@@ -42,9 +43,13 @@ aoe_init(void)
 {
 	int ret;
 
+	aoe_wq = alloc_workqueue("aoe_wq", 0, 0);
+	if (!aoe_wq)
+		return -ENOMEM;
+
 	ret = aoedev_init();
 	if (ret)
-		return ret;
+		goto dev_fail;
 	ret = aoechr_init();
 	if (ret)
 		goto chr_fail;
@@ -77,6 +82,8 @@ aoe_init(void)
 	aoechr_exit();
  chr_fail:
 	aoedev_exit();
+ dev_fail:
+	destroy_workqueue(aoe_wq);
 
 	printk(KERN_INFO "aoe: initialisation failure.\n");
 	return ret;
-- 
2.32.0


