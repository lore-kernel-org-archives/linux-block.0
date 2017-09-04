Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/3] three bfq fixes restoring service guarantees with random sync writes in bg
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170904081451.swq52kn2x24guphz@techsingularity.net>
Date: Mon, 4 Sep 2017 10:55:13 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 broonie@kernel.org,
 lee.tibbert@gmail.com,
 oleksandr@natalenko.name
Message-Id: <4532CA63-C71A-41E9-AE91-D685F3692475@linaro.org>
References: <20170831064631.2223-1-paolo.valente@linaro.org> <20170831144257.oa5nm6vzihpam6kw@techsingularity.net> <20170904081451.swq52kn2x24guphz@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 04 set 2017, alle ore 10:14, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> On Thu, Aug 31, 2017 at 03:42:57PM +0100, Mel Gorman wrote:
>> On Thu, Aug 31, 2017 at 08:46:28AM +0200, Paolo Valente wrote:
>>> [SECOND TAKE, with just the name of one of the tester fixed]
>>>=20
>>> Hi,
>>> while testing the read-write unfairness issues reported by Mel, I
>>> found BFQ failing to guarantee good responsiveness against heavy
>>> random sync writes in the background, i.e., multiple writers doing
>>> random writes and systematic fdatasync [1]. The failure was caused =
by
>>> three related bugs, because of which BFQ failed to guarantee to
>>> high-weight processes the expected fraction of the throughput.
>>>=20
>>=20
>> Queued on top of Ming's most recent series even though that's still a =
work
>> in progress. I should know in a few days how things stand.
>>=20
>=20
> The problems with parallel heavy writers seem to have disappeared with =
this
> series. There are still revisions taking place on Ming's to overall =
setting
> of legacy vs mq is still a work in progress but this series looks =
good.
>=20

Great news!

Thanks for testing,
Paolo

> Thanks.
>=20
> --=20
> Mel Gorman
> SUSE Labs
