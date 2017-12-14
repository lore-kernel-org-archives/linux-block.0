Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:42155 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdLNNa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Dec 2017 08:30:27 -0500
MIME-Version: 1.0
In-Reply-To: <20171214111817.xnyxgtremfspjk7f@hirez.programming.kicks-ass.net>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <CANrsvRMAci5Vxj0kKsgW4-cgK4X4BAvq9jOwkAx0TWHqBjogVw@mail.gmail.com>
 <20171214030711.gtxzm57h7h4hwbfe@thunk.org> <20171214111817.xnyxgtremfspjk7f@hirez.programming.kicks-ass.net>
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Thu, 14 Dec 2017 22:30:24 +0900
Message-ID: <CANrsvRP8hHUJZAYUnJ5Vbu79O+HRrWfWou=Q0stRiLO9SaidCw@mail.gmail.com>
Subject: Re: About the try to remove cross-release feature entirely by Ingo
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 14, 2017 at 8:18 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Dec 13, 2017 at 10:07:11PM -0500, Theodore Ts'o wrote:
>> interpreted this as the lockdep maintainers saying, "hey, not my
>> fault, it's the subsystem maintainer's fault for not properly
>> classifying the locks" --- and thus dumping the responsibility in the
>> subsystem maintainers' laps.
>
> Let me clarify that I (as lockdep maintainer) disagree with that
> sentiment. I have spend a lot of time over the years staring at random
> code trying to fix lockdep splats. Its awesome if corresponding
> subsystem maintainers help out and many have, but I very much do not
> agree its their problem and their problem alone.

I apologize to all of you. That's really not what I intended to say.

I said that other folks can annotate it for the sub-system better
than lockdep developer, so suggested to invalidate locks making
trouble and wanting to avoid annotating it at the moment, and
validate those back when necessary with additional annotations.

It's my fault. I'm not sure how I should express what I want to say,
but, I didn't intend to charge the responsibility to other folks.

Ideally, I think it's best to solve it with co-work. I should've been
more careful to say that.

Again, I apologize for that, to lockdep and fs maintainers.

Of course, for cross-release, I have the will to annotate it or
find a better way to avoid false positives. And I think I have to.

-- 
Thanks,
Byungchul
