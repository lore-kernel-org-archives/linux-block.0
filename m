Return-Path: <hch@lst.de>
Date: Thu, 9 Nov 2017 16:51:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
Message-ID: <20171109155141.GA25997@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-5-hch@lst.de> <163098dc-02f0-4146-17da-903971e5214d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <163098dc-02f0-4146-17da-903971e5214d@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 04:44:32PM +0100, Hannes Reinecke wrote:
> - We don't have the topology information in sysfs;

We have all the topology information in sysfs, but you seem to look
for the wrong thing.

> while the namespace
> device has the 'slaves' and 'holders' directories, they remain empty,
> and the path devices don't even have those directories. I really would
> like to see them populated to help things like dracut figuring out the
> topology when building up a list of modules to include.

Of course there aren't because there is not block device you can hold
for the controller.  

> - The patch doesn't integrate with the 'claim' mechanism for block
> devices, ie device-mapper might accidentally stumble upon it when
> traversing devices.

Same as above.  There is no block device to be claimed.

> I'll be sending two patches to resurrect the 'bd_link_disk_holder'
> idea I posted earlier; that should take care of these issues.

It doesn't.  There is not block device you can hold, so there is no
point in claiming it.
