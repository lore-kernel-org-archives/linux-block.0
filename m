Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2017 08:00:09 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 01/10] block: move existing elevator ops to union
Message-ID: <20170113150009.GA23338@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-2-git-send-email-axboe@fb.com>
 <20170113083420.GB16676@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170113083420.GB16676@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> On Wed, Jan 11, 2017 at 02:39:54PM -0700, Jens Axboe wrote:
> > Prep patch for adding MQ ops as well, since doing anon unions with
> > named initializers doesn't work on older compilers.
> 
> My gut feeling tells me MQ schedulers shouldn't share elevator_type.
> I'll play around a bit with the code later to see if my gut was right.

It's crazy to re-invent a new framework just for MQ schedulers, imho. So
you're going to have to come up with something better than a gut
feeling.

-- 
Jens Axboe
