Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdAZJRq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 04:17:46 -0500
Date: Thu, 26 Jan 2017 10:17:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Alex Gartrell <agartrell@fb.com>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170126091758.GB31667@kroah.com>
References: <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com>
 <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
 <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
 <20170125213004.GA6141@kroah.com>
 <68e14c2e-e96e-ff8d-bd8a-0754fb970e77@redhat.com>
 <20170126084047.GA9242@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126084047.GA9242@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:40:47AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 25, 2017 at 03:36:20PM -0600, Eric Blake wrote:
> > How do you get an fd to existing nbd block device?  Your intent is to
> > use an ioctl to request creating/opening a new nbd device that no one
> > else is using; opening an existing device in order to send that ioctl
> > may have negative ramifications to the actual user of that existing
> > device, if not permissions issues that prevent the open from even
> > happening.  Having a separate control fd makes it obvious that you are
> > asking for a new nbd device, and don't want to stomp on any existing
> > devices.
> 
> Yes, - this whole concept of needing a device first to then associate
> it with a backing store is something we had a in a lot of drivers,
> and it's always been a major problem.  Thus we've been slowly moving
> all the drivers off it.

Ok, but do you feel the "loop method" of using a char device node to
create/control these devices is a good model to follow for new devices
like ndb?

thanks,

greg k-h
