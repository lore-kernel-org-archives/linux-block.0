Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BAEC43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbiFGM7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiFGM73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:59:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5368215D
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:59:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FA1D1F9F5;
        Tue,  7 Jun 2022 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654606767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckKMtKwSleuSsuoXrQgL5wc93QOtlrO90PARe93kVlA=;
        b=iIBcQQL2S6UhqTfDRg6t3B+Ac004cWYROa+zGp+xgCOvVlwb3I+rCr7Sbkx5TDs4Jhesy4
        tUqjrsqd3WFXNGwYUP0vxB7m2KZ8VW7QGZ8o74Q1T98d817XiQUEwrKNeedgCSFK40xFLs
        16L4b6N9XmdGJU0c/9MJsLcI5xesigY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654606767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckKMtKwSleuSsuoXrQgL5wc93QOtlrO90PARe93kVlA=;
        b=2ahxMAPqlTJLygTWUktI1XTzTgXKX317Go2GtKhoYRM3tohvA1SewJY1RLQ/fgNvK6T8G0
        zUpSjY6KPdXp/JBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B49FD2C142;
        Tue,  7 Jun 2022 12:59:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 73624A0633; Tue,  7 Jun 2022 14:59:26 +0200 (CEST)
Date:   Tue, 7 Jun 2022 14:59:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Message-ID: <20220607125926.ez7uvsajs4alridk@quack3.lan>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
 <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
 <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
 <c79b25f4-88dc-c432-e69b-ef5abdf37720@opensource.wdc.com>
 <20220606104202.ht6u7mek3yfs4koi@quack3.lan>
 <20220606142136.j7lztd5zyuowuh64@quack3.lan>
 <Yp9A+yxFkREMOXqt@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9A+yxFkREMOXqt@x1-carbon>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 07-06-22 12:13:48, Niklas Cassel wrote:
> On Mon, Jun 06, 2022 at 04:21:36PM +0200, Jan Kara wrote:
> > On Mon 06-06-22 12:42:02, Jan Kara wrote:
> > > On Thu 02-06-22 10:53:29, Damien Le Moal wrote:
> > > > But to avoid the performance regression you observed, we really need to be 100%
> > > > sure that all bios have their ->bi_ioprio field correctly initialized. Something
> > > > like:
> > > > 
> > > > void bio_set_effective_ioprio(struct *bio)
> > > > {
> > > > 	switch (IOPRIO_PRIO_CLASS(bio->bi_ioprio)) {
> > > > 	case IOPRIO_CLASS_RT:
> > > > 	case IOPRIO_CLASS_BE:
> > > > 	case IOPRIO_CLASS_IDLE:
> > > > 		/*
> > > > 		 * the bio ioprio was already set from an aio kiocb ioprio
> > > > 		 * (aio->aio_reqprio) or from the issuer context ioprio if that
> > > > 		 * context used ioprio_set().
> > > > 		 */;
> > > > 		return;
> > > > 	case IOPRIO_CLASS_NONE:
> > > > 	default:
> > > > 		/* Use the current task CPU priority */
> > > > 		bio->ioprio =
> > > > 			IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> > > > 					  task_nice_ioprio(current));
> > > > 		return;
> > > > 	}
> > > > }
> > > > 
> > > > being called before a bio is inserted in a scheduler or bypass inserted in the
> > > > dispatch queues should result in all BIOs having an ioprio that is set to
> > > > something other than IOPRIO_CLASS_NONE. And the obvious place may be simply at
> > > > the beginning of submit_bio(), before submit_bio_noacct() is called.
> > > > 
> > > > I am tempted to argue that block device drivers should never see any req
> > > > with an ioprio set to IOPRIO_CLASS_NONE, which means that no bio should
> > > > ever enter the block stack with that ioprio either. With the above
> > > > solution, bios from DM targets submitted with submit_bio_noacct() could
> > > > still have IOPRIO_CLASS_NONE...  So would submit_bio_noacct() be the
> > > > better place to call the effective ioprio helper ?
> > > 
> > > Yes, I also think it would be the cleanest if we made sure bio->ioprio is
> > > always set to some value other than IOPRIO_CLASS_NONE. I'll see how we can
> > > make that happen in the least painful way :). Thanks for your input!
> > 
> > When looking into this I've hit a snag: ioprio rq_qos policy relies on the
> > fact that bio->bi_ioprio remains at 0 (unless explicitely set to some other
> > value by userspace) until we call rq_qos_track() in blk_mq_submit_bio().
> > BTW this happens after we have attempted to merge the bio to existing
> > requests so ioprio rq_qos policy is going to show strange behavior wrt
> > merging - most of the bios will not be able to merge to existing queued
> > requests due to ioprio mismatch.
> > 
> > I'd say .track hook gets called too late to properly set bio->bi_ioprio.
> > Shouldn't we set the io priority much earlier - I'd be tempted to use
> > bio_associate_blkg_from_css() for this... What do people think?
> 
> Hello Jan,
> 
> bio_associate_blkg_from_css() is just an empty stub if CONFIG_BLK_CGROUP
> is not set.
> 
> Having the effective ioprio set should correctly shouldn't depend on if
> CONFIG_BLK_CGROUP is set or not, no?
> 
> The function name bio_associate_blkg_from_css() (css - cgroup_subsys_state)
> also seems to imply that it should only perform cgroup related things, no?
> 
> AFAICT, both bfq and mq-deadline can currently prioritize requests without
> CONFIG_BLK_CGROUP enabled.

Correct on all points. However the ioprio rq_qos policy very much depends
on the cgroup support. So at least the update of bio->bi_ioprio based on
that policy would make sense in bio_associate_blkg_from_css(). OTOH
thinking about it now, we would have a problem that if bio blkcg
association changes, we don't have enough information to update the
bi_ioprio accordingly (since we don't know whether the resulting ioprio is
set by userspace or by ioprio rq_qos policy). So probably we need make
ioprio rq_qos policy to set the priority later (likely at bio submission
time when bio blkcg association is stable) but we need to do it earlier
than after we try to merge the bio...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
