Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525672597.5064.3.camel@gmx.de>
Date: Mon, 7 May 2018 11:27:25 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
 <1525672597.5064.3.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 07 mag 2018, alle ore 07:56, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
>>=20
>> diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
>> index 118f319af7c0..6662efe29b69 100644
>> --- a/block/bfq-mq-iosched.c
>> +++ b/block/bfq-mq-iosched.c
>> @@ -525,8 +525,13 @@ static void bfq_limit_depth(unsigned int op, =
struct blk_mq_alloc_data *data)
>>        if (unlikely(bfqd->sb_shift !=3D bt->sb.shift))
>>                bfq_update_depths(bfqd, bt);
>>=20
>> +#if 0
>>        data->shallow_depth =3D
>>                =
bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
>                                                            =
^^^^^^^^^^^^^
>=20
> Q: why doesn't the top of this function look like so?
>=20
> ---
> block/bfq-iosched.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -539,7 +539,7 @@ static void bfq_limit_depth(unsigned int
> 	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
> 	struct sbitmap_queue *bt;
>=20
> -	if (op_is_sync(op) && !op_is_write(op))
> +	if (!op_is_write(op))
> 		return;
>=20
> 	if (data->flags & BLK_MQ_REQ_RESERVED) {
>=20
> It looks a bit odd that these elements exist...
>=20
> +       /*
> +        * no more than 75% of tags for sync writes (25% extra tags
> +        * w.r.t. async I/O, to prevent async I/O from starving sync
> +        * writes)
> +        */
> +       bfqd->word_depths[0][1] =3D max(((1U<<bfqd->sb_shift) * 3)>>2, =
1U);
>=20
> +       /* no more than ~37% of tags for sync writes (~20% extra tags) =
*/
> +       bfqd->word_depths[1][1] =3D max(((1U<<bfqd->sb_shift) * 6)>>4, =
1U);
>=20
> ...yet we index via and log a guaranteed zero.
>=20

I'm not sure I got your point, so, to help you help me quickly, I'll
repeat what I expect the code you highlight to do:

- sync reads must have no limitation, and the lines
if (op_is_sync(op) && !op_is_write(op))
	return;
make sure they don't

- sync writes must be limited, and the code you pasted above computes
those limits

- for sync writes, for which op_is_sync(op) is true (but the condition
"op_is_sync(op) && !op_is_write(op)" is false), the line:
	bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
becomes
	bfqd->word_depths[!!bfqd->wr_busy_queues][1];
e yields the right limit for sync writes, depending on =
bfqd->wr_busy_queues.

Where is the bug?

Thanks,
Paolo


> 	-Mike
>=20
>=20
