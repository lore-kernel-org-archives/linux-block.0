Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its original
 meaning
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
 <20180804000325.3610-3-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4a329d4c-8b11-be8f-28f7-88839a6f9b66@suse.de>
Date: Mon, 6 Aug 2018 08:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2018 02:03 AM, Bart Van Assche wrote:
> In kernel v2.6.18 RQF_PREEMPT was only set for IDE preempt requests.
> Later on the SCSI core was modified such that RQF_PREEMPT requests
> was set for all requests submitted by __scsi_execute(), including
> power management requests. RQF_PREEMPT requests are the only requests
> processed in the SDEV_QUIESCE state. Instead of setting RQF_PREEMPT
> for all requests submitted by __scsi_execute(), only set RQF_PM for
> power management requests. Modify blk_get_request() such that it
> blocks in pm-only mode on non-RQF_PM requests. Leave the code out
> from scsi_prep_state_check() that is no longer reachable.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c        |  9 +++++----
>  drivers/scsi/scsi_lib.c | 28 ++++++++++++----------------
>  include/linux/blk-mq.h  |  2 ++
>  include/linux/blkdev.h  |  6 ++----
>  4 files changed, 21 insertions(+), 24 deletions(-)
> 
I am not sure this is going to work for SCSI parallel; we're using the
QUIESCE state there to do domain validation, and all commands there are
most definitely not PM requests.
Can you please validate your patches with eg aic7xxx and SCSI parallel
disks?

Thanks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
