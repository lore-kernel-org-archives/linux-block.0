Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C5C63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5D52076C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dji7uYN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgK3XZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgK3XZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 18:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606778670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/61DZnDo9bjtrofm11G0rTWGYuO7llOK0o61JLD2YRI=;
        b=Dji7uYN1nYRWKoXt+U5OHEX0qMckUuW6VRT/wW+dhtqxjmncXkyS0hkaIiZvcb/uax5uE1
        Co59aIa8XszABWw+nqCTbH/9yFtDG42JNaTYT5R8MltfhxMhnzcJ+ke1Bbbn/gSwXZNgdz
        aAYaNuTSJyth0h2+BBKtJxKe4i5P+UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479--O7WP7zlNHu5QcwBfdRnrQ-1; Mon, 30 Nov 2020 18:24:27 -0500
X-MC-Unique: -O7WP7zlNHu5QcwBfdRnrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E79F91842141
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 23:24:26 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 884DB19C71;
        Mon, 30 Nov 2020 23:24:18 +0000 (UTC)
Date:   Mon, 30 Nov 2020 18:24:17 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Bruce Johnston <bjohnsto@redhat.com>
Subject: Re: block: revert to using min_not_zero() when stacking chunk_sectors
Message-ID: <20201130232417.GA12865@redhat.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <CAMeeMh8fb2JEBmuSuTP8ys6Xr+GpFqcUr5Py73W4wCQb1MCuAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh8fb2JEBmuSuTP8ys6Xr+GpFqcUr5Py73W4wCQb1MCuAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 30 2020 at  3:51pm -0500,
John Dorminy <jdorminy@redhat.com> wrote:

> I don't think this suffices, as it allows IOs that span max(a,b) chunk
> boundaries.
> 
> Chunk sectors is defined as "if set, it will prevent merging across
> chunk boundaries". Pulling the example from the last change:

If you're going to cherry pick a portion of a commit header please
reference the commit id and use quotes or indentation to make it clear
what is being referenced, etc.

> It is possible, albeit more unlikely, for a block device to have a non
> power-of-2 for chunk_sectors (e.g. 10+2 RAID6 with 128K chunk_sectors,
> which results in a full-stripe size of 1280K. This causes the RAID6's
> io_opt to be advertised as 1280K, and a stacked device _could_ then be
> made to use a blocksize, aka chunk_sectors, that matches non power-of-2
> io_opt of underlying RAID6 -- resulting in stacked device's
> chunk_sectors being a non power-of-2).

This was from the header for commit 07d098e6bba ("block: allow
'chunk_sectors' to be non-power-of-2")

> Suppose the stacked device had a block size/chunk_sectors of 256k.

Quite the tangent just to setup an a toy example of say: thinp with 256K
blocksize/chunk_sectors ontop of a RAID6 with a chunk_sectors of 128K
and stripesize of 1280K.

> Then, with this change, some IOs issued by the stacked device to the
> RAID beneath could span 1280k sector boundaries, and require further
> splitting still.
> I think combining as the GCD is better, since any IO
> of size gcd(a,b) definitely spans neither a a-chunk nor a b-chunk
> boundary.

To be clear, you are _not_ saying using lcm_not_zero() is correct.
You're saying that simply reverting block core back to using
min_not_zero() may not be as good as using gcd().

While that may be true (not sure yet) you've now muddied a conservative
fix (that reverts block core back to its longstanding use of
min_not_zero for chunk_sectors) in pursuit of addressing some different
concern than the case that you _really_ care about getting fixed
(I'm inferring based on your regression report):
4K chunk_sectors stacked on larger chunk_sectors, e.g. 256K

My patch fixes the case and doesn't try to innovate, it tries to get
block core back to sane chunk_sectors stacking (which I broke).

> But it's possible I'm misunderstanding the purpose of chunk_sectors,
> or there should be a check that the one of the two devices' chunk
> sizes divides the other.

Seriously not amused by your response, I now have to do damage control
because you have a concern that you really weren't able to communicate
very effectively.

But I got this far, so for your above toy example (stacking 128K and
256K chunk_sectors):
min_not_zero = 128K
gcd = 128K

SO please explain to me why gcd() is better at setting a chunk_sectors
that ensures IO doesn't span 1280K stripesize (nevermind that
chunk_sectors has no meaningful relation to io_opt to begin with!).

Mike


> 
> On Mon, Nov 30, 2020 at 12:18 PM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > chunk_sectors must reflect the most limited of all devices in the IO
> > stack.
> >
> > Otherwise malformed IO may result. E.g.: prior to this fix,
> > ->chunk_sectors = lcm_not_zero(8, 128) would result in
> > blk_max_size_offset() splitting IO at 128 sectors rather than the
> > required more restrictive 8 sectors.
> >
> > Fixes: 22ada802ede8 ("block: use lcm_not_zero() when stacking chunk_sectors")
> > Cc: stable@vger.kernel.org
> > Reported-by: John Dorminy <jdorminy@redhat.com>
> > Reported-by: Bruce Johnston <bjohnsto@redhat.com>
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  block/blk-settings.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 9741d1d83e98..1d9decd4646e 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >
> >         t->io_min = max(t->io_min, b->io_min);
> >         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> > -       t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
> > +
> > +       if (b->chunk_sectors)
> > +               t->chunk_sectors = min_not_zero(t->chunk_sectors,
> > +                                               b->chunk_sectors);
> >
> >         /* Physical block size a multiple of the logical block size? */
> >         if (t->physical_block_size & (t->logical_block_size - 1)) {
> > --
> > 2.15.0
> >
> 

