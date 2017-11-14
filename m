Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:40564 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdKNOuj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Nov 2017 09:50:39 -0500
Received: by mail-it0-f50.google.com with SMTP id 72so13878124itl.5
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2017 06:50:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000ada93-ff28-a166-c95d-542a01cf926a@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com>
 <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com> <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
 <000ada93-ff28-a166-c95d-542a01cf926a@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2017 15:50:37 +0100
Message-ID: <CACRpkdY1Jn+=rs0KDX3wrQy56KP3mJKCS7Hs7_DqusvQXNJMjg@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Adrian!

Thanks for the helpful and productive tone in the recent mail,
it is very helpful and improves my work environment.

>> The block layer maintainers most definately think MQ is ready
>> but you seem to disagree. Why?
>
> I meant when the mmc conversion to blk-mq is ready.  We don't need to
> consider other sub-systems, just whether it is working for mmc.  For
> example, the issue with the block layer workqueues not performing as well as
> a thread.  That only came to light through testing mmc.

OK I see your point.

>> It's bad enough that you repeatedly point out how stupid
>> you think I am
>
> I have never called you names.  On the contrary, it is because I don't think
> you are stupid that I get upset when you seem spend so little time and
> effort to understand the code.  Equally, you seem to make comments that just
> assume the code is wrong without due consideration.

Please work on your patience. I think so few people are reviewing the
code because it is massive and complicated and sits in a complicated
place. One can not be blamed for trying, right?

I have spent considerable time with your code, more than with my own.
Mostly testing it, and that is why I can say it does not regress performance
on my end.

I also ran several rounds of fault injection, which it handled without
problems.

Then I tried to eject the SD card when running DD from the card and
then it crashed.

But that is an extreme test case, so overall it is very robust code.
With the exception of card removal during I/O, feel free to add
my Tested-by: Linus Walleij <linus.walleij@linaro.org> on this series.

