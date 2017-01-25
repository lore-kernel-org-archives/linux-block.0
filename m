Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdAYVaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 16:30:03 -0500
Date: Wed, 25 Jan 2017 22:30:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Alex Gartrell <agartrell@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170125213004.GA6141@kroah.com>
References: <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com>
 <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
 <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 06:25:11PM +0000, Alex Bligh wrote:
> 
> > On 25 Jan 2017, at 16:48, Alex Gartrell <agartrell@fb.com> wrote:
> > 
> > 
> > If nbd were *all* netlink I think that that'd be fine, but you'd have
> > problems implementing the NBD_DOIT function in that fashion.  So I'd
> > rather stick to the char device ioctl thing because it's more
> > consistent with the old NBD stuff as well as the loop device stuff.
> 
> I spend most of my time looking at the userspace side of NBD so
> apologies if this is off base.
> 
> Given (because of NBD_DO_IT) we need an ioctl anyway, and we have
> an ioctl that isn't going to go away, it would seem better if possible
> to stick with ioctls, and not introduce either a dependency
> on netlink (which would presumably bloat static binaries that
> are used early in the boot process). Personally I'd have thought
> adding a new NBD ioctl (or extending an existing one) would be
> less entropy than adding a new char device.

Why can't you just do this on any existing nbd block device with an
ioctl to it?  No need to have to do it on an out-of-band char device
node, right?

thanks,

greg k-h
