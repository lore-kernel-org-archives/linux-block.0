Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F422D5935
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765861923; cv=none; b=Nk9sHgd5jZ/Co9XMpBXEx3tzsbS+/9619U6nKs/T2yheLIugxPYA2Goqfd688L8w3bHblv9TUl1XGNCoEoBRSJhePsY5RDVgLP8pwWOHZmtasgFnr5dJMacgmebWtOXPo1ovollAmZRsg/vShHWjPS+T44LBrHtcJ9UMo8vResg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765861923; c=relaxed/simple;
	bh=dL8XLir8PFAdyV4utDspdTI6kI2GE1B3p9S0ocnPf5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0spXhcVVnOW5EYe7OCnydpM8nZk/q6oMkX5JEEr2ID37G0wwVx25DE9L1puDz9hAIvwr0zx0EYo/2Xm62RCZtvIP0BAxZlv2N5t8G+xu+MW6HvPIDGJnYmGM8B7sLs2OPS+kKEDkzDrBtFEWnNTBuajA1hckC6KYkGQUOtFduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYILH2Cn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYILH2Cn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so4446833a91.3
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 21:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765861915; x=1766466715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=woUyBoDp1pSghlFW7KW3gZ3nNWggNfrEo8pZzIkXJ8Y=;
        b=dYILH2Cn0pxiF1WRK9yhloQlTbf6+6Fr6KgRJFqXs/QjRHPGxJ/gv9EJKrdCq4wVXL
         9QDnjtlTvY4oYWqE3aeJsrK91fDR/vyrs42hC5jiWB1w4iS+CT45dHKNlKofJmTa956x
         7shutmkkQPUvdEmILAcmxNx9sFT8mf8BmKL3hnVkr+cbrFSl3vFAHkL7XIrv6TSqOA9K
         PIzbOZf5w+2qdRTo2+Ulq54AIHw9sDMVfH6ozIgKwgMZ8qA3PwdjC5w82cMZHzoF8oIq
         oMLW/M2OD/d3pYLm7SiSaxI/5KlXRdfv8T6TM8YbQf3srXU76TjEAeK+oI/HYlp6wjFn
         AAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765861915; x=1766466715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woUyBoDp1pSghlFW7KW3gZ3nNWggNfrEo8pZzIkXJ8Y=;
        b=AO1Yb+nyD05pHCsE52x3kKlriSkrforVQWtzY+J5pGE9Sa/6BTcaD8EcU1lSmg4pGA
         6o4iZgtvJNIzZ+v8QT47y+iMrBBIw9WRtlFFi7TH+BLmElV/bF1qQHKM+tpfnNMWRfZc
         38T8s9ll7oKzgZt4uuGjJJmbznzYniYM4IthJCt2sTu8qs/guKUaDFLQUt8l/pdmV2J8
         xU6N14bacZwlkFOhgqgkI94YC0trGYz6voLUW1eZWhjZ5E4uSYnYs9Nto0qelt5UwuUL
         N0y8fryFO+XaUdTQABZXQF3lKbx4o4vYRIixWITgUVTv58dM87Jith1TEIJ/+HHTTHSV
         R1cQ==
X-Gm-Message-State: AOJu0Yza5+Psm8TPeG2hcg9H8BD/0xT5shpZkTfh7XXot0nGcr7O1KoV
	O276LvqMkJ1tnt0jaU8sOFZ4CS9XC4g06mcrysJ7J3rTj1p/Lb367hqpjHMPZQ==
X-Gm-Gg: AY/fxX7cjCGwarB1tLQ9wyvJwqAFmAxiolpWMsaDXRiaeUnrZaYQK83QYvd3eHJ+pSG
	/CmNyvP/qayr00SXPy+n4QFj9lLmcBrvhG49yUKxujv5nvYrxD18/svOlrtjGdgmDz2GUhsam/p
	tPc7/AuuyDxiilTnpB5/HWQT4yanc9LzdV8uboG1tjqABggrSvCsW/hZlZLXWU2jhguSmUNKYMB
	GzJ/pVILImmInsA++Oz1SqoECcNo9oOVM1+ZUNix7yrtLNdGzAGVolkxkHlNmLQFI9DU2mKSKB6
	2A4/xeKAo5oznUS1kaVe6Z9qVZ8ZQiyY0wzgYxhKBjsygd+mhX/6/0iMqzSIcVy2f0B4kEbIwQ+
	rEsnxVIe666MiJCV8Y5LiD4tMIfs88U0F7HFaR7quoi++JzgoANd8uzpberJe8/LLhlRONkCEmy
	sZIG6tbkKI+LwT3qXV+oB9x4EKGmcw51ALdNWc/Ydl40dSynYF5baqVo32YGa6qsRoBpc=
X-Google-Smtp-Source: AGHT+IGrh+0xQHXUJQbabjqcGcb7/Cq2//j72qC2/2RtwqfQw8ruWbQwRGiHSv74bArpZYdTp56LFQ==
X-Received: by 2002:a17:90b:2ecc:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-34abd6cde33mr10956693a91.8.1765861914809;
        Mon, 15 Dec 2025 21:11:54 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:930d:e829:5a50:4004])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe200077sm10539467a91.3.2025.12.15.21.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:11:54 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	stefanha@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: [PATCH v2] block: add allocation size check in blkdev_pr_read_keys()
Date: Tue, 16 Dec 2025 10:41:47 +0530
Message-ID: <20251216051147.12818-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_pr_read_keys() takes num_keys from userspace and uses it to
calculate the allocation size for keys_info via struct_size(). While
there is a check for SIZE_MAX (integer overflow), there is no upper
bound validation on the allocation size itself.

A malicious or buggy userspace can pass a large num_keys value that
doesn't trigger overflow but still results in an excessive allocation
attempt, causing a warning in the page allocator when the order exceeds
MAX_PAGE_ORDER.

Fix this by introducing PR_KEYS_MAX_NUM to limit the number of keys to
a sane value. This makes the SIZE_MAX check redundant, so remove it.
Also switch to kvzalloc/kvfree to handle larger allocations gracefully.

Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
Tested-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Reported-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=660d079d90f8a1baf54d
Link: https://lore.kernel.org/all/20251212013510.3576091-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Added PR_KEYS_MAX_NUM (64K) limit instead of checking KMALLOC_MAX_SIZE
  - Removed redundant SIZE_MAX check
  - Switched to kvzalloc/kvfree
---
 block/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 61feed686418..98c4c7b9e7fe 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -18,6 +18,8 @@
 #include "blk.h"
 #include "blk-crypto-internal.h"
 
+#define PR_KEYS_MAX_NUM		(1u << 16)
+
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
@@ -442,11 +444,12 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	if (copy_from_user(&read_keys, arg, sizeof(read_keys)))
 		return -EFAULT;
 
-	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
-	if (keys_info_len == SIZE_MAX)
+	if (read_keys.num_keys > PR_KEYS_MAX_NUM)
 		return -EINVAL;
 
-	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
+	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
+
+	keys_info = kvzalloc(keys_info_len, GFP_KERNEL);
 	if (!keys_info)
 		return -ENOMEM;
 
@@ -473,7 +476,7 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	if (copy_to_user(arg, &read_keys, sizeof(read_keys)))
 		ret = -EFAULT;
 out:
-	kfree(keys_info);
+	kvfree(keys_info);
 	return ret;
 }
 
-- 
2.43.0

