Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE58C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F62B60E74
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhJZOpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhJZOpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5346C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b188so20717706iof.8
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eh0m6mhz4X/x9uIau1EKlBJBh1kSpnmX4hOEKbGmAXE=;
        b=hINYsXUgjEusOMHac5nxN+1XD8tNA1rsnPqN/rR2l8CXwWJei//br3+ybvk9UvvtrV
         GvaB1p8Q3v8yqC5Jo2Oq2SK+SffEWjWtKkyf3RZ+WDgLjeGgtlCROIkR9Q5hjtTUQnvf
         QcfV81YzHY2sNqVam12RjebugLlbZdlR7m37iSsjlh94FdLgwlbyM9yI2h6Aq3AzQh8b
         4du53WtRtvepcKZxfbYmD3dKnbQ/yg4/9y/dIB2xffSVEK0oygTDalUtefEQZAUbukEF
         4NJJjDLCTUsqtETwAzvW5sUbFcJzQaav/6JTIgbQESE99JqsxG7lgoXBlIXUC/Sm5tWb
         z2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eh0m6mhz4X/x9uIau1EKlBJBh1kSpnmX4hOEKbGmAXE=;
        b=vho7tPUhIDCTABYTAnv9XAHQiIjh9N3pR8GRhED3Od/kYrdydPoj4K7NXxfk6H3kO4
         Q5NFPkmGKifvh8vNF/0ab6icG5yJJP3ggENMEYr2IYw0k+Gc86U57urjjwaCLOnrBm97
         1/BcY496zrCimmBWa5K5ZgWtzAAIKjBWcccfv7nH1kuaQtyHjvgVRfzfbnUoqVVEjGnG
         5tAn+OAr/mLyG+3KswnqzMNlvVrD1J6nJDX4n/x12Tl55ryzFUUfeeeXeLH7mPoD/40U
         CEuhj6js2R5Jo/QDnHaAiQzgu9eZ7RAm5LsFnF1anevox9BQYh8uIvjToEaND8zkF0Ib
         C5Fw==
X-Gm-Message-State: AOAM533p/qWx23Co5+9kpy2IqfRKKnvPNh/Z4PjvghXiBwtlIeW2a3Do
        l1Lq/oAq5LgSTNiltjH+fcGHNQ==
X-Google-Smtp-Source: ABdhPJwUunPt/Ngy3IntI/GvvhA7VaXFIsVepe7TymxxokbgnCJ3c/PUZZLuEAsADEVcMLAXLljbEw==
X-Received: by 2002:a05:6602:122c:: with SMTP id z12mr116895iot.188.1635259368032;
        Tue, 26 Oct 2021 07:42:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e11sm7649059ils.34.2021.10.26.07.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:42:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk>
 <20211026052036.xdsw6ejx2e2n7jhi@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e8930e4f-0359-9218-3006-14463d7fe68c@kernel.dk>
