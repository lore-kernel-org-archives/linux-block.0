Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9222D785;
	Wed, 19 Nov 2025 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525637; cv=none; b=o9QSnIIKt38sMxSzRAe4+7ODibuvl+TpMpramj70a4OJN+iK2RNyWElOX4jwgk5bof0sqYA+VxttUakZs9CSO2ZSNhyUBGWfmNGV7LGk9ACVd4VEbGxTe/QtdYP2Owuoc5/X2XobcB/ne+++Y+8FxGXUxCzJMsyysSgn+A7PYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525637; c=relaxed/simple;
	bh=OFI9dhUujVeLOK47qSIsWNy1UdLz2i5iiwC9COMbnRI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QkJYLJM4I3wNrhXpr5+tU1Xvxt1CQXT8EkUQRaQ6f3qSb0IouyD3ctfm6K5kRxVtPmdGpXMJwIuRwfGz5okG7qx90gzMNlFhufX2wEe/I+11lknVYKPnvm8WfWlybH101/YRSU5QWEqlzDX/cTwq9PmYjUamzuhANTtgL8z2QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=yfCwUj7v; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="yfCwUj7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763525630;
	bh=UeJqLPZDGzdEpayI7suMAMrtOsQOR+JKs4REoOpH2fc=;
	h=From:To:Cc:Subject:Date;
	b=yfCwUj7v0jjgcAuf3kN8Hlv3XeNmG69OdQNtqygXKOclgwYQCI3ByxTLKwIKT8+gC
	 NepEi/6guVEUP31z4rx4yPRfVwyR3qzlzl1I2E7XHuXoaOJjKx5T/a1ao6DZ1xQvdO
	 pLoVvMme2dQx6NVJxsIqezITJB5EDC9JkKj1tMCc=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 36F25C09; Wed, 19 Nov 2025 12:13:47 +0800
X-QQ-mid: xmsmtpt1763525627tjjwglk73
Message-ID: <tencent_5936CFE72BAB2BA76887BB69DCC1B5E67C05@qq.com>
X-QQ-XMAILINFO: MRb64KOzELYukeQckwkBal9dMl4t0BS+3Q/txMdjgF39/72XeChq29b1g+KMZ1
	 pp/Omm1+yBlsN8vTKxvqml9EBOXcEwiCSa+ZXAs5amhY4MfeCJhKRrCH/PFcH2SuWqMaSKi1ZZW8
	 G/Mp+XY8Iqyp8mUr+4LUVXtpklyuGlUOjSV7mluM5zjIlwE96Igz3gFUYAaZC+eA9eOIXcePGPR3
	 qhXmrxJi9ZER7PnXVRfrf27OMmUoolv04mEmAnSuntUrWMzsRrOcwNWO+SM3LkizQ+pChZO7gu1r
	 rmU6fp+wpMacezrcCUtaGuUt3ld1OC5+M5ZJ9vAZxBK8sQpnxnmx0a7FJO7Xndr9qnCW2b9KSP9C
	 FoyrrYfGi6httgijv3EZRrBfCmYbvN589BMqtlUMhIxnJof05R1Do4v97vPsQA5eGc93PWcgfltC
	 cu4nLEZCNU7MhWrREFo/uLrDuTmvJbTgRVDWC4ECEXUFrRmxRfp2HTTyczP/2VAY/9GWyx6kyBUc
	 jl+Zc67eo5ti+PRY6puXM/UJgdtXuTpsjjI+vop6Vd8TkoGxvd9LUc4LeCjy6gGzP3vYk5+RT/ng
	 4mGoMboXg2A25LL20y9XG20q/LGzHU2pFPdfJGmZ0MkoVBu7FkVRy0PmuFbuPsc6bjwrscVWz+gJ
	 BC4NdqGxj2lZ1M/FdDi4fUjkjVmzh+lWH9A4g89yEp7ZgBlZbgHSqLCDhqhtckaDFUub6zS+hsx9
	 djdJHVOnZ8zcrXr7dQh4BEVyu5+ZJi1xlucJczjsxnHp1adT/rqt06zupR+2Q5HVRy4eVrAPWb7Z
	 BPKCVyL5mx7zyZm9cvorySE5UtAP4zeAZD2dW1xNs6H/IpRS3R+dGJxiOZ9tiMQWdEmEnF7Y3PTJ
	 5Xi0+bbs8p/QnLe8ibs9ULDK7gW0ylXTxRUEeIuaP9efeHIZRZB6mVx0aO2exjYfCdJFLy4D0PWT
	 9hNUc/14biB0cPO08yeEywrRLVCrOLs7Tze9ozHPvnIPaA16FLjisEUKQLQYlU7ENS0G4x3a0sPB
	 Ydv72dbqeGZQblAOxY6HrJLQb37FrbVpWmp+jTUuuRcGCqxJAdozx1gMykq3XD1m9tvo3N20Xn3N
	 f+Mnlor95rttyD6EBfkOjf25ZBwtl8MsCTHiMn
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH v4] zram: Fix the issue that the write - back limits might overflow
Date: Wed, 19 Nov 2025 12:13:45 +0800
X-OQ-MSGID: <20251119041345.2875599-1-ywen.chen@foxmail.com>
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
Changes in v4:
  - Fix the code format issue.
Changes in v3:
  - Simplify the code using rounddown.
Changes in v2:
  - Rebase the patch to adapt to the latest version.

 drivers/block/zram/zram_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8a13729..fff9e45 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -579,6 +579,16 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	/*
+	 * When the page size is greater than 4KB, if bd_wb_limit is set to
+	 * a value that is not page - size aligned, it will cause value
+	 * wrapping. For example, when the page size is set to 16KB and
+	 * bd_wb_limit is set to 3, a single write - back operation will
+	 * cause bd_wb_limit to become -1. Even more terrifying is that
+	 * bd_wb_limit is an unsigned number.
+	 */
+	val = rounddown(val, PAGE_SIZE / 4096);
+
 	down_write(&zram->init_lock);
 	zram->bd_wb_limit = val;
 	up_write(&zram->init_lock);
-- 
2.34.1

