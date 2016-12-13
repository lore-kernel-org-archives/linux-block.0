Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 6/7] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-7-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <1ef97a97-d72b-a86b-1ddd-0c4c5ace8027@sandisk.com>
Date: Tue, 13 Dec 2016 12:04:01 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-7-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
> +{
> +	struct deadline_data *dd;
> +	struct elevator_queue *eq;
> +
> +	eq = elevator_alloc(q, e);
> +	if (!eq)
> +		return -ENOMEM;
> +
> +	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
> +	if (!dd) {
> +		kobject_put(&eq->kobj);
> +		return -ENOMEM;
> +	}
> +	eq->elevator_data = dd;
> +
> +	dd->tags = blk_mq_sched_alloc_requests(256, q->node);
> +	if (!dd->tags) {
> +		kfree(dd);
> +		kobject_put(&eq->kobj);
> +		return -ENOMEM;
> +	}

Hello Jens,

Please add a comment that explains where the number 256 comes from.

Thanks,

Bart.
