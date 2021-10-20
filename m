Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D45C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262C86112D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTJiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 05:38:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29917 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 05:38:14 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZ53050sczbnCM;
        Wed, 20 Oct 2021 17:31:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 20
 Oct 2021 17:35:57 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] nbd: Fix hungtask when nbd_config_put
Date:   Wed, 20 Oct 2021 17:48:30 +0800
Message-ID: <20211020094830.3056325-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I got follow issue:
[  247.381177] INFO: task kworker/u10:0:47 blocked for more than 120 seconds.
[  247.382644]       Not tainted 4.19.90-dirty #140
[  247.383502] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.385027] Call Trace:
[  247.388384]  schedule+0xb8/0x3c0
[  247.388966]  schedule_timeout+0x2b4/0x380
[  247.392815]  wait_for_completion+0x367/0x510
[  247.397713]  flush_workqueue+0x32b/0x1340
[  247.402700]  drain_workqueue+0xda/0x3c0
[  247.403442]  destroy_workqueue+0x7b/0x690
[  247.405014]  nbd_config_put.cold+0x2f9/0x5b6
[  247.405823]  recv_work+0x1fd/0x2b0
[  247.406485]  process_one_work+0x70b/0x1610
[  247.407262]  worker_thread+0x5a9/0x1060
[  247.408699]  kthread+0x35e/0x430
[  247.410918]  ret_from_fork+0x1f/0x30

We can reprodeuce issue as follows:
1. Inject memory fault in nbd_start_device
@@ -1244,10 +1248,18 @@ static int nbd_start_device(struct nbd_device *nbd)
        nbd_dev_dbg_init(nbd);
        for (i = 0; i < num_connections; i++) {
                struct recv_thread_args *args;
-
-               args = kzalloc(sizeof(*args), GFP_KERNEL);
+
+               if (i == 1) {
+                       args = NULL;
+                       printk("%s: inject malloc error\n", __func__);
+               }
+               else
+                       args = kzalloc(sizeof(*args), GFP_KERNEL);
2. Inject delay in recv_work
@@ -757,6 +760,8 @@ static void recv_work(struct work_struct *work)

                blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
        }
+       printk("%s: comm=%s pid=%d\n", __func__, current->comm, current->pid);
+       mdelay(5 * 1000);
        nbd_config_put(nbd);
        atomic_dec(&config->recv_threads);
        wake_up(&config->recv_wq);
3. Create nbd server
nbd-server 8000 /tmp/disk
4. Create nbd client
nbd-client localhost 8000 /dev/nbd1
Then will trigger above issue.

Reason is when add delay in recv_work, lead to relase the last reference
of 'nbd->config_refs'. nbd_config_put will call flush_workqueue to make
all work finish. Obviously, it will lead to deadloop.
To solve this issue, we must ensure 'recv_work' all exit before release
the last 'nbd->config_refs' reference count.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0ee104fbb628..ba74887e24a8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2074,6 +2074,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
+	} else if (nbd->recv_workq){
+		sock_shutdown(nbd);
+		flush_workqueue(nbd->recv_workq);
 	}
 	nbd_config_put(nbd);
 	if (put_dev)
-- 
2.31.1

