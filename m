Return-Path: <riteshh@codeaurora.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Linus Walleij <linus.walleij@linaro.org>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org>
 <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Paolo Valente <paolo.valente@linaro.org>
From: Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <4c9bd61a-c21c-5bfc-1a67-6c30d5d9fdbd@codeaurora.org>
Date: Wed, 28 Dec 2016 09:51:10 +0530
MIME-Version: 1.0
In-Reply-To: <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Thanks for getting back on this.

On 12/27/2016 5:51 PM, Linus Walleij wrote:
> On Wed, Dec 21, 2016 at 6:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>
>> I may have some silly queries here. Please bear with my little understanding
>> on blk-mq.
>
> It's OK we need to build consensus.
>
>> On 12/20/2016 7:31 PM, Linus Walleij wrote:
>
>>> This hack switches the MMC/SD subsystem from using the legacy blk
>>> layer to using blk-mq. It does this by registering one single
>>> hardware queue, since MMC/SD has only one command pipe. I kill
>>
>> Could you please confirm on this- does even the HW/SW CMDQ in emmc would use
>> only 1 hardware queue with (say ~31) as queue depth, of that HW queue? Is
>> this understanding correct?
>
> Yes as far as I can tell.
Ok.

>
> But you may have to tell me, because I'm not an expert in CMDQ.
>
> Multiple queues are for when you can issue different request truly parallel
> without taking any previous and later request into account. CMDQ on
> MMC seems to require rollback etc if any of the issued requests after
> a certain request fail, and then it is essentially one queue, like a pipeline,
> and if one request fails all requests after that request needs to be backed
> out, correct?
This depends. There is a command CMD48 which can knock off the error'd 
out task from the queue. But in case if the reset of controller and card 
is required(for some error) then yes, all requests in queue needs to be 
re-queued back and removed from the card queue.

Also there are certain CMDs which can be *only* issued while the queue 
of emmc is empty. Otherwise they will be treated as illegal commands.
So yes, there is a dependency in previously issued requests - which 
means (as you said) that for blk-mq we should consider in HW/SW CMDQ as 
1 HW queue with certain qdepth advertised by card.


>
>> Or will it be possible to have more than 1 HW Queue with lesser queue depth
>> per HW queue?
>
> Depends on the above.
>
> Each queue must have its own error handling, and work isolated from
> the other queues to be considered a real hardware queue.
>
> If the requests have dependencies, like referring each other, or
> as pointed out, needing to be cancelled if there is an error on a totally
> different request, it is just a deep pipeline, single hardware queue.
Yes, thanks for explaining. Agree.

>
>> I understand that the block drivers are moving to blk-mq framework.
>> But keeping that reason apart, do we also anticipate any theoretical
>> performance gains in moving mmc driver to blk-mq framework  - for both in
>> case of legacy emmc, and SW/HW CMDQ in emmc ? And by how much?
>
> On the contrary we expect a performance regression as mq has no
> scheduling. MQ is created for the usecase where you have multiple
> hardware queues and they are so hungry for work that you have a problem
> feeding them all. Needless to say, on eMMC/SD we don't have that problem
> right now atleast.
Ok. Could you please elaborate how a regression?

 From very little understanding on blk-mq, I see that it does have 
plugging mechanism in place. So merging wont be a problem for most of 
the use cases right?
So are you referring to priority given to sync requests v/s async or 
idle type requests, which were taken care in CFQ ?
For my own understanding, I would like to understand under what 
scenarios or why we should expect a performance regression in blk-mq for 
mmc driver without blk-mq scheduling?


>
>> It would be even better to know if adding of scheduler to blk-mq will make
>> any difference in perf gains or not in this case?
>
> The tentative plan as I see it is to shunt in BFQ as the default scheduler
> for MQ in the single-hw-queue case. The old block layer schedulers getting
> deprecated in the process. But this is really up to the block layer developers.
Ok. Yes, I do see blk-mq scheduling patches on the mailing lists.

>
>> Do we any rough estimate or study on that?
>> This is only out of curiosity and for information purpose.
>
> No it is a venture into the unknown to go where no man has gone before.
>
> I just have a good feeling about this and confidence that it will work out.
>
> So I am doing RFD patches like this one to see if I'm right.
Thanks!!


Regards
Ritesh

>
> Yours,
> Linus Walleij
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
