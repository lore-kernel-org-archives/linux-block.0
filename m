Return-Path: <hare@suse.de>
Subject: Re: [PATCH 13/28] bsg: convert to use blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-14-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <716ee118-93e4-c961-3ebb-294f13cc9ae7@suse.de>
Date: Mon, 29 Oct 2018 07:57:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Requires a few changes to the FC transport class as well.
> 
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c                  | 123 +++++++++++++++++++------------
>   drivers/scsi/scsi_transport_fc.c |  59 +++++++++------
>   2 files changed, 110 insertions(+), 72 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
