Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Linus Walleij <linus.walleij@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Akinobu Mita <akinobu.mita@gmail.com>, David Howells <dhowells@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <AE364BB2-E347-4A5E-BFF7-AAAA32C512F5@linaro.org>
 <CACRpkdZYMTqgPur_S1sFfpZfT3euzDLs=pxgs-fG=+3AtMSbig@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e32acb12-729e-a407-d31b-16c0e0fd3e11@kernel.dk>
Date: Tue, 17 Oct 2017 10:49:16 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkdZYMTqgPur_S1sFfpZfT3euzDLs=pxgs-fG=+3AtMSbig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 10:45 AM, Linus Walleij wrote:
> On Tue, Oct 17, 2017 at 2:45 PM, Paolo Valente <paolo.valente@linaro.org> wrote:
> 
>> one of the most time-consuming operations needed by some blkg_*stats_*
>> functions is, e.g., find_next_bit, for which we don't see any trivial
>> replacement.
> 
> So this is one of the things that often falls down to a per-arch
> assembly optimization, c.f. arch/arm/include/asm/bitops.h
> 
> On x86 I can't see any assembly optimization of this, so the
> generic routines in lib/find_bit.c are used AFAICT.
> 
> This might be a silly question, but If you are testing this on x86,
> do you think it would help if someone stepped in and slapped in
> some optimized assembly for those functions?
> 
> (I guess that is like saying, "instead of a trivial replacement,
> what about a really complicated one"?)
> 
> A simple git log arch/x86/include/asm/bitops.h doesn't show
> any traces of anyone trying to optimize those for x86.
> 
> I paged in the x86 assembly people, they definately knows whether
> that is a good idea or if it sucks. (And if it was done in the past.)

If the problem is as big as described, I don't think an optimized
version will matter at all. Maybe it'll make things 10% faster,
that's not solving the issue.

It's probably more likely that a better data structure should be
used, if we're spending a lot of time in find_bit. Maybe this
happens when the space is mostly full? A bitmap of bitmaps
might help for that.

But I'm just guessing here, as I haven't look into the problem.

-- 
Jens Axboe
