Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
References: <20171211035017.32678-1-tytso@mit.edu> <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
 <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Dec 2017 09:00:56 -0800
Message-ID: <CA+55aFw3kiLObrtMTTiJBJW44gWV=cc=-rZs46XyuLjaTvxcHg@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
To: Byungchul Park <byungchul.park@lge.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Dec 11, 2017 at 9:20 PM, Byungchul Park <byungchul.park@lge.com> wrote:
>
> The *problem* is false positives, since locks and waiters in
> kernel are not classified properly

So the problem is that those false positives apparently end up being a
big deal for the filesystem people.

I personally don't think the code itself has to be removed, but I do
think that it should never have been added on as part of the generic
lock proving, and should always have been a separate config option.

I also feel that you dismiss "false positives" much too easily. A
false positive is a big problem - because it makes people ignore the
real cases (or just disable the functionality entirely).

It's why I am very quick to disable compiler warnings that have false
positives, for example. Just a couple of "harmless" false positive
warnings will poison the real warnings for people because they'll get
used to seeing warnings while building, and no longer actually look at
them.

                 Linus
