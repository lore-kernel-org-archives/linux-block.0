Return-Path: <axboe@kernel.dk>
Subject: Re: [BUG] Potential deadlock in the block layer
To: Thomas Gleixner <tglx@linutronix.de>
References: <alpine.DEB.2.20.1702131505580.3619@nanos>
 <4d3f25fc-7480-769c-2f4f-e5271a47f7c3@kernel.dk>
 <alpine.DEB.2.20.1702161533280.3543@nanos>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 Gabriel C <nix.or.die@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2c68940-17d3-d5ca-6385-a79cea238b0a@kernel.dk>
Date: Thu, 16 Feb 2017 07:56:12 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702161533280.3543@nanos>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/16/2017 07:35 AM, Thomas Gleixner wrote:
> On Mon, 13 Feb 2017, Jens Axboe wrote:
> 
>> On 02/13/2017 07:14 AM, Thomas Gleixner wrote:
>>> Gabriel reported the lockdep splat below while investigating something
>>> different.
>>>
>>> Explanation for the splat is in the function comment above
>>> del_timer_sync().
>>>
>>> I can reproduce it as well and it's clearly broken.
>>
>> Agree, the disable logic is broken. The below isn't super pretty, but it
>> should do the trick for 4.10.
> 
> Cures the splat. Is that a new 4.10 'feature'? That wbt stuff has been
> merged a few releases ago.

OK good, I'll get this submitted for 4.10. wbt is a new feature in
this release.

-- 
Jens Axboe
