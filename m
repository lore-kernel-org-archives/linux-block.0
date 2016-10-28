Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Linus Walleij <linus.walleij@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f71cb330-8e60-694e-0494-43ad8bc4b91b@kernel.dk>
Date: Fri, 28 Oct 2016 08:07:35 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 04:27 PM, Linus Walleij wrote:
> On Thu, Oct 27, 2016 at 11:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
>> blk-mq has evolved to support a variety of devices, there's nothing
>> special about mmc that can't work well within that framework.
>
> There is. Read mmc_queue_thread() in drivers/mmc/card/queue.c
>
> This repeatedly calls req = blk_fetch_request(q);, starting one request
> and then getting the next one off the queue, including reading
> a few NULL requests off the end of the queue (to satisfy the
> semantics of its state machine.
>
> It then preprocess each request by esstially calling .pre() and .post()
> hooks all the way down to the driver, flushing its mapped
> sglist from CPU to DMA device memory (not a problem on x86 and
> other DMA-coherent archs, but a big win on the incoherent ones).
>
> In the attempt that was posted recently this is achieved by lying
> and saying the HW queue is two items deep and eating requests
> off that queue calling pre/post on them.
>
> But as there actually exist MMC cards with command queueing, this
> would become hopeless to handle, the hw queue depth has to reflect
> the real depth. What we need is for the block core to call pre/post
> hooks on each request.
>
> The "only" thing that doesn't work well after that is that CFQ is no
> longer in action, which will have interesting effects on MMC throughput
> in any fio-like stress test as it is mostly single-hw-queue.

That will cause you pain with any IO scheduler that has more complex
state, like CFQ and BFQ... I looked at the code but I don't quite get
why it is handling requests like that. Care to expand? Is it a
performance optimization? It looks fairly convoluted for some reason. I
would imagine that latency would be one of the more important aspects
for mmc, yet the driver has a context switch for each sync IO.

-- 
Jens Axboe
