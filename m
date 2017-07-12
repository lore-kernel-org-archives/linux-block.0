Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753037AbdGLQZR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 12:25:17 -0400
Date: Wed, 12 Jul 2017 09:25:14 -0700
From: Shaohua Li <shli@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org, axboe@fb.com
Subject: Re: [PATCH V2] block: call bio_uninit in bio_endio
Message-ID: <20170712162514.engryyya3eranpk2@kernel.org>
References: <d0186f22982fb49e88bd5ee2273ba90946318ba5.1499711846.git.shli@fb.com>
 <20170712072517.GA5788@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712072517.GA5788@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 12, 2017 at 09:25:17AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2017 at 11:40:17AM -0700, Shaohua Li wrote:
> > bio_free isn't a good place to free cgroup info. There are a
> > lot of cases bio is allocated in special way (for example, in stack) and
> > never gets called by bio_put hence bio_free, we are leaking memory. This
> > patch moves the free to bio endio, which should be called anyway. The
> > bio_uninit call in bio_free is kept, in case the bio never gets called
> > bio endio.
> > 
> > This assumes ->bi_end_io() doesn't access cgroup info, which seems true
> > in my audit.
> > 
> > This along with Christoph's integrity patch should fix the memory leak
> > issue.
> 
> Can we please go ahead and:
> 
>  (a) remove the now unneeded call in __blkdev_direct_IO_simple
>  (b) kill bio_uninit - it's just a wrapper around bio_disassociate_task
>  (c) check if we can remove the call in bio_free, which I think we can
>      as bi_ioc and bi_css are only assigned from generic_make_request

Sure, will do these soon.
