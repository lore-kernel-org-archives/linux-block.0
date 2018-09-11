Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To: Takashi Iwai <tiwai@suse.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <s5h7ejsnhds.wl-tiwai@suse.de> <s5hy3c8j9g9.wl-tiwai@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7fcd013b-b87a-a603-d010-02d70d6e559d@kernel.dk>
Date: Tue, 11 Sep 2018 10:20:23 -0600
MIME-Version: 1.0
In-Reply-To: <s5hy3c8j9g9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 10:16 AM, Takashi Iwai wrote:
> On Tue, 11 Sep 2018 18:11:43 +0200,
> Takashi Iwai wrote:
>>
>> On Tue, 11 Sep 2018 18:09:44 +0200,
>> Jens Axboe wrote:
>>>
>>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>>> Hi,
>>>>
>>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>>
>>>> Is this already addressed?
>>>
>>> Haven't heard about this one before. What kernel did you last use that
>>> worked?
>>
>> IIRC, 4.18 worked fine.  Let me see whether I have a backup...
> 
> Confirmed that 4.18 worked.  It's also with CONFIG_IOSCHED_BFQ=y and
> CONFIG_BFQ_GROUP_IOSCHED=y.
> 
> And, 4.19-rc3 with CONFIG_BFQ_GROUP_IOSCHED=n seems working, too (as
> expected from the error above).
> 
> 
> (BTW I'll have to leave from this machine now.  For any further
>  inquiry, I'll check tomorrow, sorry.)

Very odd. Maybe try without CONFIG_BLK_CGROUP_IOLATENCY being set?
I'll try and reproduce it here.

-- 
Jens Axboe
