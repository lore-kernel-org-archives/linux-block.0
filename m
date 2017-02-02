Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdBBRSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2017 12:18:12 -0500
Date: Thu, 2 Feb 2017 18:18:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@fb.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
Message-ID: <20170202171815.GA31948@kroah.com>
References: <cover.1485902856.git.osandov@fb.com>
 <20170201081608.GB18278@kroah.com>
 <20170201083115.GA16278@vader>
 <20170202105853.GA27128@kroah.com>
 <6f6a76f1-7c43-4674-941e-ed3fc5379402@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f6a76f1-7c43-4674-941e-ed3fc5379402@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02, 2017 at 08:17:31AM -0700, Jens Axboe wrote:
> On 02/02/2017 03:58 AM, Greg Kroah-Hartman wrote:
> > On Wed, Feb 01, 2017 at 12:31:15AM -0800, Omar Sandoval wrote:
> >> On Wed, Feb 01, 2017 at 09:16:08AM +0100, Greg Kroah-Hartman wrote:
> >>> On Tue, Jan 31, 2017 at 02:53:16PM -0800, Omar Sandoval wrote:
> >>>> From: Omar Sandoval <osandov@fb.com>
> >>>>
> >>>> When I moved the blk-mq debugging information to debugfs, I didn't
> >>>> realize that blktrace also created directories in debugfs that
> >>>> conflicted with the blk-mq directories. This series fixes that.
> >>>>
> >>>> Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
> >>>> an ack on that if it makes sense? Jens and I went back and forth on this
> >>>> for a little while, but patch 6 has more of the rationale on why we
> >>>> decided that this approach was the cleanest.
> >>>
> >>> I can't find patch 6, you only cc:ed me on the first patch :(
> >>>
> >>> Care to bounce them all to me?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> Gah, I forgot --cc-cover to git-send-email. The series is all here:
> >> http://marc.info/?l=linux-block&r=1&b=201701&w=2. I can also send the
> >> patches directly to you if you prefer that.
> > 
> > I don't understand the problem here.  How do you not know if you have
> > created the debugfs file or not?  You have the structure, with the
> > correct name, how could it have been created?  Can't you save the dentry
> > to the debugfs file in the structure that has the name?
> 
> The problem is that blktrace registers a trace name directory, which
> can be either whole device or partition, depending on what you trace.
> For the blk-mq debug parts, we always just register the whole device
> name. There's no way to save the partition dentry, and imho, why even
> would you when you can just look it up. It's a file system...

I agree, it is a file system, but usually that debugfs file is
associated with some sort of data you want to keep track of outside of a
filesystem :)

Anyway, if it's such a big pain, then it's fine, add the function, no
objection from me anymore.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

