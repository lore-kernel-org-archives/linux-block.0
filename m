Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for 4.13-rc3
To: Christoph Hellwig <hch@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170727133011.2vyqepblk2oboit4@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9cce2bc0-85a9-e3bf-0bee-41e17a5906e3@kernel.dk>
Date: Thu, 27 Jul 2017 08:09:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170727133011.2vyqepblk2oboit4@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/27/2017 07:30 AM, Christoph Hellwig wrote:
> Just a couple small fixes all over.
> 
> The following changes since commit 76451d79bde6bed17e113f057e58e1fa5fb79e78:
> 
>   blk-mq: map queues to all present CPUs (2017-07-24 10:01:31 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.13
> 
> for you to fetch changes up to 7dd1ab163c17e11473a65b11f7e748db30618ebb:
> 
>   nvme: validate admin queue before unquiesce (2017-07-26 17:41:41 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme-pci: fix HMB size calculation
> 
> James Smart (2):
>       nvme-fc: address target disconnect race conditions in fcp io submit
>       nvme-fc: revise TRADDR parsing
> 
> Johannes Thumshirn (1):
>       nvme: also provide a UUID in the WWID sysfs attribute
> 
> Jon Derrick (1):
>       nvme: fabrics commands should use the fctype field for data direction
> 
> Scott Bauer (1):
>       nvme: validate admin queue before unquiesce

Pulled, thanks.

-- 
Jens Axboe
