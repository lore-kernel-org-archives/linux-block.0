Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E43EC433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F2523406
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 13:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAMNCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:02:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:46864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbhAMNCT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 08:02:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F347B807;
        Wed, 13 Jan 2021 13:01:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E2CD21E0872; Wed, 13 Jan 2021 14:01:31 +0100 (CET)
Date:   Wed, 13 Jan 2021 14:01:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] bfq: Fix computation of shallow depth
Message-ID: <20210113130131.GD6854@quack2.suse.cz>
References: <20201210094433.25491-1-jack@suse.cz>
 <20210105162141.GA28898@quack2.suse.cz>
 <238318dd-9103-e4e4-d591-ef7212b86a48@kernel.dk>
 <78A91DC0-0DC9-41EE-909D-341082CE4DA5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78A91DC0-0DC9-41EE-909D-341082CE4DA5@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-01-21 18:02:03, Paolo Valente wrote:
> > Il giorno 5 gen 2021, alle ore 17:29, Jens Axboe <axboe@kernel.dk> ha scritto:
> > 
> > On 1/5/21 9:21 AM, Jan Kara wrote:
> >> On Thu 10-12-20 10:44:33, Jan Kara wrote:
> >>> BFQ computes number of tags it allows to be allocated for each request type
> >>> based on tag bitmap. However it uses 1 << bitmap.shift as number of
> >>> available tags which is wrong. 'shift' is just an internal bitmap value
> >>> containing logarithm of how many bits bitmap uses in each bitmap word.
> >>> Thus number of tags allowed for some request types can be far to low.
> >>> Use proper bitmap.depth which has the number of tags instead.
> >>> 
> >>> Signed-off-by: Jan Kara <jack@suse.cz>
> >> 
> >> Ping Jens? I think it has fallen through the cracks?
> > 
> > More like waiting for Paolo to take a look. Don't mind taking it, and
> > I'll do that now, but I do expect him to review any BFQ patches being
> > sent out.
> 
> Sorry for the delay Jan.  As you know, my priority is currently to
> finalize the patches I have developed with your help; and
> unfortunately I'm way behind.  This is delaying also my review
> activity.
> 
> As for your proposal, I remember I found the right parameter rather
> empirically.  In particular, I seem to remember that the bitmap.depth
> parameter did not contain the value I needed, i.e, it did not
> contain the total number of tags.  But maybe something has changed in
> the meantime.  At any rate, if bitmap.depth does contain that value,
> then your replacement is ok.

Yes, bitmap.depth is the total number of tags AFAIK.

> If your replacement is ok, then I guess you may want to also fix the
> comments above the changes you propose.

Oh right, there's one paragraph in the comment that my patch made
redundant. I'll send a cleanup. Thanks for noticing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
