Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35475 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdBJK5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 05:57:02 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 0/5] md: use bio_clone_fast()
Date: Fri, 10 Feb 2017 18:56:12 +0800
Message-Id: <1486724177-14817-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patches replaces bio_clone() with bio_fast_clone() in
bio_clone_mddev() because:

1) bio_clone_mddev() is used in raid normal I/O and isn't in
resync I/O path, and all the direct access to bvec table in
raid happens on resync I/O only except for write behind of raid1.
Write behind is treated specially, so the replacement is safe.

2) for write behind, bio_clone() is kept, but this patchset
introduces bio_clone_bioset_partial() to just clone one specific 
bvecs range instead of whole table. Then write behind is improved
too.

V1:
	1) don't introduce bio_clone_slow_mddev_partial()
	2) return failure if mddev->bio_set can't be created
	3) remove check in bio_clone_mddev() as suggested by
	Christoph Hellwig.
	4) rename bio_clone_mddev() as bio_clone_fast_mddev()


Ming Lei (5):
  block: introduce bio_clone_bioset_partial()
  md/raid1: use bio_clone_bioset_partial() in case of write behind
  md: fail if mddev->bio_set can't be created
  md: remove unnecessary check on mddev
  md: fast clone bio in bio_clone_mddev()

 block/bio.c         | 61 +++++++++++++++++++++++++++++++++++++++++------------
 drivers/md/faulty.c |  2 +-
 drivers/md/md.c     | 14 ++++++------
 drivers/md/md.h     |  4 ++--
 drivers/md/raid1.c  | 26 ++++++++++++++++-------
 drivers/md/raid10.c | 11 +++++-----
 drivers/md/raid5.c  |  4 ++--
 include/linux/bio.h | 11 ++++++++--
 8 files changed, 92 insertions(+), 41 deletions(-)

-- 
2.7.4

Thanks,
Ming
