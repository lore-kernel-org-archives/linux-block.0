Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:52765 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdKIPwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 10:52:34 -0500
Received: by mail-it0-f53.google.com with SMTP id j140so11272847itj.1
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 07:52:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com> <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2017 16:52:32 +0100
Message-ID: <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
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

On Thu, Nov 9, 2017 at 11:42 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 10:54, Linus Walleij wrote:
>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

>> At least you could do what I did and break out a helper like
>> this:
>>
>> /*
>>  * This reports status back to the block layer for a finished request.
>>  */
>> static void mmc_blk_complete(struct mmc_queue_req *mq_rq,
>>                             blk_status_t status)
>> {
>>        struct request *req = mmc_queue_req_to_req(mq_rq);
>>
>>        if (req->mq_ctx) {
>>           blk_mq_end_request(req, status);
>>        } else
>>           blk_end_request_all(req, status);
>> }
>
> You are quibbling.

Hm wiktionary "quibble" points to:
https://en.wikipedia.org/wiki/Trivial_objections

Sorry for not being a native speaker in English, I think that
maybe you were again trying to be snarky to a reviewer but
I honestly don't know.

> It makes next to no difference especially as it all goes
> away when the legacy code is deleted.

Which is something your patch set doesn't do. Nor did you write
anywhere that deleting the legacy code was your intention.
But I'm happy to hear it.

>  I will change it in the next
> revision, but what a waste of everyone's time.
>  Please try to focus on
> things that matter.

As Jean-Paul Sartre said "hell is other people".
Can you try to be friendlier anyway?

>> This retry and error handling using requeue is very elegant.
>> I really like this.
>>
>> If we could also go for MQ-only, only this nice code
>> remains in the tree.
>
> No one has ever suggested that the legacy API will remain.  Once blk-mq is
> ready the old code gets deleted.

The block layer maintainers most definately think MQ is ready
but you seem to disagree. Why?

In the recent LWN article from kernel recepies:
https://lwn.net/Articles/735275/
the only obstacle I can see is a mention that SCSI was not
switched over by default because of some problems with
slow rotating media. "This change had to be backed out
because of some performance and scalability issues that
arose for rotating storage."

Christoph mentions that he's gonna try again for v4.14.
But it's true, I do not see that happening in linux-next yet.

But that is specifically rotating media, which MMC/SD is not.
And UBI is using it since ages without complaints. And
that is a sign of something.

Have you seen any problems when deploying it on MMC/SD,
really? If there are problems I bet the block layer people want
us to find them, diagnose them and ultimately fix them rather
than wait for them to do it. I haven't seen any performance or
scalability issues. At one point I had processes running
on two eMMC and one SD-card and apart from maxing out
the CPUs and DMA backplace as could be expected all was
fine.

>> The problem: you have just reimplemented the whole error
>> handling we had in the old block layer and now we have to
>> maintain two copies and keep them in sync.
>>
>> This is not OK IMO, we will inevitable screw it up, so we
>> need to get *one* error path.
>
> Wow, you really didn't read the code at all.

Just quit this snarky attitude.

> As I have repeatedly pointed
> out, the new code is all new.  There is no overlap and there nothing to keep
> in sync.

The problem is that you have not clearly communicated your
vision to delete the old code. The best way to communicate that
would be to include a patch actually deleteing it.

>  It may not look like it in this patch, but that is only because of
> the ridiculous idea of splitting up the patch.

Naming other people's review feedback as "ridiculous" is not very
helpful. I think the patch set became much easier to review
like this so I am happy with this format.

>>> +static void mmc_blk_mq_acct_req_done(struct mmc_queue *mq, struct request *req)
>>
>> What does "acct" mean in the above function name?
>> Accounting? Actual? I'm lost.
>
> Does "actual" have two "c"'s.  You are just making things up.

Please stop your snarky and belitteling attitude.

I am not a native English speaker and I am not making up
my review comments in order to annoy you.

Consider Hanlon's razor:
https://en.wikipedia.org/wiki/Hanlon%27s_razor
"Never attribute to malice that which is adequately explained by
stupidity".

It's bad enough that you repeatedly point out how stupid
you think I am, I am sorry about that, in my opinion sometimes
other people are really stupid but more often than not the problem
is really on your side, like being impatient and unwilling to educate
others about how your code actually works becuase it seems
so evident to yourself that you think it should be evident to everyone
else as well. I don't know what to say about that, it seems a bit
unempatic.

