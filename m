Subject: Re: [PATCH] blk-mq-sched: fix possible crash if changing scheduler
 fails
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <b83737e281e311179615f93be9cfbae50addb1a0.1485215087.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <102a347a-28c4-3966-f360-55abc9740c8a@fb.com>
Date: Tue, 24 Jan 2017 08:01:42 -0700
MIME-Version: 1.0
In-Reply-To: <b83737e281e311179615f93be9cfbae50addb1a0.1485215087.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 04:47 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In elevator_switch(), we free the old scheduler's tags and then
> initialize the new scheduler. If initializing the new scheduler fails,
> we fall back to the old scheduler, but our tags have already been freed.
> There's no reason to free the sched_tags only to reallocate them, so
> let's just reuse them, which makes it possible to safely fall back to
> the old scheduler.

Do we need a failure case on both ends? We never free the driver
tags, so it's always perfectly safe to fall back to not running
with a scheduler.

Since we were talking about making the scheduler depth configurable
or dependent on the scheduler, reusing tags seems like something that
would potentially be a short lived "feature".

So I think I'd prefer if we teardown/setup like we do now, and just
have the failure case be falling back to "none".


-- 
Jens Axboe
