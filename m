Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43305 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdLLPjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 10:39:22 -0500
Date: Tue, 12 Dec 2017 07:39:16 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Byungchul Park <byungchul.park@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
Message-ID: <20171212153916.GA9570@bombadil.infradead.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
 <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
 <20171212130343.6nwxip3i4ua24dwr@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212130343.6nwxip3i4ua24dwr@thunk.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 12, 2017 at 08:03:43AM -0500, Theodore Ts'o wrote:
> On Tue, Dec 12, 2017 at 02:20:32PM +0900, Byungchul Park wrote:
> > The *problem* is false positives, since locks and waiters in
> > kernel are not classified properly, at the moment, which is just
> > a fact that is not related to cross-release stuff at all. IOW,
> > that would be useful once all locks and waiters are classified
> > correctly. It might take time but the classifying is a must-do
> > we have to keep doing.
> 
> This is the wrong attitude.  The reason why LOCKDEP was so powerful
> was because it automatically classified locks, instead of requiring
> developers to document the locking hierarchy.  Requiring developers to
> have to document and classified locks --- especially when the d*mned
> mechanisms for doign so are so primitive and not even documented ---
> is a complete non-strarter.

That's not fair.  We had to annotate i_mutex nesting, for example, and
several other places.  crosslock doesn't change anything in this respect,
it's just that the case that you hit every damn day as a filesystem
developer is something that the normal person almost never does.

> So are you willing to take my patch?  Or give me permission to keep in
> the ext4 tree?

He sent a patch earlier ...
