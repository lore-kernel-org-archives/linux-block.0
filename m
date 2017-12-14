Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:42770 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdLNDHi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 22:07:38 -0500
Date: Wed, 13 Dec 2017 22:07:11 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20171214030711.gtxzm57h7h4hwbfe@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <CANrsvRMAci5Vxj0kKsgW4-cgK4X4BAvq9jOwkAx0TWHqBjogVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANrsvRMAci5Vxj0kKsgW4-cgK4X4BAvq9jOwkAx0TWHqBjogVw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Dec 13, 2017 at 04:13:07PM +0900, Byungchul Park wrote:
> 
> Therefore, I want to say the fundamental problem
> comes from classification, not cross-release
> specific.

You keep saying that it is "just" a matter of classificaion.

However, it is not obvious how to do the classification in a sane
manner.  And this is why I keep pointing out that there is no
documentation on how to do this, and somehow you never respond to this
point....

In the case where you have multiple unrelated subsystems that can be
stacked in different ways, with potentially multiple instances stacked
on top of each other, it is not at all clear to me how this problem
should be solved.

It was said on one of these threads (perhaps by you, perhaps by
someone else), that we can't expect the lockdep maintainers to
understand all of the subsystems in the kernels, and so therefore it
must be up to the subsystem maintainers to classify the locks.  I
interpreted this as the lockdep maintainers saying, "hey, not my
fault, it's the subsystem maintainer's fault for not properly
classifying the locks" --- and thus dumping the responsibility in the
subsystem maintainers' laps.

I don't know if the situation is just that lockdep is insufficiently
documented, and with the proper tutorial, it would be obvious how to
solve the classification problem.

Or, if perhaps, there *is* no way to solve the classification problem,
at least not in a general form.

For example --- suppose we have a network block device on which there
is an btrfs file system, which is then exported via NFS.  Now all of
the TCP locks will be used twice for two different instances, once for
the TCP connection for the network block device, and then for the NFS
export.

How exactly are we supposed to classify the locks to make it all work?

Or the loop device built on top of an ext4 file system which on a
LVM/device mapper device.  And suppose the loop device is then layered
with a dm-error device for regression testing, and with another ext4
file system on top of that?

How exactly are we supposed to classify the locks in that situation?
Where's the documentation and tutorials which explain how to make this
work, if the responsibility is going to be dumped on the subsystem
maintainers' laps?  Or if the lockdep maintainers are expected to fix
and classify all of these locks, are you volunteering to do this?

How hard is it exactly to do all of this classification work, no
matter whose responsibility it will ultimately be?

And if the answer is that it is too hard, then let me gently suggest
to you that perhaps, if this is a case, that maybe this is a
fundamental and fatal flaw with the cross-release and completion
lockdep feature?

Best regards,

						- Ted
