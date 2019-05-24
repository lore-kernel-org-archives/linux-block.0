Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53727C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176D921773
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 09:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbfEXJzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 05:55:45 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:30670 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389913AbfEXJzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 05:55:45 -0400
Received: from kernel_test2.localdomain (unknown [120.132.1.243])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id B6CFB415E9;
        Fri, 24 May 2019 17:48:02 +0800 (CST)
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nbd: fix connection timed out error after reconnecting to server
Date:   Fri, 24 May 2019 17:43:54 +0800
Message-Id: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kIGBQJHllBWUlVT0tMQkJCQkJJSExLTUpZV1koWUFJQjdXWS1ZQUlXWQ
        kOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46Dio*Ezg1TSxWMTA*CEwe
        TSMwFA9VSlVKTk5DTUJKSUNIS0xLVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQU9ISEg3Bg++
X-HM-Tid: 0a6ae93d7ff12086kuqyb6cfb415e9
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some I/O requests that have been sent succussfully but have not yet been
replied won't be resubmitted after reconnecting because of server restart,
so we add a list to track them.

Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
---
 drivers/block/nbd.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a..ca69d6e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -113,6 +113,8 @@ struct nbd_device {
 	struct list_head list;
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
+	struct mutex outstanding_lock;
+	struct list_head outstanding_queue;
 };
 
 #define NBD_CMD_REQUEUED	1
@@ -125,6 +127,7 @@ struct nbd_cmd {
 	blk_status_t status;
 	unsigned long flags;
 	u32 cmd_cookie;
+	struct list_head outstanding_entry;
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -619,6 +622,24 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
+static struct nbd_cmd *nbd_get_cmd(struct nbd_device *nbd,
+					struct nbd_cmd *xcmd)
+{
+	struct nbd_cmd *cmd, *tmp;
+
+	mutex_lock(&nbd->outstanding_lock);
+	list_for_each_entry_safe(cmd, tmp, &nbd->outstanding_queue, outstanding_entry) {
+		if (cmd != xcmd)
+			continue;
+		list_del_init(&cmd->outstanding_entry);
+		mutex_unlock(&nbd->outstanding_lock);
+		return cmd;
+	}
+	mutex_unlock(&nbd->outstanding_lock);
+
+	return ERR_PTR(-ENOENT);
+}
+
 /* NULL returned = something went wrong, inform userspace */
 static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 {
@@ -714,12 +735,30 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 				req, bvec.bv_len);
 		}
 	}
+	cmd = nbd_get_cmd(nbd, cmd);
+	if (IS_ERR(cmd)) {
+		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p which not in outstanding queue\n",
+			tag, req);
+		ret = -ENOENT;
+	}
 out:
 	trace_nbd_payload_received(req, handle);
 	mutex_unlock(&cmd->lock);
 	return ret ? ERR_PTR(ret) : cmd;
 }
 
+static void nbd_requeue_outstanding(struct nbd_device *nbd)
+{
+	struct nbd_cmd *cmd, *tmp;
+
+	mutex_lock(&nbd->outstanding_lock);
+	list_for_each_entry_safe(cmd, tmp, &nbd->outstanding_queue, outstanding_entry) {
+		nbd_requeue_cmd(cmd);
+		list_del_init(&cmd->outstanding_entry);
+	}
+	mutex_unlock(&nbd->outstanding_lock);
+}
+
 static void recv_work(struct work_struct *work)
 {
 	struct recv_thread_args *args = container_of(work,
@@ -742,6 +781,7 @@ static void recv_work(struct work_struct *work)
 
 		blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
 	}
+	nbd_requeue_outstanding(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
 	nbd_config_put(nbd);
@@ -892,6 +932,10 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		nbd_mark_nsock_dead(nbd, nsock, 1);
 		nbd_requeue_cmd(cmd);
 		ret = 0;
+	} else if (ret == 0) {
+		mutex_lock(&nbd->outstanding_lock);
+		list_add_tail(&cmd->outstanding_entry, &nbd->outstanding_queue);
+		mutex_unlock(&nbd->outstanding_lock);
 	}
 out:
 	mutex_unlock(&nsock->tx_lock);
@@ -1615,6 +1659,8 @@ static int nbd_dev_add(int index)
 	refcount_set(&nbd->config_refs, 0);
 	refcount_set(&nbd->refs, 1);
 	INIT_LIST_HEAD(&nbd->list);
+	mutex_init(&nbd->outstanding_lock);
+	INIT_LIST_HEAD(&nbd->outstanding_queue);
 	disk->major = NBD_MAJOR;
 	disk->first_minor = index << part_shift;
 	disk->fops = &nbd_fops;
-- 
1.8.3.1

