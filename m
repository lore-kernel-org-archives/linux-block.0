Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 15 Oct 2018 16:32:53 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, Pavel Machek
 <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Bart Van Assche <bvanassche@acm.org>, Jan Kara
 <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Mark Brown
 <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Johannes
 Thumshirn <jthumshirn@suse.de>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
In-Reply-To: <20181015141059.26579-1-linus.walleij@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
Message-ID: <18744e21b9f5aa4b3ab721a007a3e9a2@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

On 15.10.2018 16:10, Linus Walleij wrote:
> This sets BFQ as the default scheduler for single queue
> block devices (nr_hw_queues == 1) if it is available. This
> affects notably MMC/SD-cards but also UBI and the loopback
> device.
> 
> I have been running it for a while without any negative
> effects on my pet systems and I want some wider testing
> so let's throw it out there and see what people say.
> Admittedly my use cases are limited. I need to keep this
> patch around for my personal needs anyway.
> 
> We take special care to avoid using BFQ on zoned devices
> (in particular SMR, shingled magnetic recording devices)
> as these currently require mq-deadline to group writes
> together.
> 
> I have opted against introducing any default scheduler
> through Kconfig as the mq-deadline enforcement for
> zoned devices has to be done at runtime anyways and
> too many config options will make things confusing.
> 
> My argument for setting a default policy in the kernel
> as opposed to user space is the "reasonable defaults"
> type, analogous to how we have one default CPU scheduling
> policy (CFS) that make most sense for most tasks, and
> how automatic process group scheduling happens in most
> distributions without userspace involvement. The BFQ
> scheduling policy makes most sense for single hardware
> queue devices and many embedded systems will not have
> the clever userspace tools (such as udev) to make an
> educated choice of scheduling policy. Defaults should be
> those that make most sense for the hardware.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add a quirk so that devices with zoned writes are forced
>   to use the deadline scheduler, this is necessary since only
>   that scheduler supports zoned writes.
> - There is a summary article in LWN for subscribers:
>   https://lwn.net/Articles/767987/
> ---
>  block/elevator.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 8fdcd64ae12e..6e6048ca3471 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -948,13 +948,16 @@ int elevator_switch_mq(struct request_queue *q,
>  }
> 
>  /*
> - * For blk-mq devices, we default to using mq-deadline, if available,
> for single
> - * queue devices.  If deadline isn't available OR we have multiple 
> queues,
> - * default to "none".
> + * For blk-mq devices, we default to using:
> + * - "none" for multiqueue devices (nr_hw_queues != 1)
> + * - "bfq", if available, for single queue devices
> + * - "mq-deadline" if "bfq" is not available for single queue devices
> + * - "none" for single queue devices as well as last resort
>   */
>  int elevator_init_mq(struct request_queue *q)
>  {
>  	struct elevator_type *e;
> +	const char *policy;
>  	int err = 0;
> 
>  	if (q->nr_hw_queues != 1)
> @@ -968,7 +971,18 @@ int elevator_init_mq(struct request_queue *q)
>  	if (unlikely(q->elevator))
>  		goto out_unlock;
> 
> -	e = elevator_get(q, "mq-deadline", false);
> +	/*
> +	 * Zoned devices must use a deadline scheduler because currently
> +	 * that is the only scheduler respecting zoned writes.
> +	 */
> +	if (blk_queue_is_zoned(q))
> +		policy = "mq-deadline";
> +	else if (IS_ENABLED(CONFIG_IOSCHED_BFQ))
> +		policy = "bfq";
> +	else
> +		policy = "mq-deadline";

If more rules will be needed in the future, shall we just add extra ifs, 
or it would be better to craft some struct/table now + policy search 
helper?

> +
> +	e = elevator_get(q, policy, false);
>  	if (!e)
>  		goto out_unlock;

-- 
   Oleksandr Natalenko (post-factum)
