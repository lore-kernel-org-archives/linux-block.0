Return-Path: <BATV+7902ada3182718150db7+5511+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: clean up physical merging helpers
Date: Tue, 25 Sep 2018 13:30:04 -0700
Message-Id: <20180925203009.1838-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series moves Xen special handling of block merges from arch hooks
into common code.  A previous version has been reviewed by Boris.
