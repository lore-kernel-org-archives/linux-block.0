Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C5BC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 11:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5213761026
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 11:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFULfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 07:35:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36704 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhFULfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 07:35:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UdA9Y25_1624275214;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UdA9Y25_1624275214)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 19:33:35 +0800
Subject: Re: [dm-devel] [RFC PATCH V2 3/3] dm: support bio polling
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-4-ming.lei@redhat.com>
 <5ba43dac-b960-7c85-3a89-fdae2d1e2f51@linux.alibaba.com>
 <YMywCX6nLqLiHXyy@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <9b42601a-ca54-4748-e592-3720b7994d7b@linux.alibaba.com>
Date:   Mon, 21 Jun 2021 19:33:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMywCX6nLqLiHXyy@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/18/21 10:39 PM, Ming Lei wrote:
> From 47e523b9ee988317369eaadb96826323cd86819e Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Wed, 16 Jun 2021 16:13:46 +0800
> Subject: [RFC PATCH V3 3/3] dm: support bio polling
> 
> Support bio(REQ_POLLED) polling in the following approach:
> 
> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> still fallback on IRQ mode, so the target io is exactly inside the dm
> io.
> 
> 2) hold one refcnt on io->io_count after submitting this dm bio with
> REQ_POLLED
> 
> 3) support dm native bio splitting, any dm io instance associated with
> current bio will be added into one list which head is bio->bi_end_io
> which will be recovered before ending this bio
> 
> 4) implement .poll_bio() callback, call bio_poll() on the single target
> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> dec_pending() after the target io is done in .poll_bio()
> 
> 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> which is based on Jeffle's previous patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- covers all comments from Jeffle
> 	- fix corner cases when polling on abnormal ios
> 
...

One bug and one performance issue, though I haven't investigated deep
for both.


kernel base: based on Jens' for-next, applying Christoph and Leiming's
patchset.


1. One bug when there's DM device stack, e.g., dm-linear upon another
dm-linear. Can be reproduced by following steps:

```
$ sudo dmsetup create tmpdev --table '0 2097152 linear /dev/nvme0n1 0'

$ cat tmp.table
0 2097152 linear /dev/mapper/tmpdev 0
2097152 2097152 linear /dev/nvme0n1 0

$ cat tmp.table | dmsetup create testdev

$ fio -name=test -ioengine=io_uring -iodepth=128 -numjobs=1 -thread
-rw=randread -direct=1 -bs=4k -time_based -runtime=10 -cpus_allowed=6
-filename=/dev/mapper/testdev -hipri=1
```


BUG: unable to handle page fault for address: ffffffffc01a6208
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 39740c067 P4D 39740c067 PUD 39740e067 PMD 1035db067 PTE 1ddf6f061
Oops: 0003 [#1] SMP PTI
CPU: 6 PID: 5899 Comm: fio Tainted: G S
5.13.0-0.1.git.81bcdc3.al7.x86_64 #1
Hardware name: Inventec     K900G3-10G/B900G3, BIOS A2.20 06/23/2017
RIP: 0010:dm_submit_bio+0x171/0x3e0 [dm_mod]
Code: 08 85 c0 0f 84 78 01 00 00 80 7c 24 2c 00 0f 84 b8 00 00 00 48 8b
53 38 48 8b 44 24 18 48 85 d2 48 8d 48 28 48 89 50 28 74 04 <48> 89 4a
08 48 89 4b 38 48 83 c3 38 48 89 58 30 41 f7 c5 fe ff ff
RSP: 0018:ffff9e5c45e1b9a0 EFLAGS: 00010286
RAX: ffff8ab59fd50140 RBX: ffff8ab59fd50088 RCX: ffff8ab59fd50168
RDX: ffffffffc01a6200 RSI: 0000000000052f08 RDI: 0000000000000000
RBP: ffff8ab59fd501c8 R08: 0000000000000000 R09: 0000000000000000
R10: ffff9e5c45e1b950 R11: 0000000000000007 R12: ffff8ab4c2bc2000
R13: 0000000000000000 R14: ffff8ab4c2bc2548 R15: ffff8ab59fd50140
FS:  00007f555de42700(0000) GS:ffff8af33f180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc01a6208 CR3: 0000000124990005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 submit_bio_noacct+0x144/0x3f0
 ? submit_bio+0x42/0x120
 submit_bio+0x42/0x120
 blkdev_direct_IO+0x454/0x4b0
 ? io_resubmit_prep+0x40/0x40
 ? __fsnotify_parent+0xff/0x350
 ? __fsnotify_parent+0x10f/0x350
 ? generic_file_read_iter+0x83/0x150
 generic_file_read_iter+0x83/0x150
 blkdev_read_iter+0x41/0x50
 io_read+0xe9/0x420
 ? __cond_resched+0x16/0x40
 ? __kmalloc_node+0x16e/0x4e0
 ? memcg_alloc_page_obj_cgroups+0x32/0x90
 ? io_issue_sqe+0x7e8/0x1260
 io_issue_sqe+0x7e8/0x1260
 ? io_submit_sqes+0x47b/0x1420
 __io_queue_sqe+0x56/0x380
 ? io_submit_sqes+0x120a/0x1420
 io_submit_sqes+0x120a/0x1420
 ? __x64_sys_io_uring_enter+0x1d2/0x3e0
 __x64_sys_io_uring_enter+0x1d2/0x3e0
 ? exit_to_user_mode_prepare+0x4c/0x210
 do_syscall_64+0x36/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f55d3cb1b59
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ff e2 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007f555de41b18 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f55d3cb1b59
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007f557ce81000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000001276000
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000012c8328




2. Performance Issue

I test both on x86 (with only one NVMe) and aarch64 (with multiple NVMes).

The result (IOPS) on x86 is as expected:

Type 	  |IRQ   | Polling
--------- | ---- | ----
dm-linear | 239k | 357k

- dm-linear built upon one NVMe，bs=4k, iopoll=1, iodepth=128,
numjobs=1, direct, randread, ioengine=io_uring



While the result on aarch64 is a little confusing.

Type 	      |IRQ   | Polling
------------- | ---- | ----
dm-linear [1] | 208k | 230k
dm-linear [2] | 637k | 691k
dm-stripe     | 310k | 354k

- dm-linear [1] built upon *one* NVMe，bs=4k, iopoll=1, iodepth=128,
*numjobs=1*, direct, randread, ioengine=io_uring
- dm-linear [2] built upon *three* NVMes，bs=4k, iopoll=1, iodepth=128,
*numjobs=3*, direct, randread, ioengine=io_uring
- dm-stripe built upon *three* NVMes，chunk_size=4k, bs=12k, iopoll=1,
iodepth=128, numjobs=3, direct, randread, ioengine=io_uring


Following is the corresponding test result of Leiming's last
implementation for bio-based polling on aarch64.
IRQ	IOPOLL	ratio
dm-linear [2]	639K	835K	~30%
dm-stripe 	314K	408K	~30%


-- 
Thanks,
Jeffle
