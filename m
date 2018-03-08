Return-Path: <axboe@kernel.dk>
Date: Thu, 8 Mar 2018 14:15:06 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/11] Make all concurrent queue flag manipulations
 safe
Message-ID: <20180308211504.GB3932@kernel.dk>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 07 2018, Bart Van Assche wrote:
> Hello Jens,
> 
> As you probably know there is considerable confusion in the block
> layer core and in block drivers about how to protect queue flag
> changes against concurrent modifications. Some code protects these
> changes with the queue lock, other code uses atomic operations and
> some code does not protect queue flag changes against concurrent
> changes at all. Hence this patch series that protects all queue flag
> changes consistently with the queue lock and that removes functions
> that are not safe in a concurrent context from the public block layer
> header files.
> 
> Please consider these patches for kernel v4.17.
> 
> Note: it may be a good idea to postpone patch 11 until after the
> kernel v4.17 merge window to avoid merge conflicts.

Applied for 4.17. Not too worried about a conflict with that patch, so
applied 11/11 as well.

-- 
Jens Axboe
