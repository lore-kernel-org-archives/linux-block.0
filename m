Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: fix bug causing crashes
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b7680e6e-b416-3cf9-c3ef-313da76950a5@kernel.dk>
Date: Tue, 4 Jul 2017 09:08:14 +0200
Cc: linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 ulf.hansson@linaro.org,
 broonie@kernel.org
Message-Id: <745245EB-0BE6-44E8-B32E-B062638FA620@linaro.org>
References: <20170703080010.1709-1-paolo.valente@linaro.org> <b7680e6e-b416-3cf9-c3ef-313da76950a5@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 04 lug 2017, alle ore 00:49, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 07/03/2017 02:00 AM, Paolo Valente wrote:
>> Hi Jens,
>> I'm writing this short cover letter to hopefully help you decide what
>> to do with this patch, in this late phase of the development
>> cycle. This patch fixes a bug causing kernel crashes for at least
>> one year. Crashes apparently affect only a minority of users, but are
>> systematic for them (a crash every few tens of minutes for some).
>=20
> By the time you wrote that email, 4.12 was already released for hours.

Oops ...

> So there's really no choice this time but to queue it up for 4.13.
>=20

At least, no decision to make :)

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
