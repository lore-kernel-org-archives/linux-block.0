Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3896367F2E
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027298; cv=none; b=t12CCIgy0XUh488wSZMyM/GshzrbAiyd/81tvqNXrCaqUsefq6dRlKFA1kmIDQeuHbfBT/MxXoBFxzzS63kDZVIbVCQnowj+rrKtok7zNvNxrfbZmUzMdsdVm5hJM8IB5JEjRW06R64Wf0dXJlckCAE6/qrUqigFopRDnozQIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027298; c=relaxed/simple;
	bh=gCSx/V1b5hLJjAWTZB2yinby6cEc3cFljEu2YporLT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0k30lmZtGGPdO8y/cj7V0IaV+lk10y3JdENbbUxNQsdG5vIW+tWC5U7poVlc+R9HkX2xhfWFD7EODyl/6BbCWW5PR4oUwvJoThZetFRGLkbk07fIA/duRRiQxu1WMHrpDgwV3ygWX7IKfqsUQvHlpYm2eJQcwOT/h0GDjLBv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mDzZaFCs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mDzZaFCs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5haYVEko01fKYPVxDDJW1I5T6YH6AjjjomlRPFtsTO4=;
	b=mDzZaFCsBRK6KCw/FeSZaHBOjgziFomIUnF0ejwLDtInkkAkhr4zvSb86M1ANzbGG7PkwU
	t4p/1JDLCNy39aJJEwlIXcAT+tI6Yb633jROPMTE8muOE9FOYmqjwt5wAIXb1Ewex5Axs+
	T3mdaVcLO7ygP32pQDG2SeoXBTojhb8=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 01/10] block: convert to sysfs_emit() in blk_ia_range show()
Date: Wed,  1 Apr 2026 15:07:07 +0800
Message-ID: <20260401070716.991-2-liu.yun@linux.dev>
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

Use sysfs_emit() instead of sprintf() per the sysfs output guidelines.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-ia-ranges.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index d479f5481b66..94f4795da7c9 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -15,14 +15,14 @@ static ssize_t
 blk_ia_range_sector_show(struct blk_independent_access_range *iar,
 			 char *buf)
 {
-	return sprintf(buf, "%llu\n", iar->sector);
+	return sysfs_emit(buf, "%llu\n", iar->sector);
 }
 
 static ssize_t
 blk_ia_range_nr_sectors_show(struct blk_independent_access_range *iar,
 			     char *buf)
 {
-	return sprintf(buf, "%llu\n", iar->nr_sectors);
+	return sysfs_emit(buf, "%llu\n", iar->nr_sectors);
 }
 
 struct blk_ia_range_sysfs_entry {
-- 
2.51.1

