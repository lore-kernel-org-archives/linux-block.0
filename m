Return-Path: <ming.lei@redhat.com>
Date: Tue, 4 Jul 2017 16:12:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 0/8] correct quiescing in several block drivers
Message-ID: <20170704081244.GB29053@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:04AM +0300, Sagi Grimberg wrote:
> Before we either iterate on tags or cleanup the request queue
> we must guarantee that the hw queues are stop and no inflight
> .queue_rq is active. Thats what blk_mq_quiesce_queue is for, so
> use it where appropriate.

queue freezing is used in cleanup path, and not required to
quiesce queue.

quiesce is required for canceling request via blk_mq_tagset_busy_iter()
for avoiding double release.

I think we should make it clear in comment log.

> 
> Sagi Grimberg (8):
>   nvme-rdma: quiesce/unquiesce admin_q instead of start/stop its hw
>     queues
>   nvme-fc: quiesce/unquiesce admin_q instead of start/stop its hw queues
>   nvme-loop: quiesce/unquiesce admin_q instead of start/stop its hw
>     queues
>   nvme-pci: quiesce/unquiesce admin_q instead of start/stop its hw
>     queues
>   nbd: quiesce request queues to make sure no submissions are inflight
>   mtip32xx: quiesce request queues to make sure no submissions are
>     inflight
>   virtio_blk: quiesce/unquiesce live IO when entering PM states
>   xen-blockfront: quiesce IO before device removal
> 
>  drivers/block/mtip32xx/mtip32xx.c |  8 ++++----
>  drivers/block/nbd.c               |  4 ++--
>  drivers/block/virtio_blk.c        |  4 ++--
>  drivers/block/xen-blkfront.c      |  8 ++++----
>  drivers/nvme/host/fc.c            |  8 +++++---
>  drivers/nvme/host/pci.c           | 10 ++++++----
>  drivers/nvme/host/rdma.c          |  7 ++++---
>  drivers/nvme/target/loop.c        |  2 +-
>  8 files changed, 28 insertions(+), 23 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Ming
