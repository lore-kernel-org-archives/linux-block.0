Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F7C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 04:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6029613EA
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 04:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhFQEhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 00:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQEhB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 00:37:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF2B613BF;
        Thu, 17 Jun 2021 04:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623904494;
        bh=hdAU2EvYyDRmpCAW4XPIVGpByZPe+MkYFJ1VpttRoBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7oBxu1xBOojP5x2hHn2eEWDnKiHPQnbqdZB2GypBhlAMEo3E+MupDfSOleCnAfT5
         KpFIg0YSsKau6XmeP9trKbcQM8mGY0PeXyxF81khTlQ3JUfL3+Ckzb7JQv+qqCG4+v
         MQlVJTQ6E+uN674TiCMTdU4sVyh9gOhCH1OQbcS8JYRQnBFWb2f6Kv5bDt1o2MWGjP
         Aum5zy5AtVu7wxRZWpoy4pgTT0JfNpH/1fXs08oET7rXINSk26GvG94cSFboiyZR5z
         qrUcGPa40fSsMU5WzjF7PzWxyMkM/0KZ1U1JINTMmiRyRG7aPK1rmlDI/AXh+Ky+wt
         h+2vzItqTy1mA==
Date:   Wed, 16 Jun 2021 21:34:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 04/10] block: respect bio_required_sector_alignment()
 in blk-crypto-fallback
Message-ID: <YMrQ7KjD8BpbqNyK@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-5-satyat@google.com>
 <YMqZuBssXiMvDxIf@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMqZuBssXiMvDxIf@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16, 2021 at 05:39:20PM -0700, Eric Biggers wrote:
> On Fri, Jun 04, 2021 at 07:58:54PM +0000, Satya Tangirala wrote:
> > Make blk_crypto_split_bio_if_needed() respect
> > bio_required_sector_alignment() when calling bio_split(). Without this,
> > blk-crypto-fallback could possibly split a bio in the middle of a data
> > unit, and the resulting bios can no longer be encrypted (since encryption
> > can only be done on complete crypto data units).
> > 
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  block/blk-crypto-fallback.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> > index c322176a1e09..85c813ef670b 100644
> > --- a/block/blk-crypto-fallback.c
> > +++ b/block/blk-crypto-fallback.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/random.h>
> >  
> > +#include "blk.h"
> >  #include "blk-crypto-internal.h"
> >  
> >  static unsigned int num_prealloc_bounce_pg = 32;
> > @@ -225,6 +226,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
> >  	if (num_sectors < bio_sectors(bio)) {
> >  		struct bio *split_bio;
> >  
> > +		num_sectors = round_down(num_sectors,
> > +					 bio_required_sector_alignment(bio));
> >  		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
> >  				      &crypto_bio_split);
> >  		if (!split_bio) {
> > -- 
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Hmm, on second thought, I don't think this patch makes sense without the patch
"block: blk-crypto-fallback: handle data unit split across multiple bvecs"
which Satya sent out in his other series
(https://lkml.kernel.org/r/20210604210908.2105870-2-satyat@google.com).
Either blk-crypto-fallback assumes that the length of every bio_vec is aligned
to data_unit_size (this is the status quo), in which case the round_down() is
unnecessary, *or* it assumes that only the total length is aligned to
data_unit_size, in which case both patches are needed.  So I'm thinking these
should be combined into one patch.

- Eric
