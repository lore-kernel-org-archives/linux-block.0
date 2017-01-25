Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:45641 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbdAYSVQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 13:21:16 -0500
Date: Wed, 25 Jan 2017 19:21:07 +0100
From: Wouter Verhelst <w@uter.be>
To: Alex Gartrell <agartrell@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@fb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170125182107.i4cd3yvzqikduvut@grep.be>
References: <20170121090531.GB27048@kroah.com>
 <1485182528.9861.22@smtp.office365.com>
 <20170123145212.GA19582@kroah.com>
 <1485183472.21123.0@smtp.office365.com>
 <20170123150325.GB26884@kroah.com>
 <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com>
 <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 04:48:27PM +0000, Alex Gartrell wrote:
> On 1/25/17, 6:23 AM, "arndbergmann@gmail.com on behalf of Arnd Bergmann" <arndbergmann@gmail.com on behalf of arnd@arndb.de> wrote:
> > We have multiple established ways to deal with this kind of problem, the most
> > common ones being a separate chardev as you propose, a sysfs interface and
> > netlink.
> > 
> > They all have their own set of problems, but the needs of nbd as a network
> > storage interface seem most closely resemble what we have for other network
> > related interfaces, where we typically use netlink to do the setup, see e.g.
> > macvtap as an example for a network chardev interface.
> > 
> > Can you have a look if that would solve your problem more nicely?
> 
> FWIW, I'm the one consuming this nbd stuff at Facebook and bringing
> netlink into this would be a huge pain for me.  It's very weird to
> need to pull sockets in and then drop back to ioctls from a design
> perspective, and future consumers of this API would be sad as well.

As who's been maintaining the official userspace nbd client for 15 years
now, I have to concur. NBD has had an API that deals with /dev/nbdX
since forever, adding other APIs to that just feels wrong.

> This is compounded, I think, by the fact that the breadth of
> functionality here doesn't really merit a shared library for everyone
> to use -- could you imagine libnbdcontrol, which exposes a single
> "get_next_device" function?

Please no :)

> If nbd were *all* netlink I think that that'd be fine, but you'd have
> problems implementing the NBD_DOIT function in that fashion.  So I'd
> rather stick to the char device ioctl thing because it's more
> consistent with the old NBD stuff as well as the loop device stuff.

Indeed.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
