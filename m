Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9232 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbcKIAuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2016 19:50:24 -0500
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
CC: <linux-block@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
Date: Wed, 9 Nov 2016 09:50:13 +0900
MIME-Version: 1.0
In-Reply-To: <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Jens,

On 11/9/16 05:21, Jens Axboe wrote:
> On 11/08/2016 12:55 PM, Logan Gunthorpe wrote:
>> Hey,
>>
>> I've attached the output of dmesg from a working boot and the output of
>> mount.
>>
>> Pretty much all the file systems are ext4. We have some experimental
>> nvme devices in this system which I did try removing to eliminate that
>> possibility.
>>
>> Let me know if you need anything else.
> 
> You're using dm, that might be related. Mike, have you tried booting
> for-4.10/block and checking if dm works fine?

Using yesterday's tree, I experienced similar problems with
for-4.10/block without using dm (using ext4 on top of SSDs): random
tasks hung, starting from boot, with the machine eventually completely
freezing.

I did not dig into the problem a lot. I just looked at task stack traces
(echo t > /proc/sysrq-trigger) and noticed that hung tasks are waiting
for requests. Ex:

[   55.356418] plymouthd       D ffffffff81671758     0   353      1
0x00000000
[   55.356419]  ffff8807fbf1ec00 0000000000000000 ffff8807fba6d500
ffff8807fba3b600
[   55.356420]  ffff88081fb97900 ffff8807f04079a8 ffffffff81671758
000000000000158f
[   55.356421]  0000000000000000 ffff8807f3373800 ffff8807fba3b600
ffff88081fb97900
[   55.356421] Call Trace:
[   55.356421]  [<ffffffff81671758>] ? __schedule+0x178/0x650
[   55.356422]  [<ffffffff81671c70>] schedule+0x40/0x90
[   55.356423]  [<ffffffff816749d1>] schedule_timeout+0x2b1/0x3e0
[   55.356424]  [<ffffffff8115419d>] ? mempool_alloc_slab+0x1d/0x30
[   55.356425]  [<ffffffff810e0971>] ? ktime_get+0x41/0xb0
[   55.356426]  [<ffffffff81671574>] io_schedule_timeout+0xa4/0x110
[   55.356427]  [<ffffffff8130ee2b>] get_request+0x3fb/0x7d0
[   55.356428]  [<ffffffff8120fd83>] ? __find_get_block+0xf3/0x180
[   55.356429]  [<ffffffff810be260>] ? wait_woken+0x90/0x90
[   55.356431]  [<ffffffff813117cb>] blk_queue_bio+0xfb/0x3c0
[   55.356432]  [<ffffffff8130fb90>] generic_make_request+0xd0/0x180
[   55.356433]  [<ffffffff8130fcac>] submit_bio+0x6c/0x130
[   55.356436]  [<ffffffff81270f08>] ext4_io_submit+0x38/0x50
[   55.356437]  [<ffffffff8126c241>] ext4_writepages+0x561/0xdb0
[   55.356439]  [<ffffffff811601e1>] do_writepages+0x21/0x30
[   55.356440]  [<ffffffff811520aa>] __filemap_fdatawrite_range+0xaa/0xf0
[   55.356440]  [<ffffffff811524df>] ? __generic_file_write_iter+0x14f/0x1d0
[   55.356441]  [<ffffffff8115213c>] filemap_flush+0x1c/0x20
[   55.356442]  [<ffffffff812698bc>] ext4_alloc_da_blocks+0x2c/0x80
[   55.356443]  [<ffffffff81262268>] ext4_release_file+0x78/0xc0
[   55.356446]  [<ffffffff811db2a9>] __fput+0xb9/0x200
[   55.356447]  [<ffffffff811db42e>] ____fput+0xe/0x10
[   55.356449]  [<ffffffff81097bf5>] task_work_run+0x85/0xb0
[   55.356450]  [<ffffffff810016a7>] exit_to_usermode_loop+0x97/0xa0
[   55.356451]  [<ffffffff810019e3>] syscall_return_slowpath+0x53/0x60
[   55.356452]  [<ffffffff8167605f>] entry_SYSCALL_64_fastpath+0x92/0x94

I needed the ZBC code so I detached the head back to 5f2808f and
everything then worked fine. I will try to bisect.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
