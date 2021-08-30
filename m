Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C833EC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 02:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A100660F57
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 02:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhH3Cco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhH3Cco (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 22:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6293F60724;
        Mon, 30 Aug 2021 02:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630290711;
        bh=VHAGbY/oE8hi48782UfaO6hOJoGCHfg8GYyTkWUgwi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rcc2tbC//EMgx9Um44eVoMgjbRqyseYNGSXYRMflQrIHKDc+Y/TLfw99YKpFvvxnA
         FDLKf6Ll32nwbhu2Bu9EmUADyrwABxqcxTC6ONIKHZi8096poNJYZdBlEQKesqpjJu
         m4u9Zs0266htH050Tcc+T5QafoYD/Y8WWDf6h5EUpShnlojiqoF0Oz8scVuWVYiL3f
         yHSNTJscUmLtXvaRxEJOg4aCUol2wuRxrobT2VUAKphfZ12s6jzRXcjHTYnaESUsOl
         qW5G9Zvb/zbKUhclhinK5otXYuOWqkbn4rdC4QA5OsYRmoPD87GVnhpAkpf18TRaoz
         KOFdIQGhEnHVA==
Date:   Mon, 30 Aug 2021 11:31:45 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Message-ID: <20210830023145.GA15087@redsun51.ssa.fujisawa.hgst.com>
References: <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
 <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
 <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 29, 2021 at 11:02:22PM +0000, Damien Le Moal wrote:
> On 2021/08/27 23:34, Bart Van Assche wrote:
> > On 8/26/21 9:49 PM, Damien Le Moal wrote:
> >> So the mq-deadline priority patch reduces performance by nearly half at high QD.
> >> With the modified patch, we are back to better numbers, but still a significant
> >> 20% drop at high QD.
> > 
> > Hi Damien,
> > 
> > An implementation of I/O priority for the deadline scheduler that reduces the
> > IOPS drop to 1% on my test setup is available here:
> > https://github.com/bvanassche/linux/tree/block-for-next
> > 
> >> (*) Note: in all cases using the mq-deadline scheduler, for the first run at
> >> QD=1, I get this splat 100% of the time.
> >>
> >> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:1H:757]
> >> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-rc7+ #1334
> >> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn
> >> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40
> >> [   95.415904] Call Trace:
> >> [   95.418373]  try_to_wake_up+0x268/0x7c0
> >> [   95.422238]  blk_update_request+0x25b/0x420
> >> [   95.426452]  blk_mq_end_request+0x1c/0x120
> >> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]
> >> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0
> >> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0
> >> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140
> >> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60
> >> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90
> >> [   95.463377]  process_one_work+0x26c/0x570
> >> [   95.467421]  worker_thread+0x55/0x3c0
> >> [   95.475313]  kthread+0x140/0x160
> >> [   95.482774]  ret_from_fork+0x1f/0x30
> > 
> > I don't see any function names in the above call stack that refer to the
> > mq-deadline scheduler? Did I perhaps overlook something? Anyway, if you can
> > tell me how to reproduce this (kernel commit + kernel config) I will take a
> > look.
> 
> Indeed, the stack trace does not show any mq-deadline function. But the
> workqueue is stuck on _raw_spin_unlock_irqrestore() in the blk_mq_run_work_fn()
> function. I suspect that the spinlock is dd->lock, so the CPU may be stuck on
> entry to mq-deadline dispatch or finish request methods. Not entirely sure.

I don't think you can be stuck on the *unlock* part, though. In my
experience, that function showing up in a soft lockup indicates you're
in a broken loop that's repeatedly locking and unlocking. I haven't
found anything immediately obvious in this call chain, though.

> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached config.

Surely 5.14.0-rc7, right?
