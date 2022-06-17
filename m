Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9139C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 11:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiFQLwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382085AbiFQLwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 07:52:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152576CF7F
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:52:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8BF21FDC2;
        Fri, 17 Jun 2022 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655466736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmnh5GWBSOgb77ikO6D/MktSQlsw/k7cuW6yagSKAiM=;
        b=eoh+rEIBBv5/liYBBAxZCKKbrgpDZD89FzccNlLaTnvn6HUQ2lpXr3hochpsqrtinGveSs
        aZaXezFkaq3dDwFrF1/23eUt6UwPZz9HVMPveL+jsNjprD+pCFFPot7txeywYhjTLuk9AG
        MRm50DZr2M7p12mDVCpbD/Qz+pSQUwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655466736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmnh5GWBSOgb77ikO6D/MktSQlsw/k7cuW6yagSKAiM=;
        b=zmTkJ6vLqENRcvMeyNA1no9PJwlfLCOWSOIUMy/ODyUz0m/EhQev7NStj9r2cysJuM9Qd/
        jFJhzJ236aatrlBQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88B112C141;
        Fri, 17 Jun 2022 11:52:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A13CFA0632; Fri, 17 Jun 2022 13:52:08 +0200 (CEST)
Date:   Fri, 17 Jun 2022 13:52:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Message-ID: <20220617115208.mv55swrdcf44tw5a@quack3>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
 <ae8fbc74-64b7-2d2e-ba46-cc72851e30b5@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8fbc74-64b7-2d2e-ba46-cc72851e30b5@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 17-06-22 09:05:12, Damien Le Moal wrote:
> On 6/16/22 20:23, Jan Kara wrote:
> > On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
> >> On 6/16/22 01:16, Jan Kara wrote:
> >>> Currently, IO priority set in task's IO context is not reflected in the
> >>> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
> >>> results in odd results where process is submitting some bios with one
> >>> priority and other bios with a different (unset) priority and due to
> >>> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
> >>> always set on bio submission.
> >>>
> >>> Signed-off-by: Jan Kara <jack@suse.cz>
> >>> ---
> >>>   block/blk-mq.c | 6 ++++++
> >>>   1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index e17d822e6051..e976f696babc 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
> >>>   static void bio_set_ioprio(struct bio *bio)
> >>>   {
> >>> +	unsigned short ioprio_class;
> >>> +
> >>>   	blkcg_set_ioprio(bio);
> >>
> >> Shouldn't this function set the default using the below "if" code ?
> >>
> >>> +	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> >>> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> >>
> >> I do not think that the ioprio_class variable is useful.
> >> This can be:
> >>
> >> 	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> >> 		bio->bi_ioprio = get_current_ioprio();
> > 
> > You are right. Fixed.
> 
> What about moving this inside blkcg_set_ioprio() ? bio_set_ioprio() would
> then not be needed at all and blkcg_set_ioprio() called directly ?

What I dislike about this is that it is counterintuitive that
blkcg_set_prio() does anything when blkcgs are disabled in kernel config
(and it would have to to keep things working). So if you dislike
bio_set_ioprio(), I can just opencode this function in its single call
site. Would that be better?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
