Return-Path: <BATV+c9ebeb9e9cafa2a765ab+5448+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: two small bio cleanups
Date: Tue, 24 Jul 2018 14:04:11 +0200
Message-Id: <20180724120413.15689-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

To remove invariants that are odd and in the way of multipage biovecs.
