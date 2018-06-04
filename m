Return-Path: <BATV+f3425a2e9bbdb5bc872a+5398+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: a few cleanups to prepare for multipage bio_vecs
Date: Mon,  4 Jun 2018 15:58:50 +0200
Message-Id: <20180604135853.30972-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Clean up some bio_vec abuses to prepare for saner handling of multipage
bio_vecs.
