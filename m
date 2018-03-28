Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeC1NVU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Mar 2018 09:21:20 -0400
Date: Wed, 28 Mar 2018 15:18:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: use interruptible lock in ioctls
Message-ID: <20180328131851.GG30422@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1522106130.git.osandov@fb.com>
 <7ec1489d2ca54e886713efe5beb6dd379c2279b6.1522106130.git.osandov@fb.com>
 <20180327000421.GC10054@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327000421.GC10054@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 26, 2018 at 05:04:21PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 26, 2018 at 04:16:26PM -0700, Omar Sandoval wrote:
> > Even after the previous patch to drop lo_ctl_mutex while calling
> > vfs_getattr(), there are other cases where we can end up sleeping for a
> > long time while holding lo_ctl_mutex. Let's avoid the uninterruptible
> > sleep from the ioctls.
> 
> Umm ... you want these ioctls to return -EINTR just because you resized
> an xterm?  I think you really meant mutex_lock_killable().

Does that really happen? In some cases (namely user called ioctls) I'd
like to allow ctrl-c to interrupt a mutex_lock or other _interruptible
actions. I'd be very surprised if resizing terminal stops the command
I've just started.
