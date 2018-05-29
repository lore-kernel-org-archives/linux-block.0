Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: check_disk_size_change tidyups
Date: Tue, 29 May 2018 16:42:57 +0200
Message-Id: <20180529144259.29819-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Remove the unused export, and suppress the size change message when the
device went away.
