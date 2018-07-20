Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:36416 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbeGTO3c (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 20 Jul 2018 10:29:32 -0400
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 0/4] Fix silent data corruption in blkdev_direct_IO()
Date: Fri, 20 Jul 2018 15:05:48 +0200
Message-Id: <20180720130552.21432-1-mwilck@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens, Ming, Jan, and all others,

the following patches have been verified by a customer to fix a silent data
corruption which he has been seeing since "72ecad2 block: support a full bio
worth of IO for simplified bdev direct-io".

The patches are based on our observation that the corruption is only
observed if the __blkdev_direct_IO_simple() code path is executed,
and if that happens, "short writes" are observed in this code path,
which causes a fallback to buffered IO, while the application continues
submitting direct IO requests.

In v4, I've separated out the "get as many pages as the bio can hold"
functionality into a new helper. This way other callers can migrate to the new
helper if deemed appropriate. Changing the semantics of
bio_iov_iter_get_pages() for all callers, as Ming originally suggested, seems
too intrusive to me at this time.

Regards,
Martin

Changes wrt v1:
 - 1/3: minor formatting change (Christoph)
 - 2/3: split off the leak fix (Ming)
 - 3/3: give up if bio_iov_iter_get_pages() returns an error (Jan)
 - 3/3: warn if space in bio exhausted (Jan)
 - 3/3: add comments

Changes wrt v3:
 - split previous 3/3 into two patches (3/4, 4/4).
 - 3/4: add a new helper to retrieve as many pages as possible (Ming)
 - 3/4: put pages in case of error (Ming)

Martin Wilck (4):
  block: bio_iov_iter_get_pages: fix size of last iovec
  blkdev: __blkdev_direct_IO_simple: fix leak in error case
  block: add bio_iov_iter_get_all_pages() helper
  blkdev: __blkdev_direct_IO_simple: make sure to fill up the bio

 block/bio.c         | 61 +++++++++++++++++++++++++++++++++++++--------
 fs/block_dev.c      | 18 +++++++++----
 include/linux/bio.h |  1 +
 3 files changed, 64 insertions(+), 16 deletions(-)

-- 
2.17.1
