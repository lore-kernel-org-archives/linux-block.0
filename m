Return-Path: <efault@gmx.de>
Message-ID: <1502217234.9604.26.camel@gmx.de>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Aug 2017 20:33:54 +0200
In-Reply-To: <1502211054.7877.9.camel@gmx.de>
References: <5912148.iRCpNe8Dyb@natalenko.name>
	 <1501391551.17388.31.camel@gmx.de> <1662218.y9oETEnj5A@natalenko.name>
	 <20170808162252.GC23338@kroah.com> <1502210041.7877.5.camel@gmx.de>
	 <20170808164400.GC7415@kroah.com> <1502211054.7877.9.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-08-08 at 18:50 +0200, Mike Galbraith wrote:
> On Tue, 2017-08-08 at 09:44 -0700, Greg KH wrote:
> >=20
> > Should these go back farther than 4.12?  Looks like they apply cleanly
> > to 4.9, didn't look older than that...
>=20
> I met prerequisites at 4.11...

FWIW, I took/modified 2d0364c8c1a9. =C2=A0Dunno if the suspend regression
exists in 4.11 though, without which you'll likely want nothing.

	-Mike
