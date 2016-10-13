Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 11/16] scsi: fc: Use bsg_destroy_job
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <7c7473dfa0f74f7bdf442d5669a57204ecf812e4.1476276823.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e9d1c4be-f731-f2b1-d000-ebb0198a6dc6@suse.de>
Date: Thu, 13 Oct 2016 13:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <7c7473dfa0f74f7bdf442d5669a57204ecf812e4.1476276823.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/12/2016 03:06 PM, Johannes Thumshirn wrote:
> fc_destroy_bsgjob() and bsg_destroy_job() are now 1:1 copies, so use the
> later.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bsg-lib.c                  |  3 ++-
>  drivers/scsi/scsi_transport_fc.c | 20 ++------------------
>  include/linux/bsg-lib.h          |  1 +
>  3 files changed, 5 insertions(+), 19 deletions(-)
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
