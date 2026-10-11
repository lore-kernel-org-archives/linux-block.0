Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A638B7A5
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715065; cv=none; b=a8mk8rtYGXHxlpwxYtuIHr50pdXF7BqrDHQbWpiMbNAcuD24kZ8TDZ/aq2C1f/v3tsZ2CoQ0z25KEh6yR7zSIpos738dqVO40S5FlR7vWnZpPRF+CLgs20fdHigw72Pk9BEvT/PjkeFDe/Yu7OGN7NbcpQ/jiM8U0yKOI+Ep4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715065; c=relaxed/simple;
	bh=IVxVDsxwAK0Mfeh7ik7k3M5R5wgiz0DpE1L17MZMuD8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rfJpQ9zORfyBTWJL0RPoD1IPaAxhmH8XSA/GnHUDKpoqECGVg/UwKTqz1UbNGvXpQk9lVMfCotVjpzslm7FpAnF268iWOIxEw9ynrTMeaj9yn4bUkbNnn/07TsZPKKlCOUPUpuyVTJajedE/ynYkxS2br7SyO7LcjMjUaZmrWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69BAbRZK067766;
	Sun, 11 Oct 2026 19:37:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69BAbR8O067761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 11 Oct 2026 19:37:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
Date: Sun, 11 Oct 2026 19:37:27 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] loop: Detect write requests that failed to wait for
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
Content-Language: en-US
In-Reply-To: <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp

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
Sashiko, does this analysis look correct for you?

 drivers/block/loop.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..09b72138543d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -86,8 +86,27 @@ struct loop_cmd {
 	struct bio_vec *bvec;
 	struct cgroup_subsys_state *blkcg_css;
 	struct cgroup_subsys_state *memcg_css;
+#ifdef CONFIG_KCOV
+	unsigned long stack_entries[30];
+	int stack_nr;
+	pid_t pid;
+	char comm[TASK_COMM_LEN];
+#endif
 };
 
+static void loop_check_io_race(struct loop_device *lo, struct loop_cmd *cmd)
+{
+#ifdef CONFIG_KCOV
+	if (unlikely(READ_ONCE(lo->lo_state) == Lo_rundown &&
+		     disk_openers(lo->lo_disk) == 0)) {
+		pr_err("BUG: %s/%u is doing I/O request on loop%d in Lo_rundown state.\n",
+		       cmd->comm, cmd->pid, lo->lo_number);
+		printk("Call Trace:\n");
+		stack_trace_print(cmd->stack_entries, cmd->stack_nr, 4);
+	}
+#endif
+}
+
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
 
@@ -1879,10 +1898,18 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct loop_device *lo = rq->q->queuedata;
 
+#ifdef CONFIG_KCOV
+	cmd->stack_nr = stack_trace_save(cmd->stack_entries, ARRAY_SIZE(cmd->stack_entries), 0);
+	cmd->pid = current->pid;
+	get_task_comm(cmd->comm, current);
+#endif
+
 	blk_mq_start_request(rq);
 
-	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
+	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound) {
+		loop_check_io_race(lo, cmd);
 		return BLK_STS_IOERR;
+	}
 
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
@@ -1925,6 +1952,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
 
+	loop_check_io_race(lo, cmd);
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
-- 
2.56.0

