Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.16-RC7 WARNING: CPU: 2 PID: 0 at block/blk-mq.c:1400
 __blk_mq_delay_run_hw_queue
To: Ming Lei <ming.lei@redhat.com>, Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <96392d4b-f890-7b34-8f1e-8d51855327cc@linux.vnet.ibm.com>
 <20180327120143.GA20265@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Mar 2018 17:22:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180327120143.GA20265@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <4f039923-19cb-4268-c897-145d5d9f46d2@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 03/27/2018 02:01 PM, Ming Lei wrote:
> Hi Stefan,
> 
> On Tue, Mar 27, 2018 at 12:04:20PM +0200, Stefan Haberland wrote:
>> Hi,
>>
>> I get the following warning in __blk_mq_delay_run_hw_queue when the
>> scheduler is set to mq-deadline for DASD devices on s390.
>>
>> What I see is that for whatever reason there is a hctx nr 0 which has no
>> hctx->tags pointer set.
>> From my observation it is always hctx nr 0 which has a tags NULL pointer in
>> it and I see other hctx which have the hctx->tags pointer set correctly.
>>
>>
>> [    2.169986] WARNING: CPU: 0 PID: 0 at block/blk-mq.c:1402
>> __blk_mq_delay_run_hw_queue+0xe8/0x118
>> [    2.170007] Modules linked in:
>> [    2.170014] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>> 4.16.0-rc7-04107-g91a05d9e1d6b-dirty #147
>> [    2.170019] Hardware name: IBM 2964 N96 702 (z/VM 6.4.0)
>> [    2.170024] Krnl PSW : 0000000076fd6c7f 00000000c244c24d
>> (__blk_mq_delay_run_hw_queue+0xe8/0x118)
>> [    2.170035]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
>> RI:0 EA:3
>> [    2.170041] Krnl GPRS: 00000000599ec58a 0000000002a94000 0000000002a94000
>> 0000000000000001
>> [    2.170047]            0000000000000000 000000006e761e98 0000000002a96980
>> 0000000002a96800
>> [    2.170052]            0000000002d87ce0 00000000737fbda8 0000000000000000
>> 0000000000000001
>> [    2.170058]            0000000000000001 0000000000aedd10 00000000737fbc38
>> 00000000737fbc00
>> [    2.170069] Krnl Code: 00000000006ea3c8: ebaff0a00004 lmg    
>> %r10,%r15,160(%r15)
>>                           00000000006ea3ce: c0f4ffff5e0d brcl    15,6d5fe8
>>                          #00000000006ea3d4: a7f40001 brc     15,6ea3d6
>>                          >00000000006ea3d8: e340f0c00004        lg     
>> %r4,192(%r15)
>>                           00000000006ea3de: ebaff0a00004 lmg    
>> %r10,%r15,160(%r15)
>>                           00000000006ea3e4: 07f4 bcr     15,%r4
>>                           00000000006ea3e6: 41b01100 la      %r11,256(%r1)
>>                           00000000006ea3ea: 182a lr      %r2,%r10
>> [    2.170158] Call Trace:
>> [    2.170205] ([<0000000002a96800>] 0x2a96800)
>> [    2.170248]  [<00000000006ea4c0>] blk_mq_run_hw_queue+0xa0/0x100
>> [    2.170262]  [<00000000006ea59c>] blk_mq_run_hw_queues+0x7c/0x98
>> [    2.170295]  [<00000000006e88f6>] __blk_mq_complete_request+0x10e/0x1e0
>> [    2.170300]  [<00000000006e9e30>] blk_mq_complete_request+0x80/0xa0
>> [    2.170307]  [<000000000087fad0>] dasd_block_tasklet+0x218/0x480
>> [    2.170415]  [<000000000017c3f8>] tasklet_hi_action+0xa0/0x138
>> [    2.170434]  [<0000000000a91c10>] __do_softirq+0xc8/0x540
>> [    2.170471]  [<000000000017bd4e>] irq_exit+0x136/0x140
>> [    2.170478]  [<000000000010c912>] do_IRQ+0x8a/0xb8
>> [    2.170518]  [<0000000000a90ee0>] io_int_handler+0x138/0x2e0
>> [    2.170524]  [<0000000000102cd0>] enabled_wait+0x58/0x128
>> [    2.170562] ([<0000000000102cb8>] enabled_wait+0x40/0x128)
>> [    2.170577]  [<000000000010319a>] arch_cpu_idle+0x32/0x48
>> [    2.170604]  [<0000000000a8f636>] default_idle_call+0x3e/0x58
>> [    2.170613]  [<00000000001cd5d2>] do_idle+0xda/0x190
>> [    2.170621]  [<00000000001cd93e>] cpu_startup_entry+0x3e/0x48
>> [    2.170633]  [<0000000000e5ebf4>] start_kernel+0x47c/0x490
>> [    2.170641]  [<0000000000100020>] _stext+0x20/0x80
>> [    2.170650] 2 locks held by swapper/0/0:
>> [    2.170658]  #0:  (&(&dq->lock)->rlock){..-.}, at: [<00000000b45eaf9e>]
>> dasd_block_tasklet+0x1cc/0x480
>> [    2.170676]  #1:  (rcu_read_lock){....}, at: [<00000000bc7fa045>]
>> hctx_lock+0x34/0x110
>> [    2.170750] Last Breaking-Event-Address:
>> [    2.170758]  [<00000000006ea3d4>] __blk_mq_delay_run_hw_queue+0xe4/0x118
>> [    2.170803] ---[ end trace 1073cf0de1fd32d0 ]---
> 
> This warning is harmless, please try the following patch:
> 
> --
> From 7b2b5139bfef80f44d1b1424e09ab35b715fbfdb Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Tue, 27 Mar 2018 19:54:23 +0800
> Subject: [PATCH] blk-mq: only run mapped hw queues in blk_mq_run_hw_queues()
> 
> From commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule
> with each possisble CPU") on, it should be easier to see unmapped hctx
> in some CPU topo, such as, hctx may not be mapped to any CPU.
> 
> This patch avoids the warning in __blk_mq_delay_run_hw_queue() by
> checking if the hctx is mapped in blk_mq_run_hw_queues().
> 
> Reported-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Can we get this into 4.16?

> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 16e83e6df404..48f25a63833b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1459,7 +1459,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
>  	int i;
> 
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (blk_mq_hctx_stopped(hctx))
> +		if (blk_mq_hctx_stopped(hctx) || !blk_mq_hw_queue_mapped(hctx))
>  			continue;
> 
>  		blk_mq_run_hw_queue(hctx, async);
> 
