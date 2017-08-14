Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752561AbdHNWFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2017 18:05:05 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc: kernel-team@fb.com, Kyungchan Koh <kyungchan.koh@gmail.com>,
        Shaohua Li <shli@fb.com>
Subject: [PATCH V2 4/9] nullb: use ida to manage index
Date: Mon, 14 Aug 2017 15:04:55 -0700
Message-Id: <0f5862935338b4dca65f606a7dadb8480017815c.1502746933.git.shli@fb.com>
In-Reply-To: <cover.1502746933.git.shli@fb.com>
References: <cover.1502746933.git.shli@fb.com>
In-Reply-To: <cover.1502746933.git.shli@fb.com>
References: <cover.1502746933.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

We now dynamically create disks. Managing the disk index with ida to
avoid bump up the index too much.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/null_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index cf14c46..2f66627 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -87,7 +87,7 @@ struct nullb {
 static LIST_HEAD(nullb_list);
 static struct mutex lock;
 static int null_major;
-static int nullb_indexes;
+static DEFINE_IDA(nullb_indexes);
 static struct kmem_cache *ppa_cache;
 static struct blk_mq_tag_set tag_set;
 
@@ -871,6 +871,8 @@ static void null_del_dev(struct nullb *nullb)
 {
 	struct nullb_device *dev = nullb->dev;
 
+	ida_simple_remove(&nullb_indexes, nullb->index);
+
 	list_del_init(&nullb->list);
 
 	if (dev->use_lightnvm)
@@ -1118,7 +1120,7 @@ static int null_add_dev(struct nullb_device *dev)
 	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	nullb->index = nullb_indexes++;
+	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
 	dev->index = nullb->index;
 	mutex_unlock(&lock);
 
-- 
2.9.5