But you even go and think I am making stuff up in purpose.
That's pretty offensive.

> Of course it is "account".

This is maybe obvious for you but it was not to me.

>  It is counting the number of requests in flight - which is
> pretty obvious from the code.  We use that to support important features
> like CQE re-tuning and avoiding getting / putting the card all the time.

What is so hard with getting this point across without insults?

>>> +{
>>> +       struct request_queue *q = req->q;
>>> +       unsigned long flags;
>>> +       bool put_card;
>>> +
>>> +       spin_lock_irqsave(q->queue_lock, flags);
>>> +
>>> +       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
>>> +
>>> +       put_card = mmc_tot_in_flight(mq) == 0;
>>
>> This in_flight[] business seems a bit kludgy, but I
>> don't really understand it fully. Magic numbers like
>> -1 to mark that something is not going on etc, not
>> super-elegant.
>
> You are misreading.  It subtracts 1 from the number of requests in flight.

Right! Sorry I misread it.

>> I believe it is necessary for CQE though as you need
>> to keep track of outstanding requests?
>
> We have always avoided getting / putting the card when there is another
> request in flight.  Yes it is also used for CQE.

Yeah I took the approach to get/put the card around each
request instead. It might make things a bit simpler.

>>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>>> +
>>> +       if (put_card)
>>> +               mmc_put_card(mq->card, &mq->ctx);
>>
>> I think you should try not to sprinkle mmc_put_card() inside
>> the different functions but instead you can put this in the
>> .complete callback I guess mmc_blk_mq_complete() in your
>> patch set.
>
> This is the *only* block.c function in the blk-mq code that calls
> mmc_put_card().  The queue also has does it for requests that didn't even
> start.  That is it.

Yeah that's correct. If we also delete the old code it will not be
too bad.

>> Also you do not need to avoid calling it several times with
>> that put_card variable. It's fully reentrant thanks to your
>> own code in the lock and all calls come from the same block
>> layer process if you call it in .complete() I think?
>
> We have always avoided unnecessary gets / puts.  Since the result is better,
> why on earth take it out?

It's not a showstopper.

But what I think is nice in doing it around
each request is that since mmc_put_card() calls mmc_release_host()
contains this:

if (--host->claim_cnt) { (...)

So there is a counter inside the claim/release host functions
and now there is another counter keeping track if the in-flight
requests as well and it gives me the feeling we are maintaining
two counters when we only need one.

But maybe it is actually the host->claim_cnt that is overengineered
and should just be a bool, becuase with this construction
that you only call down and claim the host once, the
host->claim_cnt will only be 0 or 1, right?

>> Now the problem Ulf has pointed out starts to creep out in the
>> patch: a lot of code duplication on the MQ path compared to
>> the ordinary block layer path.
>>
>> My approach was structured partly to avoid this: first refactor
>> the old path, then switch to (only) MQ to avoid code duplication.
>
> The old code is rubbish.  There is nothing of value there.  You have to make
> the case why you are wasting everyone's time churning crappy code.

I kind of agree that the old code is rubbish, actually.

I guess I could turn that around and ask: if it is so crappy, why
is your patch set not deleting it?

And I guess the only reasonable answer to that would be what
you were saying above, something along the lines of "MQ is not
ready yet". But it can be argued that MQ is ready.

>  The idea
> that nice new code is wrong because it doesn't churn the old rubbish code,
> is ridiculous.

As I have said in the review comments I like your new
code, especially the new error path.

I took the approach of refactoring because I was afraid I would
break something I guess. But rewriting from scratch is also an
option.

But I think I would prefer that if a big slew of new code is
introduced it needs to be put to wide use and any bugs
smoked out during the -rc phase, and we are now
hiding it behind a Kconfig option so it's unlikely to see testing
until that option is turned on, and that is not good.

>> This looks a bit like it is reimplementing the kernel
>> completion abstraction using a mutex and a variable named
>> .complete_req?
>>
>> We were using a completion in the old block layer so
>> why did you not use it for MQ?
>
> Doesn't seem like you pay much attention to this stuff.

You really have to stop your snarky and belitteling attitude
to your fellow kernel developers.

>From 6.Followthrough.rst again:

----------8<-------------------8<-------------------8<-----------

Andrew Morton has suggested that every review comment which does not result
in a code change should result in an additional code comment instead; that
can help future reviewers avoid the questions which came up the first time
around.

----------8<-------------------8<-------------------8<-----------

At least take a moment to consider the option that maybe so few people
are reviwing your code because this is complicated stuff and really
hard to grasp, maybe the problem isn't on my side, neither on yours,
it may be that the subject matter is the problem.

>  The previous
> request has to be completed even if there is no next request.  That means
> schduling work, that then races with the dispatch path.  So mutual exclusion
> is necessary.

I would say a synchronization primitive is needed, indeed.
I have a different approach to this, which uses completion
as the synchronization primitive and I think that would be possible
to use also here.

I have this code:

        /*
         * Here we postprocess the request differently depending on if
         * we go on the success path or error path. The success path will
         * immediately let new requests hit the host, whereas the error
         * path will hold off new requests until we have retried and
         * succeeded or failed the current asynchronous request.
         */
        if (status == MMC_BLK_SUCCESS) {
                /*
                 * This immediately opens the gate for the next request
                 * to start on the host while we perform post-processing
                 * and report back to the block layer.
                 */
                host->areq = NULL;
                complete(&areq->complete);
                mmc_post_req(host, areq->mrq, 0);
                if (areq->report_done_status)
                        areq->report_done_status(areq, MMC_BLK_SUCCESS);
        } else {
                /*
                 * Post-process this request. Then, if
                 * another request was already prepared, back that out
                 * so we can handle the errors without anything prepared
                 * on the host.
                 */
                if (host->areq_pending)
                        mmc_post_req(host, host->areq_pending->mrq, -EINVAL);
                /*
                 * Call back with error status, this will trigger retry
                 * etc if needed
                 */
                if (areq->report_done_status) {
                        if (areq->report_done_status(areq, status)) {
                                /*
                                 * This happens when we finally give up after
                                 * a few retries or on unrecoverable errors.
                                 */
                                mmc_post_req(host, areq->mrq, 0);
                                host->areq = NULL;
                                /* Re-prepare the next request */
                                if (host->areq_pending)
                                        mmc_pre_req(host,
host->areq_pending->mrq);
                                complete(&areq->complete);
                        }
                }
        }

As you can see it is a bit elaborate about some
of this stuff and quite a lot of comments were added to make
clear what is going on. This is in my head so that is why I ask:
completion worked fine as a synchronization primitive here
so it is maybe a good alternative in your (similar) code
as well?

>> I would contest using a waitqueue for this. The name even says
>> "complete_req" so why is a completion not the right thing to
>> hang on rather than a waitqueue?
>
> I explained that above.

And I explained what I meant.

>> The completion already contains a waitqueue, so I think you're
>> just essentially reimplementing it.
>>
>> Just complete(&mq->mq_req_complete) or something should do
>> the trick.
>
> Nope.

That's a very terse answer to an honest review comment.

>>> +       else
>>> +               kblockd_schedule_work(&mq->complete_work);
>>
>> I did not use the kblockd workqueue for this, out of fear
>> that it would interfere and disturb the block layer work items.
>> My intuitive idea was that the MMC layer needed its own
>> worker (like in the past it used a thread) in order to avoid
>> congestion in the block layer queue leading to unnecessary
>> delays.
>
> The complete work races with the dispatch of the next request, so putting
> them in the same workqueue makes sense. i.e. the one that gets processed
> first would anyway delay the one that gets processed second.

So what we want to attain is that the next dispatch happens as soon
as possible after completing the previous request. They only race
as far as that they go through post/preprocessing before getting to
the synchronization primitive though?

>> On the other hand, this likely avoids a context switch if there
>> is no congestion on the queue.
>>
>> I am uncertain when it is advisible to use the block layer
>> queue for subsystems like MMC/SD.
>>
>> Would be nice to see some direction from the block layer
>> folks here, it is indeed exposed to us...
>>
>> My performance tests show no problems with this approach
>> though.
>
> As I already wrote, the CPU-bound block layer dispatch work queue has
> negative consequeuences for mmc performance.  So there are 2 aspects to that:
>         1. Is the choice of CPU right to start with?  I suspect it is better for
> the dispatch to run on the same CPU as the interrupt.
>         2. Does the dispatch work need to be able to be migrated to a different
> CPU? i.e. unbound work queue.  That helped in my tests, but it could just be
> a side-effect of 1.

Hm! What you are saying sounds correct, and we really need to
consider the multi-CPU aspects of this, maybe not now. I am
happy as long as we have equal performance as before and
maintainable code.

> Of course we can't start looking at these real issues, while you are

You seem to have dropped the mic there, but it looks like
what you were going to say was not nice anyway so I guess
it was for better.

>>> +static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
>>> +{
>>> +       struct request_queue *q = mq->queue;
>>> +       unsigned long flags;
>>> +       bool done;
>>> +
>>> +       spin_lock_irqsave(q->queue_lock, flags);
>>> +       done = !mq->rw_wait;
>>> +       mq->waiting = !done;
>>> +       spin_unlock_irqrestore(q->queue_lock, flags);
>>
>> This makes it look like a reimplementation of completion_done()
>> so I think you should use the completion abstraction again. The
>> struct completion even contains a variable named "done".
>
> This just serves as an example of why splitting up the patch was such a bad
> idea.  For direct completion, the wait can result in recovery being needed
> for the previous request, so the current request gets requeued.

I guess this falls back to the previous comment on the
synchronization primitives.

>> This is pretty straight-forward (pending the comments above).
>> Again it has the downside of duplicating the same code for the
>> old block layer instead of refactoring.
>
> No, the old code is rubbish.  Churning it is a waste of time.

I think we have addressed this recurring theme.

>> Again looks fine, again duplicates code. In this case I don't even
>> see why the MQ code needs its own copy of the issue funtion.
>
> Because it has to support CQE.  This attitude against CQE is very disappointing!

Please understand that there is no conspiracy against CQE out
there.

I admit I personally think getting MQ in place and making the code
long-term maintainable is more important than supporting
CQE. But that does not mean I think CQE is unimportant.

Or rather: just because someone is FOR something else,
doesn't mean they are AGAINST this.

I am pretty sure both sets of functionality can be attained in the next
merge window, but it requires good faith.

>>> +enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
>>> +{
>>> +       if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
>>> +               return MMC_ISSUE_ASYNC;
>>> +
>>> +       return MMC_ISSUE_SYNC;
>>> +}
>>
>> Distinguishing between SYNC and ASYNC operations and using
>> that as abstraction is nice.
>>
>> But you only do this in the new MQ code.
>>
>> Instead, make this a separate patch and first refactor the old
>> code to use this distinction between SYNC and ASYNC.
>
> That is a non-starter.  The old code is rubbish.  Point to something work
> saving.  There isn't anything.

I think we have addressed this.

>> Unfortunately I think Ulf's earlier criticism that you're rewriting
>> the world instead of refactoring what we have still stands on many
>> accounts here.
>
> Nope.  It is just an excuse to delay the patches.  You guys are playing
> games and it is embarassing for linux.  What is actually wrong with this
> technically?  It is not good because it doesn't churn the old code?  That is
> ridiculous.

It's not good because it does not make MQ mandatory and does
not delete the interfaces to the old block layer.

>> It makes it even harder to understand your persistance in keeping
>> the old block layer around. If you're introducing new concepts and
>> cleaner code in the MQ path and kind of discarding the old
>> block layer path, why keep it around at all?
>
> Wow, you really like making things up.  Never have I suggested keeping the
> old code.  It is rubbish.

So why are you not just deleting it?

>  As soon and blk-mq is ready and tested, delete
> the old crap.

I disagree. No "ready and tested" is needed, the code is ready,
and I have tested it. It performs. Delete the old code now.

> I was expecting CQE to be applied 6 months ago, supporting the legacy blk
> layer until blk-mq was ready.  But you never delivered on blk-mq, which is
> why I had to do it.  And now you are making up excuses about why we can't
> move forward.

Don't be so conspiracist. I think I have answered this several
times over.

Migrating to MQ and getting rid of the old block layer interface is
paramount in my view. That is the essence of all my review feedback.
The other comments are minor, and even if you don't take my
comments into consideration it is stuff I can work on fixing after
these patches are merged.

If you just make a series also deleteing the old block layer
I will test it so it doesn't break anything and then you can
probably expect a big Acked-by on the whole shebang.

>> I would have a much easier time accepting this patch if it
>> deleted as much as it was adding, i.e. introduce all this new
>> nice MQ code, but also tossing out the old block layer and error
>> handling code. Even if it is a massive rewrite, at least there
>> is just one body of code to maintain going forward.
>
> How can you pssibly call a few hundred lines massive.  The kernel has
> millions of lines.  Your sense of scale is out of whack.

Arguably you are speaking against yourself, since the old code
was described by yourself as "rubbish", and it is very terse and
uninituitive to read even a few lines of rubbish.

I had to create a (quite popular) Googledoc breaking down the
MMC stack in words before I could even start hacking at it.
So it is not massive in the sense of number of lines but in the
sense of intelligibility, it's so terse that it feels like eating a
too big piece of mudcake or something.

Just delete the rubbish and I'm happy.

>> That said, I would strongly prefer a refactoring of the old block
>> layer leading up to transitioning to MQ. But I am indeed biased
>> since I took that approach myself.
>
> Well stop it.  We have nice working code.  Get it applied and tested, and
> then we can delete the old crap.

Just get the old code deleted so there is just one thing to
test and not a matrix of old and new code paths.

>> This timeout looks like something I need to pick up in my patch
>> set as well. It seems good for stability to support this. But what happened
>> here? Did you experience a bunch of timeouts during development,
>> or let's say how was this engineered, I guess it is for the case when
>> something randomly locks up for a long time and we don't really know
>> what has happened, like a watchdog?
>
> We presently don't have the host APIs to support external timeouts.  CQE
> uses them though.

OK

>>> +static int mmc_init_request(struct request_queue *q, struct request *req,
>>> +                           gfp_t gfp)
>>> +{
>>> +       return __mmc_init_request(q->queuedata, req, gfp);
>>> +}
>>> +
>> (...)
>>> +static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
>>> +                              unsigned int hctx_idx, unsigned int numa_node)
>>> +{
>>> +       return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
>>> +}
>>> +
>>> +static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
>>> +                               unsigned int hctx_idx)
>>> +{
>>> +       struct mmc_queue *mq = set->driver_data;
>>> +
>>> +       mmc_exit_request(mq->queue, req);
>>> +}
>>
>> Here is more code duplication just to keep both the old block layer
>> and MQ around. Including introducing another inner __foo function
>> which I have something strongly against personally (I might be
>> crazily picky, because I see many people do this).
>
> In this case, it is not code duplication it is re-using the same code but
> called from the blk-mq API.

Right, OK.

>>> +               /*
>>> +                * Timeouts are handled by mmc core, so set a large value to
>>> +                * avoid races.
>>> +                */
>>> +               req->timeout = 600 * HZ;
>>> +               break;
>>> +       }
>>
>> These timeouts again, does this mean we have competing timeout
>> code in the block layer and MMC?
>
> Yes - the host controller provides hardware timeout interrupts in most
> cases.  The core provides software timeouts in other cases.

