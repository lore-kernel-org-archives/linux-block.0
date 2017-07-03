Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Core block/IO changes for 4.13-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c2565c20-527f-72fb-dc5c-bb81f56220f9@kernel.dk>
 <CA+55aFw4OeKay4Vp7wDkAM+bWepRY88dMRO=KJs8+UNzt9S25Q@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <542c91dc-aaa6-7cc9-068f-bb3ba0495f7c@kernel.dk>
Date: Mon, 3 Jul 2017 13:04:18 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFw4OeKay4Vp7wDkAM+bWepRY88dMRO=KJs8+UNzt9S25Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/03/2017 11:49 AM, Linus Torvalds wrote:
> On Sun, Jul 2, 2017 at 4:44 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This is the main pull request for the block layer for 4.13. Not a huge
>> round in terms of features, but there's a lot of churn related to some
>> core cleanups. Note that merge request will throw 3 merge failures for
>> you. I've included how I resolved them in the for-next (or
>> for-4.13/merge) branch after the pull stats, at the end of this email.
> 
> So Jens, I got a semi-complaint about this constant churn in an
> entirely unrelated scheduler tracing thread.
> 
> Basically, the block IO layer is apparently really painful to do
> various instrumentation on, because it keeps having these random
> idiotic interface churn with the status and flags and various random
> command bytes changing semantics.
> 
> Can we stop with the masturbatory "let's just randomly change things
> around" already?
> 
> It doesn't just result in annoying merge conflicts, it's just
> *confusing* to people when the interfaces keep changing. And confusion
> is bad.

Not completely disagreeing with that, and we should be mostly done.
This last annoying churn is unifying the error codes, which I do think
is (very much) a worth while thing to do. It's also a backport pain,
so it's not like I love doing them...
 
> And the fact that these things keep changing is also, I think, a sign
> of something being fundamentally wrong.
> 
> WTF is going on that the block layer *constantly* ends up having these
> stupid "let's move random command flag bits from one field to another"
> or randomly changing the error returns?

I'll keep it in mind. This round has been painful on the merge
conflicts, which is to be expected with the status code returns. It's
not pointless churn, and the end result is better for it. If not, I
would be objecting more heavily to doing them. But as I said above, I
don't expect a lot of this going forward.

> Anyway, all merged up in my tree, but your "for-4.13/merge" branch did
> *not* match what I got from you. Your main for-4.13 branch had some
> additional random lightnvm/pblk changes too.

Thanks! Yes, sorry should have mentioned that, I didn't bring it
completely up to date since there were no more conflicts. The
interesting part was just the merge commit, not the rest...

-- 
Jens Axboe
