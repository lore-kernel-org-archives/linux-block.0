Return-Path: <hare@suse.de>
Subject: Re: [PATCH 12/28] bsg: provide bsg_remove_queue() helper
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-13-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ff3cea21-b4c3-c96a-1730-4dcf0f6736d4@suse.de>
Date: Mon, 29 Oct 2018 07:55:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-13-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> All drivers do unregister + cleanup, provide a helper for that.
> 
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c                     | 7 +++++++
>   drivers/scsi/scsi_transport_fc.c    | 6 ++----
>   drivers/scsi/scsi_transport_iscsi.c | 7 +++----
>   drivers/scsi/scsi_transport_sas.c   | 6 ++----
>   include/linux/bsg-lib.h             | 1 +
>   5 files changed, 15 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
