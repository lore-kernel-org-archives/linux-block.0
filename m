Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/16] blk-mq: cleanup and improve list insertion
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-11-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <579cc1b0-0147-d5b9-a507-85b56c2e0546@suse.de>
Date: Thu, 1 Nov 2018 10:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-11-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 7:32 PM, Jens Axboe wrote:
> It's somewhat strange to have a list insertion function that
> relies on the fact that the caller has mapped things correctly.
> Pass in the hardware queue directly for insertion, which makes
> for a much cleaner interface and implementation.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-sched.c |  8 +-------
>   block/blk-mq-sched.h |  2 +-
>   block/blk-mq.c       | 25 ++++++++++++++-----------
>   3 files changed, 16 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
