Return-Path: <prvs=06256fa0ea=borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
 <4c774763-3c47-f930-a44e-5fcc5ae5afa0@kernel.dk>
 <9dd9c0a0-cc7a-eca4-21cc-876ed031dada@kernel.dk>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Mar 2018 17:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <9dd9c0a0-cc7a-eca4-21cc-876ed031dada@kernel.dk>
Content-Type: text/plain; charset=utf-8
Message-Id: <73ec6738-1471-5621-33b4-3a96510da9f0@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

With that patch I now get:

[   40.620619] virbr0: port 1(virbr0-nic) entered disabled state
[   47.418592] run queue from wrong CPU 3, hctx inactive
[   47.418602] CPU: 3 PID: 2153 Comm: kworker/3:1H Tainted: G        W        4.16.0-rc7+ #27
[   47.418604] Hardware name: IBM 2964 NC9 704 (LPAR)
[   47.418613] Workqueue: kblockd blk_mq_run_work_fn
[   47.418615] Call Trace:
[   47.418621] ([<0000000000113b86>] show_stack+0x56/0x80)
[   47.418626]  [<0000000000a5cd9a>] dump_stack+0x82/0xb0 
[   47.418627]  [<000000000069c4be>] __blk_mq_run_hw_queue+0x136/0x160 
[   47.418631]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   47.418633]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   47.418635]  [<000000000016a9d0>] kthread+0x148/0x160 
[   47.418639]  [<0000000000a7bf3a>] kernel_thread_starter+0x6/0xc 
[   47.418640]  [<0000000000a7bf34>] kernel_thread_starter+0x0/0xc 
[   77.670407] run queue from wrong CPU 4, hctx inactive
[   77.670416] CPU: 4 PID: 2155 Comm: kworker/4:1H Tainted: G        W        4.16.0-rc7+ #27
[   77.670418] Hardware name: IBM 2964 NC9 704 (LPAR)
[   77.670428] Workqueue: kblockd blk_mq_run_work_fn
[   77.670430] Call Trace:
[   77.670436] ([<0000000000113b86>] show_stack+0x56/0x80)
[   77.670441]  [<0000000000a5cd9a>] dump_stack+0x82/0xb0 
[   77.670442]  [<000000000069c4be>] __blk_mq_run_hw_queue+0x136/0x160 
[   77.670446]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   77.670448]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   77.670450]  [<000000000016a9d0>] kthread+0x148/0x160 
[   77.670454]  [<0000000000a7bf3a>] kernel_thread_starter+0x6/0xc 
[   77.670455]  [<0000000000a7bf34>] kernel_thread_starter+0x0/0xc 



On 03/28/2018 04:53 PM, Jens Axboe wrote:
> On 3/28/18 8:38 AM, Jens Axboe wrote:
>> On 3/28/18 1:45 AM, Christian Borntraeger wrote:
>>> FWIW, this patch does not fix the issue for me:
>>
>> Looks like I didn't do the delayed path. How about the below?
> 
> OK, final version... This is more in line with what I originally
> suggested.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 16e83e6df404..c90016c36a70 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1306,6 +1306,10 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
>  	int srcu_idx;
> 
> +	if (!blk_mq_hw_queue_mapped(hctx) &&
> +	    !WARN_ON_ONCE(blk_mq_hctx_has_pending(hctx)))
> +		return;
> +
>  	/*
>  	 * We should be running this queue from one of the CPUs that
>  	 * are mapped to it.
> @@ -1399,9 +1403,6 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
>  					unsigned long msecs)
>  {
> -	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
> -		return;
> -
>  	if (unlikely(blk_mq_hctx_stopped(hctx)))
>  		return;
> 
> @@ -1586,9 +1587,6 @@ static void blk_mq_run_work_fn(struct work_struct *work)
> 
>  void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>  {
> -	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
> -		return;
> -
>  	/*
>  	 * Stop the hw queue, then modify currently delayed work.
>  	 * This should prevent us from running the queue prematurely.
> 
