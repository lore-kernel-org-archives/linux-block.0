Return-Path: <hare@suse.de>
Subject: Re: [PATCH 14/14] nvme: add separate poll queue map
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-15-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <024e93e5-a265-4e71-840f-6bd469f08bbc@suse.de>
Date: Mon, 29 Oct 2018 08:48:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-15-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Adds support for defining a variable number of poll queues, currently
> configurable with the 'poll_queues' module parameter. Defaults to
> a single poll queue.
> 
> And now we finally have poll support without triggering interrupts!
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 103 +++++++++++++++++++++++++++++++++-------
>   include/linux/blk-mq.h  |   2 +-
>   2 files changed, 88 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
