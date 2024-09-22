Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67368179BC
	for <linux-block@vger.kernel.org>; Sun, 22 Sep 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726995640; cv=none; b=QeeARjbyxRJV8/p68vdsBEime51daG7DScIUO5EZ8DZ1fujGv4msx4njSUcMUx0SETU0JCZGM2oH1B/1syhPP7fV/Dzrei3Vr5a4IOC2FwsOoBCZJZp89ypxsHhbfZq0PqWfTx8nW/7wnAq68g/M4Bw0Lz/dHgO8HjzVFyPXMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726995640; c=relaxed/simple;
	bh=KNPmiznq+7w2Dg6/JP5bey9XpXtrSbPCKL8PPRERt0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW6T++BkztW/ZA2ApqUnTXRWIw3llwYNX2X6cvahv29RB7H61I1/uA0PoDalCCpYNkBETZHEo158Xxkl6tcW7RjE4pdF8BJdpkE3huKvGz7G2ErfprT7WrXIV/Gch144tvS4QlL/r+Yt4velVGZxLlATfZ2bC2MkW5Hmg4D4bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXgcE5bU; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BXgcE5bU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726995635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyOlo8+d4ThXfS7chbqCLxoj/FQGSwMj0LsMOJLjRBQ=;
	b=BXgcE5bUl/1JnJ0MA1n7IY7H5QSr4U+TsrkUN+q9pWek+2HkmpTkDsTuwkZ+ka31vMdbjP
	KI+WXFRo+1O0y1GBii77PmOhDkgyctVhs949h/DABusidtiUO5fFYCJVMf4RFhGPtliPRl
	xEYzMQPNClP6hm3WFCbEWmOiVjEtmlw=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yanjun.zhu@linux.dev,
	yukuai1@huaweicloud.com,
	dlemoal@kernel.org,
	amishin@t-argos.ru,
	shli@fb.com,
	axboe@kernel.dk,
	hare@suse.de,
	linux-block@vger.kernel.org
Subject: [PATCH 1/1] null_blk: Use u64 to avoid overflow in null_alloc_dev()
Date: Sun, 22 Sep 2024 16:59:41 +0800
Message-ID: <20240922085941.14832-1-yanjun.zhu@linux.dev>
In-Reply-To: <e5807f3c-3173-44e6-b222-fc4679be4680@linux.dev>
References: <e5807f3c-3173-44e6-b222-fc4679be4680@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The member variable size in struct nullb_device is the type
unsigned long, and the module parameter g_gb is the type int.
In 32 bit architecture, unsigned long has 32 bit. This
introduces overflow risks.

Use the type u64 in struct nullb_device and configfs. This
can avoid overflow risks.

Fixes: 2984c8684f96 ("nullb: factor disk parameters")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/null_blk/main.c     | 23 +++++++++++++++++++++--
 drivers/block/null_blk/null_blk.h |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..88c6d6277d09 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -289,6 +289,11 @@ static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
 	return snprintf(page, PAGE_SIZE, "%lu\n", val);
 }
 
+static inline ssize_t nullb_device_u64_attr_show(u64 val, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%llu\n", val);
+}
+
 static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
 {
 	return snprintf(page, PAGE_SIZE, "%u\n", val);
@@ -322,6 +327,20 @@ static ssize_t nullb_device_ulong_attr_store(unsigned long *val,
 	return count;
 }
 
+static ssize_t nullb_device_u64_attr_store(u64 *val, const char *page,
+	size_t count)
+{
+	int result;
+	u64 tmp;
+
+	result = kstrtou64(page, 0, &tmp);
+	if (result < 0)
+		return result;
+
+	*val = tmp;
+	return count;
+}
+
 static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 	size_t count)
 {
@@ -438,7 +457,7 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
 	return ret;
 }
 
-NULLB_DEVICE_ATTR(size, ulong, NULL);
+NULLB_DEVICE_ATTR(size, u64, NULL);
 NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
 NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
@@ -762,7 +781,7 @@ static struct nullb_device *null_alloc_dev(void)
 		return NULL;
 	}
 
-	dev->size = g_gb * 1024;
+	dev->size = (u64)g_gb * 1024;
 	dev->completion_nsec = g_completion_nsec;
 	dev->submit_queues = g_submit_queues;
 	dev->prev_submit_queues = g_submit_queues;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index a7bb32f73ec3..e30c011909ad 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -74,7 +74,7 @@ struct nullb_device {
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
-	unsigned long size; /* device size in MB */
+	u64 size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
-- 
2.39.2

