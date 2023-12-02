Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PGLKXqRf"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C804311C;
	Sat,  2 Dec 2023 01:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701508051; bh=LGW9/N7EF2cL/CsI7opIr7gQpKRqmDVgA5wk4y0jLVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGLKXqRfeP+y/K+gd1NoxzcnofULsJRR6EXRC1zmWYxE310Idi/4WEq0B7d3b2Eqn
	 s7NA4kXNPB5Q8QLoaD/jqEYQKOvdyMJNMFeN698T92oyeMEitsprG5XLn0dOFeSm5Q
	 Tuu2+ndd5nWtXGktNqjtVBZuhgmoRvzknZwQiiDU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 41840C9; Sat, 02 Dec 2023 17:01:01 +0800
X-QQ-mid: xmsmtpt1701507661txxvf1fxv
Message-ID: <tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTlSDgejI+6IkwjaG7P1nnYAsO0p2YoGWpP1+qm1EBlqeK3tDOKK
	 pMSWOWHeXAsA5XmT4jz92Ggmhc/mWxvcl6C5TApZ8OWBM5DmGZbtwV/ibp9vl8P/ezwDAm2cIta7
	 v1Ri3B57H4k57NjtBgNTTBpv4sx1ECCkZakUFfNvyICpiQ/6pn40gPCLThtJLXrWGpB3vSsAPd+V
	 Ejvmn90Zw+gshuZdQ9duN0yNgZ2VztHK7Xf7tbKPNjP7HM7ev5ZSKB03uUmUAcboQP5vU21bkoo9
	 rRQ//Y+J/tn6ihjzk8lD/ck6R8tYP0iqwOGuBM958noMeibfvo1JgFvQUGwwhdMcd6f/SceuyuM2
	 aZCbbYg5AnrQyAGLm/ZydWhIlNB9XadZTf+iwi4PRbIhb/yUlWcZWoO83XaE6ha57FyBMARjxHke
	 GT8nxwB90dB5gjUTcajPR9f6b3T5IaIdtj1leafdU/JtAAT1s4dR0vo09AXZbDdC/Ic5huCREPrD
	 ahq0EJURsXMMoNK2XBpiBlcBN8oe84TOkVUCjez4MBBpGmc5UIE1vxOjksNLRpuClxAr1gl0XJr6
	 m8UEknNvlIlyFPOoq9tknKf3DOeDw+RJCinmIBzbUbzD3ILtIW+IWUpj9DCM7FGdv/eeSStP+fF+
	 jXGkWaeZ6ELv4vi8CyQCCirwb5avuJK5txPRejrRtv+u3b4/ZTba2yrxgwwYrrFsg9oXQqMwdbKi
	 +GDAP4+cXRRKJXRtU7ZfbEYwKXqWQ6Ls6UBhorrC51HcQfPlyBj4aaPT2SkRqTIuqawHRY0I2c3h
	 NgOpPvF8/yPo/gzKxoL53ox0/UrRR+C4wAswVUyblq/v3x/mQA+7xcik5IMntCS+99fbSR1a71RY
	 +lkuIVx6jYQkg+u/Gnqg7r6P3fkYUKSnixddvE8poOZ5UVn/lNBqoXecXKKvhs5PTLR+8SB63YZG
	 y76o5SmJg=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	dvyukov@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	pengfei.xu@intel.com,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] trace/blktrace: fix task hung in blk_trace_ioctl
Date: Sat,  2 Dec 2023 17:01:02 +0800
X-OQ-MSGID: <20231202090101.2835111-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <00000000000047eb7e060b652d9a@google.com>
References: <00000000000047eb7e060b652d9a@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reproducer involves running test programs on multiple processors separately,
in order to enter blkdev_ioctl() and ultimately reach blk_trace_ioctl() through
two different paths, triggering an AA deadlock.

	CPU0						CPU1
	---						---
	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)


The first path:
blkdev_ioctl()->
	blk_trace_ioctl()->
		mutex_lock(&q->debugfs_mutex)

The second path:
blkdev_ioctl()->				
	blkdev_common_ioctl()->
		blk_trace_ioctl()->
			mutex_lock(&q->debugfs_mutex)

The solution I have proposed is to exit blk_trace_ioctl() to avoid AA locks if
a task has already obtained debugfs_mutex.

Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/trace/blktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 54ade89a1ad2..34e5bce42b1e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -735,7 +735,8 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
+	if (!mutex_trylock(&q->debugfs_mutex))
+		return -EBUSY;
 
 	switch (cmd) {
 	case BLKTRACESETUP:
-- 
2.43.0

