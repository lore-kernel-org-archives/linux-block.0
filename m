Return-Path: <hare@suse.de>
Subject: Re: [PATCH 13/29] bsg: provide bsg_remove_queue() helper
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-14-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <daaf85a5-824d-222e-0ea6-13c7d448c435@suse.de>
Date: Mon, 29 Oct 2018 17:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> All drivers do unregister + cleanup, provide a helper for that.
> 
> Cc: linux-scsi@vger.kernel.org
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Benjamin Block <bblock@linux.vnet.ibm.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c                     | 9 +++++++++
>   drivers/scsi/scsi_transport_fc.c    | 5 +----
>   drivers/scsi/scsi_transport_iscsi.c | 5 +----
>   drivers/scsi/scsi_transport_sas.c   | 6 +-----
>   drivers/scsi/ufs/ufs_bsg.c          | 2 +-
>   include/linux/bsg-lib.h             | 1 +
>   6 files changed, 14 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
