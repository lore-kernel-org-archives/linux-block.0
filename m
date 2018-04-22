Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: testing io.low limit for blk-throttle
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <180654d2-17ef-0d25-bef6-f526e9ec4ea3@oracle.com>
Date: Sun, 22 Apr 2018 17:53:59 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <0AAB1A24-0E2E-4054-8D7F-6C1D69379A1F@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <180654d2-17ef-0d25-bef6-f526e9ec4ea3@oracle.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 22 apr 2018, alle ore 15:29, jianchao.wang =
<jianchao.w.wang@oracle.com> ha scritto:
>=20
> Hi Paolo
>=20
> I used to meet similar issue on io.low.
> Can you try the following patch to see whether the issue could be =
fixed.
> https://marc.info/?l=3Dlinux-block&m=3D152325456307423&w=3D2
> https://marc.info/?l=3Dlinux-block&m=3D152325457607425&w=3D2
>=20

Just tried. Unfortunately, nothing seems to change :(

Thanks,
Paolo

> Thanks
> Jianchao
>=20
> On 04/22/2018 05:23 PM, Paolo Valente wrote:
>> Hi Shaohua, all,
>> at last, I started testing your io.low limit for blk-throttle.  One =
of
>> the things I'm interested in is how good throttling is in achieving a
>> high throughput in the presence of realistic, variable workloads.
>>=20
>> However, I seem to have bumped into a totally different problem.  The
>> io.low parameter doesn't seem to guarantee what I understand it is =
meant
>> to guarantee: minimum per-group bandwidths.  For example, with
>> - one group, the interfered, containing one process that does =
sequential
>>  reads with fio
>> - io.low set to 100MB/s for the interfered
>> - six other groups, the interferers, with each interferer containing =
one
>>  process doing sequential read with fio
>> - io.low set to 10MB/s for each interferer
>> - the workload executed on an SSD, with a 500MB/s of overall =
throughput
>> the interfered gets only 75MB/s.
>>=20
>> In particular, the throughput of the interfered becomes lower and
>> lower as the number of interferers is increased.  So you can make it
>> become even much lower than the 75MB/s in the example above.  There
>> seems to be no control on bandwidth.
>>=20
>> Am I doing something wrong?  Or did I simply misunderstand the goal =
of
>> io.low, and the only parameter for guaranteeing the desired bandwidth =
to
>> a group is io.max (to be used indirectly, by limiting the bandwidth =
of
>> the interferers)?
>>=20
>> If useful for you, you can reproduce the above test very quickly, by
>> using the S suite [1] and typing:
>>=20
>> cd thr-lat-with-interference
>> sudo ./thr-lat-with-interference.sh -b t -w 100000000 -W "10000000 =
10000000 10000000 10000000 10000000 10000000" -n 6 -T "read read read =
read read read" -R "0 0 0 0 0 0"
>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
>> [1]=20
>>=20
