Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Do not invoke queue operations on a dead
 queue
Date: Thu, 13 Apr 2017 23:05:32 +0000
Message-ID: <1492124731.2723.1.camel@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
	 <20170411205842.28137-2-bart.vanassche@sandisk.com>
	 <20170413230102.GA1550@vader.DHCP.thefacebook.com>
In-Reply-To: <20170413230102.GA1550@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-13 at 16:01 -0700, Omar Sandoval wrote:
> On Tue, Apr 11, 2017 at 01:58:37PM -0700, Bart Van Assche wrote:
> > The blk-mq debugfs attributes are removed after blk_cleanup_queue()
> > has finished. Since running a queue after a queue has entered the
> > "dead" state is not allowed, disallow this. This patch avoids that
> > an attempt to run a dead queue triggers a kernel crash.
> >=20
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > ---
> >  block/blk-mq-debugfs.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index df9b688b877c..a1ce823578c7 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -111,6 +111,14 @@ static ssize_t blk_queue_flags_store(struct file *=
file, const char __user *ubuf,
> >  	struct request_queue *q =3D file_inode(file)->i_private;
> >  	char op[16] =3D { }, *s;
> > =20
> > +	/*
> > +	 * The debugfs attributes are removed after blk_cleanup_queue() has
> > +	 * called blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set
> > +	 * to avoid triggering a use-after-free.
> > +	 */
> > +	if (blk_queue_dead(q))
> > +		return -ENOENT;
> > +
> >  	len =3D min(len, sizeof(op) - 1);
> >  	if (copy_from_user(op, ubuf, len))
> >  		return -EFAULT;
>=20
> Looking at this, I think we have similar issues with most of the other
> debugfs files. Should we move the debugfs cleanup earlier?

Hello Omar,

That's a good question. However, while I was debugging it was very convenie=
nt
to be able to access the queue state after it had reached the "dead" state.
Performing the cleanup earlier would be an alternative solution but would
make debugging a bit harder ...

Bart.=
