Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 7 Feb 2017 13:45:16 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH] bfq-mq: cause deadlock by executing exit_icq body
 immediately
Message-ID: <20170207214516.GA14269@vader.DHCP.thefacebook.com>
References: <20170207173346.4789-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207173346.4789-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 07, 2017 at 06:33:46PM +0100, Paolo Valente wrote:
> Hi,
> this patch is meant to show that, if the  body of the hook exit_icq is executed
> from inside that hook, and not as deferred work, then a circular deadlock
> occurs.
> 
> It happens if, on a CPU
> - the body of icq_exit takes the scheduler lock,
> - it does so from inside the exit_icq hook, which is invoked with the queue
>   lock held
> 
> while, on another CPU
> - bfq_bio_merge, after taking the scheduler lock, invokes bfq_bic_lookup,
>   which, in its turn, takes the queue lock. bfq_bic_lookup needs to take such a
>   lock, because it invokes ioc_lookup_icq.
> 
> For more details, here is a lockdep report, right before the deadlock did occur.
> 
> [   44.059877] ======================================================
> [   44.124922] [ INFO: possible circular locking dependency detected ]
> [   44.125795] 4.10.0-rc5-bfq-mq+ #38 Not tainted
> [   44.126414] -------------------------------------------------------
> [   44.127291] sync/2043 is trying to acquire lock:
> [   44.128918]  (&(&bfqd->lock)->rlock){-.-...}, at: [<ffffffff90484195>] bfq_exit_icq_bfqq+0x55/0x140
> [   44.134052]
> [   44.134052] but task is already holding lock:
> [   44.134868]  (&(&q->__queue_lock)->rlock){-.....}, at: [<ffffffff9044738e>] put_io_context_active+0x6e/0xc0

Hey, Paolo,

I only briefly skimmed the code, but what are you using the queue_lock
for? You should just use your scheduler lock everywhere. blk-mq doesn't
use the queue lock, so the scheduler is the only thing you need mutual
exclusion against. I'm guessing if you stopped using that, your locking
issues would go away.
