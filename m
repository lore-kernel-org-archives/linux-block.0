Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C03DBD65
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792049; cv=none; b=f3o6zdDGo2yiRS5e7T3CsvGVZ7/U0yzn+oZ1ePkjDBVztLDMbqQlnbcBTDXCC8je0UYtU1GqBDg5bhNU2UlABdLnscZwG7eimjXB4wjwrhrLkuaaK5jg6c1cRvLPyAserX+fU1xARaXyajGwBAR8WvK+Uyi+qR8k3AS0sT6i4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792049; c=relaxed/simple;
	bh=hmITaqgDuLqWdeBIigSTXggwSACVll2GE/YaTiXLANs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/gElkPaioCpoAUWHl4dxvAPfoheNjDcsY+4BvOtJw0qEhZAi+RpVYeZb5xCCf1yng1zUpvA3wacta4KzKfnNtD9kCbB4DVFydKWkMv2aPwgoC0QoZnr9UkzcjMeVVPAnL6oHxRqW1EfnOwM/EvPe62nc0q87t3JoOLI5921XUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MmU9YBwY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MmU9YBwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xn
	BghWhc9bHK5c0hYD4A5ldUbfuEbl7V+wVp6KD5iog=; b=MmU9YBwYQIsm0KttXZ
	FjC8O8a+pZX7//xD5nPwsnjyvlcZBjKHzBiFEYQmSxazcm4Am0oBNaCGTml3zJIY
	XBl/jxq3tDizUriqZo+N3tq83PFeN6NwgfLol9FnqHgRDWCSw+zf05ScHXoGtDlH
	TqFGXeSGiTgZtRGgBIwWUzHP8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHq__ew2FqOtnHHw--.2762S2;
	Thu, 23 Jul 2026 15:33:51 +0800 (CST)
From: dayou5941@163.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] loop: clear backing file on LOOP_CONFIGURE limits failure
Date: Thu, 23 Jul 2026 15:33:47 +0800
Message-Id: <20260723073347.2129494-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHq__ew2FqOtnHHw--.2762S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW3JFW8Wr1xtFW7Gw18Grg_yoW8Xw4fpF
	ZxKFykK39Y9F4DWFWjq34kWFy5Jw47C3y7ury7tw1v9rs8Zr9IvFyxKry5WrZ7tFWrtaya
	qF4qyrWDCr1UKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBuWJUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3h8byWphw99nxQAA3m

From: liyouhong <liyouhong@kylinos.cn>

loop_configure() assigns the backing file before queue_limits_commit_update().
If the limits update fails (e.g. an invalid block_size), the error path
fput()s the file but leaves lo->lo_backing_file set, keeps the modified
mapping gfp mask, leaves lo->lo_device dangling, and never clears the
uevent suppression flag.

Undo the assign on that failure path.

Fixes: b38c8be255e8 ("loop: use queue_limits_commit_update() for configuring")
Assisted-by: Cursor:grok-4.5
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1faecef33009..bfe2a788db44 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1059,7 +1059,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error = queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
-		goto out_unlock;
+		goto out_clear_backing;
 
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back
@@ -1096,6 +1096,11 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	return 0;
 
+out_clear_backing:
+	mapping_set_gfp_mask(file->f_mapping, lo->old_gfp_mask);
+	lo->lo_backing_file = NULL;
+	lo->lo_device = NULL;
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 out_unlock:
 	loop_global_unlock(lo, is_loop);
 out_bdev:

