Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 00/12] nbd: Netlink interface and path failure
 enhancements
Date: Thu, 6 Apr 2017 17:05:25 -0400
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
To: Jens Axboe <axboe@kernel.dk>,
 nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org,
 kernel-team@fb.com
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
Message-Id: <0BDE8C5C-1444-455D-88A3-F1D70181056C@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>


> On Apr 6, 2017, at 5:01 PM, Josef Bacik <josef@toxicpanda.com> wrote:
>=20
> This patchset adds a new netlink configuration interface to NBD as =
well as a
> bunch of enhancments around path failures.  The patches provide the =
following
> enhancemnts to NBD
>=20
> - Netlink configuration interface that doesn't leave a userspace =
application
>   waiting in kernel space for the device to disconnect.
> - Netlink reconfigure interface for adding re-connected sockets to =
replace dead
>   sockets.
> - A flag to destroy the NBD device on disconnect, much like how mount =
-o loop
>   works.
> - A status interface that currently will only report whether a device =
is
>   connected or not, but can be extended to include whatever in the =
future.
> - A netlink multicast notification scheme to notify user space when =
there are
>   connection issues to allow for seamless reconnects.
> - Dead link handling.  You can specify a dead link timeout and the NBD =
device
>   will pause IO for that timeout waiting to see if the connection can =
be
>   re-established.  This is helpful to allow for things like nbd server =
upgrades
>   where the whole server disappears for a short period of time.
>=20
> These patches have been thorougly and continuously tested for about a =
month.
> I've been finding bugs in various places, but this batch has been =
solid for the
> last few days of testing, which include a constant =
disconnect/reconnect torture
> test.  Thanks,

Oops forgot to mention that I have patches for the nbd user space side =
that utilizes all of these new interfaces, you can find the tree here

https://github.com/josefbacik/nbd

The user space patches are a bit rough, but utilize everything so good =
for testing.  They will be cleaned up and submitted once the kernel part =
is upstream.  Thanks,

Josef=
