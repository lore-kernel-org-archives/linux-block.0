Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: streamline blk-mq I/O scheduler interaction
Date: Fri, 16 Jun 2017 18:15:17 +0200
Message-Id: <20170616161527.17649-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi blk-mq І/O scheduler folks,

I've been trying to re-learn our I/O path after the scheduler additions,
and when walking through the code the following optimization came to
my mind.  I've only done basic testing with them, so for now this is
a bit of a RFC.
