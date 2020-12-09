Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E547C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 01:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040AF239FD
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 01:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLIBWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgLIBWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 20:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607476854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uik71+vVFbOyAjS/HGEmS6r9Qzko4lG+yHWyhT8VInE=;
        b=Dcu4hb7pB3WuPNWXVYLBPjdAwiMvv0QVw2ihM2r1QTdgOLowWhLgcxEM4Z6NcZgGsLU47N
        LPeh1vnxk1mfBFMRVT1HJM6+f5vLIj1RKbIah7UyLHD4E2xKYYk/Vky6zBG6If2QlTVrQ9
        HT6mUN31n4L1eSNf6qIZ4ytiwwy8lIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-vEjOeAtQMWCmJHPeY1dWeQ-1; Tue, 08 Dec 2020 20:20:50 -0500
X-MC-Unique: vEjOeAtQMWCmJHPeY1dWeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742B71005504;
        Wed,  9 Dec 2020 01:20:49 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07EE15D6D5;
        Wed,  9 Dec 2020 01:20:40 +0000 (UTC)
Date:   Wed, 9 Dec 2020 09:20:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ming.l@ssi.samsung.com, sagig@grimberg.me, axboe@fb.com,
        tom.leiming@gmail.com
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
Message-ID: <20201209012035.GB1217988@T590>
References: <20201206051802.1890-1-tom.ty89@gmail.com>
 <20201207031226.GD985419@T590>
 <CAGnHSE=9au+u+9q-XhZeFQr04GPDTiypkgMh6mi+in4-BBRi=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSE=9au+u+9q-XhZeFQr04GPDTiypkgMh6mi+in4-BBRi=g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 08:46:31PM +0800, Tom Yan wrote:
> Are you saying that it would work either way?

Please don't do top reply which is hard to follow context.

> 
> On Mon, 7 Dec 2020 at 11:12, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Sun, Dec 06, 2020 at 01:18:02PM +0800, Tom Yan wrote:
> > > While it seems to have worked for so long, it doesn't seem right
> > > that we set the new bio as the parent. bio_chain() seems to be used
> > > in the other way everywhere else anyway.
> > >
> > > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > > ---
> > >  block/blk-lib.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > index e90614fd8d6a..918deaf5c8a4 100644
> > > --- a/block/blk-lib.c
> > > +++ b/block/blk-lib.c
> > > @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
> > >       struct bio *new = bio_alloc(gfp, nr_pages);
> > >
> > >       if (bio) {
> > > -             bio_chain(bio, new);
> > > +             bio_chain(new, bio);
> > >               submit_bio(bio);
> > >       }
> >
> > This patch isn't needed. We simply wait for completion of the last issued bio, which
> > .bi_end_io(submit_bio_wait_endio) is only called after all previous bios are done.
> >
> > And the last bio is the ancestor of the whole chained bios, which are
> > submitted in the following way(order):
> >
> >         bio 0 ---> bio 1 ---> ... -> bio N(the last bio)
...
> 
> Are you saying that it would work either way?

No.

The current way of blk_next_bio() works just as expected, and your patch
is actually wrong. Let's see one simple example, suppose one discard request
is splitted into two bios(bio 0, and bio 1), after your patch is applied:

1) bio 0 becomes bio 1's parent, and bio 0 is submitted first

2) bio 1 is submitted finally via submit_bio_wait(), and bio 1's .bi_end_io/.bi_private
is updated to submit_bio_wait_endio()/&done, so when bio 1 is completed, there
isn't any way to know if bio 0 is completed, because the chain is cut by your patch.

-- 
Ming

