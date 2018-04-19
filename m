Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 19 Apr 2018 12:24:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Steffen Maier <maier@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Li Zefan <lizf@cn.fujitsu.com>, Li Zefan <lizefan@huawei.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for
 plug and unplug events
Message-ID: <20180419192341.GC20941@vader>
References: <20180413130719.22921-1-maier@linux.ibm.com>
 <20180413130719.22921-3-maier@linux.ibm.com>
 <20180415083154.GA12254@kroah.com>
 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 16, 2018 at 06:33:27PM +0200, Steffen Maier wrote:
> Hi Greg,
> 
> On 04/15/2018 10:31 AM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 13, 2018 at 03:07:18PM +0200, Steffen Maier wrote:
> > > diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> > > index a13613d27cee..cffedc26e8a3 100644
> > > --- a/include/trace/events/block.h
> > > +++ b/include/trace/events/block.h
> > > @@ -460,14 +460,18 @@ TRACE_EVENT(block_plug,
> > >   	TP_ARGS(q),
> > >   	TP_STRUCT__entry(
> > > +		__field( dev_t,		dev			)
> > >   		__array( char,		comm,	TASK_COMM_LEN	)
> > >   	),
> > >   	TP_fast_assign(
> > > +		__entry->dev = q->kobj.parent ?
> > > +		container_of(q->kobj.parent, struct device, kobj)->devt : 0;
> > 
> > That really really really scares me.  It feels very fragile and messing
> > with parent pointers is ripe for things breaking in the future in odd
> > and unexplainable ways.
> > 
> > And how can the parent be NULL?
> 
> I'm hoping for help by block layer experts.
> 
> I suppose block device unplug/removal could be a case. But I don't know the
> details how this works and if object release is protected while I/O is
> pending and new I/O is rejected beforehand. That might make my approach safe
> as it would not call the trace functions while the parent pointer changes.

We quiesce and freeze the queue before tearing it down, so it won't be
NULL while we're still doing I/O. Cc'ing Bart in case I'm lying to you,
though ;)

> > I don't know the block layer but this feels very wrong to me.  Are you
> > sure there isn't some other way to get this info?
> 
> No, I'm not sure at all. But I'm no block layer expert either. This is just
> an idea I had which did work for my cases and I'm looking for confirmation
> or denial by the experts. So if it's not safe from a block layer point of
> view either, then I have to ditch it.

There's not a pretty way to do this, but using the proper helpers would
be preferred:

disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)))

The parent of a request_queue is always a gendisk, so this should always
work.

> -- 
> Mit freundlichen Gr��en / Kind regards
> Steffen Maier
> 
> Linux on z Systems Development
> 
> IBM Deutschland Research & Development GmbH
> Vorsitzende des Aufsichtsrats: Martina Koederitz
> Geschaeftsfuehrung: Dirk Wittkopp
> Sitz der Gesellschaft: Boeblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
