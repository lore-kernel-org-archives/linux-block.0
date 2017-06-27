Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX V2] block, bfq: update wr_busy_queues if needed on a queue split
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <e070788e-8a62-024d-7aac-8f8801722ffe@kernel.dk>
Date: Tue, 27 Jun 2017 20:27:06 +0200
Cc: linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 broonie@kernel.org
Message-Id: <4AFF2E52-DCE4-4DC7-9CB0-849EEED3A9AB@linaro.org>
References: <20170619114316.2587-1-paolo.valente@linaro.org> <8520D3AF-C161-439F-A7E8-A6B7202DA2D9@linaro.org> <e070788e-8a62-024d-7aac-8f8801722ffe@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 27 giu 2017, alle ore 16:41, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 06/27/2017 12:09 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 19 giu 2017, alle ore 13:43, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>> This commit fixes a bug triggered by a non-trivial sequence of
>>> events. These events are briefly described in the next two
>>> paragraphs. The impatiens, or those who are familiar with queue
>>> merging and splitting, can jump directly to the last paragraph.
>>>=20
>>> On each I/O-request arrival for a shared bfq_queue, i.e., for a
>>> bfq_queue that is the result of the merge of two or more bfq_queues,
>>> BFQ checks whether the shared bfq_queue has become seeky (i.e., if =
too
>>> many random I/O requests have arrived for the bfq_queue; if the =
device
>>> is non rotational, then random requests must be also small for the
>>> bfq_queue to be tagged as seeky). If the shared bfq_queue is =
actually
>>> detected as seeky, then a split occurs: the bfq I/O context of the
>>> process that has issued the request is redirected from the shared
>>> bfq_queue to a new non-shared bfq_queue. As a degenerate case, if =
the
>>> shared bfq_queue actually happens to be shared only by one process
>>> (because of previous splits), then no new bfq_queue is created: the
>>> state of the shared bfq_queue is just changed from shared to non
>>> shared.
>>>=20
>>> Regardless of whether a brand new non-shared bfq_queue is created, =
or
>>> the pre-existing shared bfq_queue is just turned into a non-shared
>>> bfq_queue, several parameters of the non-shared bfq_queue are set
>>> (restored) to the original values they had when the bfq_queue
>>> associated with the bfq I/O context of the process (that has just
>>> issued an I/O request) was merged with the shared bfq_queue. One of
>>> these parameters is the weight-raising state.
>>>=20
>>> If, on the split of a shared bfq_queue,
>>> 1) a pre-existing shared bfq_queue is turned into a non-shared
>>> bfq_queue;
>>> 2) the previously shared bfq_queue happens to be busy;
>>> 3) the weight-raising state of the previously shared bfq_queue =
happens
>>> to change;
>>> the number of weight-raised busy queues changes. The field
>>> wr_busy_queues must then be updated accordingly, but such an update
>>> was missing. This commit adds the missing update.
>>>=20
>>=20
>> Hi Jens,
>> any idea of the possible fate of this fix?
>=20
> I sort of missed this one. It looks trivial enough for 4.12, or we
> can defer until 4.13. What do you think?
>=20

It should actually be something trivial, and hopefully correct,
because a further throughput improvement (for BFQ), which depends on
this fix, is now working properly, and we didn't see any regression so
far.  In addition, since this improvement is virtually ready for
submission, further steps may be probably easier if this fix gets in
sooner (whatever the luck of the improvement will be).

Thanks,
Paolo

> --=20
> Jens Axboe
