Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071D1D5CE0
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148902; cv=none; b=HnmtnU7XiuNEVP3VsFbnOcyXemxOxvWx7S1CxqXdP8siJ4AqDd0Qc3UEz+sQiViX1sc1CUIPeOJ1A/RwXZC9+k8E2yDTuMUhbEP/V0nCgcaDk53kKgeHRsY2xIQiuPqnvYviU+D1dmYLP6Ps9rPzap2Y6U/hENAGJFHwoaf1ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148902; c=relaxed/simple;
	bh=fSrG8R3csbW6uzfec7eGrS7BIHMgL+NMokZsMOF9MkE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eIPiUGNbeEMdKIMgcJ2Md8eycFzVvNyJeGM/uEO8uvvXdR9mXeJ/pcaMYWxOu1TS3CJqR2DZLXyRcMwVYrHmU2qY4YYb764Dto048q6FVYSm/u6mm2rhEFDsFRoEDGu3fxRCiysq8KH47h/dQL91ZiAFYZ61nWikHVOcsCKuSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64UDmKWd047486;
	Sat, 30 May 2026 22:48:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64UDmKke047482
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 30 May 2026 22:48:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <148efba2-a0b6-47d7-ac76-b19d2f4b696c@I-love.SAKURA.ne.jp>
Date: Sat, 30 May 2026 22:48:17 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        Hillf Danton <hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] loop: reject binding to procfs and sysfs files
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

I noticed that /dev/loopX accepts pseudo files, for loop_validate_file()
currently only checks:

  if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
      return -EINVAL;

and pseudo files are treated as S_ISREG().

Reading from pseudo files via /dev/loopX causes unexpected results, as it
tries to repeatedly read the entire content up to the size visible to the
"ls" command (padded with repeating data).

  # ls -l /sys/power/pm_test
  -rw-r--r-- 1 root root 4096 May 26 22:14 /sys/power/pm_test
  # cat /sys/power/pm_test | wc
        1       6      48
  # cat $(losetup -f --show /sys/power/pm_test) | wc
       85     513    4096

Writing to pseudo files via /dev/loopX might also cause undesirable
results. Therefore, explicitly reject binding to pseudo files on procfs
and sysfs for now. Other filesystems can be appended as needed.

There is another intention for this change. Currently, we are evaluating
the possibility of calling drain_workqueue() from __loop_clr_fd() in order
to address a NULL pointer dereference in lo_rw_aio() [1].
However, introducing drain_workqueue() into the loop teardown path where
disk->open_mutex is held forms a circular locking dependency when a pseudo
file that takes a global lock is specified as the backing store for the
loop device.

If drain_workqueue() is called from __loop_clr_fd(), an example of a
circular locking dependency that involves system_transition_mutex and
disk->open_mutex can be triggered by the following reproduction steps:

  # echo 7:0 > /sys/power/resume
  # losetup /dev/loop0 /sys/power/resume
  # cat /dev/loop0 > /dev/null
  # losetup -d /dev/loop0

Even if our final solution for [1] does not call drain_workqueue() with
disk->open_mutex held, rejecting binding to pseudo files that confuse
userspace programs is a standalone improvement.

Link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
Analyzed-by: AI Mode in Google Search (no mail address)
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..6aa88a7a0e2e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -500,8 +500,15 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 		rmb();
 		f = l->lo_backing_file;
 	}
-	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
+	if (S_ISBLK(inode->i_mode))
+		return 0;
+	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
+	switch (inode->i_sb->s_magic) {
+	case PROC_SUPER_MAGIC: /* e.g. "losetup -f /proc/sys/kernel/version" */
+	case SYSFS_MAGIC: /* e.g. "losetup -f /sys/power/state" */
+		return -EINVAL;
+	}
 	return 0;
 }
 
-- 
2.47.3