>> But what I think is nice in doing it around
>> each request is that since mmc_put_card() calls mmc_release_host()
>> contains this:
>>
>> if (--host->claim_cnt) { (...)
>>
>> So there is a counter inside the claim/release host functions
>> and now there is another counter keeping track if the in-flight
>> requests as well and it gives me the feeling we are maintaining
>> two counters when we only need one.
>
> The gets / puts also get runtime pm for the card.  It is a lot a messing
> around for the sake of a quick check for the number of requests inflight -
> which is needed anyway for CQE.

OK I buy that.

>> But maybe it is actually the host->claim_cnt that is overengineered
>> and should just be a bool, becuase with this construction
>> that you only call down and claim the host once, the
>> host->claim_cnt will only be 0 or 1, right?
>
> The claim_cnt was introduced for nested claiming.

Yeah that sounds familiar. I'm not really sure it happens
anymore after this but I guess I can test that with some
practical experiements, let's leave it like this.

>> I guess I could turn that around and ask: if it is so crappy, why
>> is your patch set not deleting it?
>
> To allow people time to test.

OK I guess I'm more forging ahead with such things. But we could
at least enable it by default so whoever checks out and builds
and tests linux-next with their MMC/SD controllers will then be
testing this for us in the next kernel cycle.

>> But I think I would prefer that if a big slew of new code is
>> introduced it needs to be put to wide use and any bugs
>> smoked out during the -rc phase, and we are now
>> hiding it behind a Kconfig option so it's unlikely to see testing
>> until that option is turned on, and that is not good.
>
> And if you find a big problem in rc7, then what do you do?  At least with
> the config option, the revert is trivial.

I see your point. I guess it is up to Ulf how he feels about
trust wrt the code. If a problem appears at -rc7 it's indeed
nice if we can leave the code in-tree and work on it.

>> At least take a moment to consider the option that maybe so few people
>> are reviwing your code because this is complicated stuff and really
>> hard to grasp, maybe the problem isn't on my side, neither on yours,
>> it may be that the subject matter is the problem.
>
> I would expect a review would take a number of days, perhaps longer.
> However, it seems people are not willing to consider anything that takes
> more than a an hour or two.

Your criticism is something like "do it properly or not at all"
and I understand that feeling. I deserve some of the criticism
and I can accept it much easier when put with these words.

It would be nice if the community would step in here and I have
seen so many people talk about this code that I really think they
should invest in proper review. More people than me and Ulf
need to help out with review and test.

>> I would say a synchronization primitive is needed, indeed.
>> I have a different approach to this, which uses completion
>> as the synchronization primitive and I think that would be possible
>> to use also here.
>
> Because they are both just wake-ups.  When waiting for multiple conditions,
> wait_event() is simpler.  You are not considering the possibility for having
> only 1 task switch between requests.

That is indeed a nice feature.

>>
>> I have this code:
>
> Which runs as a work item, so there is already a task switch to get here.
> i.e. there are 2 task switches between each request, instead of 1.

Yes. This is a limitation in my patch set.

>>         /*
>>          * Here we postprocess the request differently depending on if
>>          * we go on the success path or error path. The success path will
>>          * immediately let new requests hit the host, whereas the error
>>          * path will hold off new requests until we have retried and
>>          * succeeded or failed the current asynchronous request.
>>          */
>>         if (status == MMC_BLK_SUCCESS) {
>>                 /*
>>                  * This immediately opens the gate for the next request
>>                  * to start on the host while we perform post-processing
>>                  * and report back to the block layer.
>>                  */
>>                 host->areq = NULL;
>>                 complete(&areq->complete);
>
> So that is the second task switch.

Yes.

Interestingly, it does not affect performance in my tests.
I thought it would but it doesn't.

>> As you can see it is a bit elaborate about some
>> of this stuff and quite a lot of comments were added to make
>> clear what is going on. This is in my head so that is why I ask:
>> completion worked fine as a synchronization primitive here
>> so it is maybe a good alternative in your (similar) code
>> as well?
>
> In the case there is another request already waiting, then instead of
> scheduling work to complete the request, the dispatch is woken to complete
> the previous and start the next.  That needs different synchronization.

OK.

>> So what we want to attain is that the next dispatch happens as soon
>> as possible after completing the previous request. They only race
>> as far as that they go through post/preprocessing before getting to
>> the synchronization primitive though?
>
> They only race when the next request is not already waiting.  Otherwise the
> work is never scheduled.

OK I see better which race you were referring to and it makes
a lot of sense. This should work optimally with the kblockd queue
then. (I should have used that in my patch set as well.)

>>> As I already wrote, the CPU-bound block layer dispatch work queue has
>>> negative consequeuences for mmc performance.  So there are 2 aspects to that:
>>>         1. Is the choice of CPU right to start with?  I suspect it is better for
>>> the dispatch to run on the same CPU as the interrupt.
>>>         2. Does the dispatch work need to be able to be migrated to a different
>>> CPU? i.e. unbound work queue.  That helped in my tests, but it could just be
>>> a side-effect of 1.
>>
>> Hm! What you are saying sounds correct, and we really need to
>> consider the multi-CPU aspects of this, maybe not now. I am
>> happy as long as we have equal performance as before and
>> maintainable code.
>
> Well I saw 3% drop in sequential read performance, improving to 1% when an
> unbound workqueue was used.

I think that is acceptable, albeit I cannot see it on my host.
I wonder if people disagree strongly when I say "acceptable..."

In my tests any throughput loss is in the error margin. It may be
because of fuzz in this hardware or because of differences between
ARM and x86, caches or whatever.

>> Or rather: just because someone is FOR something else,
>> doesn't mean they are AGAINST this.
>
> But that is not what happened.  You blocked CQE even though it was ready.

That is an unfair accusation. I alone, not even being a
maintainer of MMC can't block your patch even if something is
seriously wrong with it.

The whole core of your conflict with me and the MMC maintainer is that
you think CQE is more important to get in than to get MMC converted
to MQ. You thought it was more important to support this new feature
than to evolute the MMC subsystem to support MQ. Please understand that.

When you are putting one thing over another and refusing to discuss
you are not a team player and you're not playing well with others.

With the recent patch set you have come a long way towards acceptance
from my side, because you do MQ and MQ first. As I have repeatedly
said, make it it the default and kill the old code, then you're home in
my book.

>> It's not good because it does not make MQ mandatory and does
>> not delete the interfaces to the old block layer.
>
> That is a separate issue.

Not at all. This is the core of this entire conflict, my insistance on
tranitioning to MQ over all. We need to turn this into a win-win
situation where we get both MQ and CQE in the same go in the same
merge window IMO.

>> So why are you not just deleting it?
>
> Because it needs more testing first.  If the testing goes well, then switch
> over the default.  If, after 1 or more release cycles, there are no
> problems, delete the old code.

OK I understand the conservative stance.

But it's just not my preferred stance :)

I feel a strong pressure from the block maintainers to move forward
with MQ and now it is happening. I'm very happy with that.

>> I disagree. No "ready and tested" is needed, the code is ready,
>> and I have tested it. It performs. Delete the old code now.
>
> Not true.  My testing showed the block layer workqueue wasn't performing as
> well as a thread.

Yeah good point. It's weird that my testing doesn't show anything
of the kind.

We can probably agree on one thing though: the MQ code should be
default-enabled on CQE-capable devices.

>> If you just make a series also deleteing the old block layer
>> I will test it so it doesn't break anything and then you can
>> probably expect a big Acked-by on the whole shebang.
>
> I will add patches for that - let's see what happens.

Yay!

Yours,
Linus Walleij
