Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E61CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Dec 2021 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350559AbhLAOjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Dec 2021 09:39:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350147AbhLAOg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Dec 2021 09:36:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A16061FD58;
        Wed,  1 Dec 2021 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638369217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9UBP124hYeNa6TVrkzFZrhQX94Y5SsEsxzU99CDkX8=;
        b=pRQ6T9DQ0B9+XgWAebtWR1+dYCFK8DwFhU4JnqYP7p6cAYHJMQCjT+bsuutVQJsUD/+oKq
        c7wBArNzckput3JS2y0FlAePf2u/qMkuFQqtWexWemO+XbPbILvIiaBrFkyBjZUi5nDZH/
        8foVAUpvOm/Vr38QPSJuaq34ENVnXg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638369217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9UBP124hYeNa6TVrkzFZrhQX94Y5SsEsxzU99CDkX8=;
        b=RlnVClIOHWrSCBv11TafUtJ9WAFb9LTSOza+hdjvuP7GhQ3dRFx35hkI3aJy6ud4DGOhIE
        6X90zLQn03oDKkAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9110FA3B81;
        Wed,  1 Dec 2021 14:33:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5F3311E1494; Wed,  1 Dec 2021 15:33:36 +0100 (CET)
Date:   Wed, 1 Dec 2021 15:33:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/7] block: cleanup ioc_clear_queue
Message-ID: <20211201143336.GB1815@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-7-hch@lst.de>
 <20211130172613.GL7174@quack2.suse.cz>
 <20211201072702.GB31765@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072702.GB31765@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 01-12-21 08:27:02, Christoph Hellwig wrote:
> On Tue, Nov 30, 2021 at 06:26:13PM +0100, Jan Kara wrote:
> > I'm not quite sure about dropping the rcu protection here. This function
> > generally runs without any protection so what guards us against icq being
> > freed just after we've got its pointer from the list?
> 
> How does the RCU protection scheme work for the icq lookups?
> ioc_lookup_icq takes it and then drops it before getting any kind
> of refcount, so this all looks weird.  But I guess you are right that
> I should probably keep this cargo culted scheme unless I have an
> actual plan on how this could work.

I agree the RCU there looks like a bit of cargo-cult and would need better
documentation if nothing else. But I think the logic behind RCU protection
inside __ioc_clear_queue() is that you can safely acquire ioc->lock and
check ICQ_DESTROYED flag - which should be set if ioc got already freed, if
not set, you hold the ioc->lock so you won the race to free the ioc.
For ioc_lookup_icq() I'm not sure what's going on there, there RCU looks
completely pointless.

> While we're at it:  I don't see how put put_io_context could
> be called under q->queue_lock and thus actually need the whole
> workqueue scheme.

I don't see that either but I think in the past an equivalent of
blk_mq_free_request() could get called during request merging while holding
all the locks (I have just recently fixed a deadlock due to this in BFQ by
postponing freeing of merged requests to the caller) and
blk_mq_free_request() will call put_io_context(). So at this point I don't
think it is needed anymore.

> Then again we really need to do an audit on queue_lock and split it into
> actually documented locks now that the old request code is gone.

A worthy goal :)
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
