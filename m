Return-Path: <hare@suse.de>
Subject: Re: [PATCH 11/16] blk-mq: improve plug list sorting
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-12-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <eff592b4-df3b-d4df-261c-30acb77ffcf0@suse.de>
Date: Thu, 1 Nov 2018 10:30:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-12-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 7:32 PM, Jens Axboe wrote:
> Currently we only look at the software queue, but with support
> for multiple maps, we should also look at the hardware queue.
> This is important since we'll flush out the request list if
> either the software queue or hardware queue don't match.
> 
> This sorts by software queue first, then hardware queue if
> that differs. Finally we sort by request location like before.
> This minimizes the flush points per plug list.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
