Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:40641 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdLUHIn (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 21 Dec 2017 02:08:43 -0500
Subject: Re: bfq: BUG bfq_queue: Objects remaining in bfq_queue on
 __kmem_cache_shutdown() after rmmod
To: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <b46422e2-3614-858f-4861-75c67ce38faa@applied-asynchrony.com>
From: Guoqing Jiang <gqjiang@suse.com>
Message-ID: <9c96f320-a7db-4db0-adbc-34f9510ce84d@suse.com>
Date: Thu, 21 Dec 2017 15:08:32 +0800
MIME-Version: 1.0
In-Reply-To: <b46422e2-3614-858f-4861-75c67ce38faa@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,


On 12/08/2017 08:34 AM, Holger Hoffstätte wrote:
> So plugging in a device on USB with BFQ as scheduler now works without
> hiccup (probably thanks to Ming Lei's last patch), but of course I found
> another problem. Unmounting the device after use, changing the scheduler
> back to deadline or kyber and rmmod'ing the BFQ module reproducibly gives me:
>
> kernel: =============================================================================
> kernel: BUG bfq_queue (Tainted: G    B          ): Objects remaining in bfq_queue on __kmem_cache_shutdown()
> kernel: -----------------------------------------------------------------------------
> kernel:
> kernel: INFO: Slab 0xffffea001601fc00 objects=37 used=3 fp=0xffff8805807f0360 flags=0x8000000000008100
> kernel: CPU: 0 PID: 9967 Comm: rmmod Tainted: G    B           4.14.5 #1
> kernel: Hardware name: Gigabyte Technology Co., Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
> kernel: Call Trace:
> kernel:  dump_stack+0x46/0x5e
> kernel:  slab_err+0x9e/0xb0
> kernel:  ? on_each_cpu_mask+0x35/0x40
> kernel:  ? ksm_migrate_page+0x60/0x60
> kernel:  ? __kmalloc+0x1c9/0x1d0
> kernel:  __kmem_cache_shutdown+0x177/0x350
> kernel:  shutdown_cache+0xf/0x130
> kernel:  kmem_cache_destroy+0x19e/0x1b0
> kernel:  SyS_delete_module+0x168/0x230
> kernel:  ? exit_to_usermode_loop+0x39/0x80
> kernel:  entry_SYSCALL_64_fastpath+0x13/0x94
> kernel: RIP: 0033:0x7f53e4136b97
> kernel: RSP: 002b:00007ffd660061d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f53e4136b97
> kernel: RDX: 000000000000000a RSI: 0000000000000800 RDI: 00000000006247f8
> kernel: RBP: 0000000000000000 R08: 00007ffd66005171 R09: 0000000000000000
> kernel: R10: 00007f53e41acbc0 R11: 0000000000000206 R12: 0000000000624790
> kernel: R13: 00007ffd660051d0 R14: 0000000000624790 R15: 0000000000623260
> kernel: INFO: Object 0xffff8805807f0000 @offset=0
> kernel: INFO: Object 0xffff8805807f01b0 @offset=432
> kernel: INFO: Object 0xffff8805807f3cc0 @offset=15552
> kernel: kmem_cache_destroy bfq_queue: Slab cache still has objects
> kernel: CPU: 0 PID: 9967 Comm: rmmod Tainted: G    B           4.14.5 #1
> kernel: Hardware name: Gigabyte Technology Co., Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
> kernel: Call Trace:
> kernel:  dump_stack+0x46/0x5e
> kernel:  kmem_cache_destroy+0x191/0x1b0
> kernel:  SyS_delete_module+0x168/0x230
> kernel:  ? exit_to_usermode_loop+0x39/0x80
> kernel:  entry_SYSCALL_64_fastpath+0x13/0x94
> kernel: RIP: 0033:0x7f53e4136b97
> kernel: RSP: 002b:00007ffd660061d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f53e4136b97
> kernel: RDX: 000000000000000a RSI: 0000000000000800 RDI: 00000000006247f8
> kernel: RBP: 0000000000000000 R08: 00007ffd66005171 R09: 0000000000000000
> kernel: R10: 00007f53e41acbc0 R11: 0000000000000206 R12: 0000000000624790
> kernel: R13: 00007ffd660051d0 R14: 0000000000624790 R15: 0000000000623260
>

I also encountered the similar bug, seems there are some async objects 
which are not freed with
BFQ_GROUP_IOSCHED build as "Y".

If revert part of commit e21b7a0b988772e82e7147e1c659a5afe2ae003c 
("block, bfq: add full hierarchical
scheduling and cgroups support")like below, then I can't see the bug 
again with simple test.

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 889a8549d97f..c640e64e042f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4710,6 +4710,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
         spin_lock_irq(&bfqd->lock);
         list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
                 bfq_deactivate_bfqq(bfqd, bfqq, false, false);
+       bfq_put_async_queues(bfqd, bfqd->root_group);
         spin_unlock_irq(&bfqd->lock);

         hrtimer_cancel(&bfqd->idle_slice_timer);
@@ -4718,7 +4719,6 @@ static void bfq_exit_queue(struct elevator_queue *e)
         blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
  #else
         spin_lock_irq(&bfqd->lock);
-       bfq_put_async_queues(bfqd, bfqd->root_group);
         kfree(bfqd->root_group);
         spin_unlock_irq(&bfqd->lock);

But perhaps we should do it inside blkcg_deactivate_policy, right?

Thanks,
Guoqing
