Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180622130054.oux3rlmcytua7tff@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1711249b-abad-7cb2-21b7-790061e4a495@kernel.dk>
Date: Fri, 22 Jun 2018 08:46:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180622130054.oux3rlmcytua7tff@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 7:00 AM, Christoph Hellwig wrote:
> Various relatively small fixes, mostly to fix error handling of various
> sorts.
> 
> 
> The following changes since commit 9c24c10a2c1e1bb478b6bb70612d9e885aee044f:
> 
>   Revert "block: Add warning for bi_next not NULL in bio_endio()" (2018-06-19 11:59:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.18
> 
> for you to fetch changes up to 943e942e6266f22babee5efeb00f8f672fbff5bd:
> 
>   nvme-pci: limit max IO size and segments to avoid high order allocations (2018-06-21 18:59:46 +0200)
> 
> ----------------------------------------------------------------
> Israel Rukshin (1):
>       nvme-rdma: Fix command completion race at error recovery
> 
> James Smart (1):
>       nvme-fc: release io queues to allow fast fail
> 
> Jens Axboe (1):
>       nvme-pci: limit max IO size and segments to avoid high order allocations
> 
> Jianchao Wang (1):
>       nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl
> 
> Max Gurtuvoy (1):
>       nvmet: reset keep alive timer in controller enable
> 
> Sagi Grimberg (3):
>       nvme-rdma: fix possible double free condition when failing to create a controller
>       nvme-rdma: fix possible free of a non-allocated async event buffer
>       nvme-rdma: don't override opts->queue_size
> 
>  drivers/nvme/host/core.c   |  1 +
>  drivers/nvme/host/fc.c     |  6 ++--
>  drivers/nvme/host/nvme.h   |  1 +
>  drivers/nvme/host/pci.c    | 44 ++++++++++++++++++++++++----
>  drivers/nvme/host/rdma.c   | 73 +++++++++++++++++++++++-----------------------
>  drivers/nvme/target/core.c |  8 +++++
>  6 files changed, 88 insertions(+), 45 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
