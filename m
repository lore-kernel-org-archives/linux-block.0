Return-Path: <tglx@linutronix.de>
Date: Thu, 16 Feb 2017 15:35:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
cc: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
    Gabriel C <nix.or.die@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] Potential deadlock in the block layer
In-Reply-To: <4d3f25fc-7480-769c-2f4f-e5271a47f7c3@kernel.dk>
Message-ID: <alpine.DEB.2.20.1702161533280.3543@nanos>
References: <alpine.DEB.2.20.1702131505580.3619@nanos> <4d3f25fc-7480-769c-2f4f-e5271a47f7c3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon, 13 Feb 2017, Jens Axboe wrote:

> On 02/13/2017 07:14 AM, Thomas Gleixner wrote:
> > Gabriel reported the lockdep splat below while investigating something
> > different.
> > 
> > Explanation for the splat is in the function comment above
> > del_timer_sync().
> > 
> > I can reproduce it as well and it's clearly broken.
> 
> Agree, the disable logic is broken. The below isn't super pretty, but it
> should do the trick for 4.10.

Cures the splat. Is that a new 4.10 'feature'? That wbt stuff has been
merged a few releases ago.

Thanks,

	tglx
