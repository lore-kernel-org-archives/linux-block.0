Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Fri, 27 Jul 2018 17:19:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] block: don't do cgroup accounting for split bio's
Message-ID: <20180727211913.47f3pssntdidjfdc@destiny>
References: <20180727211407.24318-1-josef@toxicpanda.com>
 <838a33f4-90e4-f939-f0e4-4434122e7f2e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <838a33f4-90e4-f939-f0e4-4434122e7f2e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 03:17:11PM -0600, Jens Axboe wrote:
> On 7/27/18 3:14 PM, Josef Bacik wrote:
> > We need to check in blkcg_bio_issue_check if the bio is flagged as
> > QUEUE_ENTERED, because if it is then we've already accounted for the IO
> > in the cgroup stats.
> 
> That's a bit of a flag overload, I think that at least warrants a
> comment.

Yeah I'm not a fan of it, but there's nothing else to indicate that the bio is a
split bio other than checking if it's endio is the chain endio.  I'll respin
with the comment.  Thanks,

Josef
