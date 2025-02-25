Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD4268689
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495476; cv=none; b=NTaCfyUiNJD9DO8EtVwuZRoK0m+ssxJWLuWOg7p2ukJvlTkRrElf4PEdHD98lMA2OAi9r3rZTiWw12pEKnCjhIllHr/emRPcl+XFthWw13EcVCXA0aFU7p9rxMGxs+uVoYRuB7S5LuxuO+smynQAv+n49BwGOMnLxN8IKlWcs/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495476; c=relaxed/simple;
	bh=DW8qA8OYk1lm43MiyiBJXjuc+q7dVnsUDxOpdKHfBT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfuXawXgUa1RfuoeiuFnNEJ+JfaVTYEx7Z2i3GE3J3yFUW4RfwEkjhvJiWPwrNS53JkkjSsLbz/YkChhWusRTfUJmuK7mzIik9mqxegj+WcmvsBpUCI+5NIm+vtMSpBrMnkPTK75cAzgt+PoQDs6tIxPQa7M2WAwwhvWYSqqGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EkLRAWEY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EkLRAWEY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740495471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5iXoLOO6lSd38TzsAagwXsaqQBnHy7b5Ch1GMIuNZX0=;
	b=EkLRAWEYyXVldjUJoyEJ5OJVSWN0P11D3rt0S6k9XfTdHppt0Qu0lwZwfoaFBkYaJuTNDV
	GXwCCP3RXhcJyjsh++OSwojl53OILR8BAWvJ8kG939CJ5Ge6RvjufhPyQSLQLaXS+jIZ79
	Gu2C1pXItho8pqOmwplSnoKc1Eh9lZg=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] loop: Remove already included header files
Date: Tue, 25 Feb 2025 15:57:42 +0100
Message-Id: <20250225145742.186882-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The header files uaccess.h, slab.h, swap.h, spinlock.h have
already been included in other header files. So remove it.

No functional changes.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/loop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c05fe27a96b6..ec232c1d260a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -14,8 +14,6 @@
 #include <linux/wait.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
-#include <linux/swap.h>
-#include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/suspend.h>
 #include <linux/freezer.h>
@@ -32,9 +30,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
-#include <linux/uaccess.h>
 #include <linux/blk-mq.h>
-#include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
-- 
2.34.1
