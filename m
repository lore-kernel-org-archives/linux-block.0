Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405EC54EBC
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 11:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjALL4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjALLzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 06:55:53 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95CA51306
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 03:47:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nt2pS1GHXz4f3nqD
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 19:47:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R9B879jnLDGBQ--.33244S3;
        Thu, 12 Jan 2023 19:47:14 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230112113833.6zkuoxshdcuctlnw@shindev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6933fa2d-014c-8773-39d9-680ad9fca98c@huaweicloud.com>
Date:   Thu, 12 Jan 2023 19:47:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230112113833.6zkuoxshdcuctlnw@shindev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R9B879jnLDGBQ--.33244S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW7JFy8XFWxKw1xAr4rGrg_yoW7ArWrpr
        W0gw17Cr48Jr1DXa17tw1j9F4vka1YkF9rXrs7Kr4xZF48Jw15XF4jvrW2vF9xWrW8Z3yI
        qa4kt39Fqw1aqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/01/12 19:38, Shinichiro Kawasaki Ð´µÀ:
> I observed another KASAN uaf related to bfq. I would like to ask bfq experts
> to take a look in it. Whole KASAN message is attached below. It looks different
> from another uaf fixed with 246cf66e300b ("block, bfq: fix uaf for bfqq in
> bfq_exit_icq_bfqq").
> 
> It was observed first time during blktests test case block/027 run on kernel
> v6.2-rc3. Depending on test machines, it was recreated during system boot or ssh
> login occasionally. When I repeat system reboot and ssh-login twice, the uaf is
> recreated.
> 
> I guess 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'") could be
> the trigger commit. I cherry-picked the two commits 64dc8c732f5c and
> 246cf66e300b on top of v6.1. With this kernel, I observed the KASAN uaf in
> bic_set_bfqq.
> 
> 
> BUG: KASAN: use-after-free in bic_set_bfqq+0x15f/0x190
> device offline error, dev sdr, sector 245352968 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> Read of size 8 at addr ffff88811de85f88 by task in:imjournal/815
> 
Thanks for the report, is the problem easy to reporduce? If so, can you
try the following patch?

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1b2829e99dad..81d2f401fa3f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -771,8 +771,8 @@ static void __bfq_bic_change_cgroup(struct bfq_data 
*bfqd,
                                  * request from the old cgroup.
                                  */
                                 bfq_put_cooperator(sync_bfqq);
-                               bfq_release_process_ref(bfqd, sync_bfqq);
                                 bic_set_bfqq(bic, NULL, true);
+                               bfq_release_process_ref(bfqd, sync_bfqq);
                         }
                 }
         }


