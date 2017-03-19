Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1489850658.2339.1.camel@sandisk.com>
Date: Sun, 19 Mar 2017 07:45:30 -0400
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <C37CED4C-5A92-422B-B6C9-4ECCD7E596A3@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com> <0B1F1CFD-C8AB-442D-B5C6-426D19B1FBA3@linaro.org> <1489850658.2339.1.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 18 mar 2017, alle ore 11:24, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Sat, 2017-03-18 at 08:08 -0400, Paolo Valente wrote:
>>> Il giorno 06 mar 2017, alle ore 14:40, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>> +#define BFQ_BFQQ_FNS(name)						=
\
>>>> +static void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)		=
\
>>>> +{									=
\
>>>> +	(bfqq)->flags |=3D (1 << BFQ_BFQQ_FLAG_##name);			=
\
>>>> +}									=
\
>>>> +static void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)		=
\
>>>> +{									=
\
>>>> +	(bfqq)->flags &=3D ~(1 << BFQ_BFQQ_FLAG_##name);			=
\
>>>> +}									=
\
>>>> +static int bfq_bfqq_##name(const struct bfq_queue *bfqq)		=
\
>>>> +{									=
\
>>>> +	return ((bfqq)->flags & (1 << BFQ_BFQQ_FLAG_##name)) !=3D 0;	=
\
>>>> +}
>>>=20
>>> Are the bodies of the above functions duplicates of __set_bit(),
>>> __clear_bit() and test_bit()?
>>=20
>> Yes.  We wrapped them into functions, because writing mark_flag_name
>> seemed more readable than writing the implementation of the marking =
of the
>> flag.
>=20
> Please do not open-code __set_bit(), __clear_bit() and test_bit() but =
use
> these macros instead.
>=20

ok, as usual, I misunderstood, and thought you wanted me to remove
those macros altogether.  I'll fix their bodies, sorry.

>>>> +	} else
>>>> +		/*
>>>> +		 * Async queues get always the maximum possible
>>>> +		 * budget, as for them we do not care about latency
>>>> +		 * (in addition, their ability to dispatch is limited
>>>> +		 * by the charging factor).
>>>> +		 */
>>>> +		budget =3D bfqd->bfq_max_budget;
>>>> +
>>>=20
>>> Please balance braces. Checkpatch should have warned about the use =
of "}
>>> else" instead of "} else {".
>>=20
>> No warning, I guess because the body of the else contains only a
>> simple instruction.  Just to learn for the future: what's the
>> rationale for adding braces here, but not imposing braces everywhere
>> for single-instruction bodies?
>=20
> It's a general style recommendation for all kernel code: if braces are =
used
> for one side of an if-statement, also use braces for the other side, =
and
> definitely if that other side consists of multiple lines due to a =
comment.
>=20

Ok, thanks for repeating this rule for me.

Thanks,
Paolo

> Bart.
