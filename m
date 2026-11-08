Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104520;
	b=Zb/Qz46jzOzRNtugh6mby3cqCKh7RHf17CzeN97u/1LbSyUuDDM46/JZxANGIAeBbnE4
	 D85Wr4xm687oy+BqVWEPA+dfDvfTT727mPoCCPqw4Hv4RSHoDRdzF5gMZEYj6OjYoqgVF
	 3e8AYZGOS7UMshOKMRsFBoX/V3DiMzUk0WRyvNbzlXZ1snjqvctqYmje3kgwUVLj5qfBW
	 q0wHPmpRFr3K/jN2306Ndfrsz2fnc735iD5v7OZHdCDy47RQ64E1hjyuLXyTzGjQTPLq8
	 AQUzjAO7salDTlD9uFlXpDZQvMDo/j2H+caUMx1sEEcUor1z69k8l6l+J1fNONX1+rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104520;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lg3LEB/Jnk5uLMaIenRlE8DmDu3jBUWxyp6bBvfT6DQ=;
	b=yqHSGSwcmkobo0mCFtRYsipOxtaMNEAU6BW4Q64h9EjDAVhzvGWZNq7TZuqL8HXXVlov
	 +4XNixpqiJQ7XjNzMn8w9pYyBOEhkCS0DhcUOXMEiKDK5mx3JooiDfcFDp0sPpLm4UOYI
	 rXO1CsLrwQJnibC6dQgMI7O/stbiVp6KCHu4k6Eo0V71TQQjQHb8nVehvuPoofwF4ahLv
	 azZUP4RgU1OJZkOt4xCjjjUhAarf1NcY6RnqauiLd9VwUG1X5VI6+EgfIR+QCsP+YFTQl
	 BisbMNL8PVvbuQmLSyWlVU7zL5FmgS1wHvRfuG63wF3nmCEyN/CN1CbFEwxdFgJRnTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GUzworsT;
	arc=none smtp.remote-ip=203.205.221.233
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C1606A31A;
	Sun,  8 Nov 2026 02:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GUzworsT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794104515; bh=Lg3LEB/Jnk5uLMaIenRlE8DmDu3jBUWxyp6bBvfT6DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GUzworsTLh+htg+aDcAHBmfqqfpU1z6hPtvTJ1eLuCgENYo2oYRqOj1uWJxG0zCh2
	 ZsEFfLztr1ebclBsRjMENDIXbqeVSVVkJw4nVwcuCoAOcRKe3xOoEfPuOhC/l9eYeZ
	 aBs+gEDUfwGd6+Z+yHP2/HoO7YDnBFPkv8V/kI6I=
Received: from shuai-VMware-Virtual-Platform ([223.88.55.201])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 574A5C8D; Sun, 08 Nov 2026 10:21:52 +0800
X-QQ-mid: xmsmtpt1794104512te6neevu0
Message-ID: <tencent_3B0DCBAE7C555338AE85D8D0C4ABBB9E3406@qq.com>
X-QQ-XMAILINFO: OD1YwH4pKZ9p0QbDbk6hacEWhO72VxVUu5E7qQ9D7OfYbt8GZEeLOXmz8XEzpq
	 r2tYKZKT5daONjH+Hip4nVgqZxSyHv3kPZzCjb/DUP5dWSB/fnjWvfAy4h/gKLCXo5TmfuuyZo9o
	 lypoXbgFThT24z2gVb9a+6JSa1X3dGMOxB7cJCUgYGoDGpD77egiOp/XcWdfDn0tIkQfPXIHIQLB
	 lwL7ytke5Sfo7PRdH0+L9NARPViWYgRl+oNnpoI5u8cm8Opu1AbsZKLUeibiLKa2ebu3pcd8c1PJ
	 b7hiT1XpYF6uiF7pj6yZWzQHOE4CYYs/rqQDctRICuTb+m8UFlvsNiF9D+4KWMiQIsUzypOXVt4D
	 B0HGUPbCN86jy5hfHF6Ju+K+70AE/cktXzBx45kXrYgnCk0vZNIpqfYxcNukgZ8363lPW+X00z78
	 PpM9nCicPqdgmVXQSmmU3/fuvZxFMFgQK72wwIhX1Ur3BtWabsl+VUg7JBdHsij/s4ep6lzUsUmX
	 zEMeEn3rpLU+DPSarV2WHzrnzM9UpK8szs8+YznByZBMwJStmG7Ho8Usd4pVUNTUqYyMOTpY2d+e
	 5XXQolwxhXDiif7RHS5cY8XImREzEdY2EZaWYEJzfSVzU0xdv+fOQU2X0VwaVxjtIXU3n9/wPEgW
	 xFOddT/NLWYn6iG+3wQOwKWG+lP43XbtdrIB/hoymO49x/105jyKJ6dPyLH8NdGvxiCu7kwRn4jc
	 M92XTXT3Pu9bfioHOgXPLfKNde7XhYE4nfWrF8F12VM9v2W5/1RgbNDIS3v7aGfroi782cOHSTV/
	 AUcNj7dJexB8Y/F+ys+c0Ap1EBIhPGnmSblOSaH4uAKbIpazWOXSuky4cvEy2gYSg/+XoXQCl1bb
	 vH3MAdBQNxPxKadpZ3nL0/zHAbmlLqyPAdG6h73ZpPTC+D1Zr25L3J776rFIidByRi73b935BkLI
	 F2Mwt5e51Ijysn0G8FybSF75LYudyHa9i0gbKPyRt/7BufixrCLVVmus19aROkLwlRePl3fhLvzp
	 dzmRSn3omEn6zLrRIIIGukGdHHgZk/NfMwwiVk9uph/QAXovDBpOES8bM5DeLIMkwt+DswFNwmgF
	 FSE4Ro
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: syzbot+1eb53c83ab8b0a0302a6@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH] block: release queue freeze lockdep locks under mq_freeze_lock
Date: Sun,  8 Nov 2026 10:21:32 +0800
X-OQ-MSGID: <20261108022132.790657-1-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6acba905.8cdf6287.1eb53.00e4.GAE@google.com>
References: <6acba905.8cdf6287.1eb53.00e4.GAE@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lockdep model for the queue freeze owner decides whether to acquire
the q_usage_counter io and queue lockdep maps based on
mq_freeze_disk_dead and mq_freeze_queue_dying.  These two flags are
re-sampled by blk_freeze_set_owner() whenever the freeze depth drops to
zero, i.e. after the previous owner released its freeze.

