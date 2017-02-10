Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1486742918.2840.1.camel@sandisk.com>
Date: Fri, 10 Feb 2017 17:49:51 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <8C0D3021-5EC2-42E7-8C95-0DF1C3E6A20C@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486742918.2840.1.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 feb 2017, alle ore 17:08, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-02-07 at 18:24 +0100, Paolo Valente wrote:
>> [1] https://github.com/Algodev-github/bfq-mq
>=20
> Hello Paolo,
>=20
> That branch includes two changes of the version suffix (EXTRAVERSION =
in Makefile).
> Please don't do that but set CONFIG_LOCALVERSION in .config to add a =
suffix to
> the kernel version string.
>=20

I know it, thanks. Unfortunately, many other irregular things you will =
probably find in that sort of private branch (as for that suffix, for =
some reason it was handy for me to have it tracked by git).

Thanks,
Paolo

> Thanks,
>=20
> Bart.
