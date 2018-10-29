Return-Path: <linux-ide-owner@vger.kernel.org>
Subject: Re: [PATCH 22/28] block: kill legacy parts of timeout handling
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-23-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <322b0ea0-4a1b-3941-d984-672fa4734728@suse.de>
Date: Mon, 29 Oct 2018 08:04:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-23-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> The only user of legacy timing now is BSG, which is invoked
> from the mq timeout handler. Kill the legacy code, and rename
> the q->rq_timed_out_fn to q->bsg_job_timeout_fn.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c       |  1 -
>   block/blk-settings.c   |  7 ---
>   block/blk-timeout.c    | 99 +++---------------------------------------
>   block/blk.h            |  1 -
>   block/bsg-lib.c        |  6 +--
>   include/linux/blkdev.h |  4 +-
>   6 files changed, 11 insertions(+), 107 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
