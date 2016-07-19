Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: resend: passthrough request improvements V3
Date: Tue, 19 Jul 2016 11:31:47 +0200
Message-Id: <1468920714-4304-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

These days we have a lot more users of struct request for driver internal
use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
up a bit.

Unchanged from the last post on June 16th.

Changes since V2:
 - really drop zeroing ->cmd from blk_get_request
 - add ACK from Boaz

Changes since V1:
 - keep blk_rq_set_block_pc for now and leave zeroing ->cmd in it
