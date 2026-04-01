Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B8316192
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027299; cv=none; b=HAWzYN+IuZARm7d9jgX7LI1fXrb/T7mgDxBwwSdcLOAfN5nDF0bsjOMF1Z7MZQdya22Qc14hdteUfLQlk6hBoQ0uXs1nsAts3B3GKzX00ImCbw0riASCcjgB3KHwDx5xqSmZbtURdFekU36Zgy4fnI38KtkAVmghBtU97/xS+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027299; c=relaxed/simple;
	bh=FmsgOzA4Ov+ILlrhkIUoX+wjLojdSovaUyLX4i8WvRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idzUqp7p0nhJlURBVCTINyJ/EB4fheQSvXzVbXrFvskQY7t4B35vhvo4WDa3s2rrJEB3Frr2da59B1bsCZa3bIrPkmZQKOCbPtMXLiyAnbpYO68uIYuzYKi/pb3v9vXW4ZvyquQ0OGvqKrwSx+wm599Z3F8A2vefnQsHNwXKCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GeQjp5MR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GeQjp5MR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/IfrVmUQwn9qMTANWSGsDCsmzVXbV+YoQ0w+FCjA5A=;
	b=GeQjp5MRrhxfr74pWPgtq9c1yUvcp7lSagN0f5jgbayGfpdfjFMcJV53XY0QiTxdk/z203
	Yp3LmNGBdhuo+Up97bF7juzGzVqBC1OEwurXTmwqk+AleSID+ulUP61ZznKdHMAisGgpMy
	HdYz/Z73wTQGdw8XLsHlUp2ou/Hv0jM=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 02/10] block: convert blk-mq hw sysfs show to sysfs_emit/sysfs_emit_at
Date: Wed,  1 Apr 2026 15:07:08 +0800
Message-ID: <20260401070716.991-3-liu.yun@linux.dev>
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

Use sysfs_emit() for nr_tags and nr_reserved_tags, and convert
cpus_show to use sysfs_emit_at() which also drops the manual
PAGE_SIZE tracking.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-mq-sysfs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 58ec293373c6..ed9546de7466 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -69,36 +69,37 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
 					    char *page)
 {
-	return sprintf(page, "%u\n", hctx->tags->nr_tags);
+	return sysfs_emit(page, "%u\n", hctx->tags->nr_tags);
 }
 
 static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
 						     char *page)
 {
-	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
+	return sysfs_emit(page, "%u\n", hctx->tags->nr_reserved_tags);
 }
 
 static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
-	const size_t size = PAGE_SIZE - 1;
 	unsigned int i, first = 1;
-	int ret = 0, pos = 0;
+	int ret, pos = 0;
 
 	for_each_cpu(i, hctx->cpumask) {
 		if (first)
-			ret = snprintf(pos + page, size - pos, "%u", i);
+			ret = sysfs_emit_at(page, pos, "%u", i);
 		else
-			ret = snprintf(pos + page, size - pos, ", %u", i);
+			ret = sysfs_emit_at(page, pos, ", %u", i);
 
-		if (ret >= size - pos)
+		if (ret <= 0)
 			break;
 
 		first = 0;
 		pos += ret;
 	}
 
-	ret = snprintf(pos + page, size + 1 - pos, "\n");
-	return pos + ret;
+	ret = sysfs_emit_at(page, pos, "\n");
+	if (ret > 0)
+		pos += ret;
+	return pos;
 }
 
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
-- 
2.51.1

