Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E6C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE4664DC3
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 07:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhBDHJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 02:09:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12022 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhBDHIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 02:08:36 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWV2t4cZfzjJr1;
        Thu,  4 Feb 2021 15:06:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 15:07:42 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v4 1/2] nbd: Fix NULL pointer in flush_workqueue
Date:   Thu, 4 Feb 2021 02:09:09 -0500
Message-ID: <20210204070910.1401239-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210204070910.1401239-1-sunke32@huawei.com>
References: <20210204070910.1401239-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open /dev/nbdX first, the config_refs will be 1 and
the pointers in nbd_device are still null. Disconnect
/dev/nbdX, then reference a null recv_workq. The
protection by config_refs in nbd_genl_disconnect is useless.

[  656.366194] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  656.368943] #PF: supervisor write access in kernel mode
[  656.369844] #PF: error_code(0x0002) - not-present page
[  656.370717] PGD 10cc87067 P4D 10cc87067 PUD 1074b4067 PMD 0
[  656.371693] Oops: 0002 [#1] SMP
[  656.372242] CPU: 5 PID: 7977 Comm: nbd-client Not tainted 5.11.0-rc5-00040-g76c057c84d28 #1
[  656.373661] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  656.375904] RIP: 0010:mutex_lock+0x29/0x60
[  656.376627] Code: 00 0f 1f 44 00 00 55 48 89 fd 48 83 05 6f d7 fe 08 01 e8 7a c3 ff ff 48 83 05 6a d7 fe 08 01 31 c0 65 48 8b 14 25 00 6d 01 00 <f0> 48 0f b1 55 d
[  656.378934] RSP: 0018:ffffc900005eb9b0 EFLAGS: 00010246
[  656.379350] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  656.379915] RDX: ffff888104cf2600 RSI: ffffffffaae8f452 RDI: 0000000000000020
[  656.380473] RBP: 0000000000000020 R08: 0000000000000000 R09: ffff88813bd6b318
[  656.381039] R10: 00000000000000c7 R11: fefefefefefefeff R12: ffff888102710b40
[  656.381599] R13: ffffc900005eb9e0 R14: ffffffffb2930680 R15: ffff88810770ef00
[  656.382166] FS:  00007fdf117ebb40(0000) GS:ffff88813bd40000(0000) knlGS:0000000000000000
[  656.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  656.383261] CR2: 0000000000000020 CR3: 0000000100c84000 CR4: 00000000000006e0
[  656.383819] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  656.384370] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  656.384927] Call Trace:
[  656.385111]  flush_workqueue+0x92/0x6c0
[  656.385395]  nbd_disconnect_and_put+0x81/0xd0
[  656.385716]  nbd_genl_disconnect+0x125/0x2a0
[  656.386034]  genl_family_rcv_msg_doit.isra.0+0x102/0x1b0
[  656.386422]  genl_rcv_msg+0xfc/0x2b0
[  656.386685]  ? nbd_ioctl+0x490/0x490
[  656.386954]  ? genl_family_rcv_msg_doit.isra.0+0x1b0/0x1b0
[  656.387354]  netlink_rcv_skb+0x62/0x180
[  656.387638]  genl_rcv+0x34/0x60
[  656.387874]  netlink_unicast+0x26d/0x590
[  656.388162]  netlink_sendmsg+0x398/0x6c0
[  656.388451]  ? netlink_rcv_skb+0x180/0x180
[  656.388750]  ____sys_sendmsg+0x1da/0x320
[  656.389038]  ? ____sys_recvmsg+0x130/0x220
[  656.389334]  ___sys_sendmsg+0x8e/0xf0
[  656.389605]  ? ___sys_recvmsg+0xa2/0xf0
[  656.389889]  ? handle_mm_fault+0x1671/0x21d0
[  656.390201]  __sys_sendmsg+0x6d/0xe0
[  656.390464]  __x64_sys_sendmsg+0x23/0x30
[  656.390751]  do_syscall_64+0x45/0x70
[  656.391017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v4: Share exception handling code for if branches
v3: Do not use unlock and add put_nbd.
v2: Use jump target unlock.
---
 drivers/block/nbd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e6ea5d344f87..3c9b3bf3f4c2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2014,17 +2014,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&nbd_index_mutex);
 	nbd = idr_find(&nbd_index_idr, index);
 	if (!nbd) {
-		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
 		       index);
-		return -EINVAL;
+		goto unlock_index;
 	}
-	if (!refcount_inc_not_zero(&nbd->refs)) {
-		mutex_unlock(&nbd_index_mutex);
+	mutex_lock(&nbd->config_lock);
+	if (!refcount_inc_not_zero(&nbd->refs) || !nbd->recv_workq) {
+		mutex_unlock(&nbd->config_lock);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
 		       index);
+unlock_index:
+		mutex_unlock(&nbd_index_mutex);
 		return -EINVAL;
 	}
+	mutex_unlock(&nbd->config_lock);
 	mutex_unlock(&nbd_index_mutex);
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		nbd_put(nbd);
-- 
2.25.4

