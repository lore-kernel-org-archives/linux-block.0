Return-Path: <ming.lei@redhat.com>
Date: Wed, 24 Jan 2018 11:49:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Eryu Guan <eguan@redhat.com>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] blk-mq-debugfs: don't allow write on attributes with
 seq_operations set
Message-ID: <20180124034925.GA16074@ming.t460p>
References: <20180123172000.20919-1-eguan@redhat.com>
 <9b37df1b-6a3e-2d24-f1f3-de34d8c690d9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b37df1b-6a3e-2d24-f1f3-de34d8c690d9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 23, 2018 at 02:32:06PM -0700, Jens Axboe wrote:
> On 1/23/18 10:20 AM, Eryu Guan wrote:
> > Attributes that only implement .seq_ops are read-only, any write to
> > them should be rejected. But currently kernel would crash when
> > writing to such debugfs entries, e.g.
> > 
> > chmod +w /sys/kernel/debug/block/<dev>/requeue_list
> > echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
> > chmod -w /sys/kernel/debug/block/<dev>/requeue_list
> > 
> > Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
> > such attributes.
> 
> I don't particularly like the fix, since it's not really clear why
> that comparison makes sense. Can't we just prevent anyone from

It might be the simplest way to check if the attribute defines .seq_ops
or not. If it is .seq_ops, it is wrong to interpret m->private as
'struct blk_mq_debugfs_attr *' because it actually points to 'struct
request_queue *' or others, which depends on the specific attribute.

So it works for avoiding the oops.

> making the debugfs entries writable? Seems like a much more sane
> approach.

I guess fs should allow root user to do 'chmod +w' on files in proc,
debugfs or sysfs. I just tried, it works on proc, debugfs and sysfs.


Thanks,
Ming
