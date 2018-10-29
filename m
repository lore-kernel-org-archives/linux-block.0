Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-11-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <874b06ae-528d-d44e-801b-0946ce2b2b87@suse.de>
Date: Mon, 29 Oct 2018 08:41:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-11-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Add a queue offset to the tag map. This enables users to map
> iteratively, for each queue map type they support.
> 
> Bump maximum number of supported maps to 2, we're now fully
> able to support more than 1 map.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-cpumap.c  | 9 +++++----
>   block/blk-mq-pci.c     | 2 +-
>   block/blk-mq-virtio.c  | 2 +-
>   include/linux/blk-mq.h | 3 ++-
>   4 files changed, 9 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
