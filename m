Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: unify and streamline the blk-mq make_request implementations V3
Date: Wed, 22 Mar 2017 15:01:48 -0400
Message-Id: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

A bunch of cleanups to get us a nice I/O submission path.

Changes since V2:
 - really address the comments from Bart
 - address another comment from Bart

Changes since V1:
 - rebase on top of the recent blk_mq_try_issue_directly changes
 - incorporate comments from Bart
