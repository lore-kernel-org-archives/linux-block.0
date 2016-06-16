Return-Path: <BATV+d68c80116f0bf241093e+4680+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: passthrough request improvements V3
Date: Thu, 16 Jun 2016 11:14:24 +0200
Message-Id: <1466068471-15746-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

These days we have a lot more users of struct request for driver internal
use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
up a bit.

Changes since V2:
 - really drop zeroing ->cmd from blk_get_request
 - add ACK from Boaz
Changes since V1:
 - keep blk_rq_set_block_pc for now and leave zeroing ->cmd in it
