Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 09/16] block: add reference counting for struct bsg_job
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <d24033462e3d6e65459db163330a8186c7e14c0a.1476276823.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <562205dc-79ba-66f5-17ed-221559fb6a9a@suse.de>
Date: Thu, 13 Oct 2016 13:43:01 +0200
MIME-Version: 1.0
In-Reply-To: <d24033462e3d6e65459db163330a8186c7e14c0a.1476276823.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/12/2016 03:06 PM, Johannes Thumshirn wrote:
> Add reference counting to 'struct bsg_job' so we can implement a reuqest
> timeout handler for bsg_jobs, which is needed for Fibre Channel.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bsg-lib.c         | 7 +++++--
>  include/linux/bsg-lib.h | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
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
