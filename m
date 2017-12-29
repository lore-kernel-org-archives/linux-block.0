Return-Path: <keith.busch@intel.com>
Date: Fri, 29 Dec 2017 08:39:50 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
Message-ID: <20171229153950.GB16407@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
 <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
 <20171229094814.GC24043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229094814.GC24043@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 29, 2017 at 10:48:14AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 27, 2017 at 11:01:48PM +0200, Sagi Grimberg wrote:
> >
> >> Awesome!
> >>
> >> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> >
> > Wait, aren't we unquiesce queues also in nvme_dev_disable?
> >
> > Doesn't that rely that the queues are suspended and queue_rq
> > will fail there?
> 
> We don't seem to have any other check as far as I can tell.

Ok, we currently do need this check in the submission side to flush
entered requests on invalidated hw contexts. We didn't have a way to
back out entered requests before, so that's why this request killing
check still exists. We can steal bio's to back out requests now, so I
think we should do that instead of failing them.

I'll do rework the series a bit to make that possible, plus add the
removal of the submission side nvme_process_cq, and resend.
