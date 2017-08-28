Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 16:30:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guan Junxiong <guanjunxiong@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Shenhong (C)" <shenhong09@huawei.com>,
	niuhaoxin <niuhaoxin@huawei.com>
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
Message-ID: <20170828143011.GA29260@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-8-hch@lst.de> <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 08:41:23PM +0800, Guan Junxiong wrote:
> If a namespace can be accessed by another subsystem,  the above line
> will ignore such namespace.

And that's intentional.

> Or does the NVMe/NVMf specification constrain that any namespace
> can only be accessed by a subsystem?

Yes, inside the NVMe spec a Namespace is contained inside a Subsystem.
That doesn't preclude other ways to access the LBAs, but they are outside
the specification (e.g. also exporting them as SCSI).
