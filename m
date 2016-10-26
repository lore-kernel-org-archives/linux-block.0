Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
Date: Wed, 26 Oct 2016 18:04:56 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 grant.likely@secretlab.ca,
 James.Bottomley@hansenpartnership.com
Message-Id: <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org> <20161026113443.GA13587@quack2.suse.cz> <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com> <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org> <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 26 ott 2016, alle ore 17:32, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/26/2016 09:29 AM, Christoph Hellwig wrote:
>> On Wed, Oct 26, 2016 at 05:13:07PM +0200, Arnd Bergmann wrote:
>>> The question to ask first is whether to actually have pluggable
>>> schedulers on blk-mq at all, or just have one that is meant to
>>> do the right thing in every case (and possibly can be bypassed
>>> completely).
>>=20
>> That would be my preference.  Have a BFQ-variant for blk-mq as an
>> option (default to off unless opted in by the driver or user), and
>> not other scheduler for blk-mq.  Don't bother with bfq for non
>> blk-mq.  It's not like there is any advantage in the legacy-request
>> device even for slow devices, except for the option of having I/O
>> scheduling.
>=20
> It's the only right way forward. blk-mq might not offer any =
substantial
> advantages to rotating storage, but with scheduling, it won't offer a
> downside either. And it'll take us towards the real goal, which is to
> have just one IO path.

ok

> Adding a new scheduler for the legacy IO path
> makes no sense.

I would fully agree if effective and stable I/O scheduling would be
available in blk-mq in one or two months.  But I guess that it will
take at least one year optimistically, given the current status of the
needed infrastructure, and given the great difficulties of doing
effective scheduling at the high parallelism and extreme target speeds
of blk-mq.  Of course, this holds true unless little clever scheduling
is performed.

So, what's the point in forcing a lot of users wait another year or
more, for a solution that has yet to be even defined, while they could
enjoy a much better system, and then switch an even better system when
scheduling is ready in blk-mq too?

For example, currently, opening a terminal on a 50KIOPS SSD with cfq,
deadline or noop, if there happens to be some background workload,
takes *more* time than opening the same terminal on a 1KIOPS HDD with
the same background workload, but with BFQ.  Does this make any sense?

> Adding one for blk-mq and phasing out the old path is
> what we need to do.
>=20

Yes, as the ultimate goal.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
