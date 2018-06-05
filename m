Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in wb_workfn (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, tj@kernel.org,
        david@fromorbit.com, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
 <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
 <c0fc1c47-0efb-5ded-7f6c-79074ad4deac@i-love.sakura.ne.jp>
 <20180531134212.oo4ra4ypuruab3xp@quack2.suse.cz>
 <eacb3cbe-3768-82cd-02c1-c8d1b549673f@kernel.dk>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
Date: Tue, 5 Jun 2018 22:45:31 +0900
MIME-Version: 1.0
In-Reply-To: <eacb3cbe-3768-82cd-02c1-c8d1b549673f@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...

On 2018/06/01 1:56, Jens Axboe wrote:
> On 5/31/18 7:42 AM, Jan Kara wrote:
>> On Thu 31-05-18 22:19:44, Tetsuo Handa wrote:
>>> On 2018/05/31 20:42, Jan Kara wrote:
>>>> On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
>>>>> So, we have no idea what is happening...
>>>>> Then, what about starting from temporary debug printk() patch shown below?
>>>>>
>>>>> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
>>>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>> Date: Wed, 30 May 2018 09:57:10 +0900
>>>>> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
>>>>>  bdi_unregister() race bug.
>>>>>
>>>>> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
>>>>> limitations that syzbot cannot find reproducer for this bug (frequency is
>>>>> once or twice per a day) nor we can't capture vmcore in the environment
>>>>> which syzbot is using, for now we need to rely on printk() debugging.
>>>>>
>>>>> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
>>>>>
>>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>
>>>> Hum a bit ugly solution but if others are fine with this, I can live with
>>>> it for a while as well. Or would it be possible for syzkaller to just test
>>>> some git tree where this patch is included? Then we would not even have to
>>>> have the extra config option...
>>>
>>> If syzbot can reproduce this bug that way. While it is possible to add/remove
>>> git trees syzbot tests, frequently adding/removing trees is bothering.
>>>
>>> syzbot can enable extra config option. Maybe the config name should be
>>> something like CONFIG_DEBUG_FOR_SYZBOT rather than individual topic.
>>>
>>> I think that syzbot is using many VM instances. I don't know how many
>>> instances will be needed for reproducing this bug within reasonable period.
>>> More git trees syzbot tests, (I assume that) longer period will be needed
>>> for reproducing this bug. The most reliable way is to use the shared part
>>> of all trees (i.e. linux.git).
>>
>> I understand this, I'd be just a bit reluctant to merge temporary debug
>> patches like this to Linus' tree only to revert them later just because
>> syzkaller... What do others think?
> 
> I guess I don't understand why having it in Linus's tree would make
> a difference to syzkaller?
> 
> If there is a compelling reason why that absolutely has to be done,
> I don't think it should be accompanied by a special Kconfig option
> for it. It should just be on unconditionally, with the intent to
> remove it before release.
> 
