Return-Path: <axboe@kernel.dk>
Subject: Re: elevator init cleanups
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20180531171141.18478-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d3d3fa8-0d07-06f0-9c41-038212651b95@kernel.dk>
Date: Thu, 31 May 2018 14:21:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180531171141.18478-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/31/18 11:11 AM, Christoph Hellwig wrote:
> The first 5 patches are simple cleanup and refactoring patches.  6 changes
> behavior in that it only attaches blk-mq ioscheds once we are done with
> probing, but that actually simplifies things a bit too even if it might
> be a bit more controversial.

1-5 are obviously fine, I have no problem taking those. For #6, I see
where you are going with this, obviously. I'd like to defer that one
a bit, to ensure there aren't any nasty corner cases or issues with it.

-- 
Jens Axboe
