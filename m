Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix cloning of requests with a special payload
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 stable@vger.kernel.org
References: <20180627195518.13958-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78b15945-3457-f09f-4c67-0fcfdb9b78a2@kernel.dk>
Date: Thu, 28 Jun 2018 09:51:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180627195518.13958-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/27/18 1:55 PM, Bart Van Assche wrote:
> This patch avoids that removing a path controlled by the dm-mpath driver
> while mkfs is running triggers the following kernel bug:
> 
>     kernel BUG at block/blk-core.c:3347!
>     invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>     CPU: 20 PID: 24369 Comm: mkfs.ext4 Not tainted 4.18.0-rc1-dbg+ #2
>     RIP: 0010:blk_end_request_all+0x68/0x70
>     Call Trace:
>      <IRQ>
>      dm_softirq_done+0x326/0x3d0 [dm_mod]
>      blk_done_softirq+0x19b/0x1e0
>      __do_softirq+0x128/0x60d
>      irq_exit+0x100/0x110
>      smp_call_function_single_interrupt+0x90/0x330
>      call_function_single_interrupt+0xf/0x20
>      </IRQ>

Thanks Bart, applied for 4.18.

-- 
Jens Axboe
