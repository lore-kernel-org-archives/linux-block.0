Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block: make elevator_get robust against cross
 blk/blk-mq choice
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
 <20170213210107.4848-2-paolo.valente@linaro.org>
 <20170213220900.GA11052@vader.DHCP.thefacebook.com>
 <89b98d59-fcae-6b13-a6a1-6fe62967929d@kernel.dk>
 <b1a1ad6d-6e22-7d55-bbad-40807d95f59b@kernel.dk>
 <AEB325FC-ED18-4927-A794-6FA915D55F75@linaro.org>
Cc: Omar Sandoval <osandov@osandov.com>, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dfad6983-c800-4ff1-002c-d586a9289054@kernel.dk>
Date: Tue, 14 Feb 2017 08:16:11 -0700
MIME-Version: 1.0
In-Reply-To: <AEB325FC-ED18-4927-A794-6FA915D55F75@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/14/2017 01:14 AM, Paolo Valente wrote:
> 
>> Il giorno 14 feb 2017, alle ore 00:10, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 02/13/2017 03:28 PM, Jens Axboe wrote:
>>> On 02/13/2017 03:09 PM, Omar Sandoval wrote:
>>>> On Mon, Feb 13, 2017 at 10:01:07PM +0100, Paolo Valente wrote:
>>>>> If, at boot, a legacy I/O scheduler is chosen for a device using blk-mq,
>>>>> or, viceversa, a blk-mq scheduler is chosen for a device using blk, then
>>>>> that scheduler is set and initialized without any check, driving the
>>>>> system into an inconsistent state. This commit addresses this issue by
>>>>> letting elevator_get fail for these wrong cross choices.
>>>>>
>>>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>>>> ---
>>>>> block/elevator.c | 26 ++++++++++++++++++--------
>>>>> 1 file changed, 18 insertions(+), 8 deletions(-)
>>>>
>>>> Hey, Paolo,
>>>>
>>>> How exactly are you triggering this? In __elevator_change(), we do check
>>>> for mq or not mq:
>>>>
>>>> 	if (!e->uses_mq && q->mq_ops) {
>>>> 		elevator_put(e);
>>>> 		return -EINVAL;
>>>> 	}
>>>> 	if (e->uses_mq && !q->mq_ops) {
>>>> 		elevator_put(e);
>>>> 		return -EINVAL;
>>>> 	}
>>>>
>>>> We don't ever appear to call elevator_init() with a specific scheduler
>>>> name, and for the default we switch off of q->mq_ops and use the
>>>> defaults from Kconfig:
>>>>
>>>> 	if (q->mq_ops && q->nr_hw_queues == 1)
>>>> 		e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false);
>>>> 	else if (q->mq_ops)
>>>> 		e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
>>>> 	else
>>>> 		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
>>>>
>>>> 	if (!e) {
>>>> 		printk(KERN_ERR
>>>> 			"Default I/O scheduler not found. " \
>>>> 			"Using noop/none.\n");
>>>> 		e = elevator_get("noop", false);
>>>> 	}
>>>>
>>>> So I guess this could happen if someone manually changed those Kconfig
>>>> options, but I don't see what other case would make this happen, could
>>>> you please explain?
>>>
>>> Was wondering the same - is it using the 'elevator=' boot parameter?
>>> Didn't look at that path just now, but that's the only one I could
>>> think of. If it is, I'd much prefer only using 'chosen_elevator' for
>>> the non-mq stuff, and the fix should be just that instead.
>>>
>>> So instead of:
>>>
>>> 	if (!e && *chosen_elevator) {
>>>
>>> do
>>>
>>> 	if (!e && !q->mq_ops && && *chosen_elevator) {
>>
>> Confirmed, that's what it seems to be, and here's a real diff of the
>> above example that works for me:
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 27ff1ed5a6fa..699d10f71a2c 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -207,11 +207,12 @@ int elevator_init(struct request_queue *q, char *name)
>> 	}
>>
>> 	/*
>> -	 * Use the default elevator specified by config boot param or
>> -	 * config option.  Don't try to load modules as we could be running
>> -	 * off async and request_module() isn't allowed from async.
>> +	 * Use the default elevator specified by config boot param for
>> +	 * non-mq devices, or by config option.
> 
> I don't fully get this choice: being able to change the default I/O
> scheduler through the command line has been rather useful for me,
> saving me a lot of recompilations, and such a feature seems widespread
> among (at least power) users.  However, mine is of course just an
> opinion, and I may be missing the main point also in this case.

The problem with the elevator= boot parameter is that it applies across
everything, which makes very little sense, since it's a per device
setting. In retrospect, it was a mistake to add this parameter, and I
don't want to continue down that path with blk-mq.

Why aren't you just using online switching through sysfs? For normal
users, typically this would be done through udev rules.

-- 
Jens Axboe
