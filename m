Return-Path: <hch@lst.de>
Date: Thu, 21 Sep 2017 16:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: track shared namespaces
Message-ID: <20170921143748.GB18424@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-9-hch@lst.de> <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site> <20170920145436.GA4709@lst.de> <20170921052217.kmrcmsf4gttubsyd@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170921052217.kmrcmsf4gttubsyd@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 07:22:17AM +0200, Johannes Thumshirn wrote:
> > But head also has connotations in the SAN world.  Maybe nvme_ns_chain?
> 
> I know that's why I didn't really like it all too much in the first place as
> well. For nvme_ns_chain, it's not a chain really (the list itself is a chain,
> the structure really is the list head...), but I suck at naming things so.

Well, it _is_ the structure for the namespace, and that's the fundamental
problem here given that we use that name for something else at the
moment.

We could hav nvme_namespace and nvme_ns, but I'm not sure that this
helps clarity..
