Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: don't require a struct block_device to submit a bio
Date: Wed, 23 Aug 2017 19:10:26 +0200
Message-Id: <20170823171032.30529-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series removes the need to have a struct block_device ready to
submit a bio.   We basically don't use it anywhere in the block stack
anyway - we always go for the gendisk or request_queue.  The only
exception is partition remapping for which we'll now need an additional
partition index.  This helps with cases where we submit I/O from a
character device (nvme or lightnvm passthrough) or a different block
device (upcoming nvme multipath support).
