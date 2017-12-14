Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdLNLS3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Dec 2017 06:18:29 -0500
Date: Thu, 14 Dec 2017 12:18:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20171214111817.xnyxgtremfspjk7f@hirez.programming.kicks-ass.net>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <CANrsvRMAci5Vxj0kKsgW4-cgK4X4BAvq9jOwkAx0TWHqBjogVw@mail.gmail.com>
 <20171214030711.gtxzm57h7h4hwbfe@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214030711.gtxzm57h7h4hwbfe@thunk.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Dec 13, 2017 at 10:07:11PM -0500, Theodore Ts'o wrote:
> interpreted this as the lockdep maintainers saying, "hey, not my
> fault, it's the subsystem maintainer's fault for not properly
> classifying the locks" --- and thus dumping the responsibility in the
> subsystem maintainers' laps.

Let me clarify that I (as lockdep maintainer) disagree with that
sentiment. I have spend a lot of time over the years staring at random
code trying to fix lockdep splats. Its awesome if corresponding
subsystem maintainers help out and many have, but I very much do not
agree its their problem and their problem alone.

This attitude is one of the biggest issues I have with the crossrelease
stuff and why I don't disagree with Ingo taking it out (for now).
