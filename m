Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: bug in tag handling in blk-mq?
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
Date: Mon, 7 May 2018 20:02:03 +0200
Cc: Mike Galbraith <efault@gmx.de>,
 Christoph Hellwig <hch@lst.de>,
 linux-block <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Message-Id: <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 07 mag 2018, alle ore 18:39, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 5/7/18 8:03 AM, Paolo Valente wrote:
>> Hi Jens, Christoph, all,
>> Mike Galbraith has been experiencing hangs, on blk_mq_get_tag, only
>> with bfq [1].  Symptoms seem to clearly point to a problem in I/O-tag
>> handling, triggered by bfq because it limits the number of tags for
>> async and sync write requests (in bfq_limit_depth).
>>=20
>> Fortunately, I just happened to find a way to apparently confirm it.
>> With the following one-liner for block/bfq-iosched.c:
>>=20
>> @@ -554,8 +554,7 @@ static void bfq_limit_depth(unsigned int op, =
struct blk_mq_alloc_data *data)
>>        if (unlikely(bfqd->sb_shift !=3D bt->sb.shift))
>>                bfq_update_depths(bfqd, bt);
>>=20
>> -       data->shallow_depth =3D
>> -               =
bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
>> +       data->shallow_depth =3D 1;
>>=20
>>        bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
>>                        __func__, bfqd->wr_busy_queues, =
op_is_sync(op),
>>=20
>> Mike's machine now crashes soon and systematically, while nothing bad
>> happens on my machines, even with heavy workloads (apart from an
>> expected throughput drop).
>>=20
>> This change simply reduces to 1 the maximum possible value for the =
sum
>> of the number of async requests and of sync write requests.
>>=20
>> This email is basically a request for help to knowledgeable people.  =
To
>> start, here are my first doubts/questions:
>> 1) Just to be certain, I guess it is not normal that blk-mq hangs if
>> async requests and sync write requests can be at most one, right?
>> 2) Do you have any hint to where I could look for, to chase this bug?
>> Of course, the bug may be in bfq, i.e, it may be a somehow unrelated
>> bfq bug that causes this hang in blk-mq, indirectly.  But it is hard
>> for me to understand how.
>=20
> CC Omar, since he implemented the shallow part. But we'll need some
> traces to show where we are hung, probably also the value of the
> /sys/debug/kernel/block/<dev>/ directory. For the crash mentioned, a
> trace as well. Otherwise we'll be wasting a lot of time on this.
>=20
> Is there a reproducer?
>=20

Ok Mike, I guess it's your turn now, for at least a stack trace.

Thanks,
Paolo

> --=20
> Jens Axboe
