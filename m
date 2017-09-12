Return-Path: <ming.lei@redhat.com>
Date: Wed, 13 Sep 2017 00:25:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/5] block: Make SCSI device suspend work reliably
Message-ID: <20170912162513.GC21349@ming.t460p>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908235226.26622-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 04:52:25PM -0700, Bart Van Assche wrote:
> Instead of allowing request allocation to succeed for suspended
> request queues and only to process power management requests, make
> blk_get_request() wait until the request queue is resumed for
> requests that are not power management requests.
> 
> This patch avoids that resume does not occur if the maximum queue
> depth is reached when a power management request is submitted.
> 
> Note: this patch affects the behavior of scsi_device_quiesce() only
> if that function is called from inside a power management callback.
> This patch does not affect the behavior of scsi_device_quiesce()
> when a call of that function is triggered by writing "quiesce" into
> /sys/class/scsi_device/*/device/state.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c       | 60 +++++++++++++++++++++++++++-----------------------
>  block/blk.h            | 12 ++++++++++
>  include/linux/blkdev.h |  1 +
>  3 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bb53c6b58e8c..cd2700c763ed 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1325,6 +1325,24 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +#ifdef CONFIG_PM
> +static bool blk_wait_until_active(struct request_queue *q, bool wait)
> +	__releases(q->queue_lock)
> +	__acquires(q->queue_lock)
> +{
> +	if (wait)
> +		wait_event_lock_irq(q->rpm_active_wq,
> +				    q->rpm_status == RPM_ACTIVE,
> +				    *q->queue_lock);
> +	return q->rpm_status == RPM_ACTIVE;

If runtime PM is disabled via /sys/.../power/control, q->rpm_status
can be always ACTIVE, even during system suspend, then you can't
prevent any new request allocation at that time.


-- 
Ming
