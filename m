Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1003C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 14:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22CE2193E
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 14:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlRbUmg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgINOt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgINOtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 10:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600094984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2FISUjw2QQra5lIkP9UmvRtfzFCQ3DCVcxVbuGUKeM=;
        b=MlRbUmg2vHQ5VMkR32IjndseqbcfesxCL3dKo74LBkJ8HgpY1t/3PmURCDaFh8UdloaTMM
        3Uao5rNUy28YpHeppRPSddxUxrBbA/vTcquMh6ASyw9kphyzNH80I7aGm2ya34iXyLDbs4
        ZZCweE8TIBydM7rf/pk/pocqw6Kl43A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-lpHmq6jdMOu89eThywB-3A-1; Mon, 14 Sep 2020 10:49:42 -0400
X-MC-Unique: lpHmq6jdMOu89eThywB-3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 572E7190A418;
        Mon, 14 Sep 2020 14:49:38 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D037481C4D;
        Mon, 14 Sep 2020 14:49:29 +0000 (UTC)
Date:   Mon, 14 Sep 2020 10:49:28 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Message-ID: <20200914144928.GA14410@redhat.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
 <20200912135252.GA210077@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912135252.GA210077@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 12 2020 at  9:52am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Fri, Sep 11, 2020 at 05:53:36PM -0400, Mike Snitzer wrote:
> > blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and
> > REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for
> > those operations.
> 
> Actually WRITE_SAME & WRITE_ZEROS are handled by the following if
> chunk_sectors is set:
> 
>         return min(blk_max_size_offset(q, offset),
>                         blk_queue_get_max_sectors(q, req_op(rq)));

Yes, but blk_rq_get_max_sectors() is a bit of a mess structurally.  he
duality of imposing chunk_sectors and/or considering offset when
calculating the return is very confused.

> > Also, there is no need to avoid blk_max_size_offset() if
> > 'chunk_sectors' isn't set because it falls back to 'max_sectors'.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  include/linux/blkdev.h | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index bb5636cc17b9..453a3d735d66 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
> >  						  sector_t offset)
> >  {
> >  	struct request_queue *q = rq->q;
> > +	int op;
> > +	unsigned int max_sectors;
> >  
> >  	if (blk_rq_is_passthrough(rq))
> >  		return q->limits.max_hw_sectors;
> >  
> > -	if (!q->limits.chunk_sectors ||
> > -	    req_op(rq) == REQ_OP_DISCARD ||
> > -	    req_op(rq) == REQ_OP_SECURE_ERASE)
> > -		return blk_queue_get_max_sectors(q, req_op(rq));
> > +	op = req_op(rq);
> > +	max_sectors = blk_queue_get_max_sectors(q, op);
> >  
> > -	return min(blk_max_size_offset(q, offset),
> > -			blk_queue_get_max_sectors(q, req_op(rq)));
> > +	switch (op) {
> > +	case REQ_OP_DISCARD:
> > +	case REQ_OP_SECURE_ERASE:
> > +	case REQ_OP_WRITE_SAME:
> > +	case REQ_OP_WRITE_ZEROES:
> > +		return max_sectors;
> > +	}
> > +
> > +	return min(blk_max_size_offset(q, offset), max_sectors);
> >  }
> 
> It depends if offset & chunk_sectors limit for WRITE_SAME & WRITE_ZEROS
> needs to be considered.

Yes, I see that now.  But why don't they need to be considered for
REQ_OP_DISCARD and REQ_OP_SECURE_ERASE?  Is it because the intent of the
block core is to offer late splitting of bios?  If so, then why impose
chunk_sectors so early?

Obviously this patch 1/3 should be dropped.  I didn't treat
chunk_sectors with proper priority.

But like I said above, blk_rq_get_max_sectors() vs blk_max_size_offset()
is not at all straight-forward.  And the code looks prone to imposing
limits that shouldn't be (or vice-versa).

Also, when falling back to max_sectors, why not consider offset to treat
max_sectors like a granularity?  Would allow for much more consistent IO
patterns.

Mike

