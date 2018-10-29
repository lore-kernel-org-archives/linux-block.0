Return-Path: <hare@suse.de>
Subject: Re: [PATCH 11/28] bsg: pass in desired timeout handler
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-12-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fb56ccc0-9b5e-b474-8a72-1ea65e389993@suse.de>
Date: Mon, 29 Oct 2018 07:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-12-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> This will ease in the conversion to blk-mq, where we can't set
> a timeout handler after queue init.
> 
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c                     | 3 ++-
>   drivers/scsi/scsi_transport_fc.c    | 7 +++----
>   drivers/scsi/scsi_transport_iscsi.c | 2 +-
>   drivers/scsi/scsi_transport_sas.c   | 4 ++--
>   include/linux/bsg-lib.h             | 2 +-
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
