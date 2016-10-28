Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60573 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755883AbcJ1HgB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 03:36:01 -0400
Date: Fri, 28 Oct 2016 09:35:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/7] block: better op and flags encoding
Message-ID: <20161028073558.GA11804@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de> <1476969135-32732-7-git-send-email-hch@lst.de> <CAJVOszBmN+=PD7MBEgkhO-jo3_R7rJ+5V1LGbWqDW8U+D=Dbgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJVOszBmN+=PD7MBEgkhO-jo3_R7rJ+5V1LGbWqDW8U+D=Dbgw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> >  void init_request_from_bio(struct request *req, struct bio *bio)
> >  {
> >         req->cmd_type = REQ_TYPE_FS;
> > -
> > -       req->cmd_flags |= bio->bi_opf & REQ_COMMON_MASK;
> 
> Don't we still have to init cmd_flags from bi_opf at some point in the
> non-mq path?

We now pass all of bi_opf to get_request -> __get_request, so cmd_flags
is initialized to the right value from the very beginning.

> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -16,6 +16,8 @@
> >  int blk_rq_append_bio(struct request *rq, struct bio *bio)
> >  {
> >         if (!rq->bio) {
> > +               rq->cmd_flags &= REQ_OP_MASK;
> > +               rq->cmd_flags |= (bio->bi_opf & REQ_OP_MASK);
> >                 blk_rq_bio_prep(rq->q, rq, bio);
> 
> Should this be "&= ~REQ_OP_MASK" ?

No - blk_rq_bio_prep previous initialized just the op, and not the
flags, and this keeps the behavior.  In the long run we should stop
setting the op here as well, though.
