Return-Path: <hch@lst.de>
Date: Wed, 25 Jul 2018 09:45:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <martin.wilck@suse.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/5] genhd: drop 'bool' argument from
	__device_add_disk()
Message-ID: <20180725074512.GA13812@lst.de>
References: <20180725062840.94114-1-hare@suse.de> <20180725062840.94114-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725062840.94114-2-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

> +void __device_get_disk(struct gendisk *disk)

This function can be static. Also it is a bit misnamed.  I'm not
really sure this split is worth it, but if we really want to kill
off the argument it might be worth to just open code the new
__device_get_disk in both callers.
