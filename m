Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
 <64ef5694-d62d-e14c-ce80-a213c406bf22@kernel.dk>
 <609A716A-F334-4A17-AA87-695CF789DFB2@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9f8530b9-b73b-b6b9-0bb2-f45878d8c2fb@kernel.dk>
Date: Wed, 15 Mar 2017 15:01:05 -0600
MIME-Version: 1.0
In-Reply-To: <609A716A-F334-4A17-AA87-695CF789DFB2@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/15/2017 11:02 AM, Paolo Valente wrote:
> 
>> Il giorno 15 mar 2017, alle ore 17:56, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 03/04/2017 09:01 AM, Paolo Valente wrote:
>>> @@ -6330,7 +7012,41 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>>
>>> static void __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
>>> {
>>> -	struct bfq_queue *bfqq = RQ_BFQQ(rq);
>>> +	struct bfq_queue *bfqq = RQ_BFQQ(rq), *new_bfqq;
>>> +
>>> +	/*
>>> +	 * An unplug may trigger a requeue of a request from the device
>>> +	 * driver: make sure we are in process context while trying to
>>> +	 * merge two bfq_queues.
>>> +	 */
>>> +	if (!in_interrupt()) {
>>
>> What's the reason for this?
> 
> None :(
> 
> Just pre-existing, working code that I did not update, sorry.

OK good, then that check can simply be killed.

-- 
Jens Axboe
