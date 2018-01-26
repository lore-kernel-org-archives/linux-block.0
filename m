Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] additional nvme updates for 4.16
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180126180944.lrdh4dqwntz7pk27@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33a2c229-121c-0c8d-7052-6c9402b5e881@kernel.dk>
Date: Fri, 26 Jan 2018 13:24:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180126180944.lrdh4dqwntz7pk27@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/26/18 11:09 AM, Christoph Hellwig wrote:
> The additional week before the 4.15 release gave us time for a few more
> nvme fixes, as well as the nifty trace points from Johannes:
> 
> 
> The following changes since commit 475a055e62a1eb92f4358ad8a9059df973c190ac:
> 
>   blk-throttle: use queue_is_rq_based (2018-01-19 21:10:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.16
> 
> for you to fetch changes up to ca5554a696dce37852f6d6721520b4f13fc295c3:
> 
>   nvme: add tracepoint for nvme_complete_rq (2018-01-26 12:34:40 +0100)
> 
> ----------------------------------------------------------------
> Jianchao Wang (1):
>       nvme-pci: introduce RECONNECTING state to mark initializing procedure
> 
> Johannes Thumshirn (3):
>       nvme: don't free uuid pointer before printing it
>       nvme: add tracepoint for nvme_setup_cmd
>       nvme: add tracepoint for nvme_complete_rq
> 
> Keith Busch (2):
>       nvme-pci: Fix queue double allocations
>       nvme-pci: Suspend queues after deleting them
> 
> Max Gurtovoy (1):
>       nvme-rdma: remove redundant boolean for inline_data

Pulled, thanks.

-- 
Jens Axboe
