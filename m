Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2 0/7] blk-mq-sched and sbitmap shallow depth
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Omar Sandoval
 <osandov@fb.com>, Mike Galbraith <efault@gmx.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
 <BB4243FC-1AC7-4200-86D4-CC088F38A4DA@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ef70237b-f72b-9cf4-f6d1-c2a65c3ebf97@kernel.dk>
Date: Thu, 10 May 2018 10:20:26 -0600
MIME-Version: 1.0
In-Reply-To: <BB4243FC-1AC7-4200-86D4-CC088F38A4DA@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 10:32 PM, Paolo Valente wrote:
> 
> 
>> Il giorno 09 mag 2018, alle ore 22:49, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> Omar had some valid complaints about the previous patchset, mostly
>> around the fact that we should not be updating depths on a per-IO
>> basis.  He's right. In fact, BFQ oddly enough does it from the
>> ->limit_depth hook, but the shallow depth counts remain static.
>>
>> This series cleans that up the ->limit_depth() handling, and keeps it
>> out of the hot path.
>>
>> Mike, this should (still) fix your hangs with BFQ. This series is
>> (functionally) identical to the bundled up version I sent you earlier.
>>
> 
> Only one question/curiosity: is performance unaffected by the lowering of
> the wake batch counts?

It's hard to discuss performance within the realm of "it hangs without
it", there's just no way around this. That said, We still have the
rolling waitqueues (default is 8) which also helps in reducing the
overhead on both wakeups and adding to wait queues. So we should still
be quite fine.

As it so happens, there's another bug in wake batch accounting in
sbitmap, which would have defeated much of the win over time anyway. New
series coming with that extra patch.

-- 
Jens Axboe
