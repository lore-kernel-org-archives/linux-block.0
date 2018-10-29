Return-Path: <hare@suse.de>
Subject: Re: [PATCH 13/14] block: add REQ_HIPRI and inherit it from IOCB_HIPRI
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-14-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2de26aaa-19f2-f3d2-f8f8-2be33c82b4da@suse.de>
Date: Mon, 29 Oct 2018 08:47:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> We use IOCB_HIPRI to poll for IO in the caller instead of scheduling.
> This information is not available for (or after) IO submission. The
> driver may make different queue choices based on the type of IO, so
> make the fact that we will poll for this IO known to the lower layers
> as well.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/block_dev.c            | 2 ++
>   fs/direct-io.c            | 2 ++
>   fs/iomap.c                | 9 ++++++++-
>   include/linux/blk_types.h | 4 +++-
>   4 files changed, 15 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
