Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBEBC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 05:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BA5221FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 05:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgLBFFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 00:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgLBFFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 00:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606885435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arkWar9alkKDb9JAyKTvWcAV4YdGbG4IrRy5idwEoqs=;
        b=ctrJ5eFCsaI+CL9YYqjZQ+TPPXDM0MRoHwtDz4Mv0LUhAGbaKsXZH8pz/UMAPZ4T6GTV7t
        QaAS0YOPSXI/Ope0MIEO4Rx1LdkPWIVBEbLhXBGfOXEES10vHYIZ4tPA+b1YUg3rCCRRoz
        cFUKgclWXKmc72s9zjl5nnY7nOEpwv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-62TtsnliM3azptK5P6DE9Q-1; Wed, 02 Dec 2020 00:03:49 -0500
X-MC-Unique: 62TtsnliM3azptK5P6DE9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43873107AFA9;
        Wed,  2 Dec 2020 05:03:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC31D1346F;
        Wed,  2 Dec 2020 05:03:44 +0000 (UTC)
Date:   Wed, 2 Dec 2020 00:03:44 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201202050343.GA20535@redhat.com>
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What you've done here is fairly chaotic/disruptive:
1) you emailed a patch out that isn't needed or ideal, I dealt already
   staged a DM fix in linux-next for 5.10-rcX, see:
   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b
2) you replied to your patch and started referencing snippets of this
   other patch's header (now staged for 5.10-rcX via Jens' block tree):
   https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.10&id=7e7986f9d3ba69a7375a41080a1f8c8012cb0923
   - why not reply to _that_ patch in response something stated in it?
3) you started telling me, and others on these lists, why you think I
   used lcm_not_zero().
   - reality is I wanted gcd() behavior, I just didn't reason through
     the math to know it.. it was a stupid oversight on my part.  Not
     designed with precision.
4) Why not check with me before you craft a patch like others reported
   the problem to you? I know it logical to follow the chain of
   implications based on one commit and see where else there might be
   gaps but... it is strange to just pickup someone else's work like
   that.

All just _seems_ weird and overdone. This isn't the kind of help I
need. That said, I _do_ appreciate you looking at making blk IO polling
work with bio-based (and DM's bio splitting in particular), but the
lack of importance you put on DM's splitting below makes me concerned.

On Tue, Dec 01 2020 at 10:57pm -0500,
JeffleXu <jefflexu@linux.alibaba.com> wrote:

> Actually in terms of this issue, I think the dilemma here is that,
> @chunk_sectors of dm device is mainly from two source.
> 
> One is that from the underlying devices, which is calculated into one
> composed one in blk_stack_limits().
> 
> > commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> > chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> > reflect the most limited of all devices in the IO stack.
> > 
> > Otherwise malformed IO may result. E.g.: prior to this fix,
> > ->chunk_sectors = lcm_not_zero(8, 128) would result in
> > blk_max_size_offset() splitting IO at 128 sectors rather than the
> > required more restrictive 8 sectors.
> 
> For this part, technically I can't agree that 'chunk_sectors must
> reflect the most limited of all devices in the IO stack'. Even if the dm
> device advertises chunk_sectors of 128K when the limits of two
> underlying devices are 8K and 128K, and thus splitting is not done in dm
> device phase, the underlying devices will split by themselves.

DM targets themselves _do_ require their own splitting.  You cannot just
assume all IO that passes through DM targets doesn't need to be properly
sized on entry.  Sure underlying devices will do their own splitting,
but those splits are based on their requirements.  DM targets have their
own IO size limits too.  Each layer needs to enforce and respect the
constraints of its layer while also factoring in those of the underlying
devices.

> > @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >  
> >  	t->io_min = max(t->io_min, b->io_min);
> >  	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> > -	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
> > +
> > +	/* Set non-power-of-2 compatible chunk_sectors boundary */
> > +	if (b->chunk_sectors)
> > +		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
> 
> This may introduces a regression.

Regression relative to what?  5.10 was the regression point.  The commit
header you pasted into your reply clearly conveys that commit
22ada802ede8 caused the regression.  It makes no sense to try to create
some other regression point.  You cannot have both from a single commit
in the most recent Linux 5.10 release.

And so I have no idea why you think that restoring DM's _required_
splitting constraints is somehow a regression.

> Suppose the @chunk_sectors limits of
> two underlying devices are 8K and 128K, then @chunk_sectors of dm device
> is 8K after the fix. So even when a 128K sized bio is actually
> redirecting to the underlying device with 128K @chunk_sectors limit,
> this 128K sized bio will actually split into 16 split bios, each 8K
> sized。Obviously it is excessive split. And I think this is actually why
> lcm_not_zero(a, b) is used originally.

No.  Not excessive splitting, required splitting.  And as I explained in
point 2) above, avoiding "excessive splits" isn't why lcm_not_zero() was
improperly used to stack chunk_sectors.

