Return-Path: <BATV+b8442eb9fd62b0a9e465+4950+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: unify and streamline the blk-mq make_request implementations
Date: Mon, 13 Mar 2017 09:48:29 -0600
Message-Id: <20170313154833.14165-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

A bunch of cleanups to get us a nice I/O submission path.
