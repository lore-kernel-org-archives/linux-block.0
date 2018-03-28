Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeC1Q5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Mar 2018 12:57:18 -0400
Date: Wed, 28 Mar 2018 09:57:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: use interruptible lock in ioctls
Message-ID: <20180328165716.GA639@bombadil.infradead.org>
References: <cover.1522106130.git.osandov@fb.com>
 <7ec1489d2ca54e886713efe5beb6dd379c2279b6.1522106130.git.osandov@fb.com>
 <20180327000421.GC10054@bombadil.infradead.org>
 <20180328131851.GG30422@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180328131851.GG30422@twin.jikos.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 28, 2018 at 03:18:52PM +0200, David Sterba wrote:
> On Mon, Mar 26, 2018 at 05:04:21PM -0700, Matthew Wilcox wrote:
> > On Mon, Mar 26, 2018 at 04:16:26PM -0700, Omar Sandoval wrote:
> > > Even after the previous patch to drop lo_ctl_mutex while calling
> > > vfs_getattr(), there are other cases where we can end up sleeping for a
> > > long time while holding lo_ctl_mutex. Let's avoid the uninterruptible
> > > sleep from the ioctls.
> > 
> > Umm ... you want these ioctls to return -EINTR just because you resized
> > an xterm?  I think you really meant mutex_lock_killable().
> 
> Does that really happen? In some cases (namely user called ioctls) I'd
> like to allow ctrl-c to interrupt a mutex_lock or other _interruptible
> actions. I'd be very surprised if resizing terminal stops the command
> I've just started.

Resizing an xterm causes the xterm to send its child SIGWINCH.  ctrl-c
will cause fatal_signal_pending() to become true, and mutex_lock_killable
to return -EINTR.  mutex_lock_interruptible() will return -EINTR for any
signal (SIGPOLL, SIGWINCH, etc).
