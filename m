Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751539AbeDIXCb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 19:02:31 -0400
Date: Tue, 10 Apr 2018 07:02:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Wang <liwang@redhat.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [s390x] New regression was found on kernel-4.16
Message-ID: <20180409230215.GB6450@ming.t460p>
References: <CAEemH2d_0DCUR9jnwu7ka-ngQBASuCOYMK5hd2oX582pF6fogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEemH2d_0DCUR9jnwu7ka-ngQBASuCOYMK5hd2oX582pF6fogQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 09, 2018 at 06:18:04PM +0800, Li Wang wrote:
> Hi,
> 
> I got this BUG_ON() on s390x platform with kernel-v4.16.0.
> 
> [    1.200196] ------------[ cut here ]------------
> [    1.200201] kernel BUG at block/bio.c:1798!
> [    1.200228] illegal operation: 0001 ilc:1 [#1] SMP
> [    1.200230] Modules linked in: dasd_eckd_mod(+) dasd_mod qeth(+)
> qdio lcs ctcm ccwgroup fsm dm_mirror dm_region_hash dm_log dm_mod
> [    1.200236] CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 4.16.0 #1
> [    1.200237] Hardware name: IBM 2827 H43 400 (z/VM 6.4.0)
> [    1.200243] Workqueue: events do_kick_device [dasd_mod]
> [    1.200245] Krnl PSW : 000000008cb7d53b 000000007073145d
> (bio_split+0xcc/0xd0)
> [    1.200250]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3
> CC:2 PM:0 RI: 0 EA:3
> [    1.200252] Krnl GPRS: 0000000000000000 0000000000000000
> 0000000001cc4400 000 0000000000000
> [    1.200253]            0000000001400000 000000007ccdb400
> 0000000000000000 000 0000000000008
> [    1.200254]            0000000001cc4400 000003d101df1640
> 0000000000001000 000 0000001cc4400
> [    1.200255]            0000000000000000 000000000077f088
> 000000007ccbb590 000 000007ccbb560
> [    1.200262] Krnl Code: 00000000004311e8: a7f4ffec            brc
>  15,4311c 0
> [    1.200262]            00000000004311ec: a7f40001            brc
>  15,4311e e
> [    1.200262]           #00000000004311f0: a7f40001            brc
>  15,4311f 2
> [    1.200262]           >00000000004311f4: 0707                bcr
>  0,%r7
> [    1.200262]            00000000004311f6: 0707                bcr
>  0,%r7
> [    1.200262]            00000000004311f8: c00400000000        brcl
>  0,4311f8
> [    1.200262]            00000000004311fe: eb6ff0480024        stmg
>  %r6,%r15 ,72(%r15)
> [    1.200262]            0000000000431204: a7f13f80            tmll
>  %r15,162 56
> [    1.200275] Call Trace:
> [    1.200278] ([<0000000001088020>] 0x1088020)
> [    1.200281]  [<0000000000443d54>] blk_queue_split+0x4a4/0x608
> [    1.200283]  [<000000000044ab6c>] blk_mq_make_request+0x7c/0x640
> [    1.200286]  [<000000000043b148>] generic_make_request+0x108/0x2b0
> [    1.200288]  [<000000000043b384>] submit_bio+0x94/0x158
> [    1.200290]  [<000000000034eede>] submit_bh_wbc+0x1b6/0x200
> [    1.200292]  [<000000000034fcc4>] block_read_full_page+0x3d4/0x3f0
> [    1.200294]  [<000000000026bdde>] do_read_cache_page+0x1ae/0x380
> [    1.200296]  [<000000000026bfe0>] read_cache_page+0x30/0x40
> [    1.200298]  [<0000000000455490>] read_dev_sector+0x58/0xe8
> [    1.200300]  [<0000000000459f4e>] read_lba+0xfe/0x1b0
> [    1.200301]  [<000000000045a5be>] find_valid_gpt+0xe6/0x618
> [    1.200303]  [<000000000045add8>] efi_partition+0x2e8/0x358
> [    1.200304]  [<0000000000457720>] check_partition+0x158/0x288
> [    1.200306]  [<0000000000455bd8>] rescan_partitions+0xd8/0x3e0
> [    1.200307]  [<0000000000450870>] blkdev_reread_part+0x40/0x60
> [    1.200312]  [<000003ff80165384>] dasd_scan_partitions+0x64/0x140
> [dasd_mod]
> [    1.200317]  [<000003ff8015fb86>] dasd_change_state+0xb6e/0xc18
> [dasd_mod]
> [    1.200322]  [<000003ff8015fc78>] do_kick_device+0x48/0x98
> [dasd_mod]
> [    1.200325]  [<000000000015f50e>] process_one_work+0x19e/0x420
> [    1.200327]  [<000000000015f7e2>] worker_thread+0x52/0x458
> [    1.200328]  [<0000000000165bb4>] kthread+0x134/0x168
> [    1.200333]  [<0000000000716722>] kernel_thread_starter+0x6/0xc
> [    1.200335]  [<000000000071671c>] kernel_thread_starter+0x0/0xc
> [    1.200335] Last Breaking-Event-Address:
> [    1.200337]  [<00000000004311f0>] bio_split+0xc8/0xd0
> [    1.200337]
> [    1.200338] Kernel panic - not syncing: Fatal exception:
> panic_on_oops

Turns out one fundamental issue, please test: 

	e9092d0d9796 ("Fix subtle macro variable shadowing in min_not_zero()")

and see discussion in the thread:

	https://marc.info/?t=152328917200004&r=1&w=2

-- 
Ming
