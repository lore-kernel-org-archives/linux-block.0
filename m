Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Wed, 13 Dec 2017 16:13:07 +0900
Message-ID: <CANrsvRMAci5Vxj0kKsgW4-cgK4X4BAvq9jOwkAx0TWHqBjogVw@mail.gmail.com>
Subject: Re: About the try to remove cross-release feature entirely by Ingo
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        tytso@mit.edu, willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 13, 2017 at 3:24 PM, Byungchul Park
<max.byungchul.park@gmail.com> wrote:
> Lockdep works, based on the following:
>
>    (1) Classifying locks properly
>    (2) Checking relationship between the classes
>
> If (1) is not good or (2) is not good, then we
> might get false positives.
>
> For (1), we don't have to classify locks 100%
> properly but need as enough as lockdep works.
>
> For (2), we should have a mechanism w/o
> logical defects.
>
> Cross-release added an additional capacity to
> (2) and requires (1) to get more precisely classified.
>
> Since the current classification level is too low for
> cross-release to work, false positives are being
> reported frequently with enabling cross-release.
> Yes. It's a obvious problem. It needs to be off by
> default until the classification is done by the level
> that cross-release requires.
>
> But, the logic (2) is valid and logically true. Please
> keep the code, mechanism, and logic.

In addition, I want to say that the current level of
classification is much less than 100% but, since we
have annotated well to suppress wrong reports by
rough classifications, finally it does not come into
view by original lockdep for now.

But since cross-release makes the dependency
graph more fine-grained, it easily comes into view.

Even w/o cross-release, it can happen by adding
additional dependencies connecting two roughly
classified lock classes in the future.

Furthermore, I can see many places in kernel to
consider wait_for_completion() using manual
lock_acquire()/lock_release() and the rate using it
raises.

In other words, even without cross-release, the
more we add manual annotations for
wait_for_completion() the more we definitely
suffer same problems someday, we are facing now
through cross-release.

Therefore, I want to say the fundamental problem
comes from classification, not cross-release
specific. Of course, since cross-release accelerates
the condition, I agree with it to be off for now.

-- 
Thanks,
Byungchul
