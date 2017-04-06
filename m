Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V2 04/16] block, bfq: modify the peak-rate estimator
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1491319738.2513.2.camel@sandisk.com>
Date: Thu, 6 Apr 2017 21:37:11 +0200
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <439E3C9C-B2D7-40F7-8831-129DCD0EC658@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org> <20170331124743.3530-5-paolo.valente@linaro.org> <1490974279.2587.5.camel@sandisk.com> <867BBC1E-080B-4A4B-88CE-BD103610BA6C@linaro.org> <1491319738.2513.2.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 04 apr 2017, alle ore 17:28, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-04-04 at 12:42 +0200, Paolo Valente wrote:
>>> Il giorno 31 mar 2017, alle ore 17:31, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>=20
>>> On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
>>>> +               delta_ktime =3D ktime_get();
>>>> +       delta_ktime =3D ktime_sub(delta_ktime, =
bfqd->last_budget_start);
>>>> +       delta_usecs =3D ktime_to_us(delta_ktime);
>>>=20
>>> This patch changes the type of the variable in which the result of =
ktime_to_us()
>>> is stored from u64 into u32 and next compares that result with =
LONG_MAX. Since
>>> ktime_to_us() returns a signed 64-bit number, are you sure you want =
to store that
>>> result in a 32-bit variable? If ktime_to_us() would e.g. return =
0xffffffff00000100
>>> or 0x100000100 then the assignment will truncate these numbers to =
0x100.
>>=20
>> The instruction above the assignment you highlight stores in
>> delta_ktime the difference between 'now' and the last budget start.
>> The latter may have happened at most about 100 ms before 'now'.  So
>> there should be no overflow issue.
>=20
> Hello Paolo,
>=20
> Please double check the following code: if (delta_usecs < 1000 || =
delta_usecs >=3D LONG_MAX)
> Since delta_usecs is a 32-bit variable and LONG_MAX a 64-bit constant =
on 64-bit systems
> I'm not sure that code will do what it is intended to do.
>=20

Yes, sorry. Actually, it never occurred to me to see that extra =
condition to hold over the last eight years on 32-bit systems. So I =
think I will just remove it. Unless Fabio, who inserted that condition =
several years ago, has something to say.

Thanks,
Paolo

> Thanks,
>=20
> Bart.
