Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Luca Miccio
 <lucmiccio@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
 <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
 <20171106150002.GY3252168@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3239d057-969e-36d4-4196-394633f4bb4c@kernel.dk>
Date: Mon, 6 Nov 2017 09:03:03 -0700
MIME-Version: 1.0
In-Reply-To: <20171106150002.GY3252168@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/06/2017 08:00 AM, Tejun Heo wrote:
> Hello,
> 
> On Sun, Nov 05, 2017 at 07:21:01PM -0700, Jens Axboe wrote:
>> It's pointless to give up on this so soon, when no effort has apparently
>> been dedicated to figuring out what the actual issue is yet. So no, no
>> patch that will just disable the stats is going to be accepted.
>>
>> That said, I have no idea who uses these stats. Surely someone can
>> answer that question. Tejun?
> 
> Except for the basic bytes / ios counts, it's all debug fluff, which
> should have been hidden behind a debug boot param or go under debugfs.
> I'm not sure we can get rid of them at this point for cfq but I don't
> see why we'd have them for bfq.

If that's the case, how about having some way to then turn it on and
leave it off by default? The metrics could still be useful, and
there's value in having them the same. But if the overhead is high
AND there's no use case for it outside of debugging, it should not
be on by default for neither cfq nor bfq.

-- 
Jens Axboe
