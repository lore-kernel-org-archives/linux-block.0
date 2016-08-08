Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo <paolo.valente@linaro.org>
Subject: [RFD] I/O scheduling in blk-mq
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Message-ID: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
Date: Mon, 8 Aug 2016 16:09:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Jens, Tejun, Christoph, all,
AFAIK blk-mq does not yet feature I/O schedulers. In particular, there
is no scheduler providing strong guarantees in terms of
responsiveness, latency for time-sensitive applications and bandwidth
distribution.

For this reason, I'm trying to port BFQ to blk-mq, or to develop
something simpler if even a reduced version of BFQ proves to be too
heavy (this project is supported by Linaro). If you are willing to
provide some feedback in this respect, I would like to ask for
opinions/suggestions on the following two matters, and possibly to
open a more general discussion on I/O scheduling in blk-mq.

1) My idea is to have an independent instance of BFQ, or in general of
the I/O scheduler, executed for each software queue. Then there would
be no global scheduling. The drawback of no global scheduling is that
each process cannot get more than 1/M of the total throughput of the
device, if M is the number of software queues. But, if I'm not
mistaken, it is however unfeasible to give a process more than 1/M of
the total throughput, without lowering the throughput itself. In fact,
giving a process more than 1/M of the total throughput implies serving
its software queue, say Q, more than the others.  The only way to do
it is periodically stopping the service of the other software queues
and dispatching only the requests in Q. But this would reduce
parallelism, which is the main way how blk-mq achieves a very high
throughput. Are these considerations, and, in particular, one
independent I/O scheduler per software queue, sensible?

2) To provide per-process service guarantees, an I/O scheduler must
create per-process internal queues. BFQ and CFQ use I/O contexts to
achieve this goal. Is something like that (or exactly the same)
available also in blk-mq? If so, do you have any suggestion, or link to
documentation/code on how to use what is available in blk-mq?

Thanks,
Paolo
