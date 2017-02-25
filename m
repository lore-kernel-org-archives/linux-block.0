Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1487961857.2575.8.camel@sandisk.com>
Date: Sat, 25 Feb 2017 18:45:58 +0100
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Message-Id: <19D7658C-BF04-4A52-AD1D-37842AE1E8C0@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486745110.2840.3.camel@sandisk.com> <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org> <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com> <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org> <1A8DF6A8-C251-472A-9CE1-ACB1BCD0E9AB@linaro.org> <1487023626.2719.9.camel@sandisk.com> <1487025524.2719.11.camel@sandisk.com> <62F8F65E-A376-44EB-B53C-C2CFB8F8693F@linaro.org> <1487961857.2575.8.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 24 feb 2017, alle ore 19:44, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Wed, 2017-02-22 at 22:29 +0100, Paolo Valente wrote:
>> thanks for this second attempt of yours.  Although, unfortunately, =
not
>> providing some clear indication of the exact cause of your hang =
(apart
>> from a possible deadlock), your log helped me notice another bug.
>>=20
>> At any rate, as I have just written to Jens, I have pushed a new
>> version of the branch [1] (not just added new commits, but also
>> integrated some old commit with new changes, to make it more =
quickly).
>> The branch now contains both a fix for the above bug, and, more
>> importantly, a fix for the circular dependencies that were still
>> lurking around.  Could you please test it?
>=20
> Hello Paolo,
>=20

Hi

> I have good news: the same test system boots normally with the same
> kernel config I used during my previous tests and with the latest
> bfq-mq code (commit a965d19585c0) merged with kernel v4.10.
>=20

Whew, I was longing for you reply, thanks :)

Should you want to have a look at it, I have just finished completing
cgroups support too, as you have probably already read from my
previous email.

Thanks,
Paolo

> Thanks,
>=20
> Bart.
