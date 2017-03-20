Return-Path: <BATV+250fd2a736c995bcc4cb+4957+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: unify and streamline the blk-mq make_request implementations V2
Date: Mon, 20 Mar 2017 16:39:26 -0400
Message-Id: <20170320203930.12533-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

A bunch of cleanups to get us a nice I/O submission path.

Changes since V1:
 - rebase on top of the recent blk_mq_try_issue_directly changes
 - incorporate comments from Bart
