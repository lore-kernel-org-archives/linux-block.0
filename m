Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1751C433F5
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 11:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiAULko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:40:44 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53726 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiAULko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 06:40:44 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20LBeFjm048207;
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 21 Jan 2022 20:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20LBe9Hb048197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 1/5] task_work: export task_work_add()
Date:   Fri, 21 Jan 2022 20:40:02 +0900
Message-Id: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
silenced a circular locking dependency warning by moving autoclear
operation to WQ context.

Then, it was reported that WQ context is too late to run autoclear
operation; some userspace programs (e.g. xfstest) assume that the autoclear
operation already completed by the moment close() returns to user mode
so that they can immediately call umount() of a partition containing a
backing file which the autoclear operation should have closed.

Then, Jan Kara found that fundamental problem is that waiting for I/O
completion (from blk_mq_freeze_queue() or flush_workqueue()) with
disk->open_mutex held has possibility of deadlock.

Then, I found that since disk->open_mutex => lo->lo_mutex dependency is
recorded by lo_open() and lo_release(), and blk_mq_freeze_queue() by e.g.
loop_set_status() waits for I/O completion with lo->lo_mutex held, from
locking dependency chain perspective we need to avoid holding lo->lo_mutex
 from lo_open() and lo_release(). And we can avoid holding lo->lo_mutex
 from lo_open(), for we can instead use a spinlock dedicated for
Lo_deleting check.

But we cannot avoid holding lo->lo_mutex from lo_release(), for WQ context
was too late to run autoclear operation. We need to make whole lo_release()
operation start without disk->open_mutex and complete before returning to
user mode. One of approaches that can meet such requirement is to use the
task_work context. Thus, export task_work_add() for the loop driver.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/task_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..2a1644189182 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -60,6 +60,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.32.0

