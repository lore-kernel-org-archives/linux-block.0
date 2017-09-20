Return-Path: <hch@lst.de>
Date: Wed, 20 Sep 2017 16:54:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: track shared namespaces
Message-ID: <20170920145436.GA4709@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-9-hch@lst.de> <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 20, 2017 at 10:36:43AM +0200, Johannes Thumshirn wrote:
> Being one of the persons who has to backport a lot of NVMe code to older
> kernels I'm not a huge fan of renaming nmve_ns.

The churn is main main worry.  Well and that I don't have a reall good
name for what currently is nvme_ns either :)

> That said, I don't have a better name for nvme_ns_head (yet) but I'll try to
> think of one as well. OTOH looking at nvme_ns_head it actaully is the list
> head of the nvme_ns list.

But head also has connotations in the SAN world.  Maybe nvme_ns_chain?