Date:   Tue, 26 Oct 2021 08:42:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211026052036.xdsw6ejx2e2n7jhi@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 11:20 PM, Shinichiro Kawasaki wrote:
> On Oct 19, 2021 / 06:08, Jens Axboe wrote:
>> If we have just one queue type in the plug list, then we can extend our
>> direct issue to cover a full plug list as well.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Hi Jens, I tried out for-next branch and observed A WARNING "do not call
> blocking ops when !TASK_RUNNING" [1]. Reverting this patch from the for-next
> branch, the warning disappears. The warning was triggered when mkfs.xfs is
> run for memory backed null_blk devices with "none" scheduler. The commands below
> recreates it.
> 
> # modprobe null_blk nr_devices=0
> # mkdir /sys/kernel/config/nullb/nullb0
> # declare sysfs=/sys/kernel/config/nullb/nullb0
> # echo 1 > "${sysfs}"/memory_backed
> # echo 1 > "${sysfs}"/power
> # echo none > /sys/block/nullb0/queue/scheduler
> # mkfs.xfs /dev/nullb0
> 
> 
> Referring the call stack printed, I walked through the function calls. In
> __blkdev_direct_IO_simple(), task state is set UNINTERRUPTIBLE. Way
> down to might_sleep_if() called from null_queue_rq(), it is warned that
> the task state is not RUNNING. This patch adds blk_mq_plug_issue_direct()
> call in blk_mq_flush_plug_list(), then the call path was linked from
> __blkdev_direct_IO_simple() to null_queue_rq().
> 
> __blkdev_direct_IO_simple() block/fops.c
>   set_current_state(TASK_UNINTERRUPTIBLE) ... current->__state = TASK_UNINTERRUPTIBLE
>   blk_io_schedule()
>     io_schedule_timeout() kernel/sched/core.c
>       io_schedule_prepare()
>         blk_schedule_flush_plug() include/linux/blkdev.h
>           blk_flush_plug_list() block/blk-core.c
>             blk_mq_flush_plug_list()
>               blk_mq_flush_plug_list() block/blk-mq.c  ... this patch added call to blk_mq_plug_issue_direct()
>                 blk_mq_plug_issue_direct()
>                   blk_mq_reqeust_issue_directly()
>                     __blk_mq_try_issue_directly()
>                       __blk_mq_issue_directly()
>                         q->mq_ops->queue_rq()
>                           null_queue_rq() drivers/block/null_blk/main.c
>                             might_sleep_if(flags & BLK_MQ_F_BLOCKING) include/linux/kernel.h
>                               might_sleep()
>                                 __might_sleep() kernel/sched/core.c ... current->__state != TASK_RUNNING  (WARN_ONCE)
> 
> So far, I can't think of a good solution for this warning. Any idea?
> 
> 
> [1]
> 
> [60501.340746] null_blk: module loaded
> [60519.303106] ------------[ cut here ]------------
> [60519.308485] do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000005ba5e596>] __blkdev_direct_IO_simple+0x3f8/0x6f0
> [60519.320943] WARNING: CPU: 2 PID: 8929 at kernel/sched/core.c:9486 __might_sleep+0x124/0x160
> [60519.330001] Modules linked in: null_blk xfs dm_zoned xt_conntrack nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nfnetlink ebtable_filter rfkill ebtables target_core_user target_core_mod ip6table_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass iTCO_wdt intel_pmc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore pcspkr joydev ipmi_ssif i2c_i801 lpc_ich i2c_smbus ses enclosure mei_me mei ioatdma wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter zram ip_tables ast
> [60519.330166]  drm_vram_helper drm_kms_helper cec drm_ttm_helper crct10dif_pclmul ttm crc32_pclmul crc32c_intel drm ghash_clmulni_intel igb mpt3sas nvme dca nvme_core i2c_algo_bit raid_class scsi_transport_sas fuse [last unloaded: null_blk]
> [60519.438458] CPU: 2 PID: 8929 Comm: mkfs.xfs Not tainted 5.15.0-rc6+ #11
> [60519.445781] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
> [60519.453893] RIP: 0010:__might_sleep+0x124/0x160
> [60519.459139] Code: 48 8d bb 98 2c 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 75 31 48 8b 93 98 2c 00 00 44 89 f6 48 c7 c7 e0 f2 88 8a e8 04 eb f9 01 <0f> 0b e9 6d ff ff ff e8 60 d1 66 00 e9 1c ff ff ff e8 66 d1 66 00
> [60519.478594] RSP: 0018:ffff8882707ef5a8 EFLAGS: 00010286
> [60519.484533] RAX: 0000000000000000 RBX: ffff888125cbb280 RCX: 0000000000000000
> [60519.492379] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffffed104e0fdeab
> [60519.500216] RBP: ffffffffc16122c0 R08: 0000000000000001 R09: ffff8888114ad587
> [60519.508052] R10: ffffed1102295ab0 R11: 0000000000000001 R12: 0000000000000618
> [60519.515886] R13: 0000000000000000 R14: 0000000000000002 R15: ffff88813160a000
> [60519.523721] FS:  00007fd79959b400(0000) GS:ffff888811480000(0000) knlGS:0000000000000000
> [60519.532509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60519.538963] CR2: 000055bf4e3dc000 CR3: 000000029e904005 CR4: 00000000001706e0
> [60519.546803] Call Trace:
> [60519.549976]  null_queue_rq+0x3ee/0x6b0 [null_blk]
> [60519.555407]  __blk_mq_try_issue_directly+0x433/0x680
> [60519.561085]  ? __submit_bio+0x63a/0x780
> [60519.565636]  ? __blk_mq_get_driver_tag+0x9a0/0x9a0
> [60519.571144]  blk_mq_flush_plug_list+0x5f6/0xc40
> [60519.576387]  ? iov_iter_get_pages_alloc+0xf50/0xf50
> [60519.581980]  ? find_held_lock+0x2c/0x110
> [60519.586618]  ? blk_mq_insert_requests+0x440/0x440
> [60519.592044]  ? __blkdev_direct_IO_simple+0x3f8/0x6f0
> [60519.597719]  blk_flush_plug_list+0x28f/0x410
> [60519.602710]  ? blk_start_plug_nr_ios+0x270/0x270
> [60519.608039]  ? __blkdev_direct_IO_simple+0x3f8/0x6f0
> [60519.613713]  io_schedule_timeout+0xcc/0x150
> [60519.618621]  __blkdev_direct_IO_simple+0x475/0x6f0
> [60519.624126]  ? blkdev_llseek+0xc0/0xc0
> [60519.628598]  ? blkdev_get_block+0xd0/0xd0
> [60519.633320]  ? filemap_check_errors+0xe0/0xe0
> [60519.638391]  ? find_held_lock+0x2c/0x110
> [60519.643024]  ? lock_release+0x1d4/0x690
> [60519.647574]  blkdev_direct_IO+0x9b2/0x1110
> [60519.652389]  ? filemap_check_errors+0x56/0xe0
> [60519.657455]  ? add_watch_to_object+0xa0/0x6e0
> [60519.662524]  ? blkdev_bio_end_io+0x490/0x490
> [60519.667518]  generic_file_direct_write+0x1a9/0x4a0
> [60519.673026]  __generic_file_write_iter+0x1fa/0x480
> [60519.678526]  ? lock_is_held_type+0xe0/0x110
> [60519.683420]  blkdev_write_iter+0x319/0x5a0
> [60519.688231]  ? blkdev_open+0x260/0x260
> [60519.692690]  ? lock_downgrade+0x6b0/0x6b0
> [60519.697412]  ? do_raw_spin_unlock+0x55/0x1f0
> [60519.702392]  new_sync_write+0x359/0x5e0
> [60519.706941]  ? new_sync_read+0x5d0/0x5d0
> [60519.711582]  ? __cond_resched+0x15/0x30
> [60519.716124]  ? inode_security+0x56/0xf0
> [60519.720688]  vfs_write+0x5e4/0x8e0
> [60519.724805]  __x64_sys_pwrite64+0x17c/0x1d0
> [60519.729698]  ? vfs_write+0x8e0/0x8e0
> [60519.733982]  ? syscall_enter_from_user_mode+0x21/0x70
> [60519.739747]  do_syscall_64+0x3b/0x90
> [60519.744037]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [60519.749796] RIP: 0033:0x7fd7997c125a
> [60519.754088] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 f3 0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [60519.773543] RSP: 002b:00007ffe8d456718 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> [60519.781816] RAX: ffffffffffffffda RBX: 00007ffe8d456e10 RCX: 00007fd7997c125a
> [60519.789656] RDX: 0000000000020000 RSI: 000055bf4e3bd600 RDI: 0000000000000004
> [60519.797494] RBP: 0000000000020000 R08: 000055bf4e3bd600 R09: 00007fd79975fa60
> [60519.805333] R10: 00000003fffe0000 R11: 0000000000000246 R12: 000055bf4e3b9710
> [60519.813172] R13: 0000000000000004 R14: 000055bf4e3bd600 R15: 0000000000001000
> [60519.821028] irq event stamp: 20385
> [60519.825139] hardirqs last  enabled at (20395): [<ffffffff883481e0>] __up_console_sem+0x60/0x70
> [60519.834455] hardirqs last disabled at (20404): [<ffffffff883481c5>] __up_console_sem+0x45/0x70
> [60519.843763] softirqs last  enabled at (20372): [<ffffffff881e6a7c>] __irq_exit_rcu+0x19c/0x200
> [60519.853079] softirqs last disabled at (20367): [<ffffffff881e6a7c>] __irq_exit_rcu+0x19c/0x200
> [60519.862389] ---[ end trace be9623465002e439 ]---

This one should fix it:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=ff1552232b3612edff43a95746a4e78e231ef3d4

-- 
Jens Axboe

