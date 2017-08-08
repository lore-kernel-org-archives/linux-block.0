Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 8 Aug 2017 09:22:52 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Message-ID: <20170808162252.GC23338@kroah.com>
References: <5912148.iRCpNe8Dyb@natalenko.name>
 <1501391551.17388.31.camel@gmx.de>
 <1662218.y9oETEnj5A@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1662218.y9oETEnj5A@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 30, 2017 at 03:50:15PM +0200, Oleksandr Natalenko wrote:
> Hello Mike et al.
> 
> On neděle 30. července 2017 7:12:31 CEST Mike Galbraith wrote:
> > FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
> > stable fixed it.
> 
> My build already includes v4.12.4.
> 
> > If not, I'd find these two commits irresistible.
> > 
> > 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue mapping
> > 4b855ad37194f blk-mq: Create hctx for each present CPU
> 
> I've applied these 2 commits, and cannot reproduce the issue anymore. Looks 
> like a perfect hit, thanks!
> 
> > 'course applying random upstream bits does come with some risk, trying
> > a kernel already containing them has less "entertainment" potential. 
> 
> Should you consider applying them to v4.12.x stable series? CC'ing Greg just 
> in case.

I can queue these up if I get an ack from the developers/maintainers
that it is ok to do so...

{hint}

thanks,

greg k-h
