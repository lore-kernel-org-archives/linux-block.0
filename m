Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Wed, 11 Jul 2018 10:28:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] blk-iolatency: fix max_depth comparisons
Message-ID: <20180711142857.tesdgn7kukmyrepi@destiny>
References: <20180711133012.15552-1-josef@toxicpanda.com>
 <7dc883e2-7bb0-f837-9547-619b5e51f81d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7dc883e2-7bb0-f837-9547-619b5e51f81d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 11, 2018 at 08:22:28AM -0600, Jens Axboe wrote:
> On 7/11/18 7:30 AM, Josef Bacik wrote:
> > max_depth used to be a u64, but I changed it to a unsigned int but
> > didn't convert my comparisons over everywhere.  Fix by comparing to
> > INT_MAX instead of (u64)-1.
> 
> Should that be UINT_MAX?
> 

Hmm I suppose it should, though I'm really just using it to indicate that we're
unthrottled so it doesn't matter a whole lot.  Would you prefer I just switch it
all over to UINT_MAX?  Thanks,

Josef
