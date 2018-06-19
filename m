Return-Path: <BATV+94b2d661b7de03f6cf2e+5413+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: [RFC] kill bio_clone_kmalloc and bio_clone_bioset
Date: Tue, 19 Jun 2018 06:52:10 +0200
Message-Id: <20180619045216.21130-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series removes all but one users of the traditional deep bio clone,
and then moves bio_clone_bioset to its only caller so that we get rid
of the deep bio cloning in the block layer API.

Patch 1 is already in the device mapper queue for 4.18, so we should
wait for that to go in before the series is applied.  The series is
inteded as preparation work for the multi-page biovecs so that it doesn't
have to deal with the difference between single page or larger bio vecs
for cloning.
