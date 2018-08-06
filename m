Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 01/10] block: Change the preempt-only flag into a
 counter
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Alan Stern <stern@rowland.harvard.edu>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
 <20180804000325.3610-2-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0903c42a-0943-ccd2-12f4-19bfc35a12f8@suse.de>
Date: Mon, 6 Aug 2018 08:25:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2018 02:03 AM, Bart Van Assche wrote:
> Rename "preempt-only" into "pm-only" because the primary purpose of
> this mode is power management. Since the power management core may
> but does not have to resume a runtime suspended device before
> performing system-wide suspend and since a later patch will set
> "pm-only" mode as long as a block device is runtime suspended, make
> it possible to set "pm-only" mode from more than one context.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  block/blk-core.c        | 35 ++++++++++++++++++-----------------
>  block/blk-mq-debugfs.c  | 10 +++++++++-
>  drivers/scsi/scsi_lib.c |  8 ++++----
>  include/linux/blkdev.h  | 14 +++++++++-----
>  4 files changed, 40 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
