Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 0/3] Fix silent data corruption in blkdev_direct_IO()
Date: Thu, 19 Jul 2018 23:01:55 +0200
Message-Id: <20180719210158.25923-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens, Ming, Jan, and all others,

the following patches have been verified by a customer to fix a silent data
corruption which he has been seeing since "72ecad2 block: support a full bio
worth of IO for simplified bdev direct-io".

The patches are based on our observation that the corruption is only
observed if the __blkdev_direct_IO_simple() code path is executed,
and if that happens, "short writes" are observed in this code path,
which causes a fallback to buffered IO, while the application continues
submitting direct IO requests.

I called this v3 because the first patch was at v2 already in the previous
submission.

Changes wrt v1:
 - 1/3: minor formatting change (Christoph)
 - 2/3: split off the leak fix (Ming)
 - 3/3: give up if bio_iov_iter_get_pages() returns an error (Jan)
 - 3/3: warn if space in bio exhausted (Jan)
 - 3/3: add comments

Martin Wilck (3):
  block: bio_iov_iter_get_pages: fix size of last iovec
  blkdev: __blkdev_direct_IO_simple: fix leak in error case
  blkdev: __blkdev_direct_IO_simple: make sure to fill up the bio

 block/bio.c    | 18 ++++++++----------
 fs/block_dev.c | 27 +++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.17.1
