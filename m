Return-Path: <efault@gmx.de>
Message-ID: <1504199166.666.11.camel@gmx.de>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/3] three bfq fixes restoring
 service guarantees with random sync writes in bg
From: Mike Galbraith <efault@gmx.de>
To: Mel Gorman <mgorman@techsingularity.net>, Paolo Valente
	 <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org,
	lee.tibbert@gmail.com, oleksandr@natalenko.name
Date: Thu, 31 Aug 2017 19:06:06 +0200
In-Reply-To: <20170831144257.oa5nm6vzihpam6kw@techsingularity.net>
References: <20170831064631.2223-1-paolo.valente@linaro.org>
	 <20170831144257.oa5nm6vzihpam6kw@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-31 at 15:42 +0100, Mel Gorman wrote:
> On Thu, Aug 31, 2017 at 08:46:28AM +0200, Paolo Valente wrote:
> > [SECOND TAKE, with just the name of one of the tester fixed]
> >=20
> > Hi,
> > while testing the read-write unfairness issues reported by Mel, I
> > found BFQ failing to guarantee good responsiveness against heavy
> > random sync writes in the background, i.e., multiple writers doing
> > random writes and systematic fdatasync [1]. The failure was caused by
> > three related bugs, because of which BFQ failed to guarantee to
> > high-weight processes the expected fraction of the throughput.
> >=20
>=20
> Queued on top of Ming's most recent series even though that's still a wor=
k
> in progress. I should know in a few days how things stand.

It seems to have cured an interactivity issue I regularly meet during
kbuild final link/depmod phase of fat kernel kbuild, especially bad
with evolution mail usage during that on spinning rust. =C2=A0Can't really
say for sure given this is not based on measurement.

	-Mike=C2=A0
