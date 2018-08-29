Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.19
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180829165114.GA15464@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e138fcde-5279-7440-1552-921a04096c80@kernel.dk>
Date: Wed, 29 Aug 2018 11:05:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180829165114.GA15464@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/29/18 10:51 AM, Christoph Hellwig wrote:
> The following changes since commit db193954ed9e35701b6e489fa4cc97b08589341b:
> 
>   block: bsg: move atomic_t ref_count variable to refcount API (2018-08-27 19:17:02 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.19
> 
> for you to fetch changes up to 04db0e5ec58167364a80fd33ddb4f3b67434eb85:
> 
>   nvmet: free workqueue object if module init fails (2018-08-28 08:40:44 +0200)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (1):
>       nvmet: free workqueue object if module init fails
> 
> James Smart (1):
>       nvme-fcloop: Fix dropped LS's to removed target port
> 
> Michal Wnukowski (1):
>       nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event
> 
>  drivers/nvme/host/pci.c      | 8 ++++++++
>  drivers/nvme/target/core.c   | 4 +++-
>  drivers/nvme/target/fcloop.c | 3 ++-
>  3 files changed, 13 insertions(+), 2 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
