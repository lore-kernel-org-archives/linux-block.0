Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C0EC17442
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15180214E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 08:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKMIDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:03:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:51520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfKMIDm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 03:03:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94844ABD6;
        Wed, 13 Nov 2019 08:03:40 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 00/12] bcache patches for Linux v5.5
Date:   Wed, 13 Nov 2019 16:03:14 +0800
Message-Id: <20191113080326.69989-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The second submit adds two missed patches from Christoph Hellwig.

This is the patches for Linux v5.5. The patches have been testing for
a while during my current development, they are ready to be merged.

There are still other patches under testing, I will submit to you in
later runs if I feel they are solid enough in my testing.

Thanks for taking care of this.

Coly Li

---

Andrea Righi (1):
  bcache: fix deadlock in bcache_allocator

Christoph Hellwig (2):
  bcache: remove the extra cflags for request.o
  bcache: don't export symbols

Coly Li (8):
  bcache: fix fifo index swapping condition in journal_pin_cmp()
  bcache: fix static checker warning in bcache_device_free()
  bcache: add more accurate error messages in read_super()
  bcache: deleted code comments for dead code in bch_data_insert_keys()
  bcache: add code comment bch_keylist_pop() and bch_keylist_pop_front()
  bcache: add code comments in bch_btree_leaf_dirty()
  bcache: add idle_max_writeback_rate sysfs interface
  bcache: at least try to shrink 1 node in bch_mca_scan()

Guoju Fang (1):
  bcache: fix a lost wake-up problem caused by mca_cannibalize_lock

 drivers/md/bcache/Makefile    |  2 --
 drivers/md/bcache/alloc.c     |  5 +++-
 drivers/md/bcache/bcache.h    |  4 +++-
 drivers/md/bcache/bset.c      | 17 ++-----------
 drivers/md/bcache/btree.c     | 45 ++++++++++++++++++++++++++++++----
 drivers/md/bcache/closure.c   |  7 ------
 drivers/md/bcache/journal.h   |  4 ----
 drivers/md/bcache/request.c   | 12 ----------
 drivers/md/bcache/super.c     | 56 +++++++++++++++++++++++++++++++------------
 drivers/md/bcache/sysfs.c     |  7 ++++++
 drivers/md/bcache/writeback.c |  4 ++++
 11 files changed, 102 insertions(+), 61 deletions(-)

-- 
2.16.4

