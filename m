Return-Path: <jthumshirn@suse.de>
Date: Wed, 20 Sep 2017 10:36:43 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: track shared namespaces
Message-ID: <20170920083643.xe6dbr4iu53hhm5t@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170918231453.27128-9-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 04:14:52PM -0700, Christoph Hellwig wrote:
> Introduce a new struct nvme_ns_head [1] that holds information about
> an actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there
> is a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
> 
> [1] comments welcome if you have a better name for it, the current one is
>     horrible.  One idea would be to rename the current struct nvme_ns
>     to struct nvme_ns_link or similar and use the nvme_ns name for the
>     new structure.  But that would involve a lot of churn.

Being one of the persons who has to backport a lot of NVMe code to older
kernels I'm not a huge fan of renaming nmve_ns.

That said, I don't have a better name for nvme_ns_head (yet) but I'll try to
think of one as well. OTOH looking at nvme_ns_head it actaully is the list
head of the nvme_ns list.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
