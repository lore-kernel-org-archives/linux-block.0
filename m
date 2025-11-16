Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AC1DB125
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263265; cv=none; b=a+6PY39LkFFi+Nd7qBUJaTQ9AY4dE46YZONkoLw4mOtiUb/v0jwfWY06b/GASMUlwU4haklY+JctbamDAdimlixwaT9j4bf76BuRnDl2XMJvDH2l2rCO7kf3WVi+9aHZB9K+8YGM/lp0JMRnHP6bfbAgJllIZy3Q7A1KPvS42Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263265; c=relaxed/simple;
	bh=hh1bIV/4NJvdi+LJD71lmjTfw9FGPr7RlXla8j+ZY4U=;
	h=Message-Id:Cc:Subject:Date:Mime-Version:To:Content-Type:From; b=GMZ2KkSmdD0+pSj+DK7eY8GuSQvEA9pzeRw1IxQq+UpL3igJ3pckt8+OSKTTHT5udI2M1wRshSC3/WOvzXChT+Jio7sAI9jcVgIhEgLY70GkXj4kw1l2nT2xwywK/P4BwbbWij0bDapenOar50yDtOxnNdbrQpbvQu+d4lSx5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=j2Suhsat; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="j2Suhsat"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263257;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kiWLPRK//gF7CQNeGuB/NkfObgOVqylMsxLOgKSLaj4=;
 b=j2SuhsatndCKkAXZIVHmdCB1kqfG38Z1VCFda0GFII9epBs8ZC3JoaBqkz5ilpjoS62lFO
 gs05Rq2ORlPU+s2O70gghpWyNc+5/F3RJ+TKuqkBoBbYLKy3/26ROdsPBOxAplbSqUnxW2
 SZs/HgozO6ijVCWoMHwpd2DvDKsm/a4C6AyCctJxxKIya8FbXwdqiIjOi8v8WVvX0Atw96
 rvSOK0VSewvD3Hz/ncByaL5ad5tqwhHizq2c2QhWXrpt05VZT1FID/Ez8gunnEtpGh7d6e
 G5upv99dQEn5Cyt3S4Qtz53Ov4zKk7uB6HCiB0TxEivZQ9zwqeNlOPmbSqnhng==
Message-Id: <20251116032044.118664-2-yukuai@fnnas.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269194318+ea4df6+vger.kernel.org+yukuai@fnnas.com>
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
Subject: [PATCH RESEND v4 1/7] block: convert nr_requests to unsigned int
Date: Sun, 16 Nov 2025 11:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:20:55 +0800
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
From: "Yu Kuai" <yukuai@fnnas.com>

This value represents the number of requests for elevator tags, or drivers
tags if elevator is none. The max value for elevator tags is 2048, and
in drivers at most 16 bits is used for tag.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2fff8a80dbd2..bedcaa59feec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -551,7 +551,7 @@ struct request_queue {
 	/*
 	 * queue settings
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned int		nr_requests;	/* Max # of requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0
