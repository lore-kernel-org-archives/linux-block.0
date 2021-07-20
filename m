Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B89C07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 14:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFD1613BE
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhGTOLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 10:11:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7405 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbhGTNwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 09:52:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTh125Bv8z7wTr;
        Tue, 20 Jul 2021 22:29:10 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 22:32:49 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 20 Jul 2021 22:32:48 +0800
Subject: Re: [RFC PATCH] block: stop wait rcu once we can ensure no io while
 elevator init
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210720063147.966670-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <912a1de1-9ac1-861c-03ee-a4794769dc47@huawei.com>
Date:   Tue, 20 Jul 2021 22:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210720063147.966670-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test with latest kernel, this will trigger a warning:

[    5.155702] ------------[ cut here ]------------
[    5.156305] WARNING: CPU: 1 PID: 1 at block/mq-deadline-main.c:600 
dd_init_sched+0x207/0x240
[    5.157876] Modules linked in:
[    5.158270] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
5.14.0-rc2-00003-gec7ef05d2bff-dirty #104
[    5.159379] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[    5.160999] RIP: 0010:dd_init_sched+0x207/0x240
[    5.161556] Code: 48 89 ef e8 2b 47 91 ff 48 83 05 1b 15 ef 0b 01 eb 
b6 48 83 05 e1 14 ef 0b 01 41 bd f4 ff ff ff eb de 48 83 05 99 14 ef 0b 
01 <0f> 0b 48 83 05 97 14 ef 0b 01 48 8f
[    5.163812] RSP: 0000:ffffc90000013d20 EFLAGS: 00010202
[    5.164467] RAX: ffff8881060dd200 RBX: ffff888112b18008 RCX: 
0000000000000004
[    5.165315] RDX: 0000000000000001 RSI: 0000000000000206 RDI: 
ffffffff8da3bf64
[    5.166160] RBP: ffffffff8a909c60 R08: ffff888103b67648 R09: 
0000000000000005
[    5.167014] R10: ffff888000000000 R11: 0000160000000000 R12: 
0000000000000001
[    5.167852] R13: ffffffff8a909c60 R14: ffff888104c629a0 R15: 
0000000000000000
[    5.168711] FS:  0000000000000000(0000) GS:ffff88813bc40000(0000) 
knlGS:0000000000000000
[    5.169684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.170365] CR2: 0000000000000000 CR3: 000000000340a000 CR4: 
00000000000006e0
[    5.171204] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    5.172045] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    5.172883] Call Trace:
[    5.173183]  blk_mq_init_sched+0x1b3/0x480
[    5.173677]  elevator_init_mq+0x189/0x2b0
[    5.174156]  __device_add_disk+0x2ff/0x520
[    5.174645]  device_add_disk+0x17/0x20
[    5.175094]  loop_add+0x2e7/0x360
[    5.175490]  loop_init+0x135/0x160
[    5.176443]  ? max_loop_setup+0x28/0x28
[    5.176912]  do_one_initcall+0x71/0x330
[    5.177370]  kernel_init_freeable+0x3aa/0x44a
[    5.177900]  ? rest_init+0x150/0x150
[    5.178334]  kernel_init+0x26/0x230
[    5.178760]  ret_from_fork+0x1f/0x30
[    5.179193] ---[ end trace 669dc68f99fcdd5a ]---
[    5.195376] loop: module loaded


08a9ad8bf607388d768a341957d53eae64250c2d ("block/mq-deadline: Add cgroup 
support") add the follow logical:

static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
{
         struct deadline_data *dd;
         struct elevator_queue *eq;
         enum dd_prio prio;
         int ret = -ENOMEM;

         /*
          * Initialization would be very tricky if the queue is not frozen,
          * hence the warning statement below.
          */
         WARN_ON_ONCE(!percpu_ref_is_zero(&q->q_usage_counter)); <=== 
Trigger this






在 2021/7/20 14:31, yangerkun 写道:
> 'commit 737eb78e82d5 ("block: Delay default elevator initialization")'
> delay elevator init to fix some problem for special device like SMR.
> Also, the commit add the logic to ensure no IO can happened while
> blk_mq_init_sched. However, blk_mq_freeze_queue/blk_mq_quiesce_queue
> will add RCU Grace period which can lead some overhead(about 36 loop
> device try to mount which each Grace period around 20ms).
> 
> For loop device, no io can happened while add_disk, so it's safe to skip
> this step. Add flag QUEUE_FLAG_NO_INIT_IO to identify this case.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   block/elevator.c       | 14 ++++++++++----
>   drivers/block/loop.c   |  5 +++++
>   include/linux/blkdev.h |  2 ++
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 52ada14cfe45..ddf24afb999e 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -672,6 +672,7 @@ void elevator_init_mq(struct request_queue *q)
>   {
>   	struct elevator_type *e;
>   	int err;
> +	bool no_init_io;
>   
>   	if (!elv_support_iosched(q))
>   		return;
> @@ -688,13 +689,18 @@ void elevator_init_mq(struct request_queue *q)
>   	if (!e)
>   		return;
>   
> -	blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue(q);
> +	no_init_io = blk_queue_no_init_io(q);
> +	if (!no_init_io) {
> +		blk_mq_freeze_queue(q);
> +		blk_mq_quiesce_queue(q);
> +	}
>   
>   	err = blk_mq_init_sched(q, e);
>   
> -	blk_mq_unquiesce_queue(q);
> -	blk_mq_unfreeze_queue(q);
> +	if (!no_init_io) {
> +		blk_mq_unquiesce_queue(q);
> +		blk_mq_unfreeze_queue(q);
> +	}
>   
>   	if (err) {
>   		pr_warn("\"%s\" elevator initialization failed, "
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f37b9e3d833c..4667273bf071 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2326,6 +2326,11 @@ static int loop_add(int i)
>   	disk->private_data	= lo;
>   	disk->queue		= lo->lo_queue;
>   	sprintf(disk->disk_name, "loop%d", i);
> +	/*
> +	 * There won't be io before add_disk, QUEUE_FLAG_NO_INIT_IO can help
> +	 * to save time while elevator_init_mq.
> +	 */
> +	blk_queue_flag_set(QUEUE_FLAG_NO_INIT_IO, lo->lo_queue);
>   	add_disk(disk);
>   	mutex_unlock(&loop_ctl_mutex);
>   	return i;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3177181c4326..b070c902d8c9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -603,6 +603,7 @@ struct request_queue {
>   #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
>   #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>   #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> +#define QUEUE_FLAG_NO_INIT_IO	30	/* no IO can happen while elevator_init_mq */
>   
>   #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>   				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -649,6 +650,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>   #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
>   #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>   #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> +#define blk_queue_no_init_io(q)	test_bit(QUEUE_FLAG_NO_INIT_IO, &(q)->queue_flags)
>   
>   extern void blk_set_pm_only(struct request_queue *q);
>   extern void blk_clear_pm_only(struct request_queue *q);
> 
