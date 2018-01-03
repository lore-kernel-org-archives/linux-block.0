Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:7899 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751148AbeACC6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jan 2018 21:58:12 -0500
Date: Wed, 3 Jan 2018 13:58:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, kernel-team@lge.com, daniel@ffwll.ch
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20180103025808.GD30682@dastard>
References: <20171229014736.GA10341@X58A-UD3R>
 <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
 <20171230061624.GA27959@bombadil.infradead.org>
 <20171230154041.GB3366@thunk.org>
 <20171230204417.GF27959@bombadil.infradead.org>
 <20171230224028.GC3366@thunk.org>
 <20171230230057.GB12995@thunk.org>
 <20180101101855.GA23567@bombadil.infradead.org>
 <06e73e69-9c78-07bc-3d06-a51accb2645b@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06e73e69-9c78-07bc-3d06-a51accb2645b@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 03, 2018 at 11:28:44AM +0900, Byungchul Park wrote:
> On 1/1/2018 7:18 PM, Matthew Wilcox wrote:
> >On Sat, Dec 30, 2017 at 06:00:57PM -0500, Theodore Ts'o wrote:
> >>Also, what to do with TCP connections which are created in userspace
> >>(with some authentication exchanges happening in userspace), and then
> >>passed into kernel space for use in kernel space, is an interesting
> >>question.
> >
> >Yes!  I'd love to have a lockdep expert weigh in here.  I believe it's
> >legitimate to change a lock's class after it's been used, essentially
> >destroying it and reinitialising it.  If not, it should be because it's
> >a reasonable design for an object to need different lock classes for
> >different phases of its existance.
> 
> I also think it should be done ultimately. And I think it's very much
> hard since it requires to change the dependency graph of lockdep but
> anyway possible. It's up to lockdep maintainer's will though..

We used to do this in XFS to work around the fact that the memory
reclaim context "locks" were too stupid to understand that an object
referenced and locked above memory allocation could not be
accessed below in memory reclaim because memory reclaim only accesses
/unreferenced objects/. We played whack-a-mole with lockdep for
years to get most of the false positives sorted out.

Hence for a long time we had to re-initialise the lock context for
the XFS inode iolock in ->evict_inode() so we could lock it for
reclaim processing.  Eventually we ended up completely reworking the
inode reclaim locking in XFS primarily to get rid of all the nasty
lockdep hacks we had strewn throughout the code. It was ~2012 we
got rid of the last inode re-init code, IIRC. Yeah:

commit 4f59af758f9092bc7b266ca919ce6067170e5172
Author: Christoph Hellwig <hch@infradead.org>
Date:   Wed Jul 4 11:13:33 2012 -0400

    xfs: remove iolock lock classes
    
    Now that we never take the iolock during inode reclaim we don't need
    to play games with lock classes.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Rich Johnston <rjohnston@sgi.com>
    Signed-off-by: Ben Myers <bpm@sgi.com>



We still have problems with lockdep false positives w.r.t. memory
allocation contexts, mainly with code that can be called from
both above and below memory allocation contexts. We've finally
got __GFP_NOLOCKDEP to be able to annotate memory allocation points
within such code paths, but that doesn't help with locks....

Byungchul, lockdep has a long, long history of having sharp edges
and being very unfriendly to developers. We've all been scarred by
lockdep at one time or another and so there's a fair bit of
resistance to repeating past mistakes and allowing lockdep to
inflict more scars on us....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
