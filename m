Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 15 Apr 2018 10:31:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for
 plug and unplug events
Message-ID: <20180415083154.GA12254@kroah.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
 <20180413130719.22921-3-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180413130719.22921-3-maier@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 13, 2018 at 03:07:18PM +0200, Steffen Maier wrote:
> Complements v2.6.31 commit 55782138e47d ("tracing/events: convert block
> trace points to TRACE_EVENT()") to be equivalent to traditional blktrace
> output. Also this allows event filtering to not always get all (un)plug
> events.
> 
> NB: The NULL pointer check for q->kobj.parent is certainly racy and
> I don't have enough experience if it's good enough for a trace event.
> The change did work for my cases (block device read/write I/O on
> zfcp-attached SCSI disks and dm-mpath on top).
> 
> While I haven't seen any prior art using driver core (parent) relations
> for trace events, there are other cases using this when no direct pointer
> exists between objects, such as:
>  #define to_scsi_target(d)	container_of(d, struct scsi_target, dev)
>  static inline struct scsi_target *scsi_target(struct scsi_device *sdev)
>  {
> 	return to_scsi_target(sdev->sdev_gendev.parent);
>  }

That is because you "know" the parent of a target device is a
scsi_target.

> This is the object model we make use of here:
> 
> struct gendisk {
>         struct hd_struct {
>                 struct device {      /*container_of*/
>                         struct kobject kobj; <--+
>                         dev_t  devt; /*deref*/  |
>                 } __dev;                        |
>         } part0;                                |
>         struct request_queue *queue; ..+        |
> }                                      :        |
>                                        :        |
> struct request_queue {  <..............+        |
>         /* queue kobject */                     |
>         struct kobject {                        |
>                 struct kobject *parent; --------+

Are you sure about this?

>         } kobj;
> }
> 
> The parent pointer comes from:
>  #define disk_to_dev(disk)	(&(disk)->part0.__dev)
> int blk_register_queue(struct gendisk *disk)
> 	struct device *dev = disk_to_dev(disk);
> 	struct request_queue *q = disk->queue;
> 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
> 	                            ^^^parent
> 
> $ ls -d /sys/block/sdf/queue
> /sys/block/sda/queue
> $ cat /sys/block/sdf/dev
> 80:0
> 
> A partition does not have its own request queue:
> 
> $ cat /sys/block/sdf/sdf1/dev
> 8:81
> $ ls -d /sys/block/sdf/sdf1/queue
> ls: cannot access '/sys/block/sdf/sdf1/queue': No such file or directory
> 
> The difference to blktrace parsed output is that block events don't use the
> partition's minor number but the containing block device's minor number:

Why do you want the block device's minor number here?  What is wrong
with the partition's minor number?  I would think you want that instead.

> 
> $ dd if=/dev/sdf1 count=1
> 
> $ cat /sys/kernel/debug/tracing/trace
> block_bio_remap: 8,80 R 2048 + 32 <- (8,81) 0
> block_bio_queue: 8,80 R 2048 + 32 [dd]
> block_getrq: 8,80 R 2048 + 32 [dd]
> block_plug: 8,80 [dd]
>             ^^^^
> block_rq_insert: 8,80 R 16384 () 2048 + 32 [dd]
> block_unplug: 8,80 [dd] 1 explicit
>               ^^^^
> block_rq_issue: 8,80 R 16384 () 2048 + 32 [dd]
> block_rq_complete: 8,80 R () 2048 + 32 [0]
> 
> $ btrace /dev/sdf1
>   8,80   1        1     0.000000000 240240  A   R 2048 + 32 <- (8,81) 0
>   8,81   1        2     0.000220890 240240  Q   R 2048 + 32 [dd]
>   8,81   1        3     0.000229639 240240  G   R 2048 + 32 [dd]
>   8,81   1        4     0.000231805 240240  P   N [dd]
>     ^^
>   8,81   1        5     0.000234671 240240  I   R 2048 + 32 [dd]
>   8,81   1        6     0.000236365 240240  U   N [dd] 1
>     ^^
>   8,81   1        7     0.000238527 240240  D   R 2048 + 32 [dd]
>   8,81   2        2     0.000613741     0  C   R 2048 + 32 [0]
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>  include/trace/events/block.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index a13613d27cee..cffedc26e8a3 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -460,14 +460,18 @@ TRACE_EVENT(block_plug,
>  	TP_ARGS(q),
>  
>  	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
>  		__array( char,		comm,	TASK_COMM_LEN	)
>  	),
>  
>  	TP_fast_assign(
> +		__entry->dev = q->kobj.parent ?
> +		container_of(q->kobj.parent, struct device, kobj)->devt : 0;

That really really really scares me.  It feels very fragile and messing
with parent pointers is ripe for things breaking in the future in odd
and unexplainable ways.

And how can the parent be NULL?

>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>  	),
>  
> -	TP_printk("[%s]", __entry->comm)
> +	TP_printk("%d,%d [%s]",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->comm)
>  );
>  
>  #define show_block_unplug_explicit(val)		\
> @@ -482,18 +486,23 @@ DECLARE_EVENT_CLASS(block_unplug,
>  	TP_ARGS(q, depth, explicit),
>  
>  	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
>  		__field( int,		nr_rq			)
>  		__field( bool,		explicit		)
>  		__array( char,		comm,	TASK_COMM_LEN	)
>  	),
>  
>  	TP_fast_assign(
> +		__entry->dev   = q->kobj.parent ?
> +		container_of(q->kobj.parent, struct device, kobj)->devt : 0;

Again, how can the parent be null?

>  		__entry->nr_rq = depth;
>  		__entry->explicit = explicit;
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>  	),
>  
> -	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
> +	TP_printk("%d,%d [%s] %d %s",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),

I don't know the block layer but this feels very wrong to me.  Are you
sure there isn't some other way to get this info?

thanks,

greg k-h
