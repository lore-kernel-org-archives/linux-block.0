Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCCC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AA460FA0
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 10:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhHCKpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:45:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41920 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhHCKpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 06:45:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 929B721EFB;
        Tue,  3 Aug 2021 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627987502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnNAeex2HypcjUY5rCZp4LyUWdVLz/QLbt8C8VLw12o=;
        b=cOvzdLEm1KFavLJ03fmuXUhoEvUTTkMA2nWIA8iyV4x/V0CNoYrdtIOkZDk+Zl2p1VPy/z
        sPKsFZ03elGTHrFdpVO7Fk4ar/Qf9hTh8dGT4X6/S/5C6DVFEy6lrvmeSPwxLrdmGHRuoz
        OHklsOFg35y5vBuEgkSrzBkibfuoLko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627987502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnNAeex2HypcjUY5rCZp4LyUWdVLz/QLbt8C8VLw12o=;
        b=qCXPg7Hh4fXpKiEJT2yrRVwDvwGLVlNUvrjcm6zyx8dgkZhX/XJEXdjWria8F7xO9K33Ae
        nO3EO2pMY0ZmN6Bw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6E8ADA3BCF;
        Tue,  3 Aug 2021 10:45:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F1121E62D6; Tue,  3 Aug 2021 12:45:02 +0200 (CEST)
Date:   Tue, 3 Aug 2021 12:45:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
Message-ID: <20210803104502.GA10621@quack2.suse.cz>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
 <20210622162948.GJ14261@quack2.suse.cz>
 <2957867.CS06ZTPI5V@spock>
 <1630141.ki6cbyAirf@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1630141.ki6cbyAirf@natalenko.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 02-08-21 22:40:26, Oleksandr Natalenko wrote:
