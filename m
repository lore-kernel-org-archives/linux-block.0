Return-Path: <BATV+b244dc37f40e53d0e5a9+4729+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ming.lei@canonical.com,
	mchristi@redhat.com,
	david@fromorbit.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix loop discard regression
Date: Thu,  4 Aug 2016 16:09:59 +0200
Message-Id: <1470319801-20594-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The first patch fixes a regression where discard request were accidentally
marked as aio after the req_op conversion.  This would have been mostly
harmless except for the god-awful parsing of request types later in the
actual I/O handler which turns them into a write, so the second patch
rewrites that handler using a proper switch statement as well.
