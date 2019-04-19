Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE8EC282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EA1222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfDSSXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbfDSSXs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 263D2AD0C;
        Fri, 19 Apr 2019 16:05:16 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 00/16] bcache: fix journal no-space deadlock 
Date:   Sat, 20 Apr 2019 00:04:53 +0800
Message-Id: <20190419160509.66298-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The initial journal no-space deadlock issue was known as several
kthreads or kworkers were reported by kernel to hang for quite long
time. The reason was a deadlock happened when there is no more journal
space avialable for new coming journal request.

In v1 RFC series, I though the journal no-space deadlock was from two
conditions, which was not the truth. After long time testing and
debugging, I realize the journal deadlock was a result of a series of
problems hidden in current code.

Now I make progress in v2 series, and all known problems related to the
journal no-space deadlock are fixed. I don't observe journal deadlock
and related I/O hang warning any more.

Unfortunately we can not apply this whole series at this moment, because
after fixing the journal no-space deadlock issue, I find a race in dirty
btree node flushing. Beside normal dirty btree node flushing, when there
is no journal space, btree_flush_write() will be called to write down
the oldest dirty btree node. Once the oldest dirty btree node is written
from memory into cache device, its associated journal reference will be
released, this operation is necessary to reclaim oldest busy journal
bucket when no-space in journal buckets.

The problem of this race is, when building c->flush_btree heap, all
dirty btree node from for_each_cached_btree() are not protected or
referenced, so there is a race that after the heap c->flush_btree is
built and before the oldest node is selected from the heap, the oldest
node is already written in normal code path, and the memory is
released/reused.

From my testing, a kernel panic triggered by wild pointer deference or
un-paired mutex_lock/unlock can be observed from btree_flush_write(),
this is because the selected btree node was written and released
already, btree_flush_write() just references invalid memory object.

So far I don't have good idea to fix such race without hurting I/O
performance, and IMHO the bcache I/O hang by journal is kind of better
than kenrel panic. Therefore before the race of dirty btree nodes
writting gets fixed, I won't apply the whole series.

But there are still some helpful and non-major fixes which can go into
upstream, to reduce the whole patch set and avoid huge changes in a
single kernel merge.

The patch 'bcache: acquire c->journal.lock in bch_btree_leaf_dirty()` in
v1 series was removed from v2 series. I still feel this is a problem to
access journal pipo without any protection, but this fix is limited and
I need to think about a more thoughtful way to fix.

Any review comment or suggestion are warmly welcome.

Thanks in advance for your help.

Coly Li
---

Coly Li (16):
  bcache: move definition of 'int ret' out of macro read_bucket()
  bcache: never set 0 to KEY_PTRS of jouranl key in journal_reclaim()
  bcache: reload jouranl key information during journal replay
  bcache: fix journal deadlock during jouranl replay
  bcache: reserve space for journal_meta() in run time
  bcache: add failure check to run_cache_set() for journal replay
  bcache: add comments for kobj release callback routine
  bcache: return error immediately in bch_journal_replay()
  bcache: add error check for calling register_bdev()
  bcache: Add comments for blkdev_put() in registration code path
  bcache: add comments for closure_fn to be called in closure_queue()
  bcache: add pendings_cleanup to stop pending bcache device
  bcache: fix fifo index swapping condition in btree_flush_write()
  bcache: try to flush btree nodes as many as possible
  bcache: improve bcache_reboot()
  bcache: introduce spinlock_t flush_write_lock in struct journal

 drivers/md/bcache/journal.c | 312 ++++++++++++++++++++++++++++++++++++++++----
 drivers/md/bcache/journal.h |   8 +-
 drivers/md/bcache/super.c   | 112 ++++++++++++++--
 3 files changed, 393 insertions(+), 39 deletions(-)

-- 
2.16.4

