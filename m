Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: RQF_PM fix/cleanup
Date: Tue,  3 Oct 2017 10:46:59 +0200
Message-Id: <20171003084701.19346-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series fixed the blocking/passing of requests during PM IFF there were
more than one.  That currently isn't the case, but relying on that not only
is fragile, but also leads to more obscure code than handling it properly.
