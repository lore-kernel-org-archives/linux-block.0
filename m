Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470BC678DB
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 08:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCGI6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 03:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCGI6F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 03:58:05 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC6222D8
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 00:57:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PW8VB5ymRz4f3jHm
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 16:57:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR+R_AZkXVn2EQ--.34512S3;
        Tue, 07 Mar 2023 16:57:55 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
Date:   Tue, 7 Mar 2023 16:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230307071448.rzihxbm4jhbf5krj@shindev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR+R_AZkXVn2EQ--.34512S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFykCw4fKF4kJFyrKFykXwb_yoWfGw13pr
        sxK3yxCr40vryUXr4SyrWkAw4rCw47Aa4UAFWxC3WfJa48Wr1aqFy7JrWjqryUGr18ua43
        Jay5Gr1jqa4Yg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/03/07 15:14, Shinichiro Kawasaki Ð´µÀ:
> I observe the KASAN BUG message with kernel v6.3-rc1 during my system boot [1].
> The BUG is reliably recreated. I bisected and found that the trigger commit is
> fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_cq"). I
> reverted the commit from v6.3-rc1, and observed the BUG disappears. Action for
> fix will be appreciated. I can take actions on my system if it helps.
> 
> [1]
> 
> ...
> [   49.534400] NET: Registered PF_QIPCRTR protocol family
> [   51.420663] ==================================================================
> [   51.422452] BUG: KASAN: slab-use-after-free in bfq_setup_cooperator+0x120b/0x1650
> [   51.423576] Read of size 4 at addr ffff88811a8bd600 by task NetworkManager/724
> 
> [   51.425032] CPU: 3 PID: 724 Comm: NetworkManager Not tainted 6.3.0-rc1-kts #1
> [   51.426105] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> [   51.427647] Call Trace:
> [   51.428103]  <TASK>
> [   51.428472]  dump_stack_lvl+0x57/0x90
> [   51.429042]  print_report+0xcf/0x630
> [   51.429642]  ? bfq_setup_cooperator+0x120b/0x1650
> [   51.430296]  kasan_report+0xbb/0xf0
> [   51.430843]  ? bfq_setup_cooperator+0x120b/0x1650
> [   51.431487]  bfq_setup_cooperator+0x120b/0x1650
> [   51.432175]  ? __pfx_lock_release+0x10/0x10
> [   51.432769]  ? __pfx_bfq_setup_cooperator+0x10/0x10
> [   51.433442]  ? lock_is_held_type+0xe3/0x140
> [   51.434046]  bfq_insert_requests+0xdfc/0x9360
> [   51.434622]  ? __pfx___lock_acquire+0x10/0x10
> [   51.435248]  ? set_operstate+0x193/0x1f0
> [   51.435778]  ? __pfx_bfq_insert_requests+0x10/0x10
> [   51.436440]  ? blk_mq_sched_insert_requests+0xba/0x880
> [   51.437091]  ? __pfx_lock_release+0x10/0x10
> [   51.437700]  blk_mq_sched_insert_requests+0x16b/0x880
> [   51.438356]  blk_mq_flush_plug_list+0x341/0xdb0
> [   51.438930]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
> [   51.439600]  __blk_flush_plug+0x28d/0x450
> [   51.440117]  ? __pfx___blk_flush_plug+0x10/0x10
> [   51.440734]  blk_finish_plug+0x4b/0xa0
> [   51.441199]  read_pages+0x50a/0xb90
> [   51.441627]  ? __pfx_read_pages+0x10/0x10
> [   51.442147]  ? free_unref_page_commit+0x243/0x500
> [   51.442698]  ? _raw_spin_unlock+0x29/0x50
> [   51.443176]  ? free_unref_page+0x2f2/0x400
> [   51.443687]  page_cache_ra_order+0x617/0x870
> [   51.444198]  filemap_fault+0xe45/0x1eb0
> [   51.444714]  ? __pfx_filemap_fault+0x10/0x10
> [   51.445221]  ? lock_is_held_type+0xe3/0x140
> [   51.445711]  ? lock_is_held_type+0xe3/0x140
> [   51.446238]  __xfs_filemap_fault+0x141/0x7d0 [xfs]
> [   51.447406]  ? __pfx___xfs_filemap_fault+0x10/0x10 [xfs]
> [   51.448302]  ? xfs_filemap_map_pages+0x9d/0xd0 [xfs]
> [   51.449200]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
> [   51.450073]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
> [   51.450953]  __do_fault+0xef/0x5b0
> [   51.451357]  ? __pfx_xfs_filemap_map_pages+0x10/0x10 [xfs]
> [   51.452236]  do_fault+0x4c1/0xec0
> [   51.452619]  ? __pfx_pmd_page_vaddr+0x10/0x10
> [   51.453139]  __handle_mm_fault+0xc40/0x2410
> [   51.453605]  ? lock_is_held_type+0xe3/0x140
> [   51.454063]  ? __pfx___handle_mm_fault+0x10/0x10
> [   51.454617]  ? count_memcg_events.constprop.0+0x40/0x50
> [   51.455171]  handle_mm_fault+0x21f/0x7a0
> [   51.455616]  do_user_addr_fault+0x344/0xed0
> [   51.456130]  exc_page_fault+0x65/0x100
> [   51.456555]  asm_exc_page_fault+0x22/0x30
> [   51.456999] RIP: 0033:0x562259a3da00
> [   51.457472] Code: Unable to access opcode bytes at 0x562259a3d9d6.
> [   51.458109] RSP: 002b:00007ffcd8f6c5d8 EFLAGS: 00010287
> [   51.458718] RAX: 0000562259a3da00 RBX: 0000000000000000 RCX: 0000000000000000
> [   51.459449] RDX: 00007f07c1ce9310 RSI: 000056225a0bb6f0 RDI: 000056225a07d8f0
> [   51.460224] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
> [   51.460919] R10: 0000000000000001 R11: 00007f07c1b58c80 R12: 000056225a07d8f0
> [   51.461669] R13: 0000000000000000 R14: 000056225a0c43d0 R15: 00007ffcd8f6c780
> [   51.462382]  </TASK>
> 
> [   51.462907] Allocated by task 723:
> [   51.463287]  kasan_save_stack+0x1c/0x40
> [   51.463705]  kasan_set_track+0x21/0x30
> [   51.464163]  __kasan_slab_alloc+0x85/0x90
> [   51.464602]  kmem_cache_alloc_node+0x16a/0x330
> [   51.465068]  bfq_get_queue+0x1fc/0x1420
> [   51.465537]  bfq_get_bfqq_handle_split+0x11a/0x510
> [   51.466029]  bfq_insert_requests+0x731/0x9360
> [   51.466492]  blk_mq_sched_insert_requests+0x16b/0x880
> [   51.467068]  blk_mq_flush_plug_list+0x341/0xdb0
> [   51.513146]  __blk_flush_plug+0x28d/0x450
> [   51.743436]  blk_finish_plug+0x4b/0xa0
> [   51.800072]  _xfs_buf_ioapply+0x68c/0xab0 [xfs]
> [   51.800884]  __xfs_buf_submit+0x1e8/0x7b0 [xfs]
> [   51.801677]  xfs_buf_read_map+0x301/0xad0 [xfs]
> [   51.802521]  xfs_trans_read_buf_map+0x280/0x7c0 [xfs]
> [   51.803368]  xfs_imap_to_bp+0xe6/0x140 [xfs]
> [   51.804164]  xfs_iget+0x780/0x2a60 [xfs]
> [   51.804909]  xfs_lookup+0x234/0x390 [xfs]
> [   51.805669]  xfs_vn_lookup+0x108/0x150 [xfs]
> [   51.806442]  lookup_open.isra.0+0x7e8/0x1280
> [   51.806965]  path_openat+0x829/0x25d0
> [   51.807388]  do_filp_open+0x19f/0x3b0
> [   51.807803]  do_open_execat+0xa8/0x570
> [   51.808282]  bprm_execve+0x3da/0x15e0
> [   51.808698]  do_execveat_common.isra.0+0x4d6/0x6c0
> [   51.809213]  __x64_sys_execve+0x88/0xb0
> [   51.809678]  do_syscall_64+0x37/0x90
> [   51.810084]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> [   51.810895] Freed by task 724:
> [   51.811256]  kasan_save_stack+0x1c/0x40
> [   51.811688]  kasan_set_track+0x21/0x30
> [   51.812161]  kasan_save_free_info+0x2a/0x50
> [   51.812627]  ____kasan_slab_free+0x169/0x1c0
> [   51.813096]  slab_free_freelist_hook+0xdb/0x1b0
> [   51.813642]  kmem_cache_free+0xdb/0x390
> [   51.814071]  bfq_put_queue+0x439/0x950
> [   51.814497]  bfq_setup_cooperator+0xa41/0x1650
> [   51.815030]  bfq_insert_requests+0xdfc/0x9360
> [   51.815503]  blk_mq_sched_insert_requests+0x16b/0x880
> [   51.816042]  blk_mq_flush_plug_list+0x341/0xdb0
> [   51.816583]  __blk_flush_plug+0x28d/0x450
> [   51.817027]  blk_finish_plug+0x4b/0xa0
> [   51.817451]  read_pages+0x50a/0xb90
> [   51.817897]  page_cache_ra_order+0x617/0x870
> [   51.818368]  filemap_fault+0xe45/0x1eb0
> [   51.818801]  __xfs_filemap_fault+0x141/0x7d0 [xfs]
> [   51.819622]  __do_fault+0xef/0x5b0
> [   51.820011]  do_fault+0x4c1/0xec0
> [   51.820448]  __handle_mm_fault+0xc40/0x2410
> [   51.820910]  handle_mm_fault+0x21f/0x7a0
> [   51.821352]  do_user_addr_fault+0x344/0xed0
> [   51.821864]  exc_page_fault+0x65/0x100
> [   51.822289]  asm_exc_page_fault+0x22/0x30
> 
> [   51.822956] The buggy address belongs to the object at ffff88811a8bd600
>                  which belongs to the cache bfq_queue of size 576
> [   51.824269] The buggy address is located 0 bytes inside of
>                  freed 576-byte region [ffff88811a8bd600, ffff88811a8bd840)
> 
> [   51.825761] The buggy address belongs to the physical page:
> [   51.826393] page:00000000e11d915c refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811a8bc2c0 pfn:0x11a8bc
> [   51.827462] head:00000000e11d915c order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   51.828247] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [   51.829021] raw: 0017ffffc0010200 ffff888100a95cc0 dead000000000122 0000000000000000
> [   51.829779] raw: ffff88811a8bc2c0 0000000080170011 00000001ffffffff 0000000000000000
> [   51.830581] page dumped because: kasan: bad access detected
> 
> [   51.831358] Memory state around the buggy address:
> [   51.831907]  ffff88811a8bd500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   51.832615]  ffff88811a8bd580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   51.833371] >ffff88811a8bd600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   51.834077]                    ^
> [   51.834496]  ffff88811a8bd680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   51.835228]  ffff88811a8bd700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   51.836009] ==================================================================
> [   51.836739] Disabling lock debugging due to kernel taint
> [   51.999350] e1000: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> ...
> 

Thanks for the report, can you help to provide the result of add2line of
following?

bfq_setup_cooperator+0x120b/0x1650
bfq_setup_cooperator+0xa41/0x1650

That will help to locate the problem.

Thanks,
Kuai
> 

