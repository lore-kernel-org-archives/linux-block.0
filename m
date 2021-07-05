Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FA8C07E98
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 06:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16107613BA
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 06:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhGEGDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 02:03:11 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:51697 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhGEGDL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 02:03:11 -0400
X-UUID: aef34200a498452db2aa8595579cf2b2-20210705
X-UUID: aef34200a498452db2aa8595579cf2b2-20210705
X-User: jiangguoqing@kylinos.cn
Received: from [172.30.60.82] [(106.37.198.34)] by nksmu.kylinos.cn
        (envelope-from <jiangguoqing@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 789127503; Mon, 05 Jul 2021 13:59:32 +0800
Subject: Re: [syzbot] general protection fault in blk_mq_run_hw_queues
To:     syzbot <syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        hch@lst.de
References: <0000000000005093cb05c659dae4@google.com>
From:   Guoqing Jiang <jiangguoqing@kylinos.cn>
Message-ID: <79eae2c8-3540-f257-6068-2620570fa7f7@kylinos.cn>
Date:   Mon, 5 Jul 2021 14:00:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000005093cb05c659dae4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 7/5/21 1:48 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    dbe69e43 Merge tag 'net-next-5.14' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12690d94300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ef0afdedbe2d773d
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ca43ff47167c0ee3466
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ded6ac300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af1344300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com
>
> netlink: 4 bytes leftover after parsing attributes in process `syz-executor092'.
> netlink: 4 bytes leftover after parsing attributes in process `syz-executor092'.
> nbd: socks must be embedded in a SOCK_ITEM attr
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 8422 Comm: syz-executor092 Tainted: G        W         5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:blk_mq_map_queue_type block/blk-mq.h:96 [inline]
> RIP: 0010:blk_mq_get_sq_hctx block/blk-mq.c:1663 [inline]
> RIP: 0010:blk_mq_run_hw_queues+0x14f/0x430 block/blk-mq.c:1682
> Code: 80 3c 08 00 74 08 48 89 ef e8 0d 0f dd fd 44 89 fb 48 c1 e3 02 48 03 5d 00 48 89 d8 48 c1 e8 03 48 bd 00 00 00 00 00 fc ff df <8a> 04 28 84 c0 0f 85 b7 02 00 00 8b 03 49 8d 1c c4 48 89 d8 48 c1
> RSP: 0018:ffffc9000183f160 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f912b38
> RBP: dffffc0000000000 R08: ffffffff83eb6412 R09: ffffed1003f22687
> R10: ffffed1003f22687 R11: 0000000000000000 R12: ffff88814615f4d8
> R13: 0000000000000000 R14: ffff88801f912af0 R15: 0000000000000000
> FS:  0000000001ab6300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa915ace020 CR3: 0000000018231000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   blk_set_queue_dying block/blk-core.c:353 [inline]
>   blk_cleanup_queue+0x9c/0x220 block/blk-core.c:380
>   blk_cleanup_disk+0x3b/0x80 block/genhd.c:1324
>   nbd_dev_remove drivers/block/nbd.c:226 [inline]
>   nbd_put+0x9d/0x170 drivers/block/nbd.c:246
>   nbd_genl_connect+0x17e7/0x1aa0 drivers/block/nbd.c:1957
>   genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>   genl_rcv_msg+0xfb4/0x13c0 net/netlink/genetlink.c:800
>   netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2504
>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>   netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>   netlink_unicast+0x7de/0x9b0 net/netlink/af_netlink.c:1340
>   netlink_sendmsg+0xaa6/0xe90 net/netlink/af_netlink.c:1929
>   sock_sendmsg_nosec net/socket.c:702 [inline]
>   sock_sendmsg net/socket.c:722 [inline]
>   ____sys_sendmsg+0x5a2/0x900 net/socket.c:2385
>   ___sys_sendmsg net/socket.c:2439 [inline]
>   __sys_sendmsg+0x319/0x400 net/socket.c:2468
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x43fa29
> Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcd5946088 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 000000000043fa29
> RDX: 0000000000000000 RSI: 0000000020000b40 RDI: 0000000000000003
> RBP: 0000000000403490 R08: 0000000000000000 R09: 00000000004004a0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403520
> R13: 0000000000000000 R14: 00000000004ad018 R15: 00000000004004a0
> Modules linked in:
> ---[ end trace d9ad06d2dab45e1b ]---
> RIP: 0010:blk_mq_map_queue_type block/blk-mq.h:96 [inline]
> RIP: 0010:blk_mq_get_sq_hctx block/blk-mq.c:1663 [inline]
> RIP: 0010:blk_mq_run_hw_queues+0x14f/0x430 block/blk-mq.c:1682
> Code: 80 3c 08 00 74 08 48 89 ef e8 0d 0f dd fd 44 89 fb 48 c1 e3 02 48 03 5d 00 48 89 d8 48 c1 e8 03 48 bd 00 00 00 00 00 fc ff df <8a> 04 28 84 c0 0f 85 b7 02 00 00 8b 03 49 8d 1c c4 48 89 d8 48 c1
> RSP: 0018:ffffc9000183f160 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f912b38
> RBP: dffffc0000000000 R08: ffffffff83eb6412 R09: ffffed1003f22687
> R10: ffffed1003f22687 R11: 0000000000000000 R12: ffff88814615f4d8
> R13: 0000000000000000 R14: ffff88801f912af0 R15: 0000000000000000
> FS:  0000000001ab6300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa915ace020 CR3: 0000000018231000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Maybe it can be fixed like this as commit 
6a03cd9843fa4dcf827dc3ad60fa9b4217f3057c did.

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 614d82e7fae4..d2548d36bf21 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -222,8 +222,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)

         if (disk) {
                 del_gendisk(disk);
-               blk_mq_free_tag_set(&nbd->tag_set);
                 blk_cleanup_disk(disk);
+               blk_mq_free_tag_set(&nbd->tag_set);
         }

Also paride/pd.c needs the same change, is my understanding correct? 
Christoph.

Thanks,
Guoqing
