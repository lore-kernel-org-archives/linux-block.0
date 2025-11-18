Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF7302152;
	Tue, 18 Nov 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451652; cv=none; b=qHqaraKNi6IsBknujrH52xqFLilKfoBRIPLW03tmSrMCamQ3HjGxRs3qwMtXe/KVFtj4/uaMYgyjZbbO8TVN0WFlOFzsiwKH4lnJNlFeiWsw5R9iiUz89s1fM/0CViHkHSQgyxlYi/VUlzT3m4XOS+/KqyvwuQhRPCNvOpot8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451652; c=relaxed/simple;
	bh=zuw2EycyMzgBaGUcdOzL4LPB0kUmhCIvmtXsD/bqfU8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tuizWzWnAptOhJnpu6NqdPLJXS/tr9+LzuooJpsMgkHtDkv6/Y8+Ae8qiO7NAxtC5HkoTig4M2cTLBmT1H3Ca1izqzSrsxNfXHFWSuDaJJc4ZclTL0pVzdcnWkA0ONL/tGBxUPVCh3w1YIb2yztBrtDwhb8goG4KT9FzAZljOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iIPSXVEb; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iIPSXVEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763451636;
	bh=XWMqYs+z3GskzzvBmrAKmgnDeWF6hjh2FG2MoalbIJg=;
	h=From:To:Cc:Subject:Date;
	b=iIPSXVEbiyfvH8dmUk+t6QIXfERnqWAuVoBbnEtK2STzJW5/lDxcAfHc7gV9R9I2S
	 tO1TZjCa97n0tMF9iIWCwytHEbupLJdvUFIZB/WrOQj2FSK5dnoDkEQSiwRgnoFA52
	 Ys6LBeyDdguzrTmeITlEevXbwA1FqlkQznvao2CQ=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 9D70BEA7; Tue, 18 Nov 2025 15:39:23 +0800
X-QQ-mid: xmsmtpt1763451563tvholq72r
Message-ID: <tencent_80150170978D13BAF69D63E57D7F5175F90A@qq.com>
X-QQ-XMAILINFO: Mm8VRyTxzGuAnIMbGpNB7YBJ6dXu8LFvRutC8PX9BL3PSBhQH4wdwNunsZI3EP
	 bQkNBRKBPqJJlTFTJcA0as5jZo7oDGTEdrUohfeVK+cSxg2owbLY2cChKVp94vYeD0exw+sF9Kzd
	 9XoI15/6sa6NTCIghJ7NdmWKNCDsYcQEXjyqZRbFZYKORi/rQs5KQSOU8rkvE31korAOY6fIRNiZ
	 4fBsILKOPumNqFaEDef7qTpwQnUfEE8Ijke+gKlZnxijXkoroasehfSPok3vVdt2jAHAfON5Svfq
	 FyHHHie4iBx8QhNbMJQU80rSWrb45/gB1TTAlWqPIcchztB3ziLEhCLDJLBCH6r7mQX3PKmhFySA
	 50LGgZTSuqocsP/0SaLIrQAq3kAzsCmnO2yGuWIk8QHTEPlSNPWhApDgnUBYuOGaYD0o22Gk9Dnq
	 rTYP2riH0MmHQQ2t/l2j01D/7i15i4gTSn65UW3lsMjPHLttExUJwUzCMtQ8ORG/UGT3ZBpMa/zX
	 0uWuD3J70fBPWrOCFjlsmqubMdRdGE6jePsAT2gisWE0UC6KW0fFcttcl7KTPPgEFzh1PZ6nK6wv
	 Ad8snX4pZ1PqyIsP0bYvTUxMUszmcDJQPCndRzI44WP17LT25f/ycnntj07GX/QPXijKJLmTDd6d
	 iO/HdFq64xUkbWBHCFlxCPr2do9b19pJEvdW8HS69VRC0xM4eExn5vb5VCAzHtAlcnsBD6qw1FX5
	 1L1Er1LP6ixXY2JupnbhsKSZ2V9U2z32BGtnAAuVn68yx4NKGjDWYZJujZLBDEMfDOU64dXkQ/Fp
	 OWLSp+KyuFo4sfyOQ5FQ4wqfZkoMEjeXNTckWLFMu0EiNf7w2jCqwQIKL9FyDHm1qiHgd13Rp9S+
	 KejGJO//dxS3gWvVmthS5tcFjXcGA1X8FUOF1pe6rzC+CxNvddYMG1kb37JrVbcT+K6qSk0IiyMD
	 FRK91ij7sVzwQIrnnK+HarYRxQi1ul2ntYyGyD2DT+BcYMqYART9e7XHn7ko4vmx+8FlA1vSPJWy
	 jYKzVQnU+Igkzhs+5EAAxZ7YdaKL9Sy+vlpsF2utQh8hxzxCovRPCnXRrkbL4poo1YTu9mGsOzEr
	 +P9CCh1GD6lZT8bzVOxbMeMvVgX1TwSoGNypMw+pk/Rwy0k38j2TDQmkuJ5Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: [PATCH] zram: Fix the issue that the write - back limits might overflow
Date: Tue, 18 Nov 2025 15:39:20 +0800
X-OQ-MSGID: <20251118073920.2807954-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the value of bd_wb_limit is an unsigned number, when the
page size is larger than 4 KB, it may cause an out-of-bounds situation.

This patch fixes the issue by limiting bd_wb_limit to be an
integer multiple of PAGE_SIZE / 4096.

Fixes: 1d69a3f8ae77e ("zram: idle writeback fixes and cleanup")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4f2824a..4ecf2e7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -562,6 +562,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	val = val & (~((1UL << (PAGE_SHIFT - 12)) - 1));
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
-- 
2.34.1

