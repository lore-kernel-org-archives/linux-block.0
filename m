Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 04/16] block, bfq: modify the peak-rate estimator
Date: Tue, 4 Apr 2017 15:28:59 +0000
Message-ID: <1491319738.2513.2.camel@sandisk.com>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
	 <20170331124743.3530-5-paolo.valente@linaro.org>
	 <1490974279.2587.5.camel@sandisk.com>
	 <867BBC1E-080B-4A4B-88CE-BD103610BA6C@linaro.org>
In-Reply-To: <867BBC1E-080B-4A4B-88CE-BD103610BA6C@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-04 at 12:42 +0200, Paolo Valente wrote:
> > Il giorno 31 mar 2017, alle ore 17:31, Bart Van Assche <bart.vanassche@=
sandisk.com> ha scritto:
> >=20
> > On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
> > > +               delta_ktime =3D ktime_get();
> > > +       delta_ktime =3D ktime_sub(delta_ktime, bfqd->last_budget_star=
t);
> > > +       delta_usecs =3D ktime_to_us(delta_ktime);
> >=20
> > This patch changes the type of the variable in which the result of ktim=
e_to_us()
> > is stored from u64 into u32 and next compares that result with LONG_MAX=
. Since
> > ktime_to_us() returns a signed 64-bit number, are you sure you want to =
store that
> > result in a 32-bit variable? If ktime_to_us() would e.g. return 0xfffff=
fff00000100
> > or 0x100000100 then the assignment will truncate these numbers to 0x100=
.
>=20
> The instruction above the assignment you highlight stores in
> delta_ktime the difference between 'now' and the last budget start.
> The latter may have happened at most about 100 ms before 'now'.  So
> there should be no overflow issue.

Hello Paolo,

Please double check the following code: if (delta_usecs < 1000 || delta_use=
cs >=3D LONG_MAX)
Since delta_usecs is a 32-bit variable and LONG_MAX a 64-bit constant on 64=
-bit systems
I'm not sure that code will do what it is intended to do.

Thanks,

Bart.=
