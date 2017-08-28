Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me>
Date: Mon, 28 Aug 2017 10:23:33 +0300
MIME-Version: 1.0
In-Reply-To: <20170823175815.3646-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
> 
> TODO: implement sysfs interfaces for the new subsystem and
> subsystem-namespace object.  Unless we can come up with something
> better than sysfs here..
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Christoph,

This is really taking a lot into the nvme driver. I'm not sure if
this approach will be used in other block driver, but would it
make sense to place the block_device node creation, the make_request
and failover logic and maybe the path selection in the block layer
leaving just the construction of the path mappings in nvme?
