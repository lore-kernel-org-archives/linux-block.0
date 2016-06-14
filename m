Return-Path: <BATV+1815987b1c14acf14571+4678+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: a few passthrough request improvements V2
Date: Tue, 14 Jun 2016 19:15:57 +0200
Message-Id: <1465924564-14503-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

These days we have a lot more users of struct request for driver internal
use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
up a bit.

Changes since V1:
 - keep blk_rq_set_block_pc for now and leave zeroing ->cmd in it
