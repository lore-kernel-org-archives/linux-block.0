Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81F36606C
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027311; cv=none; b=CTVp9dTZBCcinYkdvFUjX+1aZkAP+s7SUyiZPInJ4nMUCJAo2WLA87i64xUrJMCrwHYd477W7nWV3bM2CPkmnw8N+SMyLEBnA7M1ZfBWEgfItUqbw8xfT93xGGkGrUN6cxPUkQAZUHfY1flJoRwzWI/wqea6ad27uNEvRnzuIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027311; c=relaxed/simple;
	bh=aIR1i1AhI8IM3hXxRsNKk3nQwxdaSOXWhn6SjAjkYEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbGQ+tez3gBXkfi6n3k1uT0uOeBN+qVSSYIU+SrgxT2tf3J/lhRkpZ+MqiN4Be49cnAqTjFITm2p5c0uZ5hxP324uFBwDnfPOfHaANjM2ZJifUQMf1eFQx+bS5k7rof7dXL4K0E2IY6hKjPDOdOD44iEOspq2bfUBNTjRBsUw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uxKq/L/z; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uxKq/L/z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqGCUphJZZQdjRwVT5rPciyI7UC6eXwjE2s2m4B+2ms=;
	b=uxKq/L/zf5tZKcddwYF30E8relBCbT0lccwzkbI5JxQwNf63EX9Wpex0jnDAB/0KGXrur/
	XTfDO5pfaSuc9c1ZTEXIXUq8MrvrZgSR/UEaKK3nrJ4OesLs3GbZyOPpbKVDzx/drlY33h
	eREqDJR9wsQt7R9afqFnxp8lFrzwIEQ=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 10/10] block: replace sscanf() with kstrtoint() in part_fail_store()
Date: Wed,  1 Apr 2026 15:07:16 +0800
Message-ID: <20260401070716.991-11-liu.yun@linux.dev>
In-Reply-To: <20260401070716.991-1-liu.yun@linux.dev>
References: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

sscanf() is overly lenient for parsing a single integer from sysfs.
Use kstrtoint() which also properly rejects malformed input and
makes the count > 0 guard unnecessary.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/genhd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e9..369bd8c13bbf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1186,14 +1186,16 @@ ssize_t part_fail_store(struct device *dev,
 			struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	int i;
+	int val;
+
+	if (kstrtoint(buf, 10, &val))
+		return -EINVAL;
+
+	if (val)
+		bdev_set_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
+	else
+		bdev_clear_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
 
-	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
-		if (i)
-			bdev_set_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
-		else
-			bdev_clear_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
-	}
 	return count;
 }
 
-- 
2.51.1

