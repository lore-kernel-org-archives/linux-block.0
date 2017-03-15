Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <64ef5694-d62d-e14c-ce80-a213c406bf22@kernel.dk>
Date: Wed, 15 Mar 2017 18:02:46 +0100
Cc: Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
Message-Id: <609A716A-F334-4A17-AA87-695CF789DFB2@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-11-paolo.valente@linaro.org> <64ef5694-d62d-e14c-ce80-a213c406bf22@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 15 mar 2017, alle ore 17:56, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 03/04/2017 09:01 AM, Paolo Valente wrote:
>> @@ -6330,7 +7012,41 @@ static void bfq_rq_enqueued(struct bfq_data =
*bfqd, struct bfq_queue *bfqq,
>>=20
>> static void __bfq_insert_request(struct bfq_data *bfqd, struct =
request *rq)
>> {
>> -	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);
>> +	struct bfq_queue *bfqq =3D RQ_BFQQ(rq), *new_bfqq;
>> +
>> +	/*
>> +	 * An unplug may trigger a requeue of a request from the device
>> +	 * driver: make sure we are in process context while trying to
>> +	 * merge two bfq_queues.
>> +	 */
>> +	if (!in_interrupt()) {
>=20
> What's the reason for this?

None :(

Just pre-existing, working code that I did not update, sorry.

> Don't use in_interrupt() to guide any of
> your decision making here.
>=20

Of course, sorry for these silly mistakes.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
