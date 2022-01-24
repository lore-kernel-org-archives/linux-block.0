Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BBAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiAXOC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:02:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiAXOCZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 09:02:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0E5C1F3A5;
        Mon, 24 Jan 2022 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643032944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpJcqvsHM7yhdS1eiwMytBHGmYAXVhkwwSnMFJoPLeM=;
        b=inEAXQz42OyBCe4dulOJs4anHkqKRDUjkbHlzezFaqy8qllqz0kLr+9mR4fUv7vrn3HAx7
        KEDYLhu4TK3MJD50i7UVTSo4jJM5aJlxB7gvmpBXEiB2aCzpEE65ageZmVrIraDdWGXYAL
        /V6FJ0MIPhV3cVu9mtpAO8hiTQaW3/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643032944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpJcqvsHM7yhdS1eiwMytBHGmYAXVhkwwSnMFJoPLeM=;
        b=RJ3XgqWA1lryiFD79t/0WqVLhKJ6gxWzlGczkdZN/hTVqN5W5UttwW9VBQNzZZt8/Tc01D
        TzPdsx4PaOFjn6Cg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1A07A3B83;
        Mon, 24 Jan 2022 14:02:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83650A05E7; Mon, 24 Jan 2022 15:02:24 +0100 (CET)
Date:   Mon, 24 Jan 2022 15:02:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220124140224.275sdju6temjgjdu@quack3.lan>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 21-01-22 19:42:11, yukuai (C) wrote:
> 在 2022/01/21 18:56, Jan Kara 写道:
> > Hello,
> > 
> > here is the fifth version of my patches to fix use-after-free issues in BFQ
> > when processes with merged queues get moved to different cgroups. The patches
> > have survived some beating in my test VM, but so far I fail to reproduce the
> > original KASAN reports so testing from people who can reproduce them is most
> > welcome. Kuai, can you please give these patches a run in your setup? Thanks
> > a lot for your help with fixing this!
> > 
> > Changes since v4:
> > * Even more aggressive splitting of merged bfq queues to avoid problems with
> >    long merge chains.
> > 
> > Changes since v3:
> > * Changed handling of bfq group move to handle the case when target of the
> >    merge has moved.
> > 
> > Changes since v2:
> > * Improved handling of bfq queue splitting on move between cgroups
> > * Removed broken change to bfq_put_cooperator()
> > 
> > Changes since v1:
> > * Added fix for bfq_put_cooperator()
> > * Added fix to handle move between cgroups in bfq_merge_bio()
> > 
> > 								Honza
> > Previous versions:
> > Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> > Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
> > Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
> > Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
> > .
> > 
> Hi, Jan
> 
> I add a new BUG_ON() in bfq_setup_merge() while iterating new_bfqq, and
> this time this BUG_ON() is triggered:

Thanks for testing!

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 07be51bc229b..6d4e243c9a1e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2753,6 +2753,14 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
> bfq_queue *new_bfqq)
>         while ((__bfqq = new_bfqq->new_bfqq)) {
>                 if (__bfqq == bfqq)
>                         return NULL;
> +               if (new_bfqq->entity.parent != __bfqq->entity.parent &&
> +                   bfqq_group(__bfqq) != __bfqq->bfqd->root_group) {
> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n",
> __func__,
> +                               new_bfqq, bfqq_group(new_bfqq), __bfqq,
> +                               bfqq_group(__bfqq));
> +                       BUG_ON(1);

This seems to be too early to check and BUG_ON(). Yes, we can walk through
and even end up with a bfqq with a different parent however in that case we
refuse to setup merge a few lines below and so there is no problem.

Are you still able to reproduce the use-after-free issue with this version
of my patches?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
