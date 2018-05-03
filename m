Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeECRsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 May 2018 13:48:25 -0400
Date: Thu, 3 May 2018 10:48:20 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Fabiano Rosas <farosas@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tj@kernel.org
Subject: Re: write call hangs in kernel space after virtio hot-remove
Message-ID: <20180503174820.GA1562@bombadil.infradead.org>
References: <f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com>
 <20180503144255.gortapk4rfqib3kj@quack2.suse.cz>
 <0e80a398d8384741f8151212c63cbdff42c9cad1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e80a398d8384741f8151212c63cbdff42c9cad1.camel@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 03, 2018 at 12:05:14PM -0400, Jeff Layton wrote:
> On Thu, 2018-05-03 at 16:42 +0200, Jan Kara wrote:
> > On Wed 25-04-18 17:07:48, Fabiano Rosas wrote:
> > > I'm looking into an issue where removing a virtio disk via sysfs while another
> > > process is issuing write() calls results in the writing task going into a
> > > livelock:
>
> > Thanks for the debugging of the problem. I agree with your analysis however
> > I don't like your fix. The issue is that when bdi is unregistered we don't
> > really expect any writeback to happen after that moment. This is what
> > prevents various use-after-free issues and I'd like that to stay the way it
> > is.
> > 
> > What I think we should do is that we'll prevent dirtying of new pages when
> > we know the underlying device is gone. Because that will fix your problem
> > and also make sure user sees the IO errors directly instead of just in the
> > kernel log. The question is how to make this happen in the least painful
> > way. I think we could intercept writes in grab_cache_page_write_begin()
> > (which however requires that function to return a proper error code and not
> > just NULL / non-NULL). And we should also intercept write faults to not
> > allow page dirtying via mmap - probably somewhere in do_shared_fault() and
> > do_wp_page(). I've added Jeff to CC since he's dealing with IO error
> > handling a lot these days. Jeff, what do you think?
> 
> (cc'ing Willy too since he's given this more thought than me)
> 
> For the record, I've mostly been looking at error _reporting_. Handling
> errors at this level is not something I've really considered in great
> detail as of yet.
> 
> Still, I think the basic idea sounds reasonable. Not allowing pages to
> be dirtied when we can't clean them seems like a reasonable thing to
> do.
> 
> The big question is how we'll report this to userland:
> 
> Would your approach have it return an error on write() and such? What
> sort of error if so? ENODEV? Would we have to SIGBUS when someone tries
> to dirty the page through mmap?

I have been having some thoughts in this direction.  They are perhaps
a little more long-term than this particular bug, so they may not be
relevant to the immediate fix.

I want to separate removing hardware from tearing down the block device
that represents something on those hardware devices.  That allows for
better handling of intermittent transport failures, or accidental device
removal, followed by a speedy insert.

In that happy future, the bug described here wouldn't be getting an
-EIO, it'd be getting an -ENODEV because we've decided this device is
permanently gone.  I think that should indeed be a SIGBUS on mapped
writes.

Looking at the current code, filemap_fault() will return VM_FAULT_SIGBUS
already if page_cache_read() returns any error other than -ENOMEM, so
that's fine.  We probably want some code (and this is where I reach the
edge of my knowledge about the current page cache) to rip all the pages
out of the page cache for every file on an -ENODEV filesystem.
