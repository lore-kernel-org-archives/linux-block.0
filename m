Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:54830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755175AbeASDGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 22:06:51 -0500
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <james.smart@broadcom.com>,
        linux-block@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
References: <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
 <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
 <20180117095744.GF9487@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <53da00dc-3d46-dcdb-2be4-277f79a9888b@oracle.com>
Date: Fri, 19 Jan 2018 11:05:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180117095744.GF9487@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi ming

Sorry for delayed report this.

On 01/17/2018 05:57 PM, Ming Lei wrote:
> 2) hctx->next_cpu can become offline from online before __blk_mq_run_hw_queue
> is run, there isn't warning, but once the IO is submitted to hardware,
> after it is completed, how does the HBA/hw queue notify CPU since CPUs
> assigned to this hw queue(irq vector) are offline? blk-mq's timeout
> handler may cover that, but looks too tricky.

In theory, the irq affinity will be migrated to other cpu. This is done by
fixup_irqs() in the context of stop_machine.
However, in my test, I found this log:

[  267.161043] do_IRQ: 7.33 No irq handler for vector

The 33 is the vector used by nvme cq.
The irq seems to be missed and sometimes IO hang occurred.
It is not every time, I think maybe due to nvme_process_cq in nvme_queue_rq.

I add dump stack behind the error log and get following:
[  267.161043] do_IRQ: 7.33 No irq handler for vector migration/7
[  267.161045] CPU: 7 PID: 52 Comm: migration/7 Not tainted 4.15.0-rc7+ #27
[  267.161045] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[  267.161046] Call Trace:
[  267.161047]  <IRQ>
[  267.161052]  dump_stack+0x7c/0xb5
[  267.161054]  do_IRQ+0xb9/0xf0
[  267.161056]  common_interrupt+0xa2/0xa2
[  267.161057]  </IRQ>
[  267.161059] RIP: 0010:multi_cpu_stop+0xb0/0x120
[  267.161060] RSP: 0018:ffffbb6c81af7e70 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffde
[  267.161061] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000000
[  267.161062] RDX: 0000000000000006 RSI: ffffffff898c4591 RDI: 0000000000000202
[  267.161063] RBP: ffffbb6c826e7c88 R08: ffff991abc1256bc R09: 0000000000000005
[  267.161063] R10: ffffbb6c81af7db8 R11: ffffffff89c91d20 R12: 0000000000000001
[  267.161064] R13: ffffbb6c826e7cac R14: 0000000000000003 R15: 0000000000000000
[  267.161067]  ? cpu_stop_queue_work+0x90/0x90
[  267.161068]  cpu_stopper_thread+0x83/0x100
[  267.161070]  smpboot_thread_fn+0x161/0x220
[  267.161072]  kthread+0xf5/0x130
[  267.161073]  ? sort_range+0x20/0x20
[  267.161074]  ? kthread_associate_blkcg+0xe0/0xe0
[  267.161076]  ret_from_fork+0x24/0x30

The irq just occurred after the irq is enabled in multi_cpu_stop.

0xffffffff8112d655 is in multi_cpu_stop (/home/will/u04/source_code/linux-block/kernel/stop_machine.c:223).
218				 */
219				touch_nmi_watchdog();
220			}
221		} while (curstate != MULTI_STOP_EXIT);
222	
223		local_irq_restore(flags);
224		return err;
225	}


Thanks
Jianchao
