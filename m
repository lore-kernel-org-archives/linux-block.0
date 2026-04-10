Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E15E555
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824954; cv=none; b=QHqKLxyONAPeuwuQvKpltia/+B4dtlN86fQIJlvu+0AJuSyewfDe1TlD3VfHaafNl4H1TB/Yy2/F6izRHsW3HnwuaW5hEDeSZBAp4ZfA7ySQpGX+r+u/OGlrW+yxg5OW5p/CgXo4JZtLg7NdCxbE4sUUBetl5NP2d2g9GV1ecec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824954; c=relaxed/simple;
	bh=UTyHKOuusMq4k+FNHSOf4kASbGK3wQs+Ko3IrdoNxpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifYa+3JzRU/WZyAsgC/w9JKLG7XvkL5fNol9xhYUMs+m9S8we4ST9qBoJVy/+lTX1H8uEcT2yrh6hddY0AG2UfwqH3/a4973MNyTY+OOtRbM/fuVgN6gaTd3FifWqDM4114+NQcTzdHu7bDF0CjY3U1+OKJTFh0/eZIsV5Gkmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sH6XDwS6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH6XDwS6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b23f90f53aso19015625ad.0
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775824953; x=1776429753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWlcZvqYtzU9DiqMTk4lZbm13QrcUUU0RBNG3R0kzUc=;
        b=sH6XDwS6JFVAZo6yy5kcZaO/7JOXLXi3quUyn5uMoHTBtluAhwQ9/x5EbDdQHovzIC
         +6jFSb+jKGJHFmVBeuGXoANmd6jJa7KdNuzm3/qf3cEMnPyhnQlXMfxPHFCgA7ZIcOTn
         3YXqlNJ5pqDj9amMyAwxKHE+6epSj/D7zXuwcMhhZTweI+aSlfQ/8IN1P+R7ikv9/IUG
         in8pikVlENscVXFzSSk41wefEn66sJznSIEGK9nHQ9sUmAn+nAJ59qZqBQQpSRWCR0HJ
         NVaSYqvC3fmxjaWvt6OnncsxCPVIYZd7G4eyhFBpVuOCQTJZNwIUocqjEEk+yrgCKphI
         C1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824953; x=1776429753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWlcZvqYtzU9DiqMTk4lZbm13QrcUUU0RBNG3R0kzUc=;
        b=EvW/KbsLdwdITgj2DOvpfMJfyyQtgQI3Wp6vsEJJQCnUqvlgFdqMeuGs5+qXIOURUo
         TMxnYVK1gI1Gs7BB/YleNnlAMwD5t9L4PjU773yl89SW2CYoe1blRYdnSSyhHg+bSKIO
         zxZjVnsNVh9Yix6wtaBAT4CDo74ngnoyFHINv3xVEQt9B34SVOtu7qkupHyATZ1jFDjD
         MAknlQ08SV+HQyLA70xuIbEUkV/EDEGtQ6T2USRFkIWb0s8d68hXQGzVsQxEQM/7zMIl
         Y9smJHJ8qRR5XnK7uRVG5tXQ1u/HvBZtQDhxZiK2scqUABjhTFvp/u6E2DqYsBFVhYbC
         ZJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWffvUF7AOa47QMgwrOfMVkiNf/5rVk2P3s+F3eTqb8WVqPJgK7NsAZ0tRq8XpqnCI5xVZ1rK69EA4kPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvw/YXn8VZetcY5M5JUOV+ZZRS/vaNkN/vQyuus/s4gDMCQbz7
	xZFkOyyiLTqDU+gjZ4+nEudAX06NNRYuBteMljGr4Ci5d+yop8Maa5bA80XpgXd2V4w=
X-Gm-Gg: AeBDieswf8HPmnda2bxCU+PGRqN3kZndOki3DYXjy1j/Y/PZiX1wSX2Iix47QL2kHB+
	i3bv36IwKtGiqBh9ez7PZGPou5ODFXyKI7c13GHjgA4gOtmQfyXmuTkperCk4WwBdAvOOuWX07H
	OVyViU3Kpw9QLgNeGa262OIfYXqoVs38flU2i+/cAYre6OU29u7G0wojZ6ezwhCUiyMVkUCjf2p
	sGamN/vB9hyve0gkobnL+LsicI0uQSqoS2hWzFZ+V7ePyU7uyRGfl38LwIrlVbpjSxTOR+qGeac
	sXhG8Sou9j/y7JpS0gH4GdWHiX50AzNpJ1/1/GwVZtR6z6/4w+xE9KlKbKRWfZ5+RRqx43a7+e9
	se4C5RTcHH7gKnjo9VZ2znEcbQwiAqkB0kJTmkKhdTZRYA0xwuv2iIgfBUZptdZzb8MO8/uNwLz
	LRBmURdiYhd9c6ALfydaro91dOLa1ETpIJcm3ytCLOA3nAiQfcKZcP
X-Received: by 2002:a17:903:4b46:b0:2b0:6f21:8289 with SMTP id d9443c01a7336-2b2d5a45fe2mr34440875ad.25.1775824952798;
        Fri, 10 Apr 2026 05:42:32 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f4e609sm29053235ad.84.2026.04.10.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 05:42:32 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ublk: fix tautological comparison warning in ublk_ctrl_reg_buf
Date: Fri, 10 Apr 2026 20:41:36 +0800
Message-ID: <20260410124136.3983429-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit architectures, 'unsigned long size' can never exceed
UBLK_SHMEM_BUF_SIZE_MAX (1ULL << 32), causing a tautological
comparison warning. Validate buf_reg.len (__u64) directly before
using it, and consolidate all input validation into a single check.

Also remove the unnecessary local variables 'addr' and 'size' since
buf_reg.addr and buf_reg.len can be used directly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604101952.3NOzqnu9-lkp@intel.com/
Fixes: 23b3b6f0b584 ("ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 247c1ce8ce8a..49fb584e392b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5330,7 +5330,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 {
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_shmem_buf_reg buf_reg;
-	unsigned long addr, size, nr_pages;
+	unsigned long nr_pages;
 	struct page **pages = NULL;
 	unsigned int gup_flags;
 	unsigned int memflags;
@@ -5352,14 +5352,12 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	if (buf_reg.reserved)
 		return -EINVAL;
 
-	addr = buf_reg.addr;
-	size = buf_reg.len;
-	nr_pages = size >> PAGE_SHIFT;
-
-	if (!size || size > UBLK_SHMEM_BUF_SIZE_MAX ||
-	    !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
+	if (!buf_reg.len || buf_reg.len > UBLK_SHMEM_BUF_SIZE_MAX ||
+	    !PAGE_ALIGNED(buf_reg.len) || !PAGE_ALIGNED(buf_reg.addr))
 		return -EINVAL;
 
+	nr_pages = buf_reg.len >> PAGE_SHIFT;
+
 	/* Pin pages before any locks (may sleep) */
 	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
@@ -5369,7 +5367,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
 		gup_flags |= FOLL_WRITE;
 
-	pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, pages);
+	pinned = pin_user_pages_fast(buf_reg.addr, nr_pages, gup_flags, pages);
 	if (pinned < 0) {
 		ret = pinned;
 		goto err_free_pages;
-- 
2.53.0

