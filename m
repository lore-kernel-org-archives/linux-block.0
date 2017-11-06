Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3239d057-969e-36d4-4196-394633f4bb4c@kernel.dk>
Date: Mon, 6 Nov 2017 17:10:59 +0100
Cc: Tejun Heo <tj@kernel.org>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <707430C0-1562-4E5B-83A5-48EAA3943E4A@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org> <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk> <20171106150002.GY3252168@devbig577.frc2.facebook.com> <3239d057-969e-36d4-4196-394633f4bb4c@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 nov 2017, alle ore 17:03, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/06/2017 08:00 AM, Tejun Heo wrote:
>> Hello,
>>=20
>> On Sun, Nov 05, 2017 at 07:21:01PM -0700, Jens Axboe wrote:
>>> It's pointless to give up on this so soon, when no effort has =
apparently
>>> been dedicated to figuring out what the actual issue is yet. So no, =
no
>>> patch that will just disable the stats is going to be accepted.
>>>=20
>>> That said, I have no idea who uses these stats. Surely someone can
>>> answer that question. Tejun?
>>=20
>> Except for the basic bytes / ios counts, it's all debug fluff, which
>> should have been hidden behind a debug boot param or go under =
debugfs.
>> I'm not sure we can get rid of them at this point for cfq but I don't
>> see why we'd have them for bfq.
>=20
> If that's the case, how about having some way to then turn it on and
> leave it off by default? The metrics could still be useful, and
> there's value in having them the same. But if the overhead is high
> AND there's no use case for it outside of debugging, it should not
> be on by default for neither cfq nor bfq.
>=20

Yes, these were exactly my motivations and plan for bfq!  However, at
this point, I think that Tejun's answer to my detailed question about
what to keep and what not to keep may greatly help in two respects.
First, to clarify the actual use of these files, second to understand
the actual impact on performance.  In fact, as I wrote in some of my
previous emails in this thread, some functions are much heavier than
others.  Those to update debug stats seems to be the heaviest, and,
fortunately, would be already behind the CONFIG_DEBUG_BLK_CGROUP
option.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
