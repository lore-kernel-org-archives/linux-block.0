Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX V2 1/1] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4815ec99-8c92-4c3b-c6c0-33425a6f2bc6@kernel.dk>
Date: Wed, 7 Feb 2018 21:53:35 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>,
 ivan@ludios.org,
 169364@studenti.unimore.it,
 holger@applied-asynchrony.com,
 efault@gmx.de,
 Serena Ziviani <ziviani.serena@gmail.com>
Message-Id: <616D9096-8E3B-4C1E-BBDA-182A854197FB@linaro.org>
References: <20180207180050.5639-1-paolo.valente@linaro.org>
 <20180207180050.5639-2-paolo.valente@linaro.org>
 <4815ec99-8c92-4c3b-c6c0-33425a6f2bc6@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 07 feb 2018, alle ore 19:06, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 2/7/18 11:00 AM, Paolo Valente wrote:
>> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq =
via
>> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a =
device
>> be re-inserted into the active I/O scheduler for that device. As a
>> consequence, I/O schedulers may get the same request inserted again,
>> even several times, without a finish_request invoked on that request
>> before each re-insertion.
>>=20
>> This fact is the cause of the failure reported in [1]. For an I/O
>> scheduler, every re-insertion of the same re-prepared request is
>> equivalent to the insertion of a new request. For schedulers like
>> mq-deadline or kyber, this fact causes no harm. In contrast, it
>> confuses a stateful scheduler like BFQ, which keeps state for an I/O
>> request, until the finish_request hook is invoked on the request. In
>> particular, BFQ may get stuck, waiting forever for the number of
>> request dispatches, of the same request, to be balanced by an equal
>> number of request completions (while there will be one completion for
>> that request). In this state, BFQ may refuse to serve I/O requests
>> from other bfq_queues. The hang reported in [1] then follows.
>>=20
>> However, the above re-prepared requests undergo a requeue, thus the
>> requeue_request hook of the active elevator is invoked for these
>> requests, if set. This commit then addresses the above issue by
>> properly implementing the hook requeue_request in BFQ.
>>=20
>> [1] https://marc.info/?l=3Dlinux-block&m=3D151211117608676
>>=20
>> Reported-by: Ivan Kozik <ivan@ludios.org>
>> Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
>> Tested-by: Mike Galbraith <efault@gmx.de>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Serena Ziviani <ziviani.serena@gmail.com>
>> ---
>> block/bfq-iosched.c | 109 =
++++++++++++++++++++++++++++++++++++++++------------
>> 1 file changed, 84 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 47e6ec7427c4..21e6b9e45638 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -3823,24 +3823,26 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>> 		}
>>=20
>> 		/*
>> -		 * We exploit the bfq_finish_request hook to decrement
>> -		 * rq_in_driver, but bfq_finish_request will not be
>> -		 * invoked on this request. So, to avoid unbalance,
>> -		 * just start this request, without incrementing
>> -		 * rq_in_driver. As a negative consequence,
>> -		 * rq_in_driver is deceptively lower than it should be
>> -		 * while this request is in service. This may cause
>> -		 * bfq_schedule_dispatch to be invoked uselessly.
>> +		 * We exploit the bfq_finish_requeue_request hook to
>> +		 * decrement rq_in_driver, but
>> +		 * bfq_finish_requeue_request will not be invoked on
>> +		 * this request. So, to avoid unbalance, just start
>> +		 * this request, without incrementing rq_in_driver. As
>> +		 * a negative consequence, rq_in_driver is deceptively
>> +		 * lower than it should be while this request is in
>> +		 * service. This may cause bfq_schedule_dispatch to be
>> +		 * invoked uselessly.
>> 		 *
>> 		 * As for implementing an exact solution, the
>> -		 * bfq_finish_request hook, if defined, is probably
>> -		 * invoked also on this request. So, by exploiting
>> -		 * this hook, we could 1) increment rq_in_driver here,
>> -		 * and 2) decrement it in bfq_finish_request. Such a
>> -		 * solution would let the value of the counter be
>> -		 * always accurate, but it would entail using an extra
>> -		 * interface function. This cost seems higher than the
>> -		 * benefit, being the frequency of non-elevator-private
>> +		 * bfq_finish_requeue_request hook, if defined, is
>> +		 * probably invoked also on this request. So, by
>> +		 * exploiting this hook, we could 1) increment
>> +		 * rq_in_driver here, and 2) decrement it in
>> +		 * bfq_finish_requeue_request. Such a solution would
>> +		 * let the value of the counter be always accurate,
>> +		 * but it would entail using an extra interface
>> +		 * function. This cost seems higher than the benefit,
>> +		 * being the frequency of non-elevator-private
>> 		 * requests very low.
>> 		 */
>> 		goto start_rq;
>> @@ -4515,6 +4517,8 @@ static inline void =
bfq_update_insert_stats(struct request_queue *q,
>> 					   unsigned int cmd_flags) {}
>> #endif
>>=20
>> +static void bfq_prepare_request(struct request *rq, struct bio =
*bio);
>> +
>> static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct =
request *rq,
>> 			       bool at_head)
>> {
>> @@ -4541,6 +4545,20 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>> 		else
>> 			list_add_tail(&rq->queuelist, &bfqd->dispatch);
>> 	} else {
>> +		if (!bfqq) {
>> +			/*
>> +			 * This should never happen. Most likely rq is
>> +			 * a requeued regular request, being
>> +			 * re-inserted without being first
>> +			 * re-prepared. Do a prepare, to avoid
>> +			 * failure.
>> +			 */
>> +			pr_warn("Regular request associated with no =
queue");
>> +			WARN_ON(1);
>> +			bfq_prepare_request(rq, rq->bio);
>> +			bfqq =3D RQ_BFQQ(rq);
>=20
> This reads kind of strange. "Regular request not associated with a
> queue" would be cleaner. Do we really need the message? Why not just
> make the above:
>=20
> 	if (WARN_ON_ONCE(!bfqq)) {
> 		bfq_prepare_request(rq, rq->bio);
> 		bfqq =3D RQ_BFQQ(rq);
> 	}
>=20
> which is much simpler, kills the useless message, and avoids constant
> spew in case it does trigger.
>=20

I added that message because I thought that just a warning on a !bfqq
would have told nothing to a user.  But probably that message is about
as enigmatic and useless.  And I went for a WARN_ON, because I expect
this anomaly to never happen, so the number of warning would have
provided information too.  But, also in this case, I guess cons would
be more than pros.

Anyway, ok to your recommendation.

Thanks,
Paolo

> --=20
> Jens Axboe
