Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA0C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8DB2171F
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfIQL4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfIQL4T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 07:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A06418C891B;
        Tue, 17 Sep 2019 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DB1A19C4F;
        Tue, 17 Sep 2019 11:56:17 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v4 2/2] nbd: fix possible page fault for nbd disk
Date:   Tue, 17 Sep 2019 17:26:06 +0530
Message-Id: <20190917115606.13992-3-xiubli@redhat.com>
In-Reply-To: <20190917115606.13992-1-xiubli@redhat.com>
References: <20190917115606.13992-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 11:56:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When the NBD_CFLAG_DESTROY_ON_DISCONNECT flag is set and at the same
time when the socket is closed due to the server daemon is restarted,
just before the last DISCONNET is totally done if we start a new connection
by using the old nbd_index, there will be crashing randomly, like:

<3>[  110.151949] block nbd1: Receive control failed (result -32)
<1>[  110.152024] BUG: unable to handle page fault for address: 0000058000000840
<1>[  110.152063] #PF: supervisor read access in kernel mode
<1>[  110.152083] #PF: error_code(0x0000) - not-present page
<6>[  110.152094] PGD 0 P4D 0
<4>[  110.152106] Oops: 0000 [#1] SMP PTI
<4>[  110.152120] CPU: 0 PID: 6698 Comm: kworker/u5:1 Kdump: loaded Not tainted 5.3.0-rc4+ #2
<4>[  110.152136] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
<4>[  110.152166] Workqueue: knbd-recv recv_work [nbd]
<4>[  110.152187] RIP: 0010:__dev_printk+0xd/0x67
<4>[  110.152206] Code: 10 e8 c5 fd ff ff 48 8b 4c 24 18 65 48 33 0c 25 28 00 [...]
<4>[  110.152244] RSP: 0018:ffffa41581f13d18 EFLAGS: 00010206
<4>[  110.152256] RAX: ffffa41581f13d30 RBX: ffff96dd7374e900 RCX: 0000000000000000
<4>[  110.152271] RDX: ffffa41581f13d20 RSI: 00000580000007f0 RDI: ffffffff970ec24f
<4>[  110.152285] RBP: ffffa41581f13d80 R08: ffff96dd7fc17908 R09: 0000000000002e56
<4>[  110.152299] R10: ffffffff970ec24f R11: 0000000000000003 R12: ffff96dd7374e900
<4>[  110.152313] R13: 0000000000000000 R14: ffff96dd7374e9d8 R15: ffff96dd6e3b02c8
<4>[  110.152329] FS:  0000000000000000(0000) GS:ffff96dd7fc00000(0000) knlGS:0000000000000000
<4>[  110.152362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  110.152383] CR2: 0000058000000840 CR3: 0000000067cc6002 CR4: 00000000001606f0
<4>[  110.152401] Call Trace:
<4>[  110.152422]  _dev_err+0x6c/0x83
<4>[  110.152435]  nbd_read_stat.cold+0xda/0x578 [nbd]
<4>[  110.152448]  ? __switch_to_asm+0x34/0x70
<4>[  110.152468]  ? __switch_to_asm+0x40/0x70
<4>[  110.152478]  ? __switch_to_asm+0x34/0x70
<4>[  110.152491]  ? __switch_to_asm+0x40/0x70
<4>[  110.152501]  ? __switch_to_asm+0x34/0x70
<4>[  110.152511]  ? __switch_to_asm+0x40/0x70
<4>[  110.152522]  ? __switch_to_asm+0x34/0x70
<4>[  110.152533]  recv_work+0x35/0x9e [nbd]
<4>[  110.152547]  process_one_work+0x19d/0x340
<4>[  110.152558]  worker_thread+0x50/0x3b0
<4>[  110.152568]  kthread+0xfb/0x130
<4>[  110.152577]  ? process_one_work+0x340/0x340
<4>[  110.152609]  ? kthread_park+0x80/0x80
<4>[  110.152637]  ret_from_fork+0x35/0x40

This is very easy to reproduce by running the nbd-runner.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7e0501c47153..ac07e8c94c79 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -26,6 +26,7 @@
 #include <linux/ioctl.h>
 #include <linux/mutex.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -80,6 +81,9 @@ struct link_dead_args {
 #define NBD_RT_DESTROY_ON_DISCONNECT	6
 #define NBD_RT_DISCONNECT_ON_CLOSE	7
 
+#define NBD_DESTROY_ON_DISCONNECT	0
+#define NBD_DISCONNECT_REQUESTED	1
+
 struct nbd_config {
 	u32 flags;
 	unsigned long runtime_flags;
@@ -113,6 +117,9 @@ struct nbd_device {
 	struct list_head list;
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
+
+	struct completion *destroy_complete;
+	unsigned long flags;
 };
 
 #define NBD_CMD_REQUEUED	1
@@ -223,6 +230,16 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 		disk->private_data = NULL;
 		put_disk(disk);
 	}
+
+	/*
+	 * Place this in the last just before the nbd is freed to
+	 * make sure that the disk and the related kobject are also
+	 * totally removed to avoid duplicate creation of the same
+	 * one.
+	 */
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) && nbd->destroy_complete)
+		complete(nbd->destroy_complete);
+
 	kfree(nbd);
 }
 
@@ -1125,6 +1142,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
 
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
+	set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
 	send_disconnects(nbd);
 	return 0;
 }
@@ -1636,6 +1654,7 @@ static int nbd_dev_add(int index)
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
+	nbd->destroy_complete = NULL;
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
 	if (err)
@@ -1750,6 +1769,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
+	DECLARE_COMPLETION_ONSTACK(destroy_complete);
 	struct nbd_device *nbd = NULL;
 	struct nbd_config *config;
 	int index = -1;
@@ -1801,6 +1821,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		mutex_unlock(&nbd_index_mutex);
 		return -EINVAL;
 	}
+
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
+	    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
+		nbd->destroy_complete = &destroy_complete;
+		mutex_unlock(&nbd_index_mutex);
+
+		/* Wait untill the the nbd stuff is totally destroyed */
+		wait_for_completion(&destroy_complete);
+		goto again;
+	}
+
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		if (index == -1)
@@ -1855,7 +1886,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
 			set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 				&config->runtime_flags);
+			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 			put_dev = true;
+		} else {
+			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		}
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
 			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
@@ -2029,10 +2063,12 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			if (!test_and_set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					      &config->runtime_flags))
 				put_dev = true;
+			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		} else {
 			if (test_and_clear_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					       &config->runtime_flags))
 				refcount_inc(&nbd->refs);
+			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
 		}
 
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
-- 
2.21.0

