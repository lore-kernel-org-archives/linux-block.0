Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:45537 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeGSKZy (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 19 Jul 2018 06:25:54 -0400
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH 0/2] Fix silent data corruption in blkdev_direct_IO()
Date: Thu, 19 Jul 2018 11:39:16 +0200
Message-Id: <20180719093918.28876-1-mwilck@suse.com>
In-Reply-To: <20180718075440.GA15254@ming.t460p>
References: <20180718075440.GA15254@ming.t460p>
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

For the first patch, an alternative solution by Christoph Hellwig
exists:

   https://marc.info/?l=linux-kernel&m=153013977816825&w=2

While I believe that Christoph's patch is correct, the one presented
here is smaller. Ming has suggested to use Christoph's for mainline and
mine for -stable.

Wrt the second patch, we've had an internal discussion at SUSE how to handle
(unlikely) error conditions from bio_iov_iter_get_pages(). The patch presented
here tries to submit as much IO as possible via the direct path even in the
error case, while Jan Kara suggested to abort, not submit any IO, and fall 
back to buffered IO in that case.

Looking forward to your opinions and suggestions.

Regards
Martin

Martin Wilck (2):
  block: bio_iov_iter_get_pages: fix size of last iovec
  blkdev: __blkdev_direct_IO_simple: make sure to fill up the bio

 block/bio.c    | 18 ++++++++----------
 fs/block_dev.c |  8 +++++++-
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.17.1
