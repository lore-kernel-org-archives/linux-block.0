Return-Path: <axboe@kernel.dk>
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
 <478A4EBE-9218-4527-9F8A-42AAEBDC9470@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0425b6c7-d6be-b019-e750-bf858e864307@kernel.dk>
Date: Mon, 13 Feb 2017 15:29:35 -0700
MIME-Version: 1.0
In-Reply-To: <478A4EBE-9218-4527-9F8A-42AAEBDC9470@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/13/2017 02:09 PM, Paolo Valente wrote:
> 
>> Il giorno 07 feb 2017, alle ore 18:24, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> Hi,
>>
>> I have finally pushed here [1] the current WIP branch of bfq for
>> blk-mq, which I have tentatively named bfq-mq.
>>
>> This branch *IS NOT* meant for merging into mainline and contain code
>> that mau easily violate code style, and not only, in many
>> places. Commits implement the following main steps:
>> 1) Add the last version of bfq for blk
>> 2) Clone bfq source files into identical bfq-mq source files
>> 3) Modify bfq-mq files to get a working version of bfq for blk-mq
>> (cgroups support not yet functional)
>>
>> In my intentions, the main goals of this branch are:
>>
>> 1) Show, as soon as I could, the changes I made to let bfq-mq comply
>> with blk-mq-sched framework. I though this could be particularly
>> useful for Jens, being BFQ identical to CFQ in terms of hook
>> interfaces and io-context handling, and almost identical in terms
>> request-merging.
>>
>> 2) Enable people to test this first version bfq-mq. Code is purposely
>> overfull of log messages and invariant checks that halt the system on
>> failure (lock assertions, BUG_ONs, ...).
>>
>> To make it easier to revise commits, I'm sending the patches that
>> transform bfq into bfq-mq (last four patches in the branch [1]). They
>> work on two files, bfq-mq-iosched.c and bfq-mq.h, which, at the
>> beginning, are just copies of bfq-iosched.c and bfq.h.
>>
> 
> Hi,
> this is just to inform that, as I just wrote to Bart, I have rebase
> the branch [1] against the current content of for-4.11/next.
> 
> Jens, Omar, did you find the time to have a look at the main commits
> or to run some test?

I only looked at the core change you proposed for passing in the
bio as well, and Omar fixed up the icq exit part and I also applied
that patch. I haven't look at any of the bfq-mq patches at all yet.
Not sure what I can do with those, I don't think those are
particularly useful to anyone but you.

Might make more sense to post the conversion for review as a
whole.

-- 
Jens Axboe
