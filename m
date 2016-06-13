Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	bhalevy@primarydata.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: a few passthrough request improvements
Date: Mon, 13 Jun 2016 17:21:11 +0200
Message-Id: <1465831278-23653-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

These days we have a lot more users of struct request for driver internal
use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
up a bit.
