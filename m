Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 8 Aug 2017 09:44:00 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Message-ID: <20170808164400.GC7415@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name>
 <1501391551.17388.31.camel@gmx.de>
 <1662218.y9oETEnj5A@natalenko.name>
 <20170808162252.GC23338@kroah.com>
 <1502210041.7877.5.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1502210041.7877.5.camel@gmx.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 06:34:01PM +0200, Mike Galbraith wrote:
> On Tue, 2017-08-08 at 09:22 -0700, Greg KH wrote:
> > On Sun, Jul 30, 2017 at 03:50:15PM +0200, Oleksandr Natalenko wrote:
> > > Hello Mike et al.
> > > 
> > > On neděle 30. července 2017 7:12:31 CEST Mike Galbraith wrote:
> > > > FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
> > > > stable fixed it.
> > > 
> > > My build already includes v4.12.4.
> > > 
> > > > If not, I'd find these two commits irresistible.
> > > > 
> > > > 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue mapping
> > > > 4b855ad37194f blk-mq: Create hctx for each present CPU
> > > 
> > > I've applied these 2 commits, and cannot reproduce the issue anymore. Looks 
> > > like a perfect hit, thanks!
> > > 
> > > > 'course applying random upstream bits does come with some risk, trying
> > > > a kernel already containing them has less "entertainment" potential. 
> > > 
> > > Should you consider applying them to v4.12.x stable series? CC'ing Greg just 
> > > in case.
> > 
> > I can queue these up if I get an ack from the developers/maintainers
> > that it is ok to do so...
> > 
> > {hint}
> 
> {hint++}
> 
> Those commits take Steven Rostedt's hotplug stress script runtime down
> from 4 _minutes_ down to 7 seconds for my RT tree, so I'm rather hoping
> you hear an "ACK" too.

Oh, nice!

Should these go back farther than 4.12?  Looks like they apply cleanly
to 4.9, didn't look older than that...

thanks,

greg k-h
