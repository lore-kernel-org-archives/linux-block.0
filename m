Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 13 Feb 2017 14:09:00 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block: make elevator_get robust against cross
 blk/blk-mq choice
Message-ID: <20170213220900.GA11052@vader.DHCP.thefacebook.com>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
 <20170213210107.4848-2-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170213210107.4848-2-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 13, 2017 at 10:01:07PM +0100, Paolo Valente wrote:
> If, at boot, a legacy I/O scheduler is chosen for a device using blk-mq,
> or, viceversa, a blk-mq scheduler is chosen for a device using blk, then
> that scheduler is set and initialized without any check, driving the
> system into an inconsistent state. This commit addresses this issue by
> letting elevator_get fail for these wrong cross choices.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/elevator.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Hey, Paolo,

How exactly are you triggering this? In __elevator_change(), we do check
for mq or not mq:

	if (!e->uses_mq && q->mq_ops) {
		elevator_put(e);
		return -EINVAL;
	}
	if (e->uses_mq && !q->mq_ops) {
		elevator_put(e);
		return -EINVAL;
	}

We don't ever appear to call elevator_init() with a specific scheduler
name, and for the default we switch off of q->mq_ops and use the
defaults from Kconfig:

	if (q->mq_ops && q->nr_hw_queues == 1)
		e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false);
	else if (q->mq_ops)
		e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
	else
		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);

	if (!e) {
		printk(KERN_ERR
			"Default I/O scheduler not found. " \
			"Using noop/none.\n");
		e = elevator_get("noop", false);
	}

So I guess this could happen if someone manually changed those Kconfig
options, but I don't see what other case would make this happen, could
you please explain?
