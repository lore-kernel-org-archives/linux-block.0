Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171215062428.5dyv7wjbzn2ggxvz@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171213104617.7lffucjhaa6xb7lp@gmail.com> <CANrsvRPuhPyh1nFnzdYj8ph7e1FQRw_W_WN2a1tm9fzpAYks4g@mail.gmail.com>
 <CANrsvRP3-bWatoaq1teNFG1RXRbazqnHvOKXe458eAxSdAnsfg@mail.gmail.com> <20171215062428.5dyv7wjbzn2ggxvz@thunk.org>
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Fri, 15 Dec 2017 16:38:47 +0900
Message-ID: <CANrsvROu_Y6nOwnTGxyL8UbMcFpYdhZrQpa=ECNUsVxNftC=zQ@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Remove the cross-release locking checks
To: "Theodore Ts'o" <tytso@mit.edu>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, david@fromorbit.com,
        willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 3:24 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, Dec 15, 2017 at 01:05:43PM +0900, Byungchul Park wrote:
>> For example, in the case of fs issues, for now we can
>> invalidate wait_for_completion() in submit_bio_wait()....
>
> And this will spawn a checkpatch.pl ERROR:
>
>                     ERROR("LOCKDEP",
>                     "lockdep_no_validate class is reserved for device->mutex.\n" . $herecurr);
>
> This mention in checkpatch.pl is the only documentation I've been able
> to find about lockdep_set_novalidate_class(), by the way.
>
>> ... and re-validate it later, of course, I really want to find more
>> fundamental solution though.
>
> Oh, and I was finally able to find the quote that the *only* people
> who are likely to be able to deal with lock annotations are the

Right. Using the word, "only", is one that I should not have done
and I apologize for.

They are just "only" people who solve and classify locks quickly,
assuming all of kernel guys are familiar with lockdep annotations.
Thus, even this statement is bad as well, since no good
document for that exists, as you pointed out. I agree.

> subsystem maintainers.  But if the ways of dealing with lock
> annotations are not documented, such that subsystem maintainers are
> going to have a very hard time figuring out *how* to deal with it, it

Right. I've agreed with this, since you pointed out it's problem not
to be documented well.

> seems that lock classification as a solution to cross-release false
> positives seems.... unlikely:
>
>    From: Byungchul Park <byungchul.park@lge.com>
>    Date: Fri, 8 Dec 2017 18:27:45 +0900
>    Subject: Re: [PATCH v4 72/73] xfs: Convert mru cache to XArray
>
>    1) Firstly, it's hard to assign lock classes *properly*. By
>    default, it relies on the caller site of lockdep_init_map(),
>    but we need to assign another class manually, where ordering
>    rules are complicated so cannot rely on the caller site. That
>    *only* can be done by experts of the subsystem.
>
>                                         - Ted



-- 
Thanks,
Byungchul