> CPU: 5 PID: 815 Comm: in:imjournal Not tainted 6.2.0-rc3-kts+ #1
> Hardware name: Supermicro Super Server/X10SRL-F, BIOS 3.2 11/22/2019
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x77
>   print_report+0x182/0x47e
>   ? bic_set_bfqq+0x15f/0x190
>   ? bic_set_bfqq+0x15f/0x190
>   kasan_report+0xbb/0xf0
>   ? bic_set_bfqq+0x15f/0x190
>   bic_set_bfqq+0x15f/0x190
>   bfq_bic_update_cgroup+0x386/0x950
>   bfq_bio_merge+0x132/0x2c0
>   ? __pfx_bfq_bio_merge+0x10/0x10
>   blk_mq_submit_bio+0xc5c/0x1b40
>   ? __pfx_blk_mq_submit_bio+0x10/0x10
>   ? find_held_lock+0x2d/0x110
>   __submit_bio+0x24d/0x2c0
>   ? __pfx___submit_bio+0x10/0x10
>   submit_bio_noacct_nocheck+0x5b1/0x820
>   ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
>   ? rcu_read_lock_sched_held+0x3f/0x80
>   ext4_io_submit+0x86/0x110
>   ext4_do_writepages+0xb97/0x2f70
>   ? __pfx_ext4_do_writepages+0x10/0x10
>   ? lock_is_held_type+0xe3/0x140
>   ext4_writepages+0x21c/0x4b0
>   ? __pfx_ext4_writepages+0x10/0x10
>   ? __lock_acquire+0xc75/0x5520
>   do_writepages+0x166/0x630
>   ? __pfx_do_writepages+0x10/0x10
>   ? lock_release+0x365/0x730
>   ? wbc_attach_and_unlock_inode+0x3a3/0x780
>   ? __pfx_lock_release+0x10/0x10
>   ? __pfx_lock_release+0x10/0x10
>   ? __pfx_lock_acquire+0x10/0x10
>   ? do_raw_spin_unlock+0x54/0x1f0
>   ? _raw_spin_unlock+0x29/0x50
>   ? wbc_attach_and_unlock_inode+0x3a3/0x780
>   filemap_fdatawrite_wbc+0x111/0x170
>   ? kfree+0x115/0x190
>   __filemap_fdatawrite_range+0x9a/0xc0
>   ? __pfx___filemap_fdatawrite_range+0x10/0x10
>   ? __pfx_ext4_find_entry+0x10/0x10
>   ? __pfx___dquot_initialize+0x10/0x10
>   ? rcu_read_lock_sched_held+0x3f/0x80
>   ? ext4_alloc_da_blocks+0x177/0x210
>   ext4_rename+0x1123/0x23d0
>   ? __pfx_ext4_rename+0x10/0x10
>   ? __pfx___lock_acquire+0x10/0x10
>   ? lock_acquire+0x1a4/0x4f0
>   ? down_write_nested+0x141/0x200
>   ? ext4_rename2+0x88/0x200
>   vfs_rename+0xa6e/0x14f0
>   ? __pfx_lock_release+0x10/0x10
>   ? hook_file_open+0x780/0x790
>   ? __pfx_vfs_rename+0x10/0x10
>   ? __d_lookup+0x1fd/0x330
>   ? d_lookup+0x37/0x50
>   ? security_path_rename+0x111/0x1e0
>   do_renameat2+0x81c/0xa00
>   ? __pfx_do_renameat2+0x10/0x10
>   ? lock_release+0x365/0x730
>   ? __might_fault+0xbc/0x160
>   ? __pfx_lock_release+0x10/0x10
>   ? getname_flags.part.0+0x8d/0x430
>   ? lockdep_hardirqs_on_prepare+0x17b/0x410
>   __x64_sys_rename+0x7d/0xa0
>   do_syscall_64+0x5b/0x80
>   ? lockdep_hardirqs_on+0x7d/0x100
>   ? do_syscall_64+0x67/0x80
>   ? do_syscall_64+0x67/0x80
>   ? lockdep_hardirqs_on+0x7d/0x100
>   ? do_syscall_64+0x67/0x80
>   ? do_syscall_64+0x67/0x80
>   ? lockdep_hardirqs_on+0x7d/0x100
>   ? do_syscall_64+0x67/0x80
>   ? do_syscall_64+0x67/0x80
>   ? do_syscall_64+0x67/0x80
>   ? lockdep_hardirqs_on+0x7d/0x100
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7f8a2a5e3eab
> Code: e8 ba 2a 0a 00 f7 d8 19 c0 5b c3 0f 1f 40 00 b8 ff ff ff ff 5b c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05
> +c3 0f 1f 40 00 48 8b 15 51 8f 17 00 f7 d8
> RSP: 002b:00007f8a213fcc28 EFLAGS: 00000206 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 00007f8a1c00c640 RCX: 00007f8a2a5e3eab
> RDX: 0000000000000001 RSI: 000055d94c238820 RDI: 00007f8a213fcc30
> RBP: 00007f8a213fcc30 R08: 0000000000000000 R09: 00007f8a1c000130
> R10: 0000000000000000 R11: 0000000000000206 R12: 00007f8a1c00b480
> R13: 0000000000000067 R14: 00007f8a213fdce0 R15: 00007f8a1c00b180
>   </TASK>
> 
> Allocated by task 815:
>   kasan_save_stack+0x1c/0x40
>   kasan_set_track+0x21/0x30
>   __kasan_slab_alloc+0x88/0x90
>   kmem_cache_alloc_node+0x175/0x420
> 