> Hello.
> 
> On sobota 3. července 2021 0:07:53 CEST Oleksandr Natalenko wrote:
> > On úterý 22. června 2021 18:29:48 CEST Jan Kara wrote:
> > > On Tue 22-06-21 09:35:05, Oleksandr Natalenko wrote:
> > > > On úterý 22. června 2021 9:08:43 CEST Paolo Valente wrote:
> > > > > CCing also Jan and Khazhy, because in your commit log I see also the
> > > > > commit on bfq_requests_merged().
> > > > > 
> > > > > Is this OOPS reproducible for you?
> > > > 
> > > > No, I haven't found a reproducer, at least yet. It took half a day of
> > > > uptime to hit this, so might not be that easy.
> > > 
> > > Hum, if you can acquire a crash dump it would be the easiest I guess. We'd
> > > need to find out more about the request we crash on - whether it's
> > > otherwise valid, in what state it is etc...
> > 
> > Still have no reliable reproducer and no vmcore, however I'm running v5.13
> > with the following patches applied on top of it:
> > 
> > ```
> > blk: Fix lock inversion between ioc lock and bfqd lock
> > bfq: Remove merged request already in bfq_requests_merged()
> > block: Remove unnecessary elevator operation checks
> > block: Do not pull requests from the scheduler when we cannot dispatch them
> > block, bfq: reset waker pointer with shared queues
> > block, bfq: check waker only for queues with no in-flight I/O
> > block, bfq: avoid delayed merge of async queues
> > block, bfq: boost throughput by extending queue-merging times
> > block, bfq: consider also creation time in delayed stable merge
> > block, bfq: fix delayed stable merge check
> > block, bfq: let also stably merged queues enjoy weight raising
> > ```
> > 
> > and just got the following crash:
> > 
> > ```
> > [60313.522570] ------------[ cut here ]------------
> > [60313.522579] WARNING: CPU: 20 PID: 388 at arch/x86/include/asm/kfence.h:44
> > kfence_protect_page+0x39/0xc0

<snip>

> > [60313.522665] CPU: 20 PID: 388 Comm: kworker/20:1H Tainted: G        W
> > 5.13.0-pf2 #1
> > [60313.522668] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS
> > 3601 05/26/2021
> > [60313.522671] Workqueue: kblockd blk_mq_run_work_fn
> > [60313.522675] RIP: 0010:kfence_protect_page+0x39/0xc0
> > [60313.522679] Code: 04 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 c7
> > 44 24 04 00 00 00 00 e8 83 20 d5 ff 48 85 c0 74 07 83 7c 24 04 01 74 06
> > <0f> 0b 31 c0 eb 4c 48 8b 38 48 89 c2 84 db 75 59 48 89 f8 0f 1f 40
> > [60313.522682] RSP: 0018:ffffb559c0affb28 EFLAGS: 00010046
> > [60313.522684] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > ffffb559c0affb2c [60313.522687] RDX: ffffb559c0affb2c RSI: 0000000000000000
> > RDI: 0000000000000000 [60313.522690] RBP: 0000000000000000 R08:
> > 0000000000000000 R09:
> > 0000000000000000
> > [60313.522692] R10: 0000000000000000 R11: 0000000000000000 R12:
> > 0000000000000002
> > [60313.522694] R13: ffffb559c0affc28 R14: 00000000c0affc01 R15:
> > 0000000000000000 [60313.522696] FS:  0000000000000000(0000)
> > GS:ffff8cf44ef00000(0000) knlGS: 0000000000000000
> > [60313.522698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [60313.522700] CR2: 0000000000000120 CR3: 000000013ebce000 CR4:
> > 0000000000350ee0
> > [60313.522702] Call Trace:
> > [60313.522707]  kfence_handle_page_fault+0xa6/0x280
> > [60313.522710]  page_fault_oops+0x9d/0x2d0
> > [60313.522714]  exc_page_fault+0x78/0x180
> > [60313.522718]  asm_exc_page_fault+0x1e/0x30
> > [60313.522721] RIP: 0010:bfq_dispatch_request+0x4c3/0x1280
> > [60313.522725] Code: 4c 89 e7 e8 ef da ff ff 4c 89 ff 89 c6 e8 75 64 00 00
> > 4c 39 bb a0 00 00 00 0f 84 86 04 00 00 49 8b 84 24 90 00 00 00 48 8b 33
> > <ff> 80 20 01 00 00 48 89 34 24 48 8b 46 08 4c 8b 58 08 4c 89 5c 24
> > [60313.522727] RSP: 0018:ffffb559c0affcd0 EFLAGS: 00010046
> > [60313.522729] RAX: 0000000000000000 RBX: ffff8ced4d6a1000 RCX:
> > 0000000000000000 [60313.522731] RDX: 0000000000000000 RSI: ffff8ced4ad90000
> > RDI: ffff8ced52fc9f40 [60313.522733] RBP: 0000000000000000 R08:
> > 0000000000000001 R09:
> > 0000000000000000
> > [60313.522735] R10: 000000000000003f R11: 0000000000000000 R12:
> > ffff8cf20e5a5400 [60313.522737] R13: ffff8cf0e7e91c70 R14: ffff8ced4d6a1420
> > R15: ffff8cf0e7e91c70 [60313.522741]  ? mod_delayed_work_on+0x71/0xe0
> > [60313.522745]  ? __sbitmap_get_word+0x30/0x80
> > [60313.522748]  __blk_mq_do_dispatch_sched+0x218/0x320
> > [60313.522752]  __blk_mq_sched_dispatch_requests+0x107/0x150
> > [60313.522755]  blk_mq_sched_dispatch_requests+0x2f/0x60
> > [60313.522758]  blk_mq_run_work_fn+0x43/0xc0
> > [60313.522761]  process_one_work+0x24e/0x430
> > [60313.522765]  worker_thread+0x54/0x4d0
> > [60313.522767]  ? process_one_work+0x430/0x430
> > [60313.522770]  kthread+0x182/0x1b0
> > [60313.522773]  ? __kthread_init_worker+0x50/0x50
> > [60313.522776]  ret_from_fork+0x22/0x30
> > [60313.522781] ---[ end trace 55ef262e614b59af ]---

<snip>

> This is just to let you know that I'm running v5.13.7 without any extra 
> patches under block/ applied, and the issue is not reproducible.
> 
> I'll probably defer investigating this till v5.14 unless it is fixed there 
> already.

Thanks for info! I've looked some more into this. It appears the trapping
instruction is:

static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
{
        struct bfq_queue *bfqq = RQ_BFQQ(rq);

        /*
         * For consistency, the next instruction should have been
         * executed after removing the request from the queue and
         * dispatching it.  We execute instead this instruction before
         * bfq_remove_request() (and hence introduce a temporary
         * inconsistency), for efficiency.  In fact, should this
         * dispatch occur for a non in-service bfqq, this anticipated
         * increment prevents two counters related to bfqq->dispatched
         * from risking to be, first, uselessly decremented, and then
         * incremented again when the (new) value of bfqq->dispatched
         * happens to be taken into account.
         */
>>>     bfqq->dispatched++;
        bfq_update_peak_rate(q->elevator->elevator_data, rq);

        bfq_remove_request(q, rq);
}

The bfqq is in RAX and apparently is NULL. This function was called from
bfq_dispatch_rq_from_bfqq() and the above can only happen if bfqq->next_rq
was pointing to a request that was no longer attached to any bfq queue
(maybe rq was being freed?). But at this point I have no idea how this
could have possibly happened with current codebase. Can you maybe test with
5.14-rc4 to see whether current upstream has the issue?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
