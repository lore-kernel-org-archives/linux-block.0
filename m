Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "osandov@fb.com" <osandov@fb.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH 2/6] blk-mq: Fix the comment above blk_mq_quiesce_queue()
Date: Thu, 27 Apr 2017 22:40:21 +0000
Message-ID: <1493332819.2625.14.camel@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
	 <20170427155437.23228-3-bart.vanassche@sandisk.com>
	 <20170427223713.GA2806@vader.DHCP.thefacebook.com>
In-Reply-To: <20170427223713.GA2806@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-27 at 15:37 -0700, Omar Sandoval wrote:
> On Thu, Apr 27, 2017 at 08:54:33AM -0700, Bart Van Assche wrote:
> > The first version of blk_mq_quiesce_queue() that was posted on
> > the linux-block mailing list waited for ongoing .queue_rq()
> > calls but did not stop the request queue. The current version
> > however stops the request queue. Hence reflect this behavior in
> > the comment above that function.
>=20
> Can you just combine this with patch 1?

Hello Omar,

Patch 1/6 has a "Cc: stable" tag but this patch not. The comment change
is a separate patch because I don't think this comment change needs to
be integrated in the stable kernel series.

Bart.=
