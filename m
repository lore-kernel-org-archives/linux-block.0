Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
To: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
 don.brace@microsemi.com
References: <1476521241-32765-1-git-send-email-hch@lst.de>
 <1476521241-32765-4-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <63e506d9-4539-431c-96b9-07b06e1ef3e6@suse.de>
Date: Sat, 15 Oct 2016 13:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <1476521241-32765-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/15/2016 10:47 AM, Christoph Hellwig wrote:
> Which cleans up a lot of the MSI-X handling, and allows us to use the
> PCI IRQ layer provided vector mapping, which we can then expose to blk-mq.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/smartpqi/smartpqi.h      |   2 -
>  drivers/scsi/smartpqi/smartpqi_init.c | 102 +++++++++++-----------------------
>  2 files changed, 32 insertions(+), 72 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
