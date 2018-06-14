Return-Path: <msnitzer@redhat.com>
Date: Thu, 14 Jun 2018 08:38:06 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: damien.lemoal@wdc.com, hare@suse.de, axboe@kernel.dk,
	jaegeuk@kernel.org, yuchao0@huawei.com, ghe@suse.com,
	mwilck@suse.com, tchvatal@suse.com, zren@suse.com, agk@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: dm-zoned-tools: add zoned disk udev rules for scheduler / dmsetup
Message-ID: <20180614123806.GA32162@redhat.com>
References: <20180614001147.1545-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614001147.1545-1-mcgrof@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13 2018 at  8:11pm -0400,
Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> Setting up a zoned disks in a generic form is not so trivial. There
> is also quite a bit of tribal knowledge with these devices which is not
> easy to find.
> 
> The currently supplied demo script works but it is not generic enough to be
> practical for Linux distributions or even developers which often move
> from one kernel to another.
> 
> This tries to put a bit of this tribal knowledge into an initial udev
> rule for development with the hopes Linux distributions can later
> deploy. Three rule are added. One rule is optional for now, it should be
> extended later to be more distribution-friendly and then I think this
> may be ready for consideration for integration on distributions.
> 
> 1) scheduler setup

This is wrong.. if zoned devices are so dependent on deadline or
mq-deadline then the kernel should allow them to be hardcoded.  I know
Jens removed the API to do so but the fact that drivers need to rely on
hacks like this udev rule to get a functional device is proof we need to
allow drivers to impose the scheduler used.

> 2) backlist f2fs devices

There should porbably be support in dm-zoned for detecting whether a
zoned device was formatted with f2fs (assuming there is a known f2fs
superblock)?

> 3) run dmsetup for the rest of devices

automagically running dmsetup directly from udev to create a dm-zoned
target is very much wrong.  It just gets in the way of proper support
that should be add to appropriate tools that admins use to setup their
zoned devices.  For instance, persistent use of dm-zoned target should
be made reliable with a volume manager..

In general this udev script is unwelcome and makes things way worse for
the long-term success of zoned devices.

I don't dispute there is an obvious void for how to properly setup zoned
devices, but this script is _not_ what should fill that void.

So a heartfelt:

Nacked-by: Mike Snitzer <snitzer@redhat.com>
