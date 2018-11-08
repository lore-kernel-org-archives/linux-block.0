Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Nov 2018 19:40:53 -0500
Date: Thu, 8 Nov 2018 07:04:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181108150445.GA31100@infradead.org>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
 <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
 <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
 <1541607019.196084.210.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1541607019.196084.210.camel@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 07, 2018 at 08:10:19AM -0800, Bart Van Assche wrote:
> > I personally not a huge fan of decoding complicated expressions. But if
> > others are fine with it then I am too...
> 
> What I proposed is not a new pattern. It is a pattern that is already used
> elsewhere in the Linux kernel. A few examples:
> 
> >From dmabounce.c:
> 
> 		/* Figure out if we need to bounce from the DMA mask. */
> 		if ((dma_addr | (dma_addr + size - 1)) & ~mask)
> 			return 1;
> 
> >From dma-direct.h:
> 
> 	if ((addr | (addr + size - 1)) & ~mask)
> 		return 0;

Time for a well documented helper :)
