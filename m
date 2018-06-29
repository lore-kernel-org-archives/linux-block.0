Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fix for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180629124040.GA3573@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc579ed6-2aee-7d3a-96e0-a6f7728da45c@kernel.dk>
Date: Fri, 29 Jun 2018 07:56:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180629124040.GA3573@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/29/18 6:40 AM, Christoph Hellwig wrote:
> The following changes since commit 15bfd21fbc5d35834b9ea383dc458a1f0c9e3434:
> 
>   block: Fix transfer when chunk sectors exceeds max (2018-06-26 12:18:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.18
> 
> for you to fetch changes up to 682630f00a219a1b0696abe9c0967e660068187b:
> 
>   nvme-rdma: fix possible double free of controller async event buffer (2018-06-28 16:29:54 +0200)
> 
> ----------------------------------------------------------------
> Sagi Grimberg (1):
>       nvme-rdma: fix possible double free of controller async event buffer
> 
>  drivers/nvme/host/rdma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
