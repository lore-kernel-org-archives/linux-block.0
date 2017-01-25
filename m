Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:52509 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdAYIzj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 03:55:39 -0500
Date: Wed, 25 Jan 2017 09:55:28 +0100
From: Wouter Verhelst <w@uter.be>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Josef Bacik <jbacik@fb.com>, axboe@fb.com,
        nbd-general@lists.sourceforge.net, kernel-team@fb.com,
        linux-block@vger.kernel.org, arnd@arndb.de
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170125085528.mbr7p45iyvjihw6n@grep.be>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com>
 <20170121090531.GB27048@kroah.com>
 <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170124071152.GB13251@kroah.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 24, 2017 at 08:11:52AM +0100, Greg KH wrote:
> On Mon, Jan 23, 2017 at 10:52:42AM -0500, Josef Bacik wrote:
> > I explained it in the changelog and my response to Wouter.  NBD preallocates
> > all of its /dev/nbd# devices at modprobe time, so there's no way to add new
> > devices as we need them.
> 
> Why not fix that odd restriction?

Isn't that what this patch is trying to do?

> > Loop accomplishes this with the /dev/loop-control
> > and an ioctl.  Then we also need a way to figure out what is the first
> > /dev/nbd# device that isn't currently in use in order to pick the next one
> > to configure.  Keep in mind that all of the configuration for /dev/nbd#
> > devices is done through ioctls to those devices, so having a ioctl interface
> > for the control device is consistent with the rest of how NBD works.
> 
> But adding a random char device node and using ioctls on it is different
> than using an ioctl on an existing block device node that is already
> there.
> 
> So what _exactly_ do you need to do with this interface?  What data do
> you need sent/received to/from the kernel?  Specifics please.

AIUI: Create new devices, and figure out which device is the next one
free so we can find one without having to check the pid attribute for
every device (as is needed today, and which is racy).

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
