Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6902C43334
	for <linux-block@archiver.kernel.org>; Mon,  6 Jun 2022 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiFFKmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiFFKmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2022 06:42:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA342A9
        for <linux-block@vger.kernel.org>; Mon,  6 Jun 2022 03:42:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 37F971F904;
        Mon,  6 Jun 2022 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654512123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqrtYo+p5gTmeKnq7nbxcz0mPfqNkCOGOg6QWs/K35Y=;
        b=YohU902qDZ3rBU4JWlLMqxRoxcXPGrmc4RoqdoFwcChhB39pYAJnDWLgSCDooL18jN0IIT
        paKV6BQIRQBHONAe74+uowpoSkF8M8hmalka8iZfMZl8Afc2iuPG6JleNUArHR75UKk7CA
        gOLQZ4taq0ZZVpx80LiYqjBqboE6MiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654512123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqrtYo+p5gTmeKnq7nbxcz0mPfqNkCOGOg6QWs/K35Y=;
        b=rkbpQTnBhaBezmqpJKOCmGuatB/b0o5jn0bAh0AjVuzys/ggpYqGCbT4cwXnM4ir9zX0+o
        9DY/Xpy4erBUHVAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E89A62C142;
        Mon,  6 Jun 2022 10:42:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A78BBA0633; Mon,  6 Jun 2022 12:42:02 +0200 (CEST)
Date:   Mon, 6 Jun 2022 12:42:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Message-ID: <20220606104202.ht6u7mek3yfs4koi@quack3.lan>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
 <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
 <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
 <c79b25f4-88dc-c432-e69b-ef5abdf37720@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79b25f4-88dc-c432-e69b-ef5abdf37720@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 02-06-22 10:53:29, Damien Le Moal wrote:
> On 2022/06/02 1:04, Jan Kara wrote:
> > On Thu 02-06-22 00:08:28, Damien Le Moal wrote:
> >> The different ioprio leading to no BIO merging is definitely a problem
> >> but this patch is not really fixing anything in my opinion. It simply
> >> gets back to the previous "all 0s" ioprio initialization, which do not
> >> show the places where we actually have missing ioprio initialization to
> >> IOPRIO_DEFAULT.
> > 
> > So I agree we should settle on how to treat IOs with unset IO priority. The
> > behavior to use task's CPU priority when IO priority is unset is there for
> > a *long* time and so I think we should preserve that. The question is where
> > in the stack should the switch from "unset" value to "effective ioprio"
> > happen. Switching in IO context is IMO too early since userspace needs to
> > be able to differentiate "unset" from "set to
> > IOPRIO_CLASS_BE,IOPRIO_BE_NORM". But we could have a helper like
> > current_effective_ioprio() that will do the magic with mangling unset IO
> > priority based on task's CPU priority.
> 
> I agree that the task's CPU priority is a more sensible default. However,
> I do not understand your point about the IO context being too early to
> set the effective priority. If we do not do that, getting the issuer CPU
> priority will not be easily possible, right ?

I just meant that in the IO context we need to keep the information whether
IO priority is set to a particular value, or whether it is set to 0 meaning
"inherit from CPU priority". So we cannot just store the effective IO
priority immediately in the IO context instead of 0.

> > The fact is that bio->bi_ioprio gets set to anything only for direct IO in
> > iomap_dio_rw(). The rest of the IO has priority unset (BFQ fetches the
> > priority from task's IO context and ignores priority on bios BTW). And the
> > only place where req->ioprio (inherited from bio->bi_ioprio) gets used is
> > in a few drivers to set HIGHPRI flag for IOPRIO_CLASS_RT IO and then the
> > relatively new code in mq-deadline.
> 
> Yes, only IOPRIO_CLASS_RT has an effect at the hardware level right now.
> Everything else is only for the IO scheduler to play with. I am preparing a
> patch series to support scsi/ata command duration limits though. That adds a new
> IOPRIO_CLASS_DL and that one will also have an effect on the hardware.
> 
> Note that if a process/thread use ioprio_set(), we should also honor the ioprio
> set for buffered reads, at least those page IOs that are issued directly from
> the IO issuer context (which may include readahead... hmmm).

Yes, that would make sense as well.

> >> Isn't it simply that IOPRIO_DEFAULT should be set as the default for any bio
> >> being allocated (in bio_alloc ?) before it is setup and inherits the user io
> >> priority ? Otherwise, the bio io prio is indeed IOPRIO_CLASS_NONE/0 and changing
> >> IOPRIO_DEFAULT to that value removes the differences you observed.
> > 
> > Yes, I think that would make sence although as I explain above this is
> > somewhat independent to what the default IO priority behavior should be.
> I am OK with the use of the task CPU priority/ionice value as the default when
> no other ioprio is set for a bio using the user aio_reqprio or ioprio_set(). If
> this relies on task_nice_ioclass() as it is today (I see no reason to change
> that), then the default class for regular tasks remains IOPRIO_CLASS_BE as is
> defined by IOPRIO_DEFAULT.

Yes, good.

> But to avoid the performance regression you observed, we really need to be 100%
> sure that all bios have their ->bi_ioprio field correctly initialized. Something
> like:
> 
> void bio_set_effective_ioprio(struct *bio)
> {
> 	switch (IOPRIO_PRIO_CLASS(bio->bi_ioprio)) {
> 	case IOPRIO_CLASS_RT:
> 	case IOPRIO_CLASS_BE:
> 	case IOPRIO_CLASS_IDLE:
> 		/*
> 		 * the bio ioprio was already set from an aio kiocb ioprio
> 		 * (aio->aio_reqprio) or from the issuer context ioprio if that
> 		 * context used ioprio_set().
> 		 */;
> 		return;
> 	case IOPRIO_CLASS_NONE:
> 	default:
> 		/* Use the current task CPU priority */
> 		bio->ioprio =
> 			IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> 					  task_nice_ioprio(current));
> 		return;
> 	}
> }
> 
> being called before a bio is inserted in a scheduler or bypass inserted in the
> dispatch queues should result in all BIOs having an ioprio that is set to
> something other than IOPRIO_CLASS_NONE. And the obvious place may be simply at
> the beginning of submit_bio(), before submit_bio_noacct() is called.
> 
> I am tempted to argue that block device drivers should never see any req
> with an ioprio set to IOPRIO_CLASS_NONE, which means that no bio should
> ever enter the block stack with that ioprio either. With the above
> solution, bios from DM targets submitted with submit_bio_noacct() could
> still have IOPRIO_CLASS_NONE...  So would submit_bio_noacct() be the
> better place to call the effective ioprio helper ?

Yes, I also think it would be the cleanest if we made sure bio->ioprio is
always set to some value other than IOPRIO_CLASS_NONE. I'll see how we can
make that happen in the least painful way :). Thanks for your input!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
