Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6A368964
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027304; cv=none; b=m6nrvDJtKjVBgxi7ewg7NNW5h3qYYIwlaGb2vJlCjLi48p2uPHWGXwnm6tUuNnfHcmU9gr1yuSY8Q7quNTqrifz8xYuuli67VHDNdPyv3SVAAVv3nXhl1Lywlg356E31c1FfySbU/Q0GsTV2xnVdtfVVrjthPLyIe+OzRDPRmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027304; c=relaxed/simple;
	bh=WSlqfKozkUvSSLQ15CDaQRBCaUX0ngfNJU9PujfwVp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQHrs51Vcyox+hwmyessFZkR8k0XPEJdzXQQGzQ+UETaJzB6wPqOJa7TGyYu1Mc1tJBFQvwB2zIsODkKUC1tyVQEJUdjSQZw7f0ml5CcI4nqmNquL1wetnG75LhivMtfAOW4//IAuyF6vZBHRV804Kjyqd/wYJJo1zKzwtEMJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lG1LjQBD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lG1LjQBD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmOb+rpY870wXTMLko0pOc8C+Wb/CDJcwyxrTfGgmJo=;
	b=lG1LjQBDvbRtZcvKqObtLgpOxYnKEs+hbAaXRSmDjf2CnRbDsJVh/hkKeyo120eUyCvWyO
	FmCs3l8/ozuW7m48Stfe1OGJSMzL+9hwcPkrYK8tFqcLS2BG6x7un+o36T0uYeL6L5306X
	xU/RKUogC7Jf7UBNQcvWpDnbAZsR9SQ=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 05/10] block: convert part_timeout_show() to sysfs_emit()
Date: Wed,  1 Apr 2026 15:07:11 +0800
Message-ID: <20260401070716.991-6-liu.yun@linux.dev>
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

Use sysfs_emit() instead of sprintf() for the fail_io timeout
sysfs show function.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de0417fc1..eab6422fad4b 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -42,7 +42,7 @@ ssize_t part_timeout_show(struct device *dev, struct device_attribute *attr,
 	struct gendisk *disk = dev_to_disk(dev);
 	int set = test_bit(QUEUE_FLAG_FAIL_IO, &disk->queue->queue_flags);
 
-	return sprintf(buf, "%d\n", set != 0);
+	return sysfs_emit(buf, "%d\n", set != 0);
 }
 
 ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
-- 
2.51.1

