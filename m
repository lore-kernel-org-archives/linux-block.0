Return-Path: <hch@lst.de>
Date: Sun, 1 Oct 2017 10:07:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20171001080703.GA11895@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-9-hch@lst.de> <20170928155315.GK8463@localhost.localdomain> <mqdk20ghta5.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mqdk20ghta5.fsf@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 30, 2017 at 09:37:38PM +0200, Johannes Thumshirn wrote:
> We discussed (Hannes, Christoph and me) this as well offline this week
> and it should eithr be possible with some udev magic (fake a
> /dev/mapper/WWID symlink) or a shim device-mapper target that prevents
> dm-mpath from attaching to the underlying block devices and creates a
> real /dev/mapper/WWID device node (Christoph especially dislikes
> this). None of them are pretty, but probably all we can do so far.

I think the former is the way to go.

That being said I think you really need to kick the installers peoples
ass - at least for local bus devices there is no reason every to not
just support any node in /dev/.  We can triviall go from that to the
modules required in sysfs.  Anything networkish will need additional
work for setup that is more than bus probing, but we really should
not work around people being lazy and/or stupid too much.
