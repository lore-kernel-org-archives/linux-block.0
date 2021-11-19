Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F42C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877A861AA7
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhKSCNj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:13:39 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27143 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhKSCNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 21:13:39 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HwKnl2Wczz1DJWr;
        Fri, 19 Nov 2021 10:08:11 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 10:10:36 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 10:10:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <justin@coraid.com>
Subject: [PATCH] aoe: fix UAF in tx()
Date:   Fri, 19 Nov 2021 10:17:43 +0800
Message-ID: <20211119021743.1124606-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I got a UAF report when doing fuzz test:

[14631.865133][ T1288] BUG: KASAN: use-after-free in __dev_queue_xmit+0x1cf/0x1cd0
[14631.866261][ T1288] Read of size 8 at addr ffff8881207d08e0 by task aoe_tx0/1288
[14631.867316][ T1288]
[14631.867667][ T1288] CPU: 1 PID: 1288 Comm: aoe_tx0 Not tainted 5.16.0-rc1 #580
[14631.868672][ T1288] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[14631.870021][ T1288] Call Trace:
[14631.870481][ T1288]  <TASK>
[14631.870883][ T1288]  dump_stack_lvl+0xec/0x139
[14631.872267][ T1288]  print_address_description.constprop.11+0x41/0x60
[14631.874610][ T1288]  kasan_report.cold.16+0x83/0xdf
[14631.876825][ T1288]  __dev_queue_xmit+0x1cf/0x1cd0
[14631.888195][ T1288]  tx+0x5d/0xa0
[14631.889338][ T1288]  kthread+0x13d/0x210
[14631.892438][ T1288]  kthread+0x259/0x2a0
[14631.893704][ T1288]  ret_from_fork+0x1f/0x30
[14631.894325][ T1288]  </TASK>
[14631.894738][ T1288]
[14631.895055][ T1288] Allocated by task 22185:
[14631.895679][ T1288]  kasan_save_stack+0x1c/0x40
[14631.896336][ T1288]  __kasan_kmalloc+0x82/0xa0
[14631.896965][ T1288]  kvmalloc_node+0xb2/0x120
[14631.897590][ T1288]  alloc_netdev_mqs+0x96/0x7e0
[14631.898244][ T1288]  __tun_chr_ioctl+0x16bd/0x2a50
[14631.898925][ T1288]  __x64_sys_ioctl+0x116/0x170
[14631.899592][ T1288]  do_syscall_64+0x34/0xb0
[14631.900210][ T1288]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[14631.901026][ T1288]
[14631.901343][ T1288] Freed by task 22185:
[14631.901900][ T1288]  kasan_save_stack+0x1c/0x40
[14631.902546][ T1288]  kasan_set_track+0x21/0x30
[14631.903179][ T1288]  kasan_set_free_info+0x20/0x30
[14631.903862][ T1288]  __kasan_slab_free+0xc6/0x100
[14631.904533][ T1288]  kfree+0xc3/0x1d0
[14631.905065][ T1288]  kvfree+0x43/0x50
[14631.905593][ T1288]  device_release+0x5b/0x120
[14631.906245][ T1288]  kobject_put+0x120/0x1c0
[14631.906861][ T1288]  netdev_run_todo+0x433/0x590
[14631.907526][ T1288]  tun_chr_close+0x7b/0xb0
[14631.908136][ T1288]  __fput+0x178/0x5b0
[14631.908692][ T1288]  task_work_run+0xa7/0xf0
[14631.909301][ T1288]  do_exit+0x7f3/0x1a00
[14631.909878][ T1288]  do_group_exit+0x99/0x180
[14631.910492][ T1288]  __x64_sys_exit_group+0x28/0x30
[14631.911186][ T1288]  do_syscall_64+0x34/0xb0
[14631.911812][ T1288]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[14631.912629][ T1288]
[14631.912949][ T1288] The buggy address belongs to the object at ffff8881207d0000
[14631.912949][ T1288]  which belongs to the cache kmalloc-cg-16k of size 16384
[14631.914900][ T1288] The buggy address is located 2272 bytes inside of
[14631.914900][ T1288]  16384-byte region [ffff8881207d0000, ffff8881207d4000)
[14631.916739][ T1288] The buggy address belongs to the page:
[14631.917511][ T1288] page:0000000060187b1d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1207d0
[14631.918919][ T1288] head:0000000060187b1d order:3 compound_mapcount:0 compound_pincount:0
[14631.920068][ T1288] flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
[14631.921188][ T1288] raw: 057ff00000010200 ffffea0002b90a08 ffff888100002018 ffff88800a843f00
[14631.922372][ T1288] raw: 0000000000000000 ffff8881207d0000 0000000100000001 0000000000000000
[14631.922918][ T5332] Bluetooth: hci0: command 0x0409 tx timeout
[14631.923545][ T1288] page dumped because: kasan: bad access detected
[14631.923553][ T1288]
[14631.925582][ T1288] Memory state around the buggy address:
[14631.926347][ T1288]  ffff8881207d0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14631.927452][ T1288]  ffff8881207d0800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14631.928546][ T1288] >ffff8881207d0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14631.929629][ T1288]                                                        ^
[14631.930600][ T1288]  ffff8881207d0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[14631.931693][ T1288]  ffff8881207d0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

After skb queued into skbtxq, the net device of skb may be freed before it's
sent in tx(), then it leads a UAF. So hold the reference of device to avoid
the device been freed, put the reference after dev_queue_xmit().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/block/aoe/aoenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..f2cb5d42cc6a 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -64,6 +64,7 @@ tx(int id) __must_hold(&txlock)
 			pr_warn("aoe: packet could not be sent on %s.  %s\n",
 				ifp ? ifp->name : "netif",
 				"consider increasing tx_queue_len");
+		dev_put(ifp);
 		spin_lock_irq(&txlock);
 	}
 	return 0;
@@ -117,6 +118,7 @@ aoenet_xmit(struct sk_buff_head *queue)
 
 	skb_queue_walk_safe(queue, skb, tmp) {
 		__skb_unlink(skb, queue);
+		dev_hold(skb->dev);
 		spin_lock_irqsave(&txlock, flags);
 		skb_queue_tail(&skbtxq, skb);
 		spin_unlock_irqrestore(&txlock, flags);
-- 
2.25.1

