Return-Path: <hare@suse.de>
Subject: Re: [PATCH 01/14] libata: remove ata_scsi_timed_out
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9d8fcd75-0d87-f929-0ffd-3ab391a11a75@suse.de>
Date: Wed, 23 May 2018 15:21:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> As far as I can tell this function can't even be called any more, given
> that ATA implements its own eh_strategy_handler with ata_scsi_error, which
> never calls ->eh_timed_out.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/ata/libata-eh.c | 51 -----------------------------------------
>   include/linux/libata.h  |  2 --
>   2 files changed, 53 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
