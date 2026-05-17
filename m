Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696ED3BB661
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038787; cv=none; b=aWSP3hhuriQyWVOr02RF+FCd7dUMptNHEEMhIF2uMghnw32RaW7cBKnN4ji54CtH/jE/5N1P0s8XD49oxyvF2JFzy46dymbYQErKtXQQDQbE6cUkHlY7dm9Lm8+l2DE3duLl9/c2O7Q9aOsOZI28v0dRrT6b4YmUvPYkp9AA/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038787; c=relaxed/simple;
	bh=eJsfiUZLw3wmJYdoGds/9LxKqXLvl/zHbkZXEefuyqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PpyhT78g9xS9Yd5Jd4/X4JOs/9iRNxvoUAHWKFMeS8cjW3Bm4DPOjh+4rdBiEf8eLv6YPF58xXdXXCvvCS/LiGO4bgETFw6DcYMQciFy6KEZgFKCGs8Nn4k3pLFKxME5L/T/awJkEpbO77nESD5KqGWh8DhGqJ0WP+WX2ETmwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fQj6T2Tw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fQj6T2Tw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779038782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=76A0oZKKwfcdbs5aKjR8EbOiZitG9AezNjNS+0A/s0s=;
	b=fQj6T2TwMKYJU357KmZwNUZ9lZ6u9U4axvvwAgyKUDkRhlPmMkmz51+GD55aYMzQq3I58l
	eOhSl3ZsGuUVhxgDNcYW1Gib7IMaopqtmFgXSIYCLxdvkr/pnnDLMt4cQcArSrHtcVcRBE
	4Fji3JBwwO8xk/ZOK8ri5SSCdmz6wP8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] n64cart: use strscpy in n64cart_probe
Date: Sun, 17 May 2026 19:26:17 +0200
Message-ID: <20260517172617.3954-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=thorsten.blum@linux.dev; h=from:subject; bh=eJsfiUZLw3wmJYdoGds/9LxKqXLvl/zHbkZXEefuyqk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmcvyxjduj/7+yQebn74XLzd/NXbj7tUqag6VdicWyes fQrVaZ/HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRpQ8ZGVbuEubryD2y5vtM laiTiw3Kfz0+5Dpt+8mtNSkMlh82LZ3D8If3UVNEeaGpkf7xdMUIua88ii5n3ncekc6bEe+U5sq UwAcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. While the
current code works correctly, replace strcpy() with the safer strscpy()
to follow secure coding best practices.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

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
