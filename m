Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943EC433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 07:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D6261108
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 07:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJHHPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:15:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24222 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHHPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Oct 2021 03:15:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HQfWj5khpzPjsL;
        Fri,  8 Oct 2021 15:12:01 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 15:13:03 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 15:13:02 +0800
Subject: Re: [PATCH V2 5/5] blk-mq: support concurrent queue quiesce/unquiesce
To:     Ming Lei <ming.lei@redhat.com>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-6-ming.lei@redhat.com>
 <e3d6c61c-f7cf-dcb0-df2e-a8e9acf5aaaa@acm.org> <YVu49xcM1N//fvKR@T590>
 <9fa25896-74e1-0d94-c39d-bf46f57472c4@huawei.com> <YV/SzEokvrkp4mrQ@T590>
 <c40edae3-f784-5d55-52f0-60a48aaffc55@huawei.com> <YV/mvAAe0FLNtTSx@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9b21c797-e505-3821-4f5b-df7bf9380328@huawei.com>
Date:   Fri, 8 Oct 2021 15:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YV/mvAAe0FLNtTSx@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/08 14:35, Ming Lei wrote:
> On Fri, Oct 08, 2021 at 02:22:39PM +0800, yukuai (C) wrote:
>> On 2021/10/08 13:10, Ming Lei wrote:
>>> Hello yukuai,
>>>
>>> On Fri, Oct 08, 2021 at 11:22:38AM +0800, yukuai (C) wrote:
>>>> On 2021/10/05 10:31, Ming Lei wrote:
>>>>> On Thu, Sep 30, 2021 at 08:56:29AM -0700, Bart Van Assche wrote:
>>>>>> On 9/30/21 5:56 AM, Ming Lei wrote:
>>>>>>> Turns out that blk_mq_freeze_queue() isn't stronger[1] than
>>>>>>> blk_mq_quiesce_queue() because dispatch may still be in-progress after
>>>>>>> queue is frozen, and in several cases, such as switching io scheduler,
>>>>>>> updating nr_requests & wbt latency, we still need to quiesce queue as a
>>>>>>> supplement of freezing queue.
>>>>>>
>>>>>> Is there agreement about this? If not, how about leaving out the above from the
>>>>>> patch description?
>>>>>
>>>>> Yeah, actually the code has been merged, please see the related
>>>>> functions: elevator_switch(), queue_wb_lat_store() and
>>>>> blk_mq_update_nr_requests().
>>>>>
>>>>>>
>>>>>>> As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
>>>>>>> for us to need support nested quiesce, especially we can't let
>>>>>>> unquiesce happen when there is quiesce originated from other contexts.
>>>>>>>
>>>>>>> This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
>>>>>>> and we only unquiesce queue when it is the last/outer-most one of all
>>>>>>> contexts.
>>>>>>>
>>>>>>> One kernel panic issue has been reported[2] when running stress test on
>>>>>>> dm-mpath's updating nr_requests and suspending queue, and the similar
>>>>>>> issue should exist on almost all drivers which use quiesce/unquiesce.
>>>>>>>
>>>>>>> [1] https://marc.info/?l=linux-block&m=150993988115872&w=2
>>>>>>> [2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html
>>>>>>
>>>>>> Please share the call stack of the kernel oops fixed by [2] since that
>>>>>> call stack is not in the patch description.
>>>>>
>>>>> OK, it is something like the following:
>>>>>
>>>>> [  145.453672] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-2.fc30 04/01/2014
>>>>> [  145.454104] RIP: 0010:dm_softirq_done+0x46/0x220 [dm_mod]
>>>>> [  145.454536] Code: 85 ed 0f 84 40 01 00 00 44 0f b6 b7 70 01 00 00 4c 8b a5 18 01 00 00 45 89 f5 f6 47 1d 04 75 57 49 8b 7c 24 08 48 85 ff 74 4d <48> 8b 47 08 48 8b 40 58 48 85 c0 74 40 49 8d 4c 24 50 44 89 f2 48
>>>>> [  145.455423] RSP: 0000:ffffa88600003ef8 EFLAGS: 00010282
>>>>> [  145.455865] RAX: ffffffffc03fbd10 RBX: ffff979144c00010 RCX: dead000000000200
>>>>> [  145.456321] RDX: ffffa88600003f30 RSI: ffff979144c00068 RDI: ffffa88600d01040
>>>>> [  145.456764] RBP: ffff979150eb7990 R08: ffff9791bbc27de0 R09: 0000000000000100
>>>>> [  145.457205] R10: 0000000000000068 R11: 000000000000004c R12: ffff979144c00138
>>>>> [  145.457647] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000010
>>>>> [  145.458080] FS:  00007f57e5d13180(0000) GS:ffff9791bbc00000(0000) knlGS:0000000000000000
>>>>> [  145.458516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  145.458945] CR2: ffffa88600d01048 CR3: 0000000106cf8003 CR4: 0000000000370ef0
>>>>> [  145.459382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> [  145.459815] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> [  145.460250] Call Trace:
>>>>> [  145.460779]  <IRQ>
>>>>> [  145.461453]  blk_done_softirq+0xa1/0xd0
>>>>> [  145.462138]  __do_softirq+0xd7/0x2d6
>>>>> [  145.462814]  irq_exit+0xf7/0x100
>>>>> [  145.463480]  do_IRQ+0x7f/0xd0
>>>>> [  145.464131]  common_interrupt+0xf/0xf
>>>>> [  145.464797]  </IRQ>
>>>>
>>>> Hi, out test can repoduce this problem:
>>>>
>>>> [  139.158093] BUG: kernel NULL pointer dereference, address:
>>>> 0000000000000008
>>>> [  139.160285] #PF: supervisor read access in kernel mode
>>>> [  139.161905] #PF: error_code(0x0000) - not-present page
>>>> [  139.163513] PGD 172745067 P4D 172745067 PUD 17fa88067 PMD 0
>>>> [  139.164506] Oops: 0000 [#1] PREEMPT SMP
>>>> [  139.165034] CPU: 17 PID: 1083 Comm: nbd-client Not tainted
>>>> 5.15.0-rc4-next-20211007-dirty #94
>>>> [  139.166179] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>> ?-20190727_073836-buildvm-p4
>>>> [  139.167962] RIP: 0010:kyber_has_work+0x31/0xb0
>>>> [  139.168571] Code: 41 bd 48 00 00 00 41 54 45 31 e4 55 53 48 8b 9f b0 00
>>>> 00 00 48 8d 6b 08 49 63 c4 d
>>>> [  139.171039] RSP: 0018:ffffc90000f479c8 EFLAGS: 00010246
>>>> [  139.171740] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>>>> ffff888176218f40
>>>> [  139.172680] RDX: ffffffffffffffff RSI: ffffc90000f479f4 RDI:
>>>> ffff888175310000
>>>> [  139.173611] RBP: 0000000000000008 R08: 0000000000000000 R09:
>>>> ffff88882fa6c0a8
>>>> [  139.174541] R10: 000000000000030e R11: ffff88817fbcfa10 R12:
>>>> 0000000000000000
>>>> [  139.175482] R13: 0000000000000048 R14: ffffffff99b7e340 R15:
>>>> ffff8881783edc00
>>>> [  139.176402] FS:  00007fa8e62e4b40(0000) GS:ffff88882fa40000(0000)
>>>> knlGS:0000000000000000
>>>> [  139.177434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  139.178190] CR2: 0000000000000008 CR3: 00000001796ac000 CR4:
>>>> 00000000000006e0
>>>> [  139.179127] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [  139.180066] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [  139.181000] Call Trace:
>>>> [  139.182338]  <TASK>
>>>> [  139.182638]  blk_mq_run_hw_queue+0x135/0x180
>>>> [  139.183207]  blk_mq_run_hw_queues+0x80/0x150
>>>> [  139.183766]  blk_mq_unquiesce_queue+0x33/0x40
>>>> [  139.184329]  nbd_clear_que+0x52/0xb0 [nbd]
>>>> [  139.184869]  nbd_disconnect_and_put+0x6b/0xe0 [nbd]
>>>> [  139.185499]  nbd_genl_disconnect+0x125/0x290 [nbd]
>>>> [  139.186123]  genl_family_rcv_msg_doit.isra.0+0x102/0x1b0
>>>> [  139.186821]  genl_rcv_msg+0xfc/0x2b0
>>>> [  139.187300]  ? nbd_ioctl+0x500/0x500 [nbd]
>>>> [  139.187847]  ? genl_family_rcv_msg_doit.isra.0+0x1b0/0x1b0
>>>> [  139.188564]  netlink_rcv_skb+0x62/0x180
>>>> [  139.189075]  genl_rcv+0x34/0x60
>>>> [  139.189490]  netlink_unicast+0x26d/0x590
>>>> [  139.190006]  netlink_sendmsg+0x3a1/0x6d0
>>>> [  139.190513]  ? netlink_rcv_skb+0x180/0x180
>>>> [  139.191039]  ____sys_sendmsg+0x1da/0x320
>>>> [  139.191556]  ? ____sys_recvmsg+0x130/0x220
>>>> [  139.192095]  ___sys_sendmsg+0x8e/0xf0
>>>> [  139.192591]  ? ___sys_recvmsg+0xa2/0xf0
>>>> [  139.193102]  ? __wake_up_common_lock+0xac/0xe0
>>>> [  139.193699]  __sys_sendmsg+0x6d/0xe0
>>>> [  139.194167]  __x64_sys_sendmsg+0x23/0x30
>>>> [  139.194675]  do_syscall_64+0x35/0x80
>>>> [  139.195145]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [  139.195806] RIP: 0033:0x7fa8e59ebb87
>>>> [  139.196281] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 80 00 00 00
>>>> 00 8b 05 6a 2b 2c 00 48 63 8
>>>> [  139.198715] RSP: 002b:00007ffd50573c38 EFLAGS: 00000246 ORIG_RAX:
>>>> 000000000000002e
>>>> [  139.199710] RAX: ffffffffffffffda RBX: 0000000001318120 RCX:
>>>> 00007fa8e59ebb87
>>>> [  139.200643] RDX: 0000000000000000 RSI: 00007ffd50573c70 RDI:
>>>> 0000000000000003
>>>> [  139.201583] RBP: 00000000013181f0 R08: 0000000000000014 R09:
>>>> 0000000000000002
>>>> [  139.202512] R10: 0000000000000006 R11: 0000000000000246 R12:
>>>> 0000000001318030
>>>> [  139.203434] R13: 00007ffd50573c70 R14: 0000000000000001 R15:
>>>> 00000000ffffffff
>>>> [  139.204364]  </TASK>
>>>> [  139.204652] Modules linked in: nbd
>>>> [  139.205101] CR2: 0000000000000008
>>>> [  139.205580] ---[ end trace 0248c57101a02431 ]---
>>>>
>>>> hope the call stack can be helpful.
>>>
>>> Can you share the following info?
>>>
>>> 1) is the above panic triggered with this quiesce patchset or without
>>> it?
>>
>> Without it, of course.
> 
> Got it, any chance to test this patchset V2 and see if your nbd issue can be
> fixed?
> 

I aready test it and the problem can be fixed by your patch 5.

In fact, I was going to send a patch similar to your patch 5 today,
and found your patch set.

Thanks,
Kuai

