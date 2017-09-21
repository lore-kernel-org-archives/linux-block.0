Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Sep 2017 11:16:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: track shared namespaces
Message-ID: <20170921151631.GA10713@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-9-hch@lst.de>
 <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
 <20170920145436.GA4709@lst.de>
 <20170921052217.kmrcmsf4gttubsyd@linux-x5ow.site>
 <20170921143748.GB18424@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170921143748.GB18424@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 04:37:48PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 21, 2017 at 07:22:17AM +0200, Johannes Thumshirn wrote:
> > > But head also has connotations in the SAN world.  Maybe nvme_ns_chain?
> > 
> > I know that's why I didn't really like it all too much in the first place as
> > well. For nvme_ns_chain, it's not a chain really (the list itself is a chain,
> > the structure really is the list head...), but I suck at naming things so.
> 
> Well, it _is_ the structure for the namespace, and that's the fundamental
> problem here given that we use that name for something else at the
> moment.
> 
> We could hav nvme_namespace and nvme_ns, but I'm not sure that this
> helps clarity..

If there weren't resistence to renaming structs, it would be more
aligned to how the specification calls these if we rename nvme_ns to
nvme_ns_path, and what you're calling nvme_ns_head is should just be
the nvme_ns.
