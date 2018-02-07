Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 alban.browaeys@gmail.com, ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, holger@applied-asynchrony.com, efault@gmx.de,
 Serena Ziviani <ziviani.serena@gmail.com>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
Date: Wed, 7 Feb 2018 15:18:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180207211920.6343-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/7/18 2:19 PM, Paolo Valente wrote:
> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq via
> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a device
> be re-inserted into the active I/O scheduler for that device. As a
> consequence, I/O schedulers may get the same request inserted again,
> even several times, without a finish_request invoked on that request
> before each re-insertion.
> 
> This fact is the cause of the failure reported in [1]. For an I/O
> scheduler, every re-insertion of the same re-prepared request is
> equivalent to the insertion of a new request. For schedulers like
> mq-deadline or kyber, this fact causes no harm. In contrast, it
> confuses a stateful scheduler like BFQ, which keeps state for an I/O
> request, until the finish_request hook is invoked on the request. In
> particular, BFQ may get stuck, waiting forever for the number of
> request dispatches, of the same request, to be balanced by an equal
> number of request completions (while there will be one completion for
> that request). In this state, BFQ may refuse to serve I/O requests
> from other bfq_queues. The hang reported in [1] then follows.
> 
> However, the above re-prepared requests undergo a requeue, thus the
> requeue_request hook of the active elevator is invoked for these
> requests, if set. This commit then addresses the above issue by
> properly implementing the hook requeue_request in BFQ.

Thanks, applied.

-- 
Jens Axboe
