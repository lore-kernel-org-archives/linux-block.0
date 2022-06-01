Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7133C43334
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 16:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiFAQEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbiFAQEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 12:04:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F98A5A9A
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 09:04:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B8EA1F8F6;
        Wed,  1 Jun 2022 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654099483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSGGwcVF0CWpDS5JRWvU4w7qFuKQg/h9tJpTdV+je6k=;
        b=HGYo6tn0ssV2I8V3rikkOjeskkSSY2ZbVOuFQw22YasJXAD9g8Ek/0tW3YL93oLYQSfvvt
        Z//EDrwt/JxXmqtphYXaMLTeufdHCdreZ9YfgfVeuNKCnM1NADd345x6zVlhhax2vJUN7i
        bxdHZCiEttChmB4qDWHR5gk/oUFYiPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654099483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSGGwcVF0CWpDS5JRWvU4w7qFuKQg/h9tJpTdV+je6k=;
        b=eprk1fU3E+wqaRGEkofsxkjzHrLCFJa7qxQc6Kx/5YEEnRViVY4cuYWHlrWmCQclPHPv8G
        lW8vbYrtpRZTebDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FB2D2C141;
        Wed,  1 Jun 2022 16:04:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D018A0633; Wed,  1 Jun 2022 18:04:43 +0200 (CEST)
Date:   Wed, 1 Jun 2022 18:04:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Message-ID: <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
 <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 02-06-22 00:08:28, Damien Le Moal wrote:
> On 2022/06/01 23:51, Jan Kara wrote:
> > Commit e70344c05995 ("block: fix default IO priority handling")
> > introduced an inconsistency in get_current_ioprio() that tasks without
> > IO context return IOPRIO_DEFAULT priority while tasks with freshly
> > allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
> > Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
> > move io_context creation into where it's needed") but after this commit
> > they became common because now only BFQ IO scheduler setups task's IO
> > context. Similar inconsistency is there for get_task_ioprio() so this
> > inconsistency is now exposed to userspace and userspace will see
> > different IO priority for tasks operating on devices with BFQ compared
> > to devices without BFQ. Furthemore the changes done by commit
> > e70344c05995 change the behavior when no IO priority is set for BFQ IO
> > scheduler which is also documented in ioprio_set(2) manpage - namely
> > that tasks without set IO priority will use IO priority based on their
> > nice value.
> > 
> > So make sure we default to IOPRIO_CLASS_NONE as used to be the case
> > before commit e70344c05995. Also cleanup alloc_io_context() to
> > explicitely set this IO priority for the allocated IO context.
> > 
> > Fixes: e70344c05995 ("block: fix default IO priority handling")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/blk-ioc.c        | 2 ++
> >  include/linux/ioprio.h | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> > index df9cfe4ca532..63fc02042408 100644
> > --- a/block/blk-ioc.c
> > +++ b/block/blk-ioc.c
> > @@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
> >  	INIT_HLIST_HEAD(&ioc->icq_list);
> >  	INIT_WORK(&ioc->release_work, ioc_release_fn);
> >  #endif
> > +	ioc->ioprio = IOPRIO_DEFAULT;
> > +
> >  	return ioc;
> >  }
> >  
> > diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> > index 774bb90ad668..d9dc78a15301 100644
> > --- a/include/linux/ioprio.h
> > +++ b/include/linux/ioprio.h
> > @@ -11,7 +11,7 @@
> >  /*
> >   * Default IO priority.
> >   */
> > -#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
> > +#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)
> 
> "man ioprio_set" says:
> 
> IOPRIO_CLASS_BE (2)
> This is the best-effort scheduling class, which is the default for any process
> that hasn't set  a  specific I/O  priority.
> 
> Which is why patch e70344c05995 introduced IOPRIO_DEFAULT definition using the
> BE class, to have the kernel in sync with the manual.

Yes, but it also has:

       If no I/O scheduler has been set for a thread, then by default the  I/O
       priority  will  follow  the  CPU nice value (setpriority(2)).  In Linux
       kernels before version 2.6.24, once an I/O priority had been set  using
       ioprio_set(),  there was no way to reset the I/O scheduling behavior to
       the default.  Since Linux 2.6.24, specifying ioprio as 0 can be used to
       reset to the default I/O scheduling behavior.

So apparently even the manpage itself is inconsistent ;) (and I will
neglect the mistake that the text says "no I/O scheduler" instead of "no
I/O priority"). And there is actually code in BFQ (and there used to be
code in CFQ) that does:
        switch (ioprio_class) {
	...
        case IOPRIO_CLASS_NONE:
                /*
                 * No prio set, inherit CPU scheduling settings.
                 */
                bfqq->new_ioprio = task_nice_ioprio(tsk);
                bfqq->new_ioprio_class = task_nice_ioclass(tsk);
                break;
	
So IOPRIO_CLASS_NONE indeed has a meaning and it used to be the default
one until Christoph's 5a9d041ba2f6 in most cases. Your change e70344c05995
happening before that actually didn't change much practically because IO
contexts were initialized with 0 priority anyway and that was what
get_current_ioprio() was returning.

> The different ioprio leading to no BIO merging is definitely a problem
> but this patch is not really fixing anything in my opinion. It simply
> gets back to the previous "all 0s" ioprio initialization, which do not
> show the places where we actually have missing ioprio initialization to
> IOPRIO_DEFAULT.

So I agree we should settle on how to treat IOs with unset IO priority. The
behavior to use task's CPU priority when IO priority is unset is there for
a *long* time and so I think we should preserve that. The question is where
in the stack should the switch from "unset" value to "effective ioprio"
happen. Switching in IO context is IMO too early since userspace needs to
be able to differentiate "unset" from "set to
IOPRIO_CLASS_BE,IOPRIO_BE_NORM". But we could have a helper like
current_effective_ioprio() that will do the magic with mangling unset IO
priority based on task's CPU priority.

The fact is that bio->bi_ioprio gets set to anything only for direct IO in
iomap_dio_rw(). The rest of the IO has priority unset (BFQ fetches the
priority from task's IO context and ignores priority on bios BTW). And the
only place where req->ioprio (inherited from bio->bi_ioprio) gets used is
in a few drivers to set HIGHPRI flag for IOPRIO_CLASS_RT IO and then the
relatively new code in mq-deadline.

So it all is very inconsistent mess :-|

> Isn't it simply that IOPRIO_DEFAULT should be set as the default for any bio
> being allocated (in bio_alloc ?) before it is setup and inherits the user io
> priority ? Otherwise, the bio io prio is indeed IOPRIO_CLASS_NONE/0 and changing
> IOPRIO_DEFAULT to that value removes the differences you observed.

Yes, I think that would make sence although as I explain above this is
somewhat independent to what the default IO priority behavior should be.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
