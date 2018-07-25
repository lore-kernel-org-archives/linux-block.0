Return-Path: <hch@lst.de>
Date: Wed, 25 Jul 2018 09:46:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <martin.wilck@suse.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] block: genhd: add device_add_disk_with_groups
Message-ID: <20180725074613.GB13812@lst.de>
References: <20180725062840.94114-1-hare@suse.de> <20180725062840.94114-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725062840.94114-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 08:28:37AM +0200, Hannes Reinecke wrote:
> Update __device_add_disk() to take an 'groups' argument so that
> individual drivers can register a device with additional sysfs
> attributes.
> This avoids race condition the driver would otherwise have if these
> groups need to be created with sysfs_add_groups().
> 
> Signed-off-by: Martin Wilck <martin.wilck@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

This should be From: Martin, shouldn't it?

My feedback last time was that I'd rather see the new groups argument
to device_add_disk instead of introducing yet another add_disk variant.

I still think that would be the better way to go.
