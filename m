Return-Path: <axboe@kernel.dk>
Date: Wed, 29 Mar 2017 08:00:25 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/4] block: misc changes
Message-ID: <20170329140025.GA8461@kernel.dk>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
 <20170329021136.GA4625@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329021136.GA4625@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 29 2017, Ming Lei wrote:
> On Mon, Mar 27, 2017 at 08:06:54PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > The 1st  patch add comments on blk-mq races with timeout handler.
> > 
> > The other 3 patches improves handling for dying queue:
> > 	- the 2nd one adds one barrier in blk_queue_enter() for
> > 	avoiding hanging caused by out-of-order
> > 	- the 3rd and 4th patches block new I/O entering queue
> > 	after queue is set as dying
> > 
> > V3:
> > 	- tweak comments as suggested by Bart Van Assche
> 
> Hi Jens,
> 
> This patchset has been posted several times without real code change
> for a while, could you consider it for v4.12?

We can queue it up now. I do agree that patch 2+4 should have been
folded into one, but that's not a huge deal.

-- 
Jens Axboe
