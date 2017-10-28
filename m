Return-Path: <hch@lst.de>
Date: Sat, 28 Oct 2017 08:20:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 17/17] nvme: also expose the namespace identification
	sysfs files for mpath nodes
Message-ID: <20171028062041.GC13723@lst.de>
References: <20171023145126.2471-1-hch@lst.de> <20171023145126.2471-18-hch@lst.de> <ab2161cc-aa24-4137-8a68-08e63adce764@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab2161cc-aa24-4137-8a68-08e63adce764@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 24, 2017 at 09:45:44AM +0200, Hannes Reinecke wrote:
> device_add_disk_with_groups()?
> What happened to that proposal?

Doesn't look like it got anywhere near a tree I could base this work
on.

And what happen to not fullquoting a patch for a two line comment?
