Return-Path: <wouter@grep.be>
Date: Fri, 7 Apr 2017 15:04:25 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [Nbd] [PATCH 00/12] nbd: Netlink interface and path failure
 enhancements
Message-ID: <20170407130425.6obtgqrewytkicsu@grep.be>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
 <0BDE8C5C-1444-455D-88A3-F1D70181056C@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0BDE8C5C-1444-455D-88A3-F1D70181056C@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Hi Josef,

On Thu, Apr 06, 2017 at 05:05:25PM -0400, Josef Bacik wrote:
> 
> > On Apr 6, 2017, at 5:01 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> > This patchset adds a new netlink configuration interface to NBD as well as a
> > bunch of enhancments around path failures.  The patches provide the following
> > enhancemnts to NBD
> > 
> > - Netlink configuration interface that doesn't leave a userspace application
> >   waiting in kernel space for the device to disconnect.
> > - Netlink reconfigure interface for adding re-connected sockets to replace dead
> >   sockets.
> > - A flag to destroy the NBD device on disconnect, much like how mount -o loop
> >   works.
> > - A status interface that currently will only report whether a device is
> >   connected or not, but can be extended to include whatever in the future.
> > - A netlink multicast notification scheme to notify user space when there are
> >   connection issues to allow for seamless reconnects.
> > - Dead link handling.  You can specify a dead link timeout and the NBD device
> >   will pause IO for that timeout waiting to see if the connection can be
> >   re-established.  This is helpful to allow for things like nbd server upgrades
> >   where the whole server disappears for a short period of time.
> > 
> > These patches have been thorougly and continuously tested for about a month.
> > I've been finding bugs in various places, but this batch has been solid for the
> > last few days of testing, which include a constant disconnect/reconnect torture
> > test.  Thanks,
> 
> Oops forgot to mention that I have patches for the nbd user space side
> that utilizes all of these new interfaces, you can find the tree here
> 
> https://github.com/josefbacik/nbd

Yeah, found that already :-)

> The user space patches are a bit rough, but utilize everything so good
> for testing. They will be cleaned up and submitted once the kernel
> part is upstream. Thanks,

No worries, I'll probably clean it up myself. TBH, cleaning up
nbd-client so it becomes somewhat less of a beast has been on my TODO
list for a while, and this will only add to it... maybe that'll finally
convince me that it's time ;-)

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
