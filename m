Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: wake up all when we scale up, not down
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: stable@vger.kernel.org
References: <20181011192930.2844-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <729350ca-183a-ad1f-9d4f-3e90913a40f8@kernel.dk>
Date: Thu, 11 Oct 2018 13:31:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181011192930.2844-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/11/18 1:29 PM, Josef Bacik wrote:
> Tetsuo brought to my attention that I screwed up the scale_up/scale_down
> helpers when I factored out the rq-qos code.  We need to wake up all the
> waiters when we add slots for requests to make, not when we shrink the
> slots.  Otherwise we'll end up things waiting forever.  This was a
> mistake and simply puts everything back the way it was.

I'll apply this for 4.19. I haven't hit this in testing, I'm guessing
the jitter when going up and down hides the issue.

-- 
Jens Axboe
