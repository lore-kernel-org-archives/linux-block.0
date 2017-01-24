Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAXHLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 02:11:40 -0500
Date: Tue, 24 Jan 2017 08:11:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josef Bacik <jbacik@fb.com>
Cc: arnd@arndb.de, axboe@fb.com, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170124071152.GB13251@kroah.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com>
 <20170121090531.GB27048@kroah.com>
 <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485186762.21123.1@smtp.office365.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 23, 2017 at 10:52:42AM -0500, Josef Bacik wrote:
> On Mon, Jan 23, 2017 at 10:03 AM, Greg KH <gregkh@linuxfoundation.org>
> wrote:
> > On Mon, Jan 23, 2017 at 09:57:52AM -0500, Josef Bacik wrote:
> > >  On Mon, Jan 23, 2017 at 9:52 AM, Greg KH
> > > <gregkh@linuxfoundation.org> wrote:
> > >  > On Mon, Jan 23, 2017 at 09:42:08AM -0500, Josef Bacik wrote:
> > >  > >
> > >  > >
> > >  > >  On Sat, Jan 21, 2017 at 4:05 AM, Greg KH
> > >  > > <gregkh@linuxfoundation.org> wrote:
> > >  > >  > On Fri, Jan 20, 2017 at 04:56:52PM -0500, Josef Bacik wrote:
> > >  > >  > >  This patch mirrors the loop back device behavior with a
> > > few
> > >  > >  > > changes.  First
> > >  > >  > >  there is no DEL operation as NBD doesn't get as much
> > > churn as
> > >  > > loop
> > >  > >  > > devices do.
> > >  > >  > >  Secondly the GET_NEXT operation can optionally create a
> > > new NBD
> > >  > >  > > device or not.
> > >  > >  > >  Our infrastructure people want to not allow NBD to create
> > > new
> > >  > >  > > devices as it
> > >  > >  > >  causes problems for them in containers.  However allow
> > > this to
> > >  > > be
> > >  > >  > > optional as
> > >  > >  > >  things like the OSS NBD client probably doesn't care and
> > > would
> > >  > > like
> > >  > >  > > to just be
> > >  > >  > >  given a device to use.
> > >  > >  > >
> > >  > >  > >  Signed-off-by: Josef Bacik <jbacik@fb.com>
> > >  > >  >
> > >  > >  > A random char device with odd ioctls?  Why?  There's no other
> > >  > >  > configuration choice you could possibly use?  Where is the
> > >  > > userspace
> > >  > >  > tool that uses this new kernel api?
> > >  > >  >
> > >  > >  > You aren't passing in structures to the ioctl, so why does
> > > this
> > >  > > HAVE to
> > >  > >  > be an ioctl?
> > >  > >
> > >  > >  Again, this is how loop does it so I assumed a known, regularly
> > >  > > used API was
> > >  > >  the best bet.  I can do literally anything, but these
> > > interfaces
> > >  > > have to be
> > >  > >  used by other people, including internal people.  The
> > >  > > /dev/whatever-control
> > >  > >  is a well established way for interacting with dynamic device
> > >  > > drivers (loop,
> > >  > >  DM, btrfs), so that's what I went with.  Thanks,
> > >  >
> > >  > Again, please don't duplicate what loop did, we must _learn_ from
> > >  > history, not repeat it :(
> > > 
> > >  Sure but what am I supposed to do?  Have some random sysfs knobs?
> > > Thanks,
> > 
> > It all depends on what you are trying to do.  I have yet to figure that
> > out at all here :(
> 
> I explained it in the changelog and my response to Wouter.  NBD preallocates
> all of its /dev/nbd# devices at modprobe time, so there's no way to add new
> devices as we need them.

Why not fix that odd restriction?

> Loop accomplishes this with the /dev/loop-control
> and an ioctl.  Then we also need a way to figure out what is the first
> /dev/nbd# device that isn't currently in use in order to pick the next one
> to configure.  Keep in mind that all of the configuration for /dev/nbd#
> devices is done through ioctls to those devices, so having a ioctl interface
> for the control device is consistent with the rest of how NBD works.

But adding a random char device node and using ioctls on it is different
than using an ioctl on an existing block device node that is already
there.

So what _exactly_ do you need to do with this interface?  What data do
you need sent/received to/from the kernel?  Specifics please.

thanks,

greg k-h
