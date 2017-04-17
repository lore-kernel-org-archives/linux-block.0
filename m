Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/12] nbd: Netlink interface and path failure
 enhancements
To: Josef Bacik <josef@toxicpanda.com>, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d58e5d19-9bda-e5a0-55a1-00aee6ecb3b3@kernel.dk>
Date: Mon, 17 Apr 2017 09:59:27 -0600
MIME-Version: 1.0
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/06/2017 03:01 PM, Josef Bacik wrote:
> This patchset adds a new netlink configuration interface to NBD as well as a
> bunch of enhancments around path failures.  The patches provide the following
> enhancemnts to NBD
> 
>  - Netlink configuration interface that doesn't leave a userspace application
>    waiting in kernel space for the device to disconnect.
>  - Netlink reconfigure interface for adding re-connected sockets to replace dead
>    sockets.
>  - A flag to destroy the NBD device on disconnect, much like how mount -o loop
>    works.
>  - A status interface that currently will only report whether a device is
>    connected or not, but can be extended to include whatever in the future.
>  - A netlink multicast notification scheme to notify user space when there are
>    connection issues to allow for seamless reconnects.
>  - Dead link handling.  You can specify a dead link timeout and the NBD device
>    will pause IO for that timeout waiting to see if the connection can be
>    re-established.  This is helpful to allow for things like nbd server upgrades
>    where the whole server disappears for a short period of time.
> 
> These patches have been thorougly and continuously tested for about a month.
> I've been finding bugs in various places, but this batch has been solid for the
> last few days of testing, which include a constant disconnect/reconnect torture
> test.  Thanks,

Added for 4.12, thanks.

-- 
Jens Axboe
