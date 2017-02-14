Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block: make elevator_get robust against cross
 blk/blk-mq choice
To: Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@osandov.com>,
 Paolo Valente <paolo.valente@linaro.org>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
 <20170213210107.4848-2-paolo.valente@linaro.org>
 <20170213220900.GA11052@vader.DHCP.thefacebook.com>
 <89b98d59-fcae-6b13-a6a1-6fe62967929d@kernel.dk>
 <d6e69d7b-dc69-90ec-0130-dc774fd4da2a@suse.de>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <51581bb4-7b76-8e29-4c1c-dad43085581e@kernel.dk>
Date: Tue, 14 Feb 2017 08:13:53 -0700
MIME-Version: 1.0
In-Reply-To: <d6e69d7b-dc69-90ec-0130-dc774fd4da2a@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/13/2017 11:58 PM, Hannes Reinecke wrote:
> On 02/13/2017 11:28 PM, Jens Axboe wrote:
>> On 02/13/2017 03:09 PM, Omar Sandoval wrote:
>>> On Mon, Feb 13, 2017 at 10:01:07PM +0100, Paolo Valente wrote:
>>>> If, at boot, a legacy I/O scheduler is chosen for a device using blk-mq,
>>>> or, viceversa, a blk-mq scheduler is chosen for a device using blk, then
>>>> that scheduler is set and initialized without any check, driving the
>>>> system into an inconsistent state. This commit addresses this issue by
>>>> letting elevator_get fail for these wrong cross choices.
>>>>
>>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>>> ---
>>>>  block/elevator.c | 26 ++++++++++++++++++--------
>>>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> Hey, Paolo,
>>>
>>> How exactly are you triggering this? In __elevator_change(), we do check
>>> for mq or not mq:
>>>
>>> 	if (!e->uses_mq && q->mq_ops) {
>>> 		elevator_put(e);
>>> 		return -EINVAL;
>>> 	}
>>> 	if (e->uses_mq && !q->mq_ops) {
>>> 		elevator_put(e);
>>> 		return -EINVAL;
>>> 	}
>>>
>>> We don't ever appear to call elevator_init() with a specific scheduler
>>> name, and for the default we switch off of q->mq_ops and use the
>>> defaults from Kconfig:
>>>
>>> 	if (q->mq_ops && q->nr_hw_queues == 1)
>>> 		e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false);
>>> 	else if (q->mq_ops)
>>> 		e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
>>> 	else
>>> 		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
>>>
>>> 	if (!e) {
>>> 		printk(KERN_ERR
>>> 			"Default I/O scheduler not found. " \
>>> 			"Using noop/none.\n");
>>> 		e = elevator_get("noop", false);
>>> 	}
>>>
>>> So I guess this could happen if someone manually changed those Kconfig
>>> options, but I don't see what other case would make this happen, could
>>> you please explain?
>>
>> Was wondering the same - is it using the 'elevator=' boot parameter?
>> Didn't look at that path just now, but that's the only one I could
>> think of. If it is, I'd much prefer only using 'chosen_elevator' for
>> the non-mq stuff, and the fix should be just that instead.
>>
> [ .. ]
> While we're at the topic:
> 
> Can't we use the same names for legacy and mq scheduler?
> It's quite an unnecessary complication to have
> 'noop', 'deadline', and 'cfq' for legacy, but 'none' and 'mq-deadline'
> for mq. If we could use 'noop' and 'deadline' for mq, too, the existing
> settings or udev rules will continue to work and we wouldn't get any
> annoying and pointless warnings here...

I'm fine with potentially renaming mq-deadline to deadline, but I don't
want to mix up none and noop. One is an actual scheduler, the other is
not.

-- 
Jens Axboe
