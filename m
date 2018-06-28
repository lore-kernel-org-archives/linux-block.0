Return-Path: <msnitzer@redhat.com>
Date: Thu, 28 Jun 2018 11:33:11 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
Subject: Re: block: Fix cloning of requests with a special payload
Message-ID: <20180628153311.GB17723@redhat.com>
References: <20180627195518.13958-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627195518.13958-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27 2018 at  3:55pm -0400,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

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
> 
> Fixes: f9d03f96b988 ("block: improve handling of the magic discard payload")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: <stable@vger.kernel.org>

Acked-by: Mike Snitzer <snitzer@redhat.com>
