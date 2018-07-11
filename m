Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Wed, 11 Jul 2018 13:28:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>,  <linux-block@vger.kernel.org>,
    "Rafael J. Wysocki" <rjw@rjwysocki.net>,  <linux-pm@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
    "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>,
     <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC 4/4] scsi_mq: enable runtime PM
In-Reply-To: <20180711162906.14271-5-ming.lei@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1807111327110.1436-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 12 Jul 2018, Ming Lei wrote:

> Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
> core for enabling block runtime PM.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c        | 2 +-
>  drivers/scsi/scsi_lib.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bf66d561980d..9e47205366ab 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3770,7 +3770,7 @@ EXPORT_SYMBOL(blk_finish_plug);
>  void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  {
>  	/* not support for RQF_PM and ->rpm_status in blk-mq yet */

Shouldn't that comment be removed?

Alan Stern
