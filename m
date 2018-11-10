Return-Path: <BATV+3de936c6eedb3fd3a39f+5557+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: remove most req->special users v2
Date: Sat, 10 Nov 2018 09:30:43 +0100
Message-Id: <20181110083049.17475-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Try to get rid of the req->special users so that we can remove this
field.  With this series we basically only have the osd / scsi BIDI
code left, which should go away in another series.

Note that the first one is a bug fix for the blk-mq conversion
series, I don't think the current fnic code can work, but this
version is only compile tested as well.

Changes since v1:
 - fix the retries counter in skd to actually work.
