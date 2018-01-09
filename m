Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:42873 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeAIEpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 23:45:23 -0500
Subject: Re: [RFC PATCH] blk-throttle: dispatch more sync writes in block
 throttle layer
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Shaohua Li <shli@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com
References: <f6f59e3c-456a-8275-8af0-32e4f2e5cdd6@gmail.com>
 <20180108120742.GJ3668920@devbig577.frc2.facebook.com>
From: xuejiufei <xuejiufei@gmail.com>
Message-ID: <5ff01c31-5277-909f-4c35-9b9be513d8e1@gmail.com>
Date: Tue, 9 Jan 2018 12:45:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180108120742.GJ3668920@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

Thanks for your reply.

On 2018/1/8 下午8:07, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 05, 2018 at 01:16:26PM +0800, xuejiufei wrote:
>> From: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
>>
>> Cgroup writeback is supported since v4.2. But there exists a problem
>> in the following case.
>>
>> A cgroup may send both buffer and direct/sync IOs. The foreground
>> thread will be stalled when periodic writeback IOs is flushed because
>> the service queue in block throttle layer already has a plenty of
>> writeback IOs, then foreground IOs should be enqueued with its FIFO
>> policy. The current policy is dispatching 6 reads and 2 writes during
>> each round, sync writes will be significantly delayed.
>>
>> This patch adds another queue in block throttle. Now there are 3 queues
>> in a service queue: read, sync write, async write, and we can dispatch
>> more sync writes than aync writes.
> 
> We usually handle sync writes together with reads instead of
> introducing a separate queue for sync writes.
> 

Do you mean we should put reads and sync writes into the same
queue? There are 2 reasons that I introduce another queue for
async writes and others.

1. A bio is charged according to the direction, if we put the reads
and sync writes together, we need to search the queue to pick a
certain number of read and write IOs when the limit is not reached.

2. I found that the multi-queue scheduler kyber also has three queues:
one for read, one for sync write and one for others. This patch
introduces another queue for async writes and others just like kyber.

BTW, I found another case when I test cgroup writeback.
Create a file with 5G written extents and last 1G unwritten extents,
then write to the file sequentially using buffer IO. The write thread
is stalled when writes to the unwritten extent because it sends a
zeroout request which is queued at the tail of service queue and
will dispatched after all the writeback IOs.

[<ffffffff812d73dc>] blkdev_issue_zeroout+0x24c/0x260
[<ffffffffa02e59fc>] ext4_ext_zeroout.isra.37+0x4c/0x60 [ext4]
[<ffffffffa02ea68b>] ext4_ext_handle_unwritten_extents+0x53b/0xd20 [ext4]
[<ffffffffa02eb71f>] ext4_ext_map_blocks+0x87f/0xed0 [ext4]
[<ffffffffa02b92b9>] ext4_map_blocks+0x179/0x590 [ext4]
[<ffffffffa02b978c>] _ext4_get_block+0xbc/0x1b0 [ext4]
[<ffffffffa02b9896>] ext4_get_block+0x16/0x20 [ext4]
[<ffffffff8121a5d7>] __block_write_begin+0x1a7/0x490
[<ffffffffa02bd7da>] ext4_write_begin+0x18a/0x420 [ext4]
[<ffffffff8116a89d>] generic_file_buffered_write+0x11d/0x290
[<ffffffff8116bf75>] __generic_file_aio_write+0x1d5/0x3e0
[<ffffffff8116c1dd>] generic_file_aio_write+0x5d/0xc0
[<ffffffffa02b29d5>] ext4_file_write+0xb5/0x460 [ext4]
[<ffffffff81231688>] do_io_submit+0x3b8/0x870
[<ffffffff81231b50>] SyS_io_submit+0x10/0x20
[<ffffffff8164b249>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff

Thanks.
Jiufei Xue
> Thanks.
> 
