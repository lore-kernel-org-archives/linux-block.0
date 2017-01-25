Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:59824 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbdAYSZP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 13:25:15 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
Date: Wed, 25 Jan 2017 18:25:11 +0000
Cc: Alex Bligh <alex@alex.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@fb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>
Message-Id: <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com> <1484949412-6903-4-git-send-email-jbacik@fb.com> <20170121090531.GB27048@kroah.com> <1485182528.9861.22@smtp.office365.com> <20170123145212.GA19582@kroah.com> <1485183472.21123.0@smtp.office365.com> <20170123150325.GB26884@kroah.com> <1485186762.21123.1@smtp.office365.com> <20170124071152.GB13251@kroah.com> <1485352053.5902.0@smtp.office365.com> <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com> <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
To: Alex Gartrell <agartrell@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 25 Jan 2017, at 16:48, Alex Gartrell <agartrell@fb.com> wrote:
> 
> 
> If nbd were *all* netlink I think that that'd be fine, but you'd have
> problems implementing the NBD_DOIT function in that fashion.  So I'd
> rather stick to the char device ioctl thing because it's more
> consistent with the old NBD stuff as well as the loop device stuff.

I spend most of my time looking at the userspace side of NBD so
apologies if this is off base.

Given (because of NBD_DO_IT) we need an ioctl anyway, and we have
an ioctl that isn't going to go away, it would seem better if possible
to stick with ioctls, and not introduce either a dependency
on netlink (which would presumably bloat static binaries that
are used early in the boot process). Personally I'd have thought
adding a new NBD ioctl (or extending an existing one) would be
less entropy than adding a new char device.

-- 
Alex Bligh




