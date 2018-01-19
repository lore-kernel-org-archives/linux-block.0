Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] additional nvme fixes and cleanups for Linux 4.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180119190219.cdsqnoiwe77j2zhd@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <86c41fd7-bfa8-e6b8-d5f3-103c4c8418aa@kernel.dk>
Date: Fri, 19 Jan 2018 12:29:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180119190219.cdsqnoiwe77j2zhd@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/19/18 12:02 PM, Christoph Hellwig wrote:
> The following changes since commit bf9ae8c5325c0070d0ec81a849bba8d156f65993:
> 
>   blk-mq: fix bad clear of RQF_MQ_INFLIGHT in blk_mq_ct_ctx_init() (2018-01-14 10:46:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.16
> 
> for you to fetch changes up to 88de4598bca84e27b261685c06fff816b8d932a1:
> 
>   nvme-pci: clean up SMBSZ bit definitions (2018-01-17 17:55:14 +0100)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (2):
>       nvme-pci: clean up CMB initialization
>       nvme-pci: clean up SMBSZ bit definitions
> 
> James Smart (2):
>       nvme-fc: fix rogue admin cmds stalling teardown
>       nvme-fc: correct hang in nvme_ns_remove()
> 
> Minwoo Im (1):
>       nvme: fix comment typos in nvme_create_io_queues
> 
> Roland Dreier (1):
>       nvme-fabrics: fix memory leak when parsing host ID option
> 
> Roy Shterman (1):
>       nvme: host delete_work and reset_work on separate workqueues
> 
> Sagi Grimberg (3):
>       nvme-pci: serialize pci resets
>       nvme-pci: allocate device queues storage space at probe
>       nvmet: release a ns reference in nvmet_req_uninit if needed
> 
>  drivers/nvme/host/core.c    |  47 ++++++++++++++--
>  drivers/nvme/host/fabrics.c |   4 +-
>  drivers/nvme/host/fc.c      |   6 ++
>  drivers/nvme/host/nvme.h    |   3 +
>  drivers/nvme/host/pci.c     | 133 ++++++++++++++++++++------------------------
>  drivers/nvme/host/rdma.c    |   2 +-
>  drivers/nvme/target/core.c  |   3 +
>  drivers/nvme/target/loop.c  |   2 +-
>  include/linux/nvme.h        |  22 +++++---
>  9 files changed, 132 insertions(+), 90 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
