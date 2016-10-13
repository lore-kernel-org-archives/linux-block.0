Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 14/16] block: add bsg_job_put() and bsg_job_get()
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <18a915378ba11b84faa85341beb57df3f5976b64.1476276823.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ded0fa07-42b8-e05a-fd8f-d05af8b8d704@suse.de>
Date: Thu, 13 Oct 2016 13:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <18a915378ba11b84faa85341beb57df3f5976b64.1476276823.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/12/2016 03:06 PM, Johannes Thumshirn wrote:
> Add bsg_job_put() and bsg_job_get() so don't need to export
> bsg_destroy_job() any more.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bsg-lib.c                  | 17 ++++++++++++++---
>  drivers/scsi/scsi_transport_fc.c |  4 ++--
>  include/linux/bsg-lib.h          |  3 ++-
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
