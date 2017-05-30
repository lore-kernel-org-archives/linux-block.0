Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Date: Tue, 30 May 2017 17:24:39 +0000
Message-ID: <1496165077.2627.15.camel@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
	 <20170525233810.23211-5-bart.vanassche@sandisk.com>
	 <20170527005456.GB20421@ming.t460p>
In-Reply-To: <20170527005456.GB20421@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-05-27 at 08:54 +0800, Ming Lei wrote:
> On Thu, May 25, 2017 at 04:38:09PM -0700, Bart Van Assche wrote:
> > Requests that got stuck in a block driver are neither on
> > blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
> > visible in debugfs through the "busy" attribute.
>=20
> The name of 'busy' isn't very explicit about this case, and I
> guess you mean the requests are dispatched to hardware, so
> 'dispatched' or sort of name may be more accurate.

Hello Ming,

There is already a debugfs attribute with the name "dispatch". I'm afraid
having one attribute with the name "dispatch" and another with the name
"dispatched" would be confusing.

> [ ... ]
> During this small window, the request can be freed and reallocated
> in another I/O path, then use-after-free is caused.

A similar remark applies to all request queue debugfs attributes: the queue
state can change immediately after having queried the state so that's not
unique to this attribute. Regarding the "use-after-free": the memory that i=
s
allocated for requests is only freed after the debugfs attributes have been
removed so the code that implements this attribute will read the contents o=
f
a struct request. It is up to the person who reads the contents of this
attribute to decide how to interpret the contents.

> But the new fixed blk_mq_quiesce_queue() can be used before calling
> blk_mq_tagset_busy_iter() to avoid the race.

That would be overkill. The "busy" attribute is intended as a debugging hel=
p.
The implementation of this function should trigger any crashes. But it was
not my intention to avoid data races when I implemented this function.

Bart.=
