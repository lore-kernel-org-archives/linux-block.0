Return-Path: <mwilck@suse.com>
Message-ID: <1507114002.22324.12.camel@suse.com>
Subject: Re: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
From: Martin Wilck <mwilck@suse.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Johannes
 Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Date: Wed, 04 Oct 2017 12:46:42 +0200
In-Reply-To: <20170929225949.GP8463@localhost.localdomain>
References: <20170928193637.24707-1-mwilck@suse.com>
	 <20170929225949.GP8463@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-09-29 at 16:59 -0600, Keith Busch wrote:
> On Thu, Sep 28, 2017 at 09:36:36PM +0200, Martin Wilck wrote:
> > In the NVME subsystem, we're seeing a race condition with udev
> > where
> > device_add_disk() is called (which triggers an "add" uevent), and a
> > sysfs attribute group is added to the disk device afterwards.
> > If udev rules access these attributes before they are created,
> > udev processing of the device is incomplete, in particular, device
> > WWIDs may not be determined correctly.
> > 
> > To fix this, this patch introduces a new function
> > device_add_disk_with_groups(), which takes a list of attribute
> > groups
> > and adds them to the device before sending out uevents.
> > 
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> 
> Is NVMe the only one having this problem?

There are other devices that follow the same programming pattern
(device_add_disk followed by sysfs_create_group), but I haven't tested
them all, nor reviewed whether these devices need the disk's sysfs
attributes for udev processing. If they don't, the problem will just go
unnoticed.

SCSI obviously takes a very different approach to sysfs layout.

> Was putting our attributes in the disk's kobj a bad choice?

Well, it would make sense to separate the block (disk) device from the
device representing the NVMe subsys/namespace in sysfs. But I guess
it's too late for that now. Actually, the first attempt I made to solve
this problem was exactly that, and it proved to "work", too, but only
at the cost of changing the path of the NVMe block device in sysfs,
which I considered a no-go. Thus I came up with the approach I posted.

Regards,
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
