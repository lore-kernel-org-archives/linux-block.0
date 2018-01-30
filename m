Return-Path: <ming.lei@redhat.com>
Date: Tue, 30 Jan 2018 22:40:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: paolo.valente@linaro.org, Ivan Kozik <ivan@ludios.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	bfq-iosched@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
	linus.walleij@linaro.org
Subject: Re: v4.15 and I/O hang with BFQ
Message-ID: <20180130144002.GA14401@ming.t460p>
References: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
 <20180130081925.GA25183@ming.t460p>
 <38bd4dbe280bd0934abde764fe0916cd@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38bd4dbe280bd0934abde764fe0916cd@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 30, 2018 at 03:30:28PM +0100, Oleksandr Natalenko wrote:
> Hi.
> 
...
>    systemd-udevd-271   [000] ....     4.311033: bfq_insert_requests: insert
> rq->0
>    systemd-udevd-271   [000] ...1     4.311037: blk_mq_do_dispatch_sched:
> not get rq, 1
>           cfdisk-408   [000] ....    13.484220: bfq_insert_requests: insert
> rq->1
>     kworker/0:1H-174   [000] ....    13.484253: blk_mq_do_dispatch_sched:
> not get rq, 1
> ===
> 
> Looks the same, right?

Yeah, same with before.

-- 
Ming
