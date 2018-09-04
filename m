Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: clean up physical merging helpers
Date: Tue,  4 Sep 2018 12:14:18 -0700
Message-Id: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series moves various helpers related to merging based on physical
addresses from the public headers into block/, moves the Xen special
case from arch hooks into common code, cleans up the code a bit, and
removes not nessecary includes from the block headers.
