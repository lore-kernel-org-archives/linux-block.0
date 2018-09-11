Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39951 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKSOF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 14:14:05 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Tue, 11 Sep 2018 21:14:04 +0800
Message-ID: <CA+NNRhHVjM=WKnYcOR-3dRRfdrsbEbU_tEuFjk=anajwXWS26Q@mail.gmail.com>
Subject: [PATCH] bcache: fix failure in journal relplay
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From 171ff6c2d35c2bb985c225a52ed787dc271ef6e0 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Wed, 12 Sep 2018 04:42:14 +0800
Subject: [PATCH] bcache: fix failure in journal relplay

journal replay failed with messages:
Sep 10 19:10:43 ceph kernel: bcache: error on
bb379a64-e44e-4812-b91d-a5599871a3b1: bcache: journal entries
2057493-2057567 missing! (replaying 2057493-2076601), disabling
caching

The reason is in journal_reclaim(), we send discard command and
reclaim those journal buckets whose seq is old than the last_seq_now,
but before we write a journal with last_seq_now, the machine is
restarted, so the journal with the last_seq_now is not written to
the journal bucket, and the last_seq_wrote in the newest journal is
old than last_seq_now which we expect to be, so when we doing
replay, journals from last_seq_wrote to last_seq_now are missing.

It's hard to write a journal immediately after journal_reclaim(),
and it harmless if those missed journal are caused by discarding
since those journals are already wrote to btree node. So, if miss
seqs are started from the beginning journal, we treat it as normal,
and only print a message to show the miss journal, and point out
it maybe caused by discarding.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/journal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 10748c6..9b4cd2e 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -328,9 +328,13 @@ int bch_journal_replay(struct cache_set *s,
struct list_head *list)
  list_for_each_entry(i, list, list) {
  BUG_ON(i->pin && atomic_read(i->pin) != 1);

- cache_set_err_on(n != i->j.seq, s,
-"bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
+ if (n != i->j.seq && n == start)
+ pr_info("bcache: journal entries %llu-%llu may be discarded!
(replaying %llu-%llu)",
  n, i->j.seq - 1, start, end);
+ else
+ cache_set_err_on(n != i->j.seq, s,
+        "bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
+        n, i->j.seq - 1, start, end);

  for (k = i->j.start;
       k < bset_bkey_last(&i->j);
-- 
1.8.3.1
