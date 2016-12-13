Subject: Re: [PATCH 6/7] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-7-git-send-email-axboe@fb.com>
 <1ef97a97-d72b-a86b-1ddd-0c4c5ace8027@sandisk.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <26064b12-6434-27bd-97d2-b6a747b20a66@fb.com>
Date: Tue, 13 Dec 2016 08:08:28 -0700
MIME-Version: 1.0
In-Reply-To: <1ef97a97-d72b-a86b-1ddd-0c4c5ace8027@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/13/2016 04:04 AM, Bart Van Assche wrote:
> On 12/08/2016 09:13 PM, Jens Axboe wrote:
>> +static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
>> +{
>> +	struct deadline_data *dd;
>> +	struct elevator_queue *eq;
>> +
>> +	eq = elevator_alloc(q, e);
>> +	if (!eq)
>> +		return -ENOMEM;
>> +
>> +	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
>> +	if (!dd) {
>> +		kobject_put(&eq->kobj);
>> +		return -ENOMEM;
>> +	}
>> +	eq->elevator_data = dd;
>> +
>> +	dd->tags = blk_mq_sched_alloc_requests(256, q->node);
>> +	if (!dd->tags) {
>> +		kfree(dd);
>> +		kobject_put(&eq->kobj);
>> +		return -ENOMEM;
>> +	}
> 
> Hello Jens,
> 
> Please add a comment that explains where the number 256 comes from.

Pulled out of my... I'll add a comment! Really this should just be
->nr_requests soft setting, the 256 is just a random sane default that I
chose for now. I had forgotten about that, thanks.

-- 
Jens Axboe
