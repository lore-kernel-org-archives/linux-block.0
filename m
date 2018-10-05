Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for 4.20
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20181005134104.GA11359@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5d89dba-8926-1a89-bb8e-d244c425b443@kernel.dk>
Date: Fri, 5 Oct 2018 08:16:07 -0600
MIME-Version: 1.0
In-Reply-To: <20181005134104.GA11359@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/5/18 7:41 AM, Christoph Hellwig wrote:
> A relatively boring merge window:
> 
>  - better AEN tracing (Chaitanya)
>  - NUMA aware PCIe multipathing (me)
>  - RDMA workqueue fixes (Sagi)
>  - better bio usage in the target (Sagi)
>  - FC rework for target removal (James)
>  - better multipath handling of ->queue_rq failures (James)
>  - various cleanups (Milan)
> 
> The following changes since commit c0aac682fa6590cb660cb083dbc09f55e799d2d2:
> 
>   Merge tag 'v4.19-rc6' into for-4.20/block (2018-10-01 08:58:57 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to 2acf70ade79d26b97611a8df52eb22aa33814cd4:
> 
>   nvmet-rdma: use a private workqueue for delete (2018-10-05 09:25:18 +0200)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (2):
>       nvmet: remove redundant module prefix
>       nvme-core: add async event trace helper
> 
> Christoph Hellwig (1):
>       nvme: take node locality into account when selecting a path
> 
> James Smart (3):
>       nvmet_fc: support target port removal with nvmet layer
>       nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
>       nvme: call nvme_complete_rq when nvmf_check_ready fails for mpath I/O
> 
> Milan P. Gandhi (2):
>       nvme: fix typo in nvme_identify_ns_descs
>       nvme-fc: fix for a minor typos
> 
> Sagi Grimberg (2):
>       nvmet: don't split large I/Os unconditionally
>       nvmet-rdma: use a private workqueue for delete
> 
>  drivers/nvme/host/core.c          |  20 ++++--
>  drivers/nvme/host/fabrics.c       |   7 +-
>  drivers/nvme/host/fc.c            | 108 +++++++++++++++++++++++++++----
>  drivers/nvme/host/multipath.c     |  57 +++++++++++++----
>  drivers/nvme/host/nvme.h          |  25 +++-----
>  drivers/nvme/host/trace.h         |  28 ++++++++
>  drivers/nvme/target/admin-cmd.c   |   2 +-
>  drivers/nvme/target/fc.c          | 130 +++++++++++++++++++++++++++++++++++---
>  drivers/nvme/target/io-cmd-bdev.c |   9 ++-
>  drivers/nvme/target/nvmet.h       |   1 +
>  drivers/nvme/target/rdma.c        |  19 ++++--
>  include/linux/nvme.h              |   1 +
>  12 files changed, 347 insertions(+), 60 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
