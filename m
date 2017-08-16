Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 16 Aug 2017 08:42:44 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>,
	Nishita Borkar <nishita.borkar@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Dmitry Monakhov <dmonakhov@openvz.org>, linux-block@vger.kernel.org
Subject: Re: migrate the block tests from Dimity to blktests?
Message-ID: <20170816154244.GA2459@vader>
References: <20170816091733.GA22832@lst.de>
 <b8bf8b27-8fda-2251-9726-25f9cf6a099b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8bf8b27-8fda-2251-9726-25f9cf6a099b@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 16, 2017 at 08:46:56AM -0600, Jens Axboe wrote:
> On 08/16/2017 03:17 AM, Christoph Hellwig wrote:
> > Hi all,
> > 
> > Dmitry Monakhov wrote a few very useful block layers tests a while
> > ago and wired them up for xfstests at that point:
> > 
> > 	https://github.com/dmonakhov/xfstests/commits/dif-dix-tests-v2
> > 
> > Is anyone interested in migrating them over to blktests?  Doing
> > so has been on my todo list for a while, but given that said
> > lists keeps growing I'd like to check if anyone else might be
> > interested.
> 
> Yes please, that would be awesome.

Nishita volunteered off-list. Nishita, let me know if you need any help
with the port.