OK maybe we can extend the comment about to explain this
situation so it is clear what is racing with what.

>> This mentions timeouts in the MMC core, but they are actually
>> coming from the *MMC* core, when below you set:
>> blk_queue_rq_timeout(mq->queue, 60 * HZ);?
>>
>> Isn't the actual case that the per-queue timeout is set up to
>> occur before the per-request timeout, and that you are hacking
>> around the block layer core having two different timeouts?
>
> There is no per-queue timeout.  The request timeout has a default value
> given by the queue.  It can be changed for different requests.

Aha.

>> It's a bit confusing so I'd really like to know what's going on...
>
> I don't expect to have to teach you the block layer.

But I will tell you to stop snarking around every time you
write things like that.


>>> +       mq->in_flight[issue_type] += 1;
>>> +       get_card = mmc_tot_in_flight(mq) == 1;
>>
>> Parenthesis around the logical expression preferred I guess
>> get_card = (mmc_tot_in_flight(mq) == 1);
>> (Isn't checkpatch complaining about this?)
>
> Nope

Too bad. OK I think it's nice with a paranthesis anyway.
Aids perception or something.

>> Then:
>> (...)
>>> +       if (get_card)
>>> +               mmc_get_card(card, &mq->ctx);
>>
>> I simply took the card on every request. Since the context is the
>> same for all block layer business and the lock is now fully
>> reentrant this if (get_card) is not necessary. Just take it for
>> every request and release it in the .complete() callback.
>
> As I have written elsewhere, we have always avoind getting / putting
> unecessarily.  It is better that way, so no point in taking it out.

I explained about about the double counters.

>>> +#define MMC_QUEUE_DEPTH 64
>>> +
>>> +static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
>>> +                        spinlock_t *lock)
>>> +{
>>> +       int q_depth;
>>> +       int ret;
>>> +
>>> +       q_depth = MMC_QUEUE_DEPTH;
>>> +
>>> +       ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);
>>
>> Apart from using a define, then assigning the define to a
>> variable and then passing that variable instead of just
>> passing the define: why 64? Is that the depth of the CQE
>> queue? In that case we need an if (cqe) and set it down
>> to 2 for non-CQE.
>
> Are you ever going to learn about the block layer.

