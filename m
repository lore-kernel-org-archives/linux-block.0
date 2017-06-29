Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: block: T10/DIF Fixes and cleanups v5
Date: Thu, 29 Jun 2017 11:31:07 -0700
Message-Id: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This series contains a rebase of the DIF fixes from Dmitry, plus
a new patch from me to free the integrity data from bio_endio.
