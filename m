Return-Path: <hch@lst.de>
Date: Fri, 1 Jun 2018 08:24:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: elevator init cleanups
Message-ID: <20180601062448.GA22524@lst.de>
References: <20180531171141.18478-1-hch@lst.de> <9d3d3fa8-0d07-06f0-9c41-038212651b95@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d3d3fa8-0d07-06f0-9c41-038212651b95@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 31, 2018 at 02:21:51PM -0600, Jens Axboe wrote:
> On 5/31/18 11:11 AM, Christoph Hellwig wrote:
> > The first 5 patches are simple cleanup and refactoring patches.  6 changes
> > behavior in that it only attaches blk-mq ioscheds once we are done with
> > probing, but that actually simplifies things a bit too even if it might
> > be a bit more controversial.
> 
> 1-5 are obviously fine, I have no problem taking those. For #6, I see
> where you are going with this, obviously. I'd like to defer that one
> a bit, to ensure there aren't any nasty corner cases or issues with it.

Ok, fine with me.
