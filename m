Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:39108 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbdLOIj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Dec 2017 03:39:27 -0500
MIME-Version: 1.0
In-Reply-To: <20171215062428.5dyv7wjbzn2ggxvz@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171213104617.7lffucjhaa6xb7lp@gmail.com> <CANrsvRPuhPyh1nFnzdYj8ph7e1FQRw_W_WN2a1tm9fzpAYks4g@mail.gmail.com>
 <CANrsvRP3-bWatoaq1teNFG1RXRbazqnHvOKXe458eAxSdAnsfg@mail.gmail.com> <20171215062428.5dyv7wjbzn2ggxvz@thunk.org>
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Fri, 15 Dec 2017 17:39:25 +0900
Message-ID: <CANrsvROwvaZzAmTGFH=BaPohkXEB=HhDRdM3xdmPu0m4mjDpfw@mail.gmail.com>
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
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 15, 2017 at 3:24 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> seems that lock classification as a solution to cross-release false
> positives seems.... unlikely:

For this, let me explain more.

For example, either to use cross-release or to consider
wait_for_completion() in submit_bio_wait() manually using
lock_acquire() someday, classifying locks or waiters precisely
is needed.

All locks should belong to one class if each path of acquisition
can be switchable each other within the class at any time.
Otherwise, they should belong to a different class.

Even though they are different classes but belong to one class
roughly, no problem comes into view unless they are connected
each other via extra dependency chains. But, once they get
connected, we can see problems by the wrong classification.
That can happen even w/o cross-release.

Of course, as you pointed out, cross-release generates many
chains between classes, assuming all classes are well-
classified. But, practically well-classifying is not an easy work.

So that's why I suggested the way since anyway that's better
than removing all. If that's allowed, I can invalidate those waiters,
using e.g. completion_init_nomap().

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
