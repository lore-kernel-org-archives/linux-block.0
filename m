Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Do not invoke queue operations on a dead
 queue
Date: Fri, 14 Apr 2017 16:12:01 +0000
Message-ID: <1492186320.2644.7.camel@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
	 <20170411205842.28137-2-bart.vanassche@sandisk.com>
	 <20170413230102.GA1550@vader.DHCP.thefacebook.com>
	 <1492124731.2723.1.camel@sandisk.com> <20170414074023.GA24673@vader>
In-Reply-To: <20170414074023.GA24673@vader>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-14 at 00:40 -0700, Omar Sandoval wrote:
> On Thu, Apr 13, 2017 at 11:05:32PM +0000, Bart Van Assche wrote:
> > On Thu, 2017-04-13 at 16:01 -0700, Omar Sandoval wrote:
> > > Looking at this, I think we have similar issues with most of the othe=
r
> > > debugfs files. Should we move the debugfs cleanup earlier?
> >=20
> > That's a good question. However, while I was debugging it was very conv=
enient
> > to be able to access the queue state after it had reached the "dead" st=
ate.
> > Performing the cleanup earlier would be an alternative solution but wou=
ld
> > make debugging a bit harder ...
>=20
> What useful information were you getting out of debugfs once the queue
> was already dead? Wasn't the interesting stuff freed at that point?

Hello Omar,

I'm currently chasing a stall of dm-rq + dm-mpath that occurs after the
queues below it have reached the "dead" state. I will look for another
way to obtain the information I need such that we can remove the block
layer queue debugfs information before these queues reach the "dead"
state.

Bart.=