Some DM targets really do require the IO be split on specific boundaries
-- however inconvenient for the underlying layers that DM splitting
might be.

> The other one source is dm device itself. DM device can set @max_io_len
> through ->io_hint(), and then set @chunk_sectors from @max_io_len.

ti->max_io_len should always be set in the DM target's .ctr

DM core takes care of applying max_io_len to chunk_sectors since 5.10,
you should know that given your patch is meant to fix commit
882ec4e609c1

And for 5.11 I've staged a change to have it impose max_io_len in terms
of ->max_sectors too, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=41dcb8f21a86edbe409b2bef9bb1df4cb9d66858

One thing I clearly need to do moving forward is: always post my changes
to dm-devel; just so someone like yourself can follow along via email
client.  I just assumed others who care about DM changes also track the
linux-dm.git tree's branches.  Clearly not the best assumption or
practice on my part.

> This part is actually where 'chunk_sectors must reflect the most limited
> of all devices in the IO stack' is true, and we have to apply the most
> strict limitation here. This is actually what the following patch does.

There is a very consistent and deliberate way that device limits must be
handled, sometimes I too have missteps but that doesn't change the fact
that there is a deliberate evenness to how limits are stacked.
blk_stack_limits() needs to be the authority on how these limits stack
up.  So all DM's limits stacking wraps calls to it.  My fix, shared in
point 1) above, restores that design pattern by _not_ having DM
duplicate a subset of how blk_stack_limits() does its stacking.

Mike

> On 12/2/20 11:38 AM, Jeffle Xu wrote:
> > As it said in commit 7e7986f9d3ba ("block: use gcd() to fix
> > chunk_sectors limit stacking"), chunk_sectors should reflect the most
> > limited of all devices in the IO stack.
> > 
> > The previous commit only fixes block/blk-settings.c:blk_stack_limits(),
> > while leaving dm.c:dm_calculate_queue_limits() unfixed.
> > 
> > Fixes: 882ec4e609c1 ("dm table: stack 'chunk_sectors' limit to account for target-specific splitting")
> > cc: stable@vger.kernel.org
> > Reported-by: John Dorminy <jdorminy@redhat.com>
> > Reported-by: Bruce Johnston <bjohnsto@redhat.com>
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> >  drivers/md/dm-table.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index ce543b761be7..dcc0a27355d7 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/blk-mq.h>
> >  #include <linux/mount.h>
> >  #include <linux/dax.h>
> > +#include <linux/gcd.h>
> >  
> >  #define DM_MSG_PREFIX "table"
> >  
> > @@ -1457,7 +1458,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
> >  
> >  		/* Stack chunk_sectors if target-specific splitting is required */
> >  		if (ti->max_io_len)
> > -			ti_limits.chunk_sectors = lcm_not_zero(ti->max_io_len,
> > +			ti_limits.chunk_sectors = gcd(ti->max_io_len,
> >  							       ti_limits.chunk_sectors);
> >  		/* Set I/O hints portion of queue limits */
> >  		if (ti->type->io_hints)
> > 
> 
> -- 
> Thanks,
> Jeffle
> 

