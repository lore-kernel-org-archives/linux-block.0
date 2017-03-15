Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <64ef5694-d62d-e14c-ce80-a213c406bf22@kernel.dk>
Date: Wed, 15 Mar 2017 10:56:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170304160131.57366-11-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 09:01 AM, Paolo Valente wrote:
> @@ -6330,7 +7012,41 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  
>  static void __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
>  {
> -	struct bfq_queue *bfqq = RQ_BFQQ(rq);
> +	struct bfq_queue *bfqq = RQ_BFQQ(rq), *new_bfqq;
> +
> +	/*
> +	 * An unplug may trigger a requeue of a request from the device
> +	 * driver: make sure we are in process context while trying to
> +	 * merge two bfq_queues.
> +	 */
> +	if (!in_interrupt()) {

What's the reason for this? Don't use in_interrupt() to guide any of
your decision making here.

-- 
Jens Axboe
