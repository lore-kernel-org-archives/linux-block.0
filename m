Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E961C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AD32083E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDIKGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:06:03 -0400
Received: from verein.lst.de ([213.95.11.211]:49312 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfDIKGD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 06:06:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A338868C4E; Tue,  9 Apr 2019 12:05:49 +0200 (CEST)
Date:   Tue, 9 Apr 2019 12:05:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages
 calls per bio
Message-ID: <20190409100548.GA7361@lst.de>
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-4-hch@lst.de> <1554761855.118779.285.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554761855.118779.285.camel@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 03:17:35PM -0700, Bart Van Assche wrote:
> On Mon, 2019-04-08 at 12:46 +0200, Christoph Hellwig wrote:
> > No caller uses bio_iov_iter_get_pages multiple times on a given bio,
> > and that funtionality isn't all that useful.  Removing it will make
> > some future changes a little easier and also simplifies the function
> > a bit.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/bio.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index ad346082a971..2fa624db21c7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -958,7 +958,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >         const bool is_bvec = iov_iter_is_bvec(iter);
> > -       unsigned short orig_vcnt = bio->bi_vcnt;
> > +       int ret = -EFAULT;
> 
> Is the value -EFAULT used anywhere? In other words, can " = -EFAULT" be left
> out? Otherwise this patch looks good to me.

True, it could be dropped.  The assignment is a leftover from an earlier
version of the patch.
