Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05561DDA18;
	Wed, 19 Nov 2025 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525003; cv=none; b=b4ndOsE9I6RpAZDv8OfqfXXtEXcEemyz76zsWvZoMzQXAvhxfKHAfCP5EB777hkURmC/ro5HzebxWcNhUsrcnt/8JSRLIC9Q3/qrUGgm0xlj3ZgJYWN4N70Zvib19/PKO9NHL3HwK4Lk/zcdQcyzjp93uWNjgtOm8kmTMihZ/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525003; c=relaxed/simple;
	bh=2hyBoNxdPjO+Gfy+OAIv0Y9z7Lat0rLvI0ytCPwTBXs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=P6EViNH0VzGuatQLt1VgAJbf5QLfqH8T5bgEDJ/MA/fT8/ZG1gH/T/yKaycOGWmOFik8nUlp8dD7DEdGCpgn712p+JGMZZpDPqB1FfgHvLj3RBvdBhJX7d6iK8BYQR6VGNaUC3zoo+XmnJnGYCP9VxYCEWscPlvNHQI17kVkr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tuEtA5or; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tuEtA5or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763524992;
	bh=bclAGtoqR+J0YE9UMEx2BjcAWkKekT/9z3C0zxu6rZw=;
	h=From:To:Cc:Subject:Date;
	b=tuEtA5orA5chhjbDV5Mb8R7XzKQ8tbdMInsd+SqBPFKpffDr3a/RylzwoclEr1mKM
	 eSxbU9CHsUbusP1jRz3WpuEJ8xdnEUW2pyL/EjbBbqjRoJzX1uQcqOPS9Po5i4JQo3
	 4D0Q9YHpaNDKJh88+rzi+l6HNYr/wTY4UHaiRxBw=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7A90C4E; Wed, 19 Nov 2025 12:01:58 +0800
X-QQ-mid: xmsmtpt1763524918tauejn0qo
Message-ID: <tencent_C9BC3F2FE38BB1EBA44887FB683CD195E705@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPQ7mS3fQDG9QXuXn4UBK3U90mB/MBj5VcXJfrwIDftjdrBAmoBU
	 7DXQ9tyKAwZ/vpBRawP0M50nDRmtpS198FtoE954fjT/3n0kmUY+ABEpSbsJWuBzdPwFxAWQQTq/
	 Li1fPQyFks5gTAcJ2i/o3ThHi3vkJ3HzNOW6lzY4K1MrY65e6ZhAPU6l+Y/WCA6Nwc9rn7l7Ueg9
	 O5x6UJXwI+xCDR7pSL1wfzjkDtbx1Cv3rCBDBaebELxUMz4WA+sMdfKniMcVtPb9PfEBLct0t9ST
	 eXaoxw/kUamLg7zRrvOiGbcUj7VJvG0Xj/fNNEIss3+MCCnt7T/2tUd9K3fHvM89V8m7AjsyhC9X
	 vHz8mLvKMa0rVeldZpQD1947x9MRmJvGXKaR0vKPivWRMUqiP5tv/Rf5KlwOz1IQSItfje5oxhHc
	 cMnELoAWwMZQtGdejQqUYOC/UWod4tDgco9JL0G4g7Wpcwe6VEjyox+tFOj0Nk9fCRBNoZfiu+Cp
	 oHDPwHPmUrUcPh6f4O+yxGfeYsfhTt/gZv+fnyX+6TsLoBIznUiAyByZDdYhTW9P/sfPgLwGz+eM
	 eY6BxVhBbao2jDMWbg9RKWCj8BN2ML/pH1sKC/N76Sjl6qFkXlo3ucbHs8l+NwPGwTWBfnvV3k/s
	 qzALgSeTR099jfZ4Ynd+Yw4tWLYz5ixR4BQqvTbJUvYt6Y2t7g9rw5jUlV14S8fesSoJGvtZLR4T
	 A1/GGS05Fby55IMBMq7DR0ru9w028yiCcU7cxIwR1vzurRJ3xEhSAlK+rHJBnnzbD3XrCtrHoT0u
	 z57Erhk8b1sULPi1bNYANHchfWQOBn9l+UmxFJtk9AlyKqtApI0JKOYMc8x7Uv/Ya1E0M1dhw2jo
	 Aq/uYL7J1NESwEg7sUGgr9yUOYXqOxX/k9UNfFqvdvkJ/xNKrvMlpj2L3U4RCa6v4hhbg8mGWScF
	 FSdBj5Nb2GO/DOmtatIYO+/GS4Cy0Qe/MxNDHfUpEY6oN2dW2b3+SBmd+n8JIDnFEqRJobNOp72A
	 57Df3bZR5sOMftnbSJc+rwTCcHquYU5uH6Tz/VDJ47FS69BFI3
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: akpm@linux-foundation.org,
	senozhatsky@chromium.org,
	minchan@kernel.org
Cc: bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: [PATCH v3] zram: Fix the issue that the write - back limits might overflow
Date: Wed, 19 Nov 2025 12:01:57 +0800
X-OQ-MSGID: <20251119040157.2874911-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the page size exceeds 4KB, if bd_wb_limit is set to a value
that is not aligned with the page size, it will cause a numerical
wrap-around issue for bd_wb_limit. For example, when the page
size is set to 16KB and bd_wb_limit is set to 3, after one
write-back operation, the value of bd_wb_limit will become -1.
More seriously, since bd_wb_limit is an unsigned number, its
value may become as large as 2^64 - 1.

The core reason for this problem is that the unit of bd_wb_limit
is 4KB. For example, when a write-back occurs on a system with a
page size of 16KB, 4 needs to be subtracted from bd_wb_limit.
This operation takes place in the zram_account_writeback_submit
function.

This patch fixes the issue by limiting bd_wb_limit to be an
integer multiple of PAGE_SIZE / 4096.

Fixes: 1d69a3f8ae77e ("zram: idle writeback fixes and cleanup")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
Changes in v3:
  - Simplify the code using rounddown.
Changes in v2:
  - Rebase the patch to adapt to the latest version.

 drivers/block/zram/zram_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8a13729..681f4ff 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -579,6 +579,16 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	/*
+         * When the page size is greater than 4KB, if bd_wb_limit is set to
+         * a value that is not page - size aligned, it will cause value
+         * wrapping. For example, when the page size is set to 16KB and
+         * bd_wb_limit is set to 3, a single write - back operation will
+         * cause bd_wb_limit to become -1. Even more terrifying is that
+         * bd_wb_limit is an unsigned number.
+         */
+	val = rounddown(val, PAGE_SIZE / 4096);
+
 	down_write(&zram->init_lock);
 	zram->bd_wb_limit = val;
 	up_write(&zram->init_lock);
-- 
2.34.1

