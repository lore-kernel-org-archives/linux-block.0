Return-Path: <BATV+d57f7b82a529b7e9747b+4995+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: update ->init_request and ->exit_request prototypes
Date: Thu, 27 Apr 2017 19:44:56 +0200
Message-Id: <20170427174501.18965-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series (against for-4.12/post-merge) updates the blk-mq
->init_request and ->exit request methods to drop a now harmful
parameter, and update one to pass a little more information.  It
then cleans up the nvme drivers based on that.
