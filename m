Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33380 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdBPLqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 06:46:06 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 00/17] md: cleanup on direct access to bvec table 
Date: Thu, 16 Feb 2017 19:45:30 +0800
Message-Id: <1487245547-24384-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In MD's resync I/O path, there are lots of direct access to bio's
bvec table. This patchset kills most of them, and the conversion
is quite straightforward.

Once direct access to bvec table in MD is cleaned up, we may make
multipage bvec moving on.

Thanks,
Ming

Ming Lei (17):
  block: introduce bio_segments_all()
  block: introduce bio_remove_last_page()
  md: raid1/raid10: use bio_remove_last_page()
  md: introduce helpers for dealing with fetch/store preallocated pages
    in bio
  md: raid1/raid10: use the introduced helpers
  md: raid1/raid10: borrow .bi_error as pre-allocated page index
  md: raid1/raid10: don't use .bi_vcnt to check if all pages are added
  md: raid1: simplify r1buf_pool_free()
  md: raid1/raid10: use bio helper in *_pool_free
  md: raid1: remove direct access to bvec table in fix_sync_read_error
  md: raid1: use bio helper in process_checks()
  md: raid1: avoid direct access to bvec table in process_checks()
  md: raid1: use bio_segments_all()
  md: raid10: avoid direct access to bvec table in sync_request_write()
  md: raid10: avoid direct access to bvec table in
    fix_recovery_read_error
  md: raid10: avoid direct access to bvec table in reshape_request
  md: raid10: avoid direct access to bvec table in
    handle_reshape_read_error

 block/bio.c         | 23 ++++++++++++++
 drivers/md/md.h     | 21 +++++++++++++
 drivers/md/raid1.c  | 87 +++++++++++++++++++++++++++++++++++++----------------
 drivers/md/raid10.c | 76 ++++++++++++++++++++++++++++++++++------------
 include/linux/bio.h |  8 +++++
 5 files changed, 169 insertions(+), 46 deletions(-)

-- 
2.7.4
