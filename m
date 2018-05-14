Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4ea9999a-e316-f0bc-a99f-70cd0e901e55@kernel.dk>
Date: Mon, 14 May 2018 19:37:48 +0200
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Message-Id: <121C9095-504D-42BB-AD23-C7733E2849DF@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
 <8B9DC3A2-0DB0-4EEB-AFB2-C4D6560B7A4A@linaro.org>
 <4ea9999a-e316-f0bc-a99f-70cd0e901e55@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 14 mag 2018, alle ore 19:31, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 5/14/18 11:16 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 10 mag 2018, alle ore 18:14, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>>>=20
>>> On Fri, 2018-05-04 at 19:17 +0200, Paolo Valente wrote:
>>>> When invoked for an I/O request rq, [ ... ]
>>>=20
>>> Tested-by: Bart Van Assche <bart.vanassche@wdc.com>
>>>=20
>>>=20
>>>=20
>>=20
>> Any decision for this fix, Jens?
>=20
> Guess I didn't reply, but I did commit this on Thursday.
>=20

Great, thank you!

Paolo

> --=20
> Jens Axboe
>=20
