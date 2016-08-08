Return-Path: <bvanassche@acm.org>
Subject: Re: [RFD] I/O scheduling in blk-mq
To: Paolo <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
References: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <3f7cbbcf-7ba3-5753-8e08-7035ef56f32f@acm.org>
Date: Mon, 8 Aug 2016 08:26:05 -0700
MIME-Version: 1.0
In-Reply-To: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/08/16 07:09, Paolo wrote:
> 2) To provide per-process service guarantees, an I/O scheduler must
> create per-process internal queues. BFQ and CFQ use I/O contexts to
> achieve this goal. Is something like that (or exactly the same)
> available also in blk-mq? If so, do you have any suggestion, or link to
> documentation/code on how to use what is available in blk-mq?

Hello Paolo,

I/O contexts are, by definition, data structures that are shared by 
multiple I/O queues. blk-mq reaches high performance by keeping each 
per-CPU queue independent. This means that using I/O contexts in a 
blk-mq I/O scheduler would introduce a contention point and probably 
also a performance bottleneck. So I would appreciate it if multiqueue 
schedulers would avoid constructs similar to I/O contexts.

Thanks,

Bart.
