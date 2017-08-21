Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 21 Aug 2017 07:48:56 -0700
From: Tejun Heo <tj@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] blk-mq: don't use WORK_CPU_UNBOUND
Message-ID: <20170821144855.GF491396@devbig577.frc2.facebook.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
 <20170821134951.18848-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821134951.18848-2-lvivier@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 21, 2017 at 03:49:51PM +0200, Laurent Vivier wrote:
> cpumask is the list of CPUs present when the queue is built.
> If a new CPU is hotplugged, this list is not updated,
> and when the scheduler asks for a CPU id, blk_mq_hctx_next_cpu()
> can return WORK_CPU_UNBOUND.
> And in this case _blk_mq_run_hw_queue() can be executed by the new CPU
> (that is not present in cpumask) and raises the following warning:
> 
>     WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>             cpu_online(hctx->next_cpu));
> 
> To fix this problem, this patch modifies blk_mq_hctx_next_cpu()
> to only return a CPU id present in cpumask.

So, this one isn't needed either.

Thanks.

-- 
tejun
