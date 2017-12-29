Return-Path: <hch@lst.de>
Date: Fri, 29 Dec 2017 10:51:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
Message-ID: <20171229095152.GE24043@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com> <20171221204636.2924-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221204636.2924-4-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This looks fine, but we also need the same in blkdev_bio_end_io and
iomap_dio_bio_end_io.  Probably best to add a little helper.
