Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96661C43219
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbiAFPps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:45:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbiAFPpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jan 2022 10:45:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DF811F39C;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSVbYQb8XYAep6dHE27+/xoER80ranM3e+UP1FiuDSY=;
        b=pSKVLEfjQH/scwakDzXS+rN7dCdshJFbwc/iUtjTmEdQ77rS8quoM3tMJd2YyGEwB3Lsue
        Pc4PXUOXHmQvUhsQnYP1H6+Eh/UkC9OqM/LavDaiXfQGHXd84cWzy5b/LDSZEnMCzTZp7l
        tTY/tGYlrJUDANAFwE2ov/CU83u9ANo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSVbYQb8XYAep6dHE27+/xoER80ranM3e+UP1FiuDSY=;
        b=leHuyFSobUuQtZRd46/gpJ6LIa/vDDRP7/em3CYu1wpjk4gBiD3wDJojuHfH92QDgN9WZh
        Gi6RQH7nx3hqDwAA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 26D82A3B83;
        Thu,  6 Jan 2022 15:45:44 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id 71469A05B1; Mon,  3 Jan 2022 21:37:05 +0100 (CET)
Date:   Mon, 3 Jan 2022 21:37:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 0/3] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220103203705.airqbsyiar4u6fy4@quack3>
References: <20211223171425.3551-1-jack@suse.cz>
 <a9a22745-6fc4-22c0-ddbc-be0e82f07876@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9a22745-6fc4-22c0-ddbc-be0e82f07876@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 24-12-21 09:30:04, yukuai (C) wrote:
> 在 2021/12/24 1:31, Jan Kara 写道:
> > Hello,
> > 
> > these three patches fix use-after-free issues in BFQ when processes with merged
> > queues get moved to different cgroups. The patches have survived some beating
> > in my test VM but so far I fail to reproduce the original KASAN reports so
> > testing from people who can reproduce them is most welcome. Thanks!
> 
> Hi,
> 
> Unfortunately, this patchset can't fix the UAF, just to mark
> split_coop in patch 3 seems not enough.

Thanks for testing! 

> Here is the result:
> 
> [  548.440184]
> ==============================================================
> [  548.441680] BUG: KASAN: use-after-free in
> __bfq_deactivate_entity+0x21/0x290
> [  548.443155] Read of size 1 at addr ffff8881723e00b0 by task rmmod/13984
> [  548.444109]
> [  548.444321] CPU: 30 PID: 13984 Comm: rmmod Tainted: G        W
> 5.16.0-rc5-next-2026
> [  548.445549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> ?-20190727_073836-4
> [  548.447348] Call Trace:
> [  548.447682]  <TASK>
> [  548.447967]  dump_stack_lvl+0x34/0x44
> [  548.448470]  print_address_description.constprop.0.cold+0xab/0x36b
> [  548.449303]  ? __bfq_deactivate_entity+0x21/0x290
> [  548.449929]  ? __bfq_deactivate_entity+0x21/0x290
> [  548.450565]  kasan_report.cold+0x83/0xdf
> [  548.451114]  ? _raw_read_lock_bh+0x20/0x40
> [  548.451658]  ? __bfq_deactivate_entity+0x21/0x290
> [  548.452296]  __bfq_deactivate_entity+0x21/0x290
> [  548.452917]  bfq_pd_offline+0xc1/0x110

Can you pass the trace through addr2line please? I'm curious whether this
is a call in bfq_flush_idle_tree() or directly from bfq_pd_offline(). Also
whether the crash in __bfq_deactivate_entity() is indeed inside
bfq_entity_service_tree() as I expect.

> [  548.453436]  blkcg_deactivate_policy+0x14b/0x210
> [  548.454058]  bfq_exit_queue+0xe5/0x100
> [  548.454573]  blk_mq_exit_sched+0x113/0x140
> [  548.455162]  elevator_exit+0x30/0x50
> [  548.455645]  blk_release_queue+0xa8/0x160

So I'm not convinced this is the same problem as before. I'll be able to
tell more when I see the addr2line output.

> How do you think about this:
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1ce1a99a7160..14c1d1c3811e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
> bfq_queue *new_bfqq)
>         while ((__bfqq = new_bfqq->new_bfqq)) {
>                 if (__bfqq == bfqq)
>                         return NULL;
> +               if (__bfqq->entity.parent != bfqq->entity.parent) {
> +                       if (bfq_bfqq_coop(__bfqq))
> +                               bfq_mark_bfqq_split_coop(__bfqq);
> +                       return NULL;
> +               }

So why is this needed? In my patches we do check in bfq_setup_merge() that
the bfqq we merge to is in the same cgroup. If some intermediate bfqq
happens to move to a different cgroup between the detection and merge, well
that's a bad luck but practically I don't think that is a real problem and
it should not cause the use-after-free issues. Or am I missing something?

>                 new_bfqq = __bfqq;
>         }
> 
> @@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct
> bfq_queue *bfqq,
>         if (bfq_too_late_for_merging(bfqq))
>                 return NULL;
> 
> -       if (bfqq->new_bfqq)
> -               return bfqq->new_bfqq;
> +       if (bfqq->new_bfqq) {
> +               struct bfq_queue *new_bfqq = bfqq->new_bfqq;
> +
> +               if(bfqq->entity.parent == new_bfqq->entity.parent)
> +                       return new_bfqq;
> +
> +               if(bfq_bfqq_coop(new_bfqq))
> +                       bfq_mark_bfqq_split_coop(new_bfqq);
> +               return NULL;
> +       }

So I wanted to say that this should be already handled by the change to
__bfq_bic_change_cgroup() in my series. But bfq_setup_cooperator() can also
be called from bfq_allow_bio_merge() and on that path we don't call
bfq_bic_update_cgroup() so indeed we can merge bfqq to a bfqq in a
different (or dead) cgroup through that path. I actually think we should
call bfq_bic_update_cgroup() in bfq_allow_bio_merge() so that we reparent /
split bfqq when new IO arrives for a different cgroup. 

Also I have realized that my change to __bfq_bic_change_cgroup() may not be
enough and we should also clear sync_bfqq->new_bfqq if it is set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
