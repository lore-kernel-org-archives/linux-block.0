Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Tue, 25 Apr 2017 22:24:48 +0000
Message-ID: <1493159087.2628.28.camel@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
	 <20170425203745.19946-6-bart.vanassche@sandisk.com>
	 <20170425213018.GB6361@vader>
In-Reply-To: <20170425213018.GB6361@vader>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-25 at 14:30 -0700, Omar Sandoval wrote:
> On Tue, Apr 25, 2017 at 01:37:40PM -0700, Bart Van Assche wrote:
> > One of the debugfs attributes allows to run a queue. Since running
> > a queue after a queue has entered the "dead" state is not allowed
> > and triggers a use-after-free, unregister the debugfs attributes
> > before a queue reaches the "dead" state.
>=20
> Still not happy with this commit message. I'd prefer:
>=20
> We currently call blk_mq_free_queue() from blk_cleanup_queue() before we
> unregister the debugfs attributes for that queue in blk_release_queue().
> This leaves a window open during which accessing most of the mq debugfs
> attributes would cause a use-after-free. Additionally, the "state"
> attribute allows running the queue, which we should not do after the
> queue has entered the "dead" state. Fix both of these cases by
> unregistering the debugfs attributes before this.

Hello Omar,

That's a very verbose description. How about this?

 =A0=A0=A0Unregister the debugfs attributes before freeing of request queue
=A0=A0=A0=A0resources starts to avoid that a use-after-free can be triggere=
d
=A0=A0=A0=A0through one of the debugfs attributes.

Bart.=
