Return-Path: <efault@gmx.de>
Message-ID: <1502210041.7877.5.camel@gmx.de>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@linuxfoundation.org>, Oleksandr Natalenko
	 <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Aug 2017 18:34:01 +0200
In-Reply-To: <20170808162252.GC23338@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name>
	 <1501391551.17388.31.camel@gmx.de> <1662218.y9oETEnj5A@natalenko.name>
	 <20170808162252.GC23338@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-08-08 at 09:22 -0700, Greg KH wrote:
> On Sun, Jul 30, 2017 at 03:50:15PM +0200, Oleksandr Natalenko wrote:
> > Hello Mike et al.
> >=20
> > On ned=C4=9Ble 30. =C4=8Dervence 2017 7:12:31 CEST Mike Galbraith wrote=
:
> > > FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
> > > stable fixed it.
> >=20
> > My build already includes v4.12.4.
> >=20
> > > If not, I'd find these two commits irresistible.
> > >=20
> > > 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue m=
apping
> > > 4b855ad37194f blk-mq: Create hctx for each present CPU
> >=20
> > I've applied these 2 commits, and cannot reproduce the issue anymore. L=
ooks=20
> > like a perfect hit, thanks!
> >=20
> > > 'course applying random upstream bits does come with some risk, tryin=
g
> > > a kernel already containing them has less "entertainment" potential.=
=20
> >=20
> > Should you consider applying them to v4.12.x stable series? CC'ing Greg=
 just=20
> > in case.
>=20
> I can queue these up if I get an ack from the developers/maintainers
> that it is ok to do so...
>=20
> {hint}

{hint++}

Those commits take Steven Rostedt's hotplug stress script runtime down
from 4 _minutes_ down to 7 seconds for my RT tree, so I'm rather hoping
you hear an "ACK" too.

	-Mike
