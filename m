Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v5 0/3] Fix silent data corruption in blkdev_direct_IO()
Date: Wed, 25 Jul 2018 23:15:06 +0200
Message-Id: <20180725211509.13592-1-mwilck@suse.com>
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

Following Ming's suggestion, I've changed the patch set such that
bio_iov_iter_get_pages() now always returns as many pages as possible.
This simplifies the patch set a lot. Except for
__blkdev_direct_IO_simple(), all callers of bio_iov_iter_get_pages()
call it in a loop, and expect to get just some pages. Therefore I
have made bio_iov_iter_get_pages() return success if it can pin some
pages, even if MM returns an error on the way. Error is returned only
if no pages at all could be pinned. This also avoids the need for
cleanup code in the helper - callers will submit the bio with the
allocated pages, and clean up later as appropriate.

Regards,
Martin

Changes wrt v4:
 - 3/3: replaced bio_iov_iter_get_pages() with the new helper
   (Ming, Christoph)
 - 4/4 dropped: this way, no changes to fs/block_dev.c are necessary any
   more except for the leak fix.

Changes wrt v3:
 - split previous 3/3 into two patches (3/4, 4/4).
 - 3/4: add a new helper to retrieve as many pages as possible (Ming)
 - 3/4: put pages in case of error (Ming)

Changes wrt v1:
 - 1/3: minor formatting change (Christoph)
 - 2/3: split off the leak fix (Ming)
 - 3/3: give up if bio_iov_iter_get_pages() returns an error (Jan)
 - 3/3: warn if space in bio exhausted (Jan)
 - 3/3: add comments

Martin Wilck (3):
  block: bio_iov_iter_get_pages: fix size of last iovec
  blkdev: __blkdev_direct_IO_simple: fix leak in error case
  block: bio_iov_iter_get_pages: pin more pages for multi-segment IOs

 block/bio.c    | 53 +++++++++++++++++++++++++++++++++++++-------------
 fs/block_dev.c |  9 +++++----
 2 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.17.1
