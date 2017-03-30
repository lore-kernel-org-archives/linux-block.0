Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12BA96@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <f80153aa-3e7d-0a20-e426-7e58cd7c249d@fb.com>
 <1490897421.2753.12.camel@sandisk.com>
Cc: "osandov@fb.com" <osandov@fb.com>, "hare@suse.de" <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <93cf9d74-1f38-0f1a-8102-77017879aa35@fb.com>
Date: Thu, 30 Mar 2017 12:14:48 -0600
MIME-Version: 1.0
In-Reply-To: <1490897421.2753.12.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 12:10 PM, Bart Van Assche wrote:
> On Thu, 2017-03-30 at 09:27 -0600, Jens Axboe wrote:
>> On 03/29/2017 03:32 PM, Bart Van Assche wrote:
>>> Make it possible to check whether or not a block layer queue has
>>> been stopped. Make it possible to start and to run a blk-mq queue
>>> from user space.
>>
>> Looks good, minor nitpicking below.
>>
>>> +static int blk_queue_flags_show(struct seq_file *m, void *v)
>>> +{
>>> +	struct request_queue *q = m->private;
>>> +	bool sep = false;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < sizeof(q->queue_flags) * BITS_PER_BYTE; i++) {
>>> +		if (!(q->queue_flags & BIT(i)))
>>> +			continue;
>>> +		if (sep)
>>> +			seq_puts(m, " ");
>>> +		sep = true;
>>
>> Put that sep = true in the else branch?
> 
> I can do that, but that would result in slightly less efficient assembler
> code (additional jump) while stores can be pipelined easily.

It's a sysfs show function, it's not like we care about branching. But we
can leave it as-is, I don't feel that strongly about it at all.

>>> +	if (strcmp(op, "run") == 0) {
>>> +		blk_mq_run_hw_queues(q, true);
>>> +	} else if (strcmp(op, "start") == 0) {
>>> +		blk_mq_start_stopped_hw_queues(q, true);
>>> +	} else {
>>> +		pr_err("%s: unsupported operation %s\n", __func__, op);
>>> +		return -EINVAL;
>>> +	}
>>
>> You are inconsistent with your braces. I'd prefer no braces for single
>> lines.
> 
> Sorry but if braces are used for one side of an if-then-else statement then
> checkpatch wants braces to be used for the other side too, even if that other
> side is only a single line. From the checkpatch source code:

Omar informs me that it's coding style mandated. The block layer generally
does NOT do braces, so I'd prefer to keep it consistent at least. Again, not
really a huge problem, and as I prefaced the original email with, totally
nitpicking.

-- 
Jens Axboe
