Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076E367F21
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027302; cv=none; b=cRLnaNSAOhJG3ACnzjEqLpOrFjZeGNMhB16/w+M++KrYZ1b6pXiQ5BV8Y3OKDGKh+uIiCOVLK/tFTv/P50CHoHb9SXBK2w+5UyIyjIithC17Ii9wSh6LXWtW2URV2ApZ6eDbpubnFLA9PI+/mTlKxmc3ffkpAA5NUICOf3U9y78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027302; c=relaxed/simple;
	bh=iQ9QVQG2CydO7XwuH1f8mGeLUQrVMU1F6To01zBZHx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHeJS4QDF4YJWf8lW9WmIUhMo8E5vbNRqCBdCiw6q0wY6weXSPYCIFPvhFUiYdczoa3L25sIJUBboZVyE7V0fUrJIGcbh686h6n72h9GMZTCRYxf2pOwFbggFTd5SH+yk8OINFFmKc/JDotwqr0zsRZ59IxGBhBgFicKV4MXvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9yan/Wp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9yan/Wp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeD88qOGFlY5dzKpFrWges5S0+Es8cq5SSHjo23Rw78=;
	b=P9yan/WpgdiOafeOuvMbGoW+QPBLiSD4K1qC6klGQl+uYjCKtjwRcMiXyusJIdozgOtUAQ
	fRPkBr35PJpVnCSU9eohuXRgyTpCRDuWl0KM2QB2lJdb/sQlbt5ZS7luj8euKzv+52h1qz
	KZjqp4eA+i9Km5Kt8wKo1arlrb4V0Xs=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 03/10] block: convert disk events sysfs show to sysfs_emit/sysfs_emit_at
Date: Wed,  1 Apr 2026 15:07:09 +0800
Message-ID: <20260401070716.991-4-liu.yun@linux.dev>
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

Use sysfs_emit()/sysfs_emit_at() instead of sprintf() for the disk
events sysfs attributes.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/disk-events.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 9f9f9f8a2d6b..b1680d6a1027 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -329,12 +329,12 @@ static ssize_t __disk_events_show(unsigned int events, char *buf)
 
 	for (i = 0; i < ARRAY_SIZE(disk_events_strs); i++)
 		if (events & (1 << i)) {
-			pos += sprintf(buf + pos, "%s%s",
-				       delim, disk_events_strs[i]);
+			pos += sysfs_emit_at(buf, pos, "%s%s",
+					     delim, disk_events_strs[i]);
 			delim = " ";
 		}
 	if (pos)
-		pos += sprintf(buf + pos, "\n");
+		pos += sysfs_emit_at(buf, pos, "\n");
 	return pos;
 }
 
@@ -361,8 +361,8 @@ static ssize_t disk_events_poll_msecs_show(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 
 	if (!disk->ev)
-		return sprintf(buf, "-1\n");
-	return sprintf(buf, "%ld\n", disk->ev->poll_msecs);
+		return sysfs_emit(buf, "-1\n");
+	return sysfs_emit(buf, "%ld\n", disk->ev->poll_msecs);
 }
 
 static ssize_t disk_events_poll_msecs_store(struct device *dev,
-- 
2.51.1

