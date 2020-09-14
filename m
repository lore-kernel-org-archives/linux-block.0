Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769AC433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7308520829
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDHLUC5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINPEI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:04:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgINPEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 11:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600095843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFVrrrfRjT3a23tm074wxzjtFdymZ366A9Lx0WOWK70=;
        b=FDHLUC5B4osvt5k6kI3XiEogFJyn0hSDlQ6bGiF/X36aZgTqB+gm8MrrWOzUwOD2BNjcE7
        hxvrQqAEDmPQFmmJp1h9MH1XBiL1F5oYs0SZN2HmNX+1XtzVtfw121oChIPJQmMrDUC+4W
        CnFAwO2QLstte6pJuuyUAli07pe7o1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-GCWNhFdoM6yySkwJjRDAuA-1; Mon, 14 Sep 2020 11:04:00 -0400
X-MC-Unique: GCWNhFdoM6yySkwJjRDAuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E2A9100747E;
        Mon, 14 Sep 2020 15:03:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C7655DC06;
        Mon, 14 Sep 2020 15:03:53 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:03:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Message-ID: <20200914150352.GC14410@redhat.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
 <CY4PR04MB375160D4EFBA9BE0957AC7EDE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375160D4EFBA9BE0957AC7EDE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 13 2020 at  8:46pm -0400,
Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> On 2020/09/12 6:53, Mike Snitzer wrote:
> > blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and
> > REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for
> > those operations.
> > 
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
> 
> Doesn't this break md devices ? (I think does use chunk_sectors for stride size,
> no ?)
> 
> As mentioned in my reply to Ming's email, this will allow these commands to
> potentially cross over zone boundaries on zoned block devices, which would be an
> immediate command failure.

Depending on the implementation it is beneficial to get a large
discard (one not constrained by chunk_sectors, e.g. dm-stripe.c's
optimization for handling large discards and issuing N discards, one per
stripe).  Same could apply for other commands.

Like all devices, zoned devices should impose command specific limits in
the queue_limits (and not lean on chunk_sectors to do a
one-size-fits-all).

But that aside, yes I agree I didn't pay close enough attention to the
implications of deferring the splitting of these commands until they
were issued to underlying storage.  This chunk_sectors early splitting
override is a bit of a mess... not quite following the logic given we
were supposed to be waiting to split bios as late as possible.

Mike

