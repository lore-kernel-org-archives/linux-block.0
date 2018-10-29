Return-Path: <hare@suse.de>
Subject: Re: [PATCH 14/29] bsg: convert to use blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-15-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <084921c9-1d15-ec9c-f57b-9e94cd7e8819@suse.de>
Date: Mon, 29 Oct 2018 17:59:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-15-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> Requires a few changes to the FC transport class as well.
> 
> Cc: linux-scsi@vger.kernel.org
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Tested-by: Benjamin Block <bblock@linux.vnet.ibm.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c                  | 123 +++++++++++++++++++------------
>   drivers/scsi/scsi_transport_fc.c |  59 +++++++++------
>   2 files changed, 110 insertions(+), 72 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
