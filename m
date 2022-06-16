Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 11:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376767AbiFPLXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376754AbiFPLXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 07:23:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7440022B38
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 04:23:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 761151FD7C;
        Thu, 16 Jun 2022 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655378584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjPBi/tylKzKdl4cALDs6nlxQ5gkqlqxq1CBD7T0iPo=;
        b=ZIMGY/nu2E5O6idPaX9K5L1s6x5zm6SzdV4xl64OS4sK01M0eOHwGgKFPzjenkQBD3dj1W
        uq9FPBzLyCvrriJsQhIZuaKtZZGx5ZGkpR+XB00KPoBvBAIHlx+ExgLR3EtmXiGFQerCbT
        1buQ8mFmtnxX7J3/c7xbGGg13PpUpIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655378584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjPBi/tylKzKdl4cALDs6nlxQ5gkqlqxq1CBD7T0iPo=;
        b=63AvQXQVOasFMpsGpE3bGWUKCyfOKWYDDytf2NTCkIpPy6fQinlDLqfjS3OQI2y8zEQD8p
        /6R7jWBekrT3TUCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F5842C141;
        Thu, 16 Jun 2022 11:23:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3CABA062E; Thu, 16 Jun 2022 13:23:03 +0200 (CEST)
Date:   Thu, 16 Jun 2022 13:23:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Message-ID: <20220616112303.wywyhkvyr74ipdls@quack3.lan>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
> On 6/16/22 01:16, Jan Kara wrote:
> > Currently, IO priority set in task's IO context is not reflected in the
> > bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
> > results in odd results where process is submitting some bios with one
> > priority and other bios with a different (unset) priority and due to
> > differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
> > always set on bio submission.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   block/blk-mq.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index e17d822e6051..e976f696babc 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
> >   static void bio_set_ioprio(struct bio *bio)
> >   {
> > +	unsigned short ioprio_class;
> > +
> >   	blkcg_set_ioprio(bio);
> 
> Shouldn't this function set the default using the below "if" code ?
> 
> > +	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> 
> I do not think that the ioprio_class variable is useful.
> This can be:
> 
> 	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> 		bio->bi_ioprio = get_current_ioprio();

You are right. Fixed.

> > +	if (ioprio_class == IOPRIO_CLASS_NONE)
> > +		bio->bi_ioprio = get_current_ioprio();
> >   }
> >   /**
> 
> Beside this comment, I am still scratching my head regarding what the user
> gets with ioprio_get(). If I understood your patches correctly, the user may
> still see IOPRIO_CLASS_NONE ?
> For that case, to be in sync with the man page, I thought the returned
> ioprio should be the effective one based on the task io nice value, that is,
> the value returned by get_current_ioprio(). Am I missing something... ?

The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
or IOPRIO_WHO_USER the effective IO priority may be different for different
processes considered and it can be also further influenced by blk-ioprio
settings. But thinking about it now after things have settled I agree that
what you suggests makes more sense. I'll fix that. Thanks for suggestion!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
