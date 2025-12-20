Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AF2D4B66
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766275217; cv=none; b=Q85wPutYtkHT6s6r0X1R0px8zogm8rTnIjmE5K7AY9fXHU/e85ZlxrfLgaSoB3PImttnPjW6Ija3mqPpuU6gfeQaW7XIBUy49eDG7PbS5juUgTqxubs57hKKrOXmGXVB/lWIqzmeyx2OoBuybVzcudJaocEYJTOJqii6kmRlRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766275217; c=relaxed/simple;
	bh=CjskQsrtDVQFPX4Kodtenm7h6AILkZ1vHQFGCHsovGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNuI8U9oDwc25OPWPQtyn8GKf8T76/ti5NH0/vEDeAWsHOXxAiDHcdgMBtFtRhXzxkocVTFdcT577cC/Mtjk+vRohTOZovjlOkQrMRU49AInNNEHin0jwFHSvAtcm6Sr+hza8TlCztTmqDi9dwfR7wVAMV7RbPB73vKTs80Ar2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CtG4b7hP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CtG4b7hP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766275199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y0GJfbucheRxs4DPq6cC6aYxCnYudhG1xGjs8gOF/9Y=;
	b=CtG4b7hPq7I3Tb58ERHgQc4VAZCtnOAdb5sTvohrjhoBdd1b2sfkOOxE1BPGRwKxQIVW3J
	HlQbDrPAQ+tgkBG1A8Q24uCtxqpY+P9tNJELCmUgDB4vGABZLpLq7bG6vJNt5vtuuau900
	MrswdaIV9LmzQkDJ+cEgiM7t2qAJM1M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] brd: replace simple_strtol with kstrtoul in ramdisk_size
Date: Sun, 21 Dec 2025 00:59:23 +0100
Message-ID: <20251220235924.126384-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtol() with the recommended kstrtoul() for parsing the
'ramdisk_size=' boot parameter. Unlike simple_strtol(), which returns a
long, kstrtoul() converts the string directly to an unsigned long and
avoids implicit casting.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving behavior for existing values, and
removes use of the deprecated simple_strtol() helper. The current code
silently sets 'rd_size = 0' if parsing fails, instead of leaving the
default value (CONFIG_BLK_DEV_RAM_SIZE) unchanged.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/block/brd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 9778259b30d4..a5104cf96609 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -247,8 +247,7 @@ MODULE_ALIAS("rd");
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str, NULL, 0);
-	return 1;
+	return kstrtoul(str, 0, &rd_size) == 0;
 }
 __setup("ramdisk_size=", ramdisk_size);
 #endif
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

