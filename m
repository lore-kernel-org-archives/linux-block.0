Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0D32E144;
	Wed,  7 Jan 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782516; cv=none; b=VDrYy3XLUGb8Jz3LsmAZNeyrXkYzd1tqU8xt+cbq+2yAO5PIjucLa0/Dy/isS/eFHZCuK5jYZZpm3uDgNzUuq+bvMkTGpnyk06T5ti338Wfve77AmNqz0Y3qg42b2KQT7z5wtfTOub8Lk802HfPohQeIDc2IV3LJmP0B7elIVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782516; c=relaxed/simple;
	bh=hxEAwiXPiLra0qei2/9MeDGrDIPKlKc03052nvMFF0c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KjSuKyJBpR7+Tefua7ErqGL/29EVVlHjaGK0mXfMj/vfAQ3gmK8hD6ylp1uqar8pEOwdhw6EhRJoyYqz1kgXuQQHNJV7VXz8+IrgXMoKG1Z7XKQJ0Mr4yVKtxTV/JTQ4OT8euyz8qSRkp5WKj//0H+74IasRgvoFQ7a7szCqwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 607AfhAw090713;
	Wed, 7 Jan 2026 19:41:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 607AfhFV090709
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 Jan 2026 19:41:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cb9229f1-5472-4221-89d4-4df31bee8488@I-love.SAKURA.ne.jp>
Date: Wed, 7 Jan 2026 19:41:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>,
        Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] loop: add missing bd_abort_claiming in loop_set_status
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

Commit 08e136ebd193 ("loop: don't change loop device under exclusive
opener in loop_set_status") forgot to call bd_abort_claiming() when
mutex_lock_killable() failed.

Fixes: 08e136ebd193 ("loop: don't change loop device under exclusive opener in loop_set_status")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since that commit for some reason calls loop_reread_partitions() when
bd_prepare_to_claim() failed, this patch calls loop_reread_partitions()
when mutex_lock_killable() failed after bd_abort_claiming()...
Maybe we should return as soon as possible?

 drivers/block/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ca74cc31bf07f..bd59c0e9508b7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1245,7 +1245,8 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
 
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
-		return err;
+		goto out_abort_claiming;
+
 	if (lo->lo_state != Lo_bound) {
 		err = -ENXIO;
 		goto out_unlock;
@@ -1284,6 +1285,7 @@ loop_set_status(struct loop_device *lo, blk_mode_t mode,
 	}
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+out_abort_claiming:
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_set_status);
 out_reread_partitions:
-- 
2.47.3

