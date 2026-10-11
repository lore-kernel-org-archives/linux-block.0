Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317A248F57
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725184; cv=none; b=gIBcCUepENctddY7zh3ak8jSWS2fnb9IMQtuDAYTS2dfcT82waUtitXY1biBksDszo8qPZIYeEXC6Ub8zUS51jO789tUb4OrOuds9weJVZFXmimWG36LxiVDZRgvRKegrBI/Q1gpaXO1MNbW4+YhmQzKg+qEQYo+byqsc6qoU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725184; c=relaxed/simple;
	bh=sQm1/mpAxNNejTpNFmmdNDvibcXSDMXfhBsCVsnycyQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PNltSuKIK0nwgtKdKXjs7bJ2smsikfpwFpT+ouRLlEQpylXTQaghJ+++79iIuGLg1aWkSPAWvst4VhWaEiniMtWZ72mNt7qWCHjgRvZlRgpk9igJZgPn+BrAhu1eNPgZ3LqsVmuKesVh9PxNLImMJkRaOs4ALX4FNw5WANkS53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69BDQJ5q036034;
	Sun, 11 Oct 2026 22:26:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69BDQJh7036031
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 11 Oct 2026 22:26:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cc2910d3-3113-44d4-94ef-0c8d365fac9c@I-love.SAKURA.ne.jp>
Date: Sun, 11 Oct 2026 22:26:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] loop: Detect write requests that failed to wait for
 completion.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Edward Adam Davis <eadavis@qq.com>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Bart Van Assche <bvanassche@acm.org>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
 <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
 <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
 <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav111.rs.sakura.ne.jp

This is a debug patch which will be reverted after we observed what is
happening. This patch does not attempt to fix the problem itself.

syzbot is reporting NULL pointer dereference in lo_rw_aio() [1][2].
An analysis by the Gemini AI collaborator [3] considers that this problem
is caused by a timing shift primarily exposed by commit 65565ca5f99b
("block: unify the synchronous bi_end_io callbacks"), along with helper
refactorings like commit 92c3737a2473 ("block: add a bio_submit_or_kill
helper").

But due to difficulty of reproducing this race, discussion about what is
happening and how to fix this problem is stalling. Also, we haven't
identified how many filesystems are subjected to this problem. Therefore,
we need to proceed to debug printk() approach, for syzbot cannot find a
reproducer for this problem.

Another analysis by the Gemini AI collaborator found possibility of
sync_blockdev() not waiting for write requests due to skipping
__filemap_fdatawait_range() when filemap_fdatawrite_range() returned -EIO.

  Step 1: A test process is created and calls unshare().
  Step 2: That process extracts a crafted JFS image to a memfd storage.
  Step 3: That process binds that image to a loop device.
  Step 4: That process mounts that loop device as read-write.
  Step 5: That process issues some buffered write requests.
  Step 6: That process is killed before writeback for Step 5 starts.
  Step 7: Automatic unmount operation starts due to teardown of a mount
          namespace.
  Step 8: jfs_umount() calls filemap_write_and_wait() (directly or via
          sync_blockdev()).
  Step 9: filemap_fdatawrite_range() returns -EIO due to filesystem errors
          after several submit_bio() have been already issued.
  Step 10: jfs_umount() completes without calling
           __filemap_fdatawait_range() which should wait for completion of
           I/O requests issued by Step 5 due to Step 9.
  Step 11: fput() is called from __loop_clr_fd() from lo_release(), and
           destruction of "struct file" starts after returning from
           lo_release().
  Step 12: The in-flight I/O request issued by Step 9 is finally processed
           by the loop backend kworker. However, since the backing "struct
           file" (and its associated structures) is already under
           destruction, the kworker attempts to dereference now-invalid
           fields, leading to WARN_ON_ONCE().

In order to check whether the steps described above is actually happening,
add debug code to the loop module for reporting I/O requests that are
processed after __loop_clr_fd() started. Note that this debug code is
enabled only if CONFIG_KCOV=y, for this check is a waste of computation
resources for almost all users.

Link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
Link: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 [2]
Link: https://lkml.kernel.org/r/fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp [3]
Assisted-by: Gemini-Pro
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  - Use "loop device is no longer bound" and "there is no users" as
    the conditions to report.

Changes in v2:
  - Include linux/stacktrace.h file.
  - Sashiko's review spotted that lo->lo_state is already Lo_unbound
    by the time fput() is called. Therefore, don't check lo->lo_state
    value, and check from only loop_handle_cmd() path. Since syzbot is
    reporting that kworker is finding inflight I/O, this change should
    still be able to catch [1] and [2] above.
  - I would like to introduce a kernel config option like
    CONFIG_DEBUG_AID_FOR_SYZBOT for gating debug code used by syzbot.
    But that will be a different discussion.
  - Not using ratelimit for reporting, for there should be only few
    if any when loop_handle_cmd() finds one. Not checking from 
    loop_queue_rq() path should reduce the amount of  output a lot.

 drivers/block/loop.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..191807599bf7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -36,6 +36,7 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
+#include <linux/stacktrace.h>
 
 /* Possible states of device */
 enum {
@@ -86,6 +87,12 @@ struct loop_cmd {
 	struct bio_vec *bvec;
 	struct cgroup_subsys_state *blkcg_css;
 	struct cgroup_subsys_state *memcg_css;
+#if defined(CONFIG_KCOV) && defined(CONFIG_STACKTRACE)
+	unsigned long stack_entries[30];
+	int stack_nr;
+	pid_t pid;
+	char comm[TASK_COMM_LEN];
+#endif
 };
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
@@ -1910,6 +1917,13 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 #endif
 	}
 #endif
+
+#if defined(CONFIG_KCOV) && defined(CONFIG_STACKTRACE)
+	cmd->stack_nr = stack_trace_save(cmd->stack_entries, ARRAY_SIZE(cmd->stack_entries), 0);
+	cmd->pid = current->pid;
+	get_task_comm(cmd->comm, current);
+#endif
+
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -1925,6 +1939,21 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
 
+#if defined(CONFIG_KCOV) && defined(CONFIG_STACKTRACE)
+	/*
+	 * This request was queued after checking lo->lo_state == Lo_bound
+	 * in loop_queue_rq(). The state should remain unchanged unless
+	 * __loop_clr_fd() by error starts before blk_mq_complete_request()
+	 * is called.
+	 */
+	if (unlikely(data_race(READ_ONCE(lo->lo_state)) != Lo_bound &&
+		     disk_openers(lo->lo_disk) == 0)) {
+		pr_err("BUG: found I/O issued by %s/%u but loop%d is no longer bound.\n",
+		       cmd->comm, cmd->pid, lo->lo_number);
+		printk("Call Trace:\n");
+		stack_trace_print(cmd->stack_entries, cmd->stack_nr, 4);
+	}
+#endif
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
-- 
2.56.0

