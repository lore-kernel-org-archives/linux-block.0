Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1101C2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 16:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E87207E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 16:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfFGQp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:45:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57399 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfFGQp7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Jun 2019 12:45:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED67E68AFE; Fri,  7 Jun 2019 18:45:32 +0200 (CEST)
Date:   Fri, 7 Jun 2019 18:45:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] block: remove the bi_phys_segments field in struct
 bio
Message-ID: <20190607164532.GD7307@lst.de>
References: <20190606102904.4024-1-hch@lst.de> <20190606102904.4024-4-hch@lst.de> <481003ba-aa95-0d0e-ba1f-ce48f2c61105@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481003ba-aa95-0d0e-ba1f-ce48f2c61105@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 07, 2019 at 08:02:55AM +0200, Hannes Reinecke wrote:
> > +void blk_queue_split(struct request_queue *q, struct bio **bio)
> > +{
> > +	unsigned int nr_segs;
> > +
> > +	__blk_queue_split(q, bio, &nr_segs);
> > +}
> >  EXPORT_SYMBOL(blk_queue_split);
> >  
> That looks a bit weird, and I guess some or other compiler might
> complain here about nr_segs being unused.
> Can't we modify __blk_queue_split() to accept a NULL argument here?

We could.  But that would bloat the fast path for absolutely no
reason.  Passing a by reference output argument that is then ignored
is a pretty common pattern.
