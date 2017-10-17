Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <8a7183b5-d9d8-af74-6ce8-aa005468a83b@kernel.dk>
References: <20171005231354.GA109107@beast> <8a7183b5-d9d8-af74-6ce8-aa005468a83b@kernel.dk>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 16 Oct 2017 17:03:49 -0700
Message-ID: <CAGXu5jK3aGwt1j=A022y2zvKOqjNxzigHuiUqfJTnqMU4-B7dw@mail.gmail.com>
Subject: Re: [PATCH v2] block/aoe: Convert timers to use timer_setup()
To: Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, "Ed L. Cashin" <ed.cashin@acm.org>,
	linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 6, 2017 at 7:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 10/05/2017 05:13 PM, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>
> Applied to for-4.15/timer

Hi,

I just wanted to check what your timer plans were for merging this
into -next (I'm doing rebasing to find out which maintainers I need to
resend patches to, and I noticed block hasn't appeared in -next, but I
know you've pulled patches...)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
