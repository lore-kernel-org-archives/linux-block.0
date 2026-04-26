Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AD17C211
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204780; cv=none; b=eGB7vGgra2Abv6iFN0EOnGidXAaPSZOmD9ZPacT9kPEeXYX0s3DYExhTChb+mm+/f3jBViHAdtoUz+UWBhz+pA5mtGknDyOanxs9PYwO6ZbvJDln8QVAAAdDwylPvTm/KzhlsUWMW/oYasfYy69Ep2Bxz/PhhiwiCzNfzPNLIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204780; c=relaxed/simple;
	bh=1sJu2a7G2pOtK9V3ZeG4Vta320GSj36dLukg+OMdvvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDMlGEXP7FYmAMbQBJZOeYQnKlObVwzQ6eV+KnFjH/z7qzRkRGtxgRXbcHd2PDukz9BAAkeYxfYApZreXVP+MdZe/VoOyyqK7mrjEPDoNMwU8v2v+6VUhsn+8XBWTybMWInvFEjW6sJKX3cTUzBcMxE7Z+RhgsyegSSPE/MLY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n016QNGD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n016QNGD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777204776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wv3Mo8fCVcczy2Ns3ljqZCrzb/HiULjMkogmx1p7uzA=;
	b=n016QNGDJyCDauY1c0luMWJiqdELkU3O2UpEqFe84uz+nnemtkIKB6CYMdNp0nSaCdXyFx
	ADNn2odv6BboXdHBlUvAln1e3t5WY8L6cyiVIJOi64jKID7pMMgij2IK0Yzl0CDTQGt+4Y
	9nf88PKrqRtJA8yFdme8SMQFjnEAijU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] n64cart: use strscpy() in n64cart_probe
Date: Sun, 26 Apr 2026 13:59:24 +0200
Message-ID: <20260426115924.75386-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=thorsten.blum@linux.dev; h=from:subject; bh=1sJu2a7G2pOtK9V3ZeG4Vta320GSj36dLukg+OMdvvs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlv/8nEnpC0LTjTWNd0gcHN419tq4joN1v/G3wqP7VLz ixY57ilo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACby8wTD//j0tA3pB9d8S7Dg KqwvUfeeciu1f0PlPY3CG9v9Uxe3fmdkOLbpTLycq+RqFvnAPXv7z85kNP38r0jv0hKNmeYKG+3 F2QE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated¹ because it performs no bounds checking on
the destination buffer, which can lead to buffer overflows. While the
current code works correctly, replace strcpy() with the safer strscpy()
to follow secure coding best practices.

¹ https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/block/n64cart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index b9fdeff31caf..328da73b6f2c 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
 
 enum {
 	PI_DRAM_REG = 0,
@@ -145,7 +146,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	disk->flags = GENHD_FL_NO_PART;
 	disk->fops = &n64cart_fops;
 	disk->private_data = &pdev->dev;
-	strcpy(disk->disk_name, "n64cart");
+	strscpy(disk->disk_name, "n64cart");
 
 	set_capacity(disk, size >> SECTOR_SHIFT);
 	set_disk_ro(disk, 1);
