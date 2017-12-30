Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:38036 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdL3XBP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Dec 2017 18:01:15 -0500
Date: Sat, 30 Dec 2017 18:00:57 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, kernel-team@lge.com, daniel@ffwll.ch
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20171230230057.GB12995@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R>
 <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
 <20171230061624.GA27959@bombadil.infradead.org>
 <20171230154041.GB3366@thunk.org>
 <20171230204417.GF27959@bombadil.infradead.org>
 <20171230224028.GC3366@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171230224028.GC3366@thunk.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Dec 30, 2017 at 05:40:28PM -0500, Theodore Ts'o wrote:
> On Sat, Dec 30, 2017 at 12:44:17PM -0800, Matthew Wilcox wrote:
> > 
> > I'm not sure I agree with this part.  What if we add a new TCP lock class
> > for connections which are used for filesystems/network block devices/...?
> > Yes, it'll be up to each user to set the lockdep classification correctly,
> > but that's a relatively small number of places to add annotations,
> > and I don't see why it wouldn't work.
> 
> I was exagerrating a bit for effect, I admit.  (but only a bit).
> 
> It can probably be for all TCP connections that are used by kernel
> code (as opposed to userspace-only TCP connections).  But it would
> probably have to be each and every device-mapper instance, each and
> every block device, each and every mounted file system, each and every
> bdi object, etc.

Clarification: all TCP connections that are used by kernel code would
need to be in their own separate lock class.  All TCP connections used
only by userspace could be in their own shared lock class.  You can't
use a one lock class for all kernel-used TCP connections, because of
the Network Block Device mounted on a local file system which is then
exported via NFS and squirted out yet another TCP connection problem.

Also, what to do with TCP connections which are created in userspace
(with some authentication exchanges happening in userspace), and then
passed into kernel space for use in kernel space, is an interesting
question.

So "all you have to do is classify the locks 'properly'" is much like
the apocrophal, "all you have to do is bell the cat"[1].  Or like the
saying, "colonizing the stars is *easy*; all you have to do is figure
out faster than light travel."

[1] https://en.wikipedia.org/wiki/Belling_the_cat

							- Ted
