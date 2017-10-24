Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>
Date: Tue, 24 Oct 2017 09:18:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c         | 57 +++++++++++++++++++++++++++++++++++----------------
>  include/linux/genhd.h |  1 +
>  2 files changed, 40 insertions(+), 18 deletions(-)
> 
Can we have some information in sysfs to figure out if a gendisk is
hidden? I'd hate having to do an inverse lookup in /proc/partitions;
it's always hard to prove that something is _not_ present.
And we already present various information (like disk_removable_show()),
so it's not without precedent.
And it would make integration with systemd/udev easier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
