Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX 0/3] three fixes for the function
 bfq_requests_merged
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d2f92f58-598f-d75c-8120-71cf269738fe@kernel.dk>
Date: Thu, 31 May 2018 16:50:46 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 oleksandr@natalenko.name,
 filippo.muzzini@outlook.it
Message-Id: <3C2F9AF5-C988-4D53-A24C-2D69A71F9F29@linaro.org>
References: <20180531132313.2986-1-paolo.valente@linaro.org>
 <d2f92f58-598f-d75c-8120-71cf269738fe@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 31 mag 2018, alle ore 16:48, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 5/31/18 7:23 AM, Paolo Valente wrote:
>> Hi Jens,
>> this series fixes three bugs in bfq_requests_merged. In more detail:
>>=20
>> - two linked bugs, with the first (critical: wrong lock) hidden by =
the
>>  second (less critical: wrong check that made the body of the
>>  function not be executed at all)
>> - a rather minor bug: superflous code
>=20
> Patch #2 doesn't apply on for-4.18/block.

Yep, it gave some problems to me too, because we happened to move this
patch around by email.

> I hand applied it, all
> 3 are queued up now.
>=20

Thanks for the patience and for queueing these fixes.

Paolo

> --=20
> Jens Axboe
>=20
