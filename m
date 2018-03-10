Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44809 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeCJKKm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Mar 2018 05:10:42 -0500
Date: Sat, 10 Mar 2018 11:10:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V4 3/4] scsi: introduce force_blk_mq
Message-ID: <20180310101041.GB32022@lst.de>
References: <20180309033218.23042-1-ming.lei@redhat.com> <20180309033218.23042-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180309033218.23042-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 09, 2018 at 11:32:17AM +0800, Ming Lei wrote:
> >From scsi driver view, it is a bit troublesome to support both blk-mq
> and non-blk-mq at the same time, especially when drivers need to support
> multi hw-queue.
> 
> This patch introduces 'force_blk_mq' to scsi_host_template so that drivers
> can provide blk-mq only support, so driver code can avoid the trouble
> for supporting both.
> 
> Cc: Omar Sandoval <osandov@fb.com>,
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/hosts.c     | 1 +
>  include/scsi/scsi_host.h | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 57bf43e34863..10f04b089392 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -477,6 +477,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  		shost->dma_boundary = 0xffffffff;
>  
>  	shost->use_blk_mq = scsi_use_blk_mq;
> +	shost->use_blk_mq = scsi_use_blk_mq || !!shost->hostt->force_blk_mq;

No need for the !! here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
