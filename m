Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E66C433FE
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 06:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbiETGK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 May 2022 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiETGK7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 May 2022 02:10:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0729809;
        Thu, 19 May 2022 23:10:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0237F68AFE; Fri, 20 May 2022 08:10:54 +0200 (CEST)
Date:   Fri, 20 May 2022 08:10:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <20220520061053.GB16557@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <20220518171131.3525293-4-kbusch@fb.com> <20220519073811.GE22301@lst.de> <YoZPcqDpwSTn/csn@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZPcqDpwSTn/csn@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 08:08:50AM -0600, Keith Busch wrote:
> > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > +	if (size > 0)
> > > +		size = ALIGN_DOWN(size, queue_logical_block_size(q));
> > 
> > So if we do get a size that is not logical block size alignment here,
> > we reduce it to the block size aligned one below.  Why do we do that?
> 
> There are two possibilities:
> 
> In the first case, the number of pages in this iteration exceeds bi_max_vecs.
> Rounding down completes the bio with a block aligned size, and the remainder
> will be picked up for the next bio, or possibly even the current bio if the
> pages are sufficiently physically contiguous.
> 
> The other case is a bad iov. If we're doing __blkdev_direct_IO(), it will error
> out immediately if the rounded size is 0, or the next iteration when the next
> size is rounded to 0. If we're doing the __blkdev_direct_IO_simple(), it will
> error out when it sees the iov hasn't advanced to the end.

Can you please document this with a comment in the code?
