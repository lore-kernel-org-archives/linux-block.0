Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F2C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B8218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfDXQs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:59794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfDXQs5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:48:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 512B2AF58;
        Wed, 24 Apr 2019 16:48:56 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 00/18] bcache patches for Linux v5.2 
Date:   Thu, 25 Apr 2019 00:48:25 +0800
Message-Id: <20190424164843.29535-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Here are the bcache patches for Linux v5.2.

Most of the patches are bug fixes. We don't introduce new feature in
this run, people continue to focus on code quality improvement for now.

Juhui Tang and I make some fixes related to bcache journal, the changes
include,
- Fix KEY_PTRS set to 0 error under very heavy small I/O pressure, to
  avoid potential missing for journal and uuid update to cache device.
- Add code comments to make code more understandable.
- Minor code cleanup.

Liang Chen, Guoju Fang and Shenghui Wang contribute useful and important
fixes for,
- Avoid a crash in cached_dev_read_done() by adding reference before
  calling bio_complete()
- Improve unused buckets statistic
- Fix a race between cache register and unregister
- Potential use-after-free and memory leak bugs

Arnd Bergmann and George Spelvin also contriubte useful code clean up
to fix clang warning and make bch_get_congested() more clear.

Please pick them for the 5.2 merge window.

Thanks you in advance.

Coly Li
---

Arnd Bergmann (1):
  bcache: avoid clang -Wunintialized warning

Coly Li (9):
  bcache: move definition of 'int ret' out of macro read_bucket()
  bcache: never set KEY_PTRS of jouranl key to 0 in journal_reclaim()
  bcache: add failure check to run_cache_set() for journal replay
  bcache: add comments for kobj release callback routine
  bcache: return error immediately in bch_journal_replay()
  bcache: add error check for calling register_bdev()
  bcache: Add comments for blkdev_put() in registration code path
  bcache: add comments for closure_fn to be called in closure_queue()
  bcache: improve bcache_reboot()

Geliang Tang (1):
  bcache: use kmemdup_nul for CACHED_LABEL buffer

George Spelvin (1):
  bcache: Clean up bch_get_congested()

Guoju Fang (2):
  bcache: fix crashes stopping bcache device before read miss done
  bcache: fix inaccurate result of unused buckets

Liang Chen (1):
  bcache: fix a race between cache register and cacheset unregister

Shenghui Wang (2):
  bcache: fix wrong usage use-after-freed on keylist in out_nocoalesce
    branch of btree_gc_coalesce
  bcache: avoid potential memleak of list of journal_replay(s) in the
    CACHE_SYNC branch of run_cache_set

Tang Junhui (1):
  bcache: fix failure in journal relplay

 drivers/md/bcache/alloc.c   |  5 +--
 drivers/md/bcache/btree.c   |  2 +-
 drivers/md/bcache/journal.c | 42 ++++++++++++++++++-----
 drivers/md/bcache/request.c | 41 +++++++++++++++-------
 drivers/md/bcache/request.h |  2 +-
 drivers/md/bcache/super.c   | 83 ++++++++++++++++++++++++++++++++++-----------
 drivers/md/bcache/sysfs.c   |  2 --
 drivers/md/bcache/util.h    | 26 ++++++++++----
 8 files changed, 149 insertions(+), 54 deletions(-)

-- 
2.16.4

