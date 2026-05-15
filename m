Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDF34AB01;
	Fri, 15 May 2026 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809150; cv=none; b=R3oksM7ePm05cNAwf48GtI8sXNLLOZ++VkUSnIgjWTM+PPvmS2cIKMfq3ZiMMOaWA+mQIMYX5lokjXM7kdaCUkJHLhr25rJgwnHh7MlJFpO+VXB+aAfUiyS3cAlEWpRiBIbjasfHsOwZ0SpGvgmyKrUXEou9RIL4kSQtgG5e+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809150; c=relaxed/simple;
	bh=1kRuJIQ8FSdTWPsi/pZjmzsE/DF7q4d76tjWl/48AeQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ccQCW4V1mHJarK60WiA4C0MzCBxRAwcHFY0M8+j4TeEzZsWLxGsWXOWjdGj08dZgvgShTP38rBrp98Tzkkup4v0V76TObFl1duuACtePyPinfkyt96BTZXJALBXh8cwYTL9vmVVdUXU/timCqP14aZfuCAYrey2b4tNmtWxwCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64F1cd9S082184;
	Fri, 15 May 2026 10:38:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64F1cd1e082181
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 15 May 2026 10:38:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
Date: Fri, 15 May 2026 10:38:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

The loop driver relies on lo_release() to automatically clear the loop
device via __loop_clr_fd() when the last file descriptor is closed
(LO_FLAGS_AUTOCLEAR). Although the backing file structure itself remains
allocated in memory thanks to proper file reference counting (f_count is
not zero), a severe race condition exists regarding the visibility of
the lo->lo_backing_file pointer.

This race window was exposed by commit 65565ca5f99b ("block: unify
the synchronous bi_end_io callbacks"). By unifying and optimizing
the synchronous I/O completion path, the timing and scheduling behavior of
the block layer altered significantly.
As a result, a highly-concurrent execution pipeline emerged where
lo_release() can progress to __loop_clr_fd() and nullify
lo->lo_backing_file while an already-scheduled asynchronous I/O work
(lo_rw_aio) is just about to be executed by a kworker thread.

Since the kworker enters lo_rw_aio() after lo->lo_backing_file has been
cleared, it attempts to dereference the now-NULL pointer when initializing
the kiocb, leading to the reported NULL pointer dereference bug.

To close this race safely without introducing heavy fast-path checks,
we must ensure that any running or scheduled dispatch threads have
completed before we nullify the pointer. Since loop_queue_rq() operates
within the block layer's RCU read-side critical section, invoke
synchronize_rcu() and drain_workqueue() in __loop_clr_fd() prior to
clearing lo->lo_backing_file.

Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
Reported-by: syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3
Analyzed-by: AI Mode in Google Search (no mail address)
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..ff117f340b2f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1118,6 +1118,17 @@ static void __loop_clr_fd(struct loop_device *lo)
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
+	/*
+	 * Now that loop_queue_rq() sees lo->lo_state != Lo_bound,
+	 * wait for already started loop_queue_rq() to complete.
+	 */
+	synchronize_rcu();
+	/*
+	 * Now that no more works are scheduled by loop_queue_rq(),
+	 * wait for already scheduled works to complete.
+	 */
+	drain_workqueue(lo->workqueue);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
-- 
2.54.0


