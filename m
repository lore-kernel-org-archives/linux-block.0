Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FD37266D
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027310; cv=none; b=Msmo315o7m/vKA7/lZzx8QUoY0K99K5519lPEdP2c0WfK51JNxCo6QqNUkHZDtTaW+CG5QUUeCxhqWzxehfAV0CF25IWPuJmCn2YiBzpuNmyoBUrKOPnfbs/bE98324By2nwHf1MAAcb2h73E0vDuSOQGEbzSEEsew+nTtiSku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027310; c=relaxed/simple;
	bh=6od36+OMQnUO4/0BygQNuBsxUKQyYXsSJeC0Bx0haP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=darxT1TkZ5QjNubZ5+w/1e9t3z4nVjrVrllNrZNNs8P88GALVrQnViSeJYOw0fsGshnkldgXDQD7khmrg+77fo7PaM/G9ANsUPd9uLMorXyiKhQ3kp2/8Zzd118Cx/mBb0YIFrilWj/2lqfHccoZNECdYIPNM5wth2sFvtxIrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixSurqp7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixSurqp7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPvAoKEDfYOw3yY3dYFftQ3BdwnQ+Au8YNJldJOy30=;
	b=ixSurqp7eOGk5TlvIdcNbotH+DnB5GHlc6lKATsf/Foz39USAVhWqq1kbW2UnJ17xkznHs
	IQ464kGlBdRAv35LKKhfWctohCNPqRzmEO+i2jfCSVX0D9VBI+Q836W+pi8RDhzMnnCGFR
	nS9bsxiSxwxKF+OOdRRHZWuHjvA8PZ0=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 09/10] block: replace simple_strtoul() with kstrtoint() in part_timeout_store()
Date: Wed,  1 Apr 2026 15:07:15 +0800
Message-ID: <20260401070716.991-10-liu.yun@linux.dev>
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

simple_strtoul() is deprecated. Switch to kstrtoint() which also
removes the need for the const-discarding cast and the if (count)
wrapper.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-timeout.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index eab6422fad4b..ea3c5451d6cf 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -49,18 +49,16 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
 	struct gendisk *disk = dev_to_disk(dev);
+	struct request_queue *q = disk->queue;
 	int val;
 
-	if (count) {
-		struct request_queue *q = disk->queue;
-		char *p = (char *) buf;
+	if (kstrtoint(buf, 10, &val))
+		return -EINVAL;
 
-		val = simple_strtoul(p, &p, 10);
-		if (val)
-			blk_queue_flag_set(QUEUE_FLAG_FAIL_IO, q);
-		else
-			blk_queue_flag_clear(QUEUE_FLAG_FAIL_IO, q);
-	}
+	if (val)
+		blk_queue_flag_set(QUEUE_FLAG_FAIL_IO, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_FAIL_IO, q);
 
 	return count;
 }
-- 
2.51.1

