Return-Path: <BATV+449e860d3caae2166dba+5408+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: remove nvme_reinit_tagset and blk_mq_tagset_iter
Date: Thu, 14 Jun 2018 14:30:13 +0200
Message-Id: <20180614123015.5989-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that nvme-fc moved off the reinit request concept both the core nvme
and blk-mq code for it becomes unused.

Jens, are you ok with queuing up the blk-mq side with the pending nvme
changes?
