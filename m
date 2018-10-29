Return-Path: <hare@suse.de>
Subject: Re: [PATCH 12/14] nvme: utilize two queue maps, one for reads and one
 for writes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-13-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <114c24f8-75df-396c-8e85-a7174d400362@suse.de>
Date: Mon, 29 Oct 2018 08:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-13-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> NVMe does round-robin between queues by default, which means that
> sharing a queue map for both reads and writes can be problematic
> in terms of read servicing. It's much easier to flood the queue
> with writes and reduce the read servicing.
> 
> Implement two queue maps, one for reads and one for writes. The
> write queue count is configurable through the 'write_queues'
> parameter.
> 
> By default, we retain the previous behavior of having a single
> queue set, shared between reads and writes. Setting 'write_queues'
> to a non-zero value will create two queue sets, one for reads and
> one for writes, the latter using the configurable number of
> queues (hardware queue counts permitting).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 139 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 131 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
