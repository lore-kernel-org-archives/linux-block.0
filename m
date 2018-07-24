Return-Path: <BATV+c9ebeb9e9cafa2a765ab+5448+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: kill bio_clone_kmalloc and bio_clone_bioset
Date: Tue, 24 Jul 2018 09:52:29 +0200
Message-Id: <20180724075234.26861-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series removes all but one users of the traditional deep bio clone,
and then moves bio_clone_bioset to its only caller so that we get rid
of the deep bio cloning in the block layer API.
