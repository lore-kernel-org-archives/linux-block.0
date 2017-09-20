Return-Path: <jthumshirn@suse.de>
Date: Wed, 20 Sep 2017 11:42:33 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170920094232.fxzar6op4v3d3ezl@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170918231453.27128-10-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 04:14:53PM -0700, Christoph Hellwig wrote:
> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
                                    no ^
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.

Sorry for the typo only mail, I'll be going around a real review soon but I
wanted to test the patchset in my nvme-rdma setup and just hit a panic in
ib_core with your branched merged into -rc1.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
