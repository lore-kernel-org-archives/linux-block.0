Return-Path: <hare@suse.de>
Subject: Re: [PATCH 21/28] block: remove __blk_put_request()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-22-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ac92ae82-606c-2ceb-bdfd-bcbcdc8e7c42@suse.de>
Date: Mon, 29 Oct 2018 08:03:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-22-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Now there's no difference between blk_put_request() and
> __blk_put_request() anymore, get rid of the underscore version and
> convert the few callers.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c                   | 9 ---------
>   block/blk-merge.c                  | 2 +-
>   drivers/scsi/osd/osd_initiator.c   | 4 ++--
>   drivers/scsi/osst.c                | 2 +-
>   drivers/scsi/scsi_error.c          | 2 +-
>   drivers/scsi/sg.c                  | 2 +-
>   drivers/scsi/st.c                  | 2 +-
>   drivers/target/target_core_pscsi.c | 2 +-
>   include/linux/blkdev.h             | 1 -
>   9 files changed, 8 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
