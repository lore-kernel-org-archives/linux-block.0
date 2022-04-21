Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204DC43219
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386979AbiDUIyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386978AbiDUIyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 04:54:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4360513E9F
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 01:51:32 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkWVM2f0KzhXYx;
        Thu, 21 Apr 2022 16:51:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:51:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:51:29 +0800
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590> <20220420124213.5wc4umnjrlvu6zbi@shindev>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9d31f634-90e0-efc3-394e-37ce0515c836@huawei.com>
Date:   Thu, 21 Apr 2022 16:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220420124213.5wc4umnjrlvu6zbi@shindev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/04/20 20:42, Shinichiro Kawasaki Ð´µÀ:
>> Hello,
>>
>> Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.
>>
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.18&id=a87c29e1a85e64b28445bb1e80505230bf2e3b4b
> 
> Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/002.
> Unfortunately, it failed with a new symptom with KASAN use-after-free [2]. I
> ran block/002 with linux-block/block-5.18 branch tip with git hash a87c29e1a85e
> and got the same KASAN uaf. Reverting the patch from the linux-block/block-5.18
> branch, the KASAN uaf disappears (Still block/002 fails). Regarding block/002,
> it looks the patch made the failure symptom worse.
> 
> [2]
> 
> [  466.424358] run blktests block/002 at 2022-04-20 19:44:02
> [  466.508847] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [  466.518617] scsi host7: scsi_debug: version 0191 [20210520]
>                   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  466.535080] scsi 7:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> [  466.548701] sd 7:0:0:0: Power-on or device reset occurred
> [  466.549819] sd 7:0:0:0: Attached scsi generic sg9 type 0
> [  466.557985] sd 7:0:0:0: [sdi] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [  466.570116] sd 7:0:0:0: [sdi] Write Protect is off
> [  466.575644] sd 7:0:0:0: [sdi] Mode Sense: 73 00 10 08
> [  466.577821] sd 7:0:0:0: [sdi] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [  466.590343] sd 7:0:0:0: [sdi] Optimal transfer size 524288 bytes
> [  466.645516] sd 7:0:0:0: [sdi] Attached SCSI disk
> [  467.438285] sd 7:0:0:0: [sdi] Synchronizing SCSI cache
> [  467.458790] ==================================================================
> [  467.466714] BUG: KASAN: use-after-free in __lock_acquire+0x396b/0x5030
> [  467.473951] Read of size 8 at addr ffff888104e05248 by task check/1549
> 
> [  467.483373] CPU: 1 PID: 1549 Comm: check Not tainted 5.18.0-rc3+ #24
> [  467.490426] Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
> [  467.498164] Call Trace:
> [  467.501313]  <TASK>
> [  467.504120]  dump_stack_lvl+0x56/0x6f
> [  467.508488]  print_report.cold+0x5e/0x5db
> [  467.513205]  ? __lock_acquire+0x396b/0x5030
> [  467.518092]  kasan_report+0xbf/0xf0
> [  467.522288]  ? lockdep_lock+0x30/0x1a0
> [  467.526738]  ? __lock_acquire+0x396b/0x5030
> [  467.531630]  __lock_acquire+0x396b/0x5030
> [  467.536346]  ? lockdep_unlock+0xf2/0x240
> [  467.540970]  ? __lock_acquire+0x23db/0x5030
> [  467.545861]  ? lockdep_hardirqs_on_prepare+0x410/0x410
> [  467.551705]  lock_acquire+0x19a/0x4b0
> [  467.556068]  ? lockref_get+0x9/0x40
> [  467.560264]  ? lock_release+0x6c0/0x6c0
> [  467.564806]  ? lock_is_held_type+0xe2/0x140
> [  467.569693]  ? find_held_lock+0x2c/0x110
> [  467.574316]  ? lock_release+0x3a7/0x6c0
> [  467.578856]  _raw_spin_lock+0x2f/0x40
> [  467.583222]  ? lockref_get+0x9/0x40
> [  467.587414]  lockref_get+0x9/0x40
> [  467.591439]  simple_recursive_removal+0x36/0x7e0
> [  467.596758]  ? debugfs_remove+0x60/0x60
> [  467.601300]  ? do_raw_spin_unlock+0x55/0x1f0
> [  467.606278]  debugfs_remove+0x40/0x60
> [  467.610643]  blk_mq_debugfs_unregister_queue_rqos+0x34/0x70
> [  467.616919]  rq_qos_exit+0x1b/0xf0
> [  467.621028]  ? sysfs_file_ops+0x170/0x170
> [  467.625740]  blk_cleanup_queue+0xfd/0x1f0
> [  467.630449]  __scsi_remove_device+0xdd/0x2b0
> [  467.635422]  sdev_store_delete+0x83/0x120
> [  467.640137]  kernfs_fop_write_iter+0x353/0x520
> [  467.645287]  new_sync_write+0x2d9/0x500
> [  467.649827]  ? new_sync_read+0x500/0x500
> [  467.654455]  ? perf_msr_probe+0x1f0/0x280
> [  467.659170]  ? lock_release+0x6c0/0x6c0
> [  467.663709]  ? inode_security+0x54/0xf0
> [  467.668253]  ? lock_is_held_type+0xe2/0x140
> [  467.673144]  vfs_write+0x61c/0x910
> [  467.677250]  ksys_write+0xe3/0x1a0
> [  467.681355]  ? __ia32_sys_read+0xa0/0xa0
> [  467.685982]  ? syscall_enter_from_user_mode+0x21/0x70
> [  467.691740]  do_syscall_64+0x3b/0x90
> [  467.696018]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  467.701772] RIP: 0033:0x7f2d0b701817
> [  467.706046] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  467.725492] RSP: 002b:00007ffd37a645e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  467.733762] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d0b701817
> [  467.741596] RDX: 0000000000000002 RSI: 000055a23ecf4630 RDI: 0000000000000001
> [  467.749431] RBP: 000055a23ecf4630 R08: 0000000000000000 R09: 00007f2d0b7b64e0
> [  467.757267] R10: 00007f2d0b7b63e0 R11: 0000000000000246 R12: 0000000000000002
> [  467.765101] R13: 00007f2d0b7fb5a0 R14: 0000000000000002 R15: 00007f2d0b7fb7a0
> [  467.772945]  </TASK>
> 
> [  467.778033] Allocated by task 111:
> [  467.782141]  kasan_save_stack+0x1e/0x40
> [  467.786681]  __kasan_slab_alloc+0x90/0xc0
> [  467.791395]  kmem_cache_alloc_lru+0x258/0x720
> [  467.796457]  __d_alloc+0x31/0x960
> [  467.800477]  d_alloc+0x44/0x200
> [  467.804326]  d_alloc_parallel+0xca/0x1490
> [  467.809041]  __lookup_slow+0x17f/0x3d0
> [  467.813495]  lookup_one_len+0x10b/0x130
> [  467.818038]  start_creating.part.0+0xf0/0x220
> [  467.823098]  debugfs_create_dir+0x2f/0x460
> [  467.827901]  blk_mq_debugfs_register_rqos+0x1fe/0x330
Hi,

Sorry that I missed the 'q->rqos_debugfs_dir' which is created under
'q->debugfs_dir'.

Ming, do you think move blk_mq_debugfs_unregister_queue_rqos() to
blk_unregister_queue() is okay?

Thanks,
Kuai
> [  467.833655]  wbt_init+0x35e/0x630
> [  467.837676]  blk_register_queue+0x26c/0x430
> [  467.842565]  device_add_disk+0x639/0xd90
> [  467.847192]  sd_probe+0x93f/0xf50
> [  467.851212]  really_probe+0x3d7/0xa10
> [  467.855581]  __driver_probe_device+0x2ab/0x460
> [  467.860721]  driver_probe_device+0x49/0x120
> [  467.865610]  __device_attach_driver+0x191/0x240
> [  467.870845]  bus_for_each_drv+0x119/0x180
> [  467.875560]  __device_attach_async_helper+0x172/0x210
> [  467.881314]  async_run_entry_fn+0x95/0x500
> [  467.886115]  process_one_work+0x7cf/0x12d0
> [  467.890915]  worker_thread+0x5ac/0xec0
> [  467.895369]  kthread+0x2a7/0x350
> [  467.899305]  ret_from_fork+0x22/0x30
