Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F4460F9F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhJSNrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:47:15 -0400
Received: from verein.lst.de ([213.95.11.211]:38365 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236032AbhJSNrN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:47:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AC4A68BEB; Tue, 19 Oct 2021 15:44:57 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:44:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: remove the RQF_ELVPRIV check in
 blk_mq_free_request
Message-ID: <20211019134457.GA20622@lst.de>
References: <20211019133944.2500822-1-hch@lst.de> <20211019133944.2500822-2-hch@lst.de> <6393ab57-3a9a-e5ee-6428-c1a4f0bee1f6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6393ab57-3a9a-e5ee-6428-c1a4f0bee1f6@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 07:43:04AM -0600, Jens Axboe wrote:
> On 10/19/21 7:39 AM, Christoph Hellwig wrote:
> > If RQF_ELVPRIV is set RQF_ELV is by definition set as well.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/blk-mq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 428e0e0fd5504..34392c439d2a8 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -580,7 +580,7 @@ void blk_mq_free_request(struct request *rq)
> >  	struct request_queue *q = rq->q;
> >  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> >  
> > -	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
> > +	if (rq->rq_flags & RQF_ELV) {
> 
> Actually just fixed a bug there. RQF_ELV means "we have an IO
> scheduler", and RQF_ELVPRIV means that plus "we have rq private data".
> The above shouldn't check RQF_ELV at all, just PRIV.

Well, in that case RQF_ELVPRIV can be replaced with
RQF_ELV && !op_is_flush as in the next patch.  But I can resend once I
see the fix in a tree somewhere.
