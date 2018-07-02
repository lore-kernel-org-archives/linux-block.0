Return-Path: <dgilbert@interlog.com>
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
To: Ming Lei <ming.lei@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
References: <20180702050642.26265-1-ming.lei@redhat.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <ca67f73e-8b6b-1581-f4d3-3bb676414fd5@interlog.com>
Date: Mon, 2 Jul 2018 22:28:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180702050642.26265-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 2018-07-02 07:06 AM, Ming Lei wrote:
> With the introduced module parameter of 'use_blk_mq', it is easy
> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
> module, so that we can test scsi_mq/blk_mq related regressions easily.
> 
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/scsi/scsi_debug.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 24d7496cd9e2..236cfb669df3 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -144,6 +144,7 @@ static const char *sdebug_version_date = "20180128";
>   #define DEF_SUBMIT_QUEUES 1
>   #define DEF_UUID_CTL 0
>   #define JDELAY_OVERRIDDEN -9999
> +#define DEF_USE_BLK_MQ  0
>   
>   #define SDEBUG_LUN_0_VAL 0
>   
> @@ -671,6 +672,7 @@ static bool sdebug_verbose;
>   static bool have_dif_prot;
>   static bool write_since_sync;
>   static bool sdebug_statistics = DEF_STATISTICS;
> +static bool sdebug_use_blk_mq = DEF_USE_BLK_MQ;
>   
>   static unsigned int sdebug_store_sectors;
>   static sector_t sdebug_capacity;	/* in sectors */
> @@ -4537,6 +4539,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
>   		   S_IRUGO | S_IWUSR);
>   module_param_named(write_same_length, sdebug_write_same_length, int,
>   		   S_IRUGO | S_IWUSR);
> +module_param_named(use_blk_mq, sdebug_use_blk_mq, bool, S_IRUGO | S_IWUSR);
>   
>   MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
>   MODULE_DESCRIPTION("SCSI debug adapter driver");
> @@ -5849,6 +5852,8 @@ static int sdebug_driver_probe(struct device *dev)
>   	sdebug_driver_template.can_queue = sdebug_max_queue;
>   	if (sdebug_clustering)
>   		sdebug_driver_template.use_clustering = ENABLE_CLUSTERING;
> +	if (sdebug_use_blk_mq)
> +		sdebug_driver_template.force_blk_mq = 1;
>   	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
>   	if (NULL == hpnt) {
>   		pr_err("scsi_host_alloc failed\n");
> 

Hi,
It is up to others whether this patch goes through. It seems the default
associated with blk_mq may soon change. So two things:
   - I'd like to see a MODULE_PARM_DESC(use_blk_mq, ...) entry in patch
   - perhaps a 3 valued use_blk_mq: 1 --> force blk_mq; 0 (def) --> accept
     default mq setting; -1 --> turn off mq (if possible, if not it's a
     NOP)

Doug Gilbert
