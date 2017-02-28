Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33974 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdB1PmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 10:42:20 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 00/14] md: cleanup on direct access to bvec table
Date: Tue, 28 Feb 2017 23:41:30 +0800
Message-Id: <1488296503-4987-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In MD's resync I/O path, there are lots of direct access to bio's
bvec table. This patchset kills almost all, and the conversion
is quite straightforward. One root cause of direct access to bvec
table is that resync I/O uses the bio's bvec to manage pages.
In V1, as suggested by Shaohua, a new approach is used to manage
these pages for resync I/O, turns out code becomes more clean
and readable.

Once direct access to bvec table in MD is cleaned up, we may make
multipage bvec moving on.

V2:
	- remove the patch for introducing/applying bio_remove_last_page()

V1:
	- allocate page array to manage resync pages

Thanks,
Ming

Ming Lei (13):
  block: introduce bio_segments_all()
  md: raid1/raid10: don't handle failure of bio_add_page()
  md: move two macros into md.h
  md: prepare for managing resync I/O pages in clean way
  md: raid1: simplify r1buf_pool_free()
  md: raid1: don't use bio's vec table to manage resync pages
  md: raid1: retrieve page from pre-allocated resync page array
  md: raid1: use bio helper in process_checks()
  md: raid1: use bio_segments_all()
  md: raid10: refactor code of read reshape's .bi_end_io
  md: raid10: don't use bio's vec table to manage resync pages
  md: raid10: retrieve page from preallocated resync page array
  md: raid10: avoid direct access to bvec table in
    handle_reshape_read_error

 drivers/md/md.h     |  59 ++++++++++++++
 drivers/md/raid1.c  | 140 ++++++++++++++++++---------------
 drivers/md/raid10.c | 220 ++++++++++++++++++++++++++++------------------------
 include/linux/bio.h |   7 ++
 4 files changed, 263 insertions(+), 163 deletions(-)

-- 
2.7.4
