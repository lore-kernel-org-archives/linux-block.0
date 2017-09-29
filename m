Return-Path: <keith.busch@intel.com>
Date: Fri, 29 Sep 2017 16:59:49 -0600
From: Keith Busch <keith.busch@intel.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
Message-ID: <20170929225949.GP8463@localhost.localdomain>
References: <20170928193637.24707-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928193637.24707-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 28, 2017 at 09:36:36PM +0200, Martin Wilck wrote:
> In the NVME subsystem, we're seeing a race condition with udev where
> device_add_disk() is called (which triggers an "add" uevent), and a
> sysfs attribute group is added to the disk device afterwards.
> If udev rules access these attributes before they are created,
> udev processing of the device is incomplete, in particular, device
> WWIDs may not be determined correctly.
> 
> To fix this, this patch introduces a new function
> device_add_disk_with_groups(), which takes a list of attribute groups
> and adds them to the device before sending out uevents.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Is NVMe the only one having this problem? Was putting our attributes in
the disk's kobj a bad choice?

Any, looks fine to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
