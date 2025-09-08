Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BC2D7DDA
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362249; cv=none; b=ViYG9So/e1KMPQKeT7nwWbv0iLMSdnERm/NPZstS9/igwTpAmYIEXZCe4zQ7Y01JuUMwjxghAFFxXp6sQt4lonwZIxh0zriOFnrSsOMj46JrP+CCxkS5cnPhnML/fvkWZKdHqlXLLRlvr1ATwOL4hGKWYtjF+uf+4xB3TknPpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362249; c=relaxed/simple;
	bh=GdWo5qY2s+/q2DpoLVfpe8mWXYCuezbFaAPeomuAb9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvIJobG+jqhagtps+4fhMi9q63TNwnc822JdCH+9fY51FFB4r+cftEQfMGHudDW7MKCr3Xstbvq0AVQvGB9GjZTDQhgZABo15xtyyfkTmOBgjXKbFCACKsvOBciAYU6cxw8o1+lKudYjhk6/W5ATWfV2rtmYUFWKha5/QHpugDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqvgMC4m; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqvgMC4m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757362244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ARYB/S5SqL4eD+uW75wvhyRnd19Sdd8JhvFggm3s75Q=;
	b=XqvgMC4mKPssXCE7EmlpVlIaoMbGNzGc2Chh7TlK+hAi4I2DQhkE8qtc3TfqzMgs8R9QjE
	8kNSAwIyA/s8mj4OfpI8P6LmDYRtQzEdbWf6V6C/EG2pdcneqw0zjMlwJlGDBGaao9WSKn
	q3MrO7oc9diw7vVmejVz43wuBRnYw8A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: floppy: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Mon,  8 Sep 2025 22:10:20 +0200
Message-ID: <20250908201021.439952-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify raw_cmd_copyin().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/block/floppy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 24be0c2c4075..b33c6543ddf2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3092,16 +3092,13 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	*rcmd = NULL;
 
 loop:
-	ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
+	ptr = memdup_user(param, sizeof(*ptr));
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 	*rcmd = ptr;
-	ret = copy_from_user(ptr, param, sizeof(*ptr));
 	ptr->next = NULL;
 	ptr->buffer_length = 0;
 	ptr->kernel_data = NULL;
-	if (ret)
-		return -EFAULT;
 	param += sizeof(struct floppy_raw_cmd);
 	if (ptr->cmd_count > FD_RAW_CMD_FULLSIZE)
 		return -EINVAL;
-- 
2.51.0

