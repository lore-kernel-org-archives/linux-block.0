Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: sx8: make full use of blk-mq
Date: Fri,  9 Nov 2018 14:51:08 +0100
Message-Id: <20181109135110.32386-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

sx8 uses multiple request_queues per host, with host-wide tags, making it
a prime candidate for using the blk-mq tag_set as originally intended.

Compile tested only.