Are you ever going to treat your fellow community peers as
equals?

It is actually your job as a patch submitter to teach others about
the details of what you are doing. If you think all your fellow programmers
suck then elevate them to your own level instead of pushing them down.

> The number of requests
> is default 128 for the legacy block layer.

I had no clue.

> For blk-mq it is queue depth
> times 2.  So 64 gives the same number of requests as before.

I see. But by just setting it to 2 as I do in my patch set, it still
performs, I guess just with less buffers allocated.

This makes some kind of sense though and I guess it explains
why we got out of memory with the bounce buffer thing, as that
then resulted in 128*64KB of allocated memory for the request
queue. I thought it would be ... a few requests.

>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       blk_queue_rq_timeout(mq->queue, 60 * HZ);
>>
>> And requests timeout after 1 minute I take it.
>>
>> I suspect both of these have some relation to CQE, so that is where
>> you find these long execution times etc?
>
> For legacy mmc, the core takes care of timeouts.  For CQE we expect reliable
> devices and I would interpret a timeout as meaning the device is broken.

OK.

> However it is sensible to have anyway.  For CQE, a request might have to
> wait for the entire rest of the queue to be processed first, or maybe the
> request somehow gets stuck and there are other requests constantly
> overtaking it.  The max queue depth is 32 so 60 seconds seems ok.

