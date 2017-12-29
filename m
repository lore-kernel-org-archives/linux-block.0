Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:39205 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbdL2CDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Dec 2017 21:03:22 -0500
Date: Fri, 29 Dec 2017 11:02:38 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        tytso@mit.edu, willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, kernel-team@lge.com, daniel@ffwll.ch
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20171229020238.GB10341@X58A-UD3R>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229014736.GA10341@X58A-UD3R>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 29, 2017 at 10:47:36AM +0900, Byungchul Park wrote:
> On Wed, Dec 13, 2017 at 03:24:29PM +0900, Byungchul Park wrote:
> > Lockdep works, based on the following:
> > 
> >    (1) Classifying locks properly
> >    (2) Checking relationship between the classes
> > 
> > If (1) is not good or (2) is not good, then we
> > might get false positives.
> > 
> > For (1), we don't have to classify locks 100%
> > properly but need as enough as lockdep works.
> > 
> > For (2), we should have a mechanism w/o
> > logical defects.
> > 
> > Cross-release added an additional capacity to
> > (2) and requires (1) to get more precisely classified.
> > 
> > Since the current classification level is too low for
> > cross-release to work, false positives are being
> > reported frequently with enabling cross-release.
> > Yes. It's a obvious problem. It needs to be off by
> > default until the classification is done by the level
> > that cross-release requires.
> > 
> > But, the logic (2) is valid and logically true. Please
> > keep the code, mechanism, and logic.
> 
> I admit the cross-release feature had introduced several false positives
> about 4 times(?), maybe. And I suggested roughly 3 ways to solve it. I
> should have explained each in more detail. The lack might have led some
> to misunderstand.
> 
>    (1) The best way: To classify all waiters correctly.
> 
>       Ultimately the problems should be solved in this way. But it
>       takes a lot of time so it's not easy to use the way right away.
>       And I need helps from experts of other sub-systems.
> 
>       While talking about this way, I made a trouble.. I still believe
>       that each sub-system expert knows how to solve dependency problems
>       most, since each has own dependency rule, but it was not about
>       responsibility. I've never wanted to charge someone else it but me.
> 
>    (2) The 2nd way: To make cross-release off by default.
> 
>       At the beginning, I proposed cross-release being off by default.
>       Honestly, I was happy and did it when Ingo suggested it on by
>       default once lockdep on. But I shouldn't have done that but kept
>       it off by default. Cross-release can make some happy but some
>       unhappy until problems go away through (1) or (2).
> 
>    (3) The 3rd way: To invalidate waiters making trouble.
> 
>       Of course, this is not the best. Now that you have already spent
>       a lot of time to fix original lockdep's problems since lockdep was
>       introduced in 2006, we don't need to use this way for typical
>       locks except a few special cases. Lockdep is fairly robust by now.
> 
>       And I understand you don't want to spend more time to fix
>       additional problems again. Now that the situation is different
>       from the time, 2006, it's not too bad to use this way to handle
>       the issues.
> 
> IMO, the ways can be considered together at a time, which perhaps would
> be even better.

+cc daniel@ffwll.ch

> Talking about what Ingo said in the commit msg.. I want to ask him back,

I'm sorry for missing specifying the commit I'm talking about.

   e966eaeeb locking/lockdep: Remove the cross-release locking checks

> if he did it with no false positives at the moment merging it in 2006,
> without using (2) or (3) method. I bet he know what it means.. And
> classifying locks/waiters correctly is not something uglifying code but
> a way to document code better. I've felt ill at ease because of the
> unnatural and forced explanation.
> 
> --
> Thanks,
> Byungchul