blk_mq_unfreeze_queue_nomemrestore() used to release the matching
lockdep locks only after dropping mq_freeze_lock.  Between dropping the
lock and reading the live flags a new freeze can run
blk_freeze_set_owner() and flip the flags from false to true if the disk
dies in that window.  The original owner then observes the flipped
flags and skips the release, leaking both lockdep maps, which triggers
"WARNING: lock held when returning to user space" with
&q->q_usage_counter(io) and &q->q_usage_counter(queue) still held.

Perform the lockdep release while still holding mq_freeze_lock so that
blk_freeze_set_owner() cannot interleave and the flags observed at
release match the values sampled at acquire time.

Fixes: 6f491a8d4b92 ("block: track disk DEAD state automatically for modeling queue freeze lockdep")
Reported-by: syzbot+1eb53c83ab8b0a0302a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=1eb53c83ab8b0a0302a6
Signed-off-by: Shuai Liu <847807867@qq.com>
---
 block/blk-mq.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b9..db769c7c88ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -208,11 +208,10 @@ void blk_mq_freeze_queue_nomemsave(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_nomemsave);
 
-bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+/* caller has to hold q->mq_freeze_lock */
+static bool __blk_mq_unfreeze_queue_locked(struct request_queue *q,
+					   bool force_atomic)
 {
-	bool unfreeze;
-
-	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
 	q->mq_freeze_depth--;
@@ -221,7 +220,15 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
-	unfreeze = blk_unfreeze_check_owner(q);
+	return blk_unfreeze_check_owner(q);
+}
+
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+{
+	bool unfreeze;
+
+	mutex_lock(&q->mq_freeze_lock);
+	unfreeze = __blk_mq_unfreeze_queue_locked(q, force_atomic);
 	mutex_unlock(&q->mq_freeze_lock);
 
 	return unfreeze;
@@ -229,8 +236,19 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 
 void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q)
 {
-	if (__blk_mq_unfreeze_queue(q, false))
+	mutex_lock(&q->mq_freeze_lock);
+	/*
+	 * Release the lockdep freeze locks while still holding
+	 * mq_freeze_lock.  blk_freeze_set_owner() re-samples
+	 * mq_freeze_disk_dead/mq_freeze_queue_dying once the freeze depth
+	 * reaches zero, and reading the flags after dropping the lock races
+	 * with that re-sampling: if the disk died in between, the flags flip
+	 * and the release is skipped even though the matching acquire
+	 * grabbed the locks, leaking them.
+	 */
+	if (__blk_mq_unfreeze_queue_locked(q, false))
 		blk_unfreeze_release_lock(q);
+	mutex_unlock(&q->mq_freeze_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_nomemrestore);
 
-- 
2.53.0

