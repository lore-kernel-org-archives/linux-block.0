Return-Path: <hch@lst.de>
Date: Sat, 28 Oct 2017 08:15:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171028061523.GB13723@lst.de>
References: <20171023145126.2471-1-hch@lst.de> <20171023145126.2471-7-hch@lst.de> <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 24, 2017 at 09:18:47AM +0200, Hannes Reinecke wrote:
> Can we have some information in sysfs to figure out if a gendisk is
> hidden? I'd hate having to do an inverse lookup in /proc/partitions;
> it's always hard to prove that something is _not_ present.
> And we already present various information (like disk_removable_show()),
> so it's not without precedent.
> And it would make integration with systemd/udev easier.

Sure, I'll add a hidden flag sysfs file.