OK we will get to see as we see more and more devices of this type.
It's fine.

>>> +static void mmc_mq_queue_suspend(struct mmc_queue *mq)
>>> +{
>>> +       blk_mq_quiesce_queue(mq->queue);
>>> +
>>> +       /*
>>> +        * The host remains claimed while there are outstanding requests, so
>>> +        * simply claiming and releasing here ensures there are none.
>>> +        */
>>> +       mmc_claim_host(mq->card->host);
>>> +       mmc_release_host(mq->card->host);
>>
>> I think just blk_mq_quiesce_queue() should be fine as and
>> should make sure all requests have called .complete() and there
>> I think you should also release the host lock.
>>
>> If the MQ code is not doing this, we need to fix MQ to
>> do the right thing (or add a new callback such as
>> blk_mq_make_sure_queue_empty()) so at the very
>> least put a big fat FIXME or REVISIT comment on the above.
>
> blk_mq_quiesce_queue() prevents dispatches not completions.  So we wait for
> outstanding requests.

I guess the quiesce call not really intended for PM suspend/resume
paths. Maybe we need to add a blk_mq_flush_queue() call then.
(No showstopper, this is OK for now.)

>> One of the good reasons to delete the old block layer is to get
>> rid of this horrible semaphore construction. So I see it as necessary
>> to be able to focus development efforts on code that actually has
>> a future.
>
> The old crap will get deleted when blk-mq is ready.

Which IMO is now.

>>> +
>>> +       int                     in_flight[MMC_ISSUE_MAX];
>>
>> So this is a [2] containing a counter for the number of
>> synchronous and asynchronous requests in flight at any
>> time.
>>
>> But are there really synchronous and asynchronous requests
>> going on at the same time?
>>
>> Maybe on the error path I guess.
>>
>> I avoided this completely but I guess it may be necessary with
>> CQE, such that in_flight[0,1] is way more than 1 or 2 at times
>> when there are commands queued?
>
> CQE needs to count DCMD separately from read / writes.  Counting by issue
> type is a simple way to do that.

OK

>>> +       bool                    rw_wait;
>>> +       bool                    waiting;
>>> +       wait_queue_head_t       wait;
>>
>> As mentioned I think this is a reimplementation of
>> the completion abstraction.
>
> I pointed out why that wouldn't work.  Another case of why the code makes
> more sense together than split up.

I'm not entirely convinced about that but we'll see. It is a detail.

Yours,
Linus Walleij
