Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A2C432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C8821781
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1Kis (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:38:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfK1Kir (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 05:38:47 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 580AC7EBE1F7FFC1E90C;
        Thu, 28 Nov 2019 18:38:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 18:38:35 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <josef@toxicpanda.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>,
        <mchristi@redhat.com>
Subject: [PATCH] nbd: fix potential deadlock in nbd_config_put()
Date:   Thu, 28 Nov 2019 18:45:51 +0800
Message-ID: <1574937951-92828-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I got a deadlock report from syzkaller:

[  234.427696] ============================================
[  234.428327] WARNING: possible recursive locking detected
[  234.429011] 5.4.0-rc4+ #1 Not tainted
[  234.429528] --------------------------------------------
[  234.430162] kworker/u9:0/894 is trying to acquire lock:
[  234.430911] ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: flush_workqueue+0xbc/0xfe8
[  234.432330]
[  234.432330] but task is already holding lock:
[  234.432927] ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: process_one_work+0x6a0/0x17e8
[  234.433983]
[  234.433983] other info that might help us debug this:
[  234.434615]  Possible unsafe locking scenario:
[  234.434615]
[  234.435263]        CPU0
[  234.435613]        ----
[  234.436019]   lock((wq_completion)knbd0-recv);
[  234.436521]   lock((wq_completion)knbd0-recv);
[  234.437166]
[  234.437166]  *** DEADLOCK ***
[  234.437166]
[  234.437763]  May be due to missing lock nesting notation
[  234.437763]
[  234.438559] 3 locks held by kworker/u9:0/894:
[  234.439040]  #0: ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: process_one_work+0x6a0/0x17e8
[  234.440185]  #1: ffff0000d344fd50 ((work_completion)(&args->work)){+.+.}, at: process_one_work+0x6a0/0x17e8
[  234.442209]  #2: ffff0000d723cd78 (&nbd->config_lock){+.+.}, at: refcount_dec_and_mutex_lock+0x5c/0x128
[  234.443380]
[  234.443380] stack backtrace:
[  234.444271] CPU: 3 PID: 894 Comm: kworker/u9:0 Not tainted 5.4.0-rc4+ #1
[  234.444989] Hardware name: linux,dummy-virt (DT)
[  234.446077] Workqueue: knbd0-recv recv_work
[  234.446909] Call trace:
[  234.447372]  dump_backtrace+0x0/0x358
[  234.447877]  show_stack+0x28/0x38
[  234.448347]  dump_stack+0x15c/0x1ec
[  234.448838]  __lock_acquire+0x12ec/0x2f78
[  234.449474]  lock_acquire+0x180/0x590
[  234.450075]  flush_workqueue+0x104/0xfe8
[  234.450587]  drain_workqueue+0x164/0x390
[  234.451090]  destroy_workqueue+0x30/0x560
[  234.451598]  nbd_config_put+0x308/0x700
[  234.452093]  recv_work+0x198/0x1f0
[  234.452556]  process_one_work+0x7ac/0x17e8
[  234.453189]  worker_thread+0x36c/0xb70
[  234.453788]  kthread+0x2f4/0x378
[  234.454257]  ret_from_fork+0x10/0x18

The root cause is recv_work() is the last one to drop the config
ref and try to destroy the workqueue from inside the work queue.

There are two ways to fix the bug. The first way is flushing the
workqueue before dropping the initial refcount and making sure
recv_work() will not be the last owner of nbd_config. However it
is hard for ioctl interface. Because nbd_clear_sock_ioctl() may
not be invoked, so we need to flush the workqueue in nbd_release()
and that will lead to another deadlock because recv_work can not
exit from nbd_read_stat() loop.

The second way is using another work to put nbd_config asynchronously
for recv_work().

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5753246..e7685a3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -110,6 +110,7 @@ struct nbd_device {
 	refcount_t config_refs;
 	refcount_t refs;
 	struct nbd_config *config;
+	struct work_struct config_release;
 	struct mutex config_lock;
 	struct gendisk *disk;
 	struct workqueue_struct *recv_workq;
@@ -152,6 +153,7 @@ static int part_shift;
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 static void nbd_config_put(struct nbd_device *nbd);
+static void nbd_config_put_async(struct nbd_device *nbd);
 static void nbd_connect_reply(struct genl_info *info, int index);
 static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
 static void nbd_dead_link_work(struct work_struct *work);
@@ -789,7 +791,7 @@ static void recv_work(struct work_struct *work)
 	}
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
-	nbd_config_put(nbd);
+	nbd_config_put_async(nbd);
 	kfree(args);
 }
 
@@ -1222,6 +1224,22 @@ static void nbd_config_put(struct nbd_device *nbd)
 	}
 }
 
+static void nbd_config_release_work(struct work_struct *work)
+{
+	struct nbd_device *nbd = container_of(work, struct nbd_device,
+						   config_release);
+	nbd_config_put(nbd);
+}
+
+static void nbd_config_put_async(struct nbd_device *nbd)
+{
+	if (refcount_dec_not_one(&nbd->config_refs))
+		return;
+
+	INIT_WORK(&nbd->config_release, nbd_config_release_work);
+	schedule_work(&nbd->config_release);
+}
+
 static int nbd_start_device(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
-- 
2.7.4

