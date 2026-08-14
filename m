Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3C282F13
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746843; cv=none; b=GtmWYjtAX5DuHCAVSD9jGNnwCGDV6BbAUf3ip39MZfJiLpuljHl9HysnlX38GDAQSnsTrJvQLlxtFRuUFUkTic2OtT1x7DNvO4QR9xAJcQEyPNNi5Wo2XG1H74Xs6jl71/dSZVaYZ0WH3BZLUffQwiepgjsdsQzSqtF5FVDi350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746843; c=relaxed/simple;
	bh=D1fdGjESKvw/uq/JSBCiUbhtq7cGQdHsYD/kdEJes6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGJf8JmN1Ya2u1N0eFVhaldioppuDNcC9SiIwjwjhk/IRnrMRYi8eePOT0brATBVxhJLsfoHT3nbiWwbWS26QQ/WbTIThbDo1uM6BEJiAERccgb6f5v1WVoC0RduHDeVtJWKehbc6bdV5MLQGL2xpxhh8FFteIU19ki9R8ppuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnTqPvWA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnTqPvWA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d6f35c1so131141185a.0
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746840; x=1787351640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5fkXF8XZbOD5FyQfrGiQUBRfaoJPe5kBpNFpnd/1aE=;
        b=DnTqPvWAEJi+kXs6BriotKPW5QjR9ih4WjIX7obXWdmbm7c+hzePUdBRrUJz4dV9Zk
         YkP9q4RHTc//NHNXTBtpQBr9mLIPz6S/u9pecnaJIiUQqCWu/JBBZDzgIBlabkw6ptH4
         siKv3UFfwWZjrOnXK9YAm33qubxa1/i/oiXX0Qh4Ivh4c0Z8jXRFX3tjwTBjrVwuIFIK
         rhhJNVETJOnc9c+cOTGdtUAHLvMITaHj9uQNgCoqKtoCo4nNd+YFsxf1U+V+Kd48yDPD
         kFVN7VX6eTC9vJOtBzfHTlLaqKEF2EGkWMKU9OXfYFX/XVsQ/ypa73meJN8BKtdFyV5t
         YIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746840; x=1787351640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5fkXF8XZbOD5FyQfrGiQUBRfaoJPe5kBpNFpnd/1aE=;
        b=F5FU8YmEGEgmqr5JzMVZZEQ8FgToxOpgq5K+DngK+wiYfArxt02VDCoemNS+oPcTtu
         dDa/bnRTLWeNmS8SsJs4kOsUXrGmqh+miPWO9XTyKkynFQsJk62U2uW/LAIHgY0XA6yv
         SRExYJAiLm241xOopW6wTOHWqM5ECuV7dKSJ34C6WKpVu3nNafo3H7qqa46u1tioVHA0
         TRIHsL4FAfknRiig7ANDr+6S5fRfSOQo6rwapQ8twJ0zgtQ0K0z2UWKyEiHFULFocd+q
         jOPJSDA96Ash/7lCCOSatrNd+1CIng9GGKkrUshRw25720oAkskRicC7i1PBZkWf7RrN
         biEA==
X-Forwarded-Encrypted: i=1; AHgh+RrQSFZNeQOIY2RXhs4s9sDdIt6IYa3fwwpSUKYNcNw1nTv8xX1ZZ+6RZJGePY0mT5MKOqVU4rR0mtmCDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OuhtgyOdfhcWaFlkLw1FAfPBdAp0byOnVGhVYcuPSmXtILpl
	M/SCHZrOqwRi9fyqETttoIY3zeMrRiLcFIHxHYSV3fFAzZiEnKPIY3TCPpCRCuZz
X-Gm-Gg: AR+sD12pA2VXoWTMuZ18NMEozcfP/oQsNM34n0K3AZTwC7Yz3pwRZWlsVHeJHHrfS+B
	PIud+beFmDeEdBxtsl4rf//FAMSA1osjHTJuq1OjY8zJ+kRzehAJ7zKpoeKAmMR8xOhZHEXcpU2
	s7dd+SphwSsDXzq4cIp5h1CGqhW3hS3VXhTY+nvb1JBsIQo6r9B5oINUdAAkDNFTCXWeBPd4yQU
	Y0/c+bXOb9Ybd9OUQXoZ/fbvG5rHYgjBom5AIwyumWPdNrwjF2gAX+HV6VX7XdaGYIDDp9kxCqt
	0/2+44DXFzF7iraAZHoiBA21P/u5o5Pk+L9e9d++aNuuj8OzlGwEeLo3P9YVehkFr0oDK79/iql
	73hBaUnhTtvmIN46fzbSeaAmPRAchQCibkMtSDlz3mteaKzcy85NV57YOz77J+o3QTUSjsPW0rz
	ACCDOot08kBbQGpwxks9uoBCIZ0zoo7T8jb+Ne6iPp/iZxH1aJ8ogfFaIOriYbOwn8+lGjjkZWp
	PHgTZZdmDwNznlYAw==
X-Received: by 2002:a05:620a:44c7:b0:915:8055:3f91 with SMTP id af79cd13be357-936d239f8a7mr962648385a.43.1786746840408;
        Fri, 14 Aug 2026 15:34:00 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce24d0b5sm371029785a.45.2026.08.14.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:34:00 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: yukuai3@huawei.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix use-after-free in blkg_conf_open_bdev
Date: Fri, 14 Aug 2026 18:33:20 -0400
Message-ID: <20260814223320.4118614-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkg_conf_open_bdev() holds rq_qos_mutex while checking whether the disk is
still live. On the dead-disk error path, it drops the bdev reference before
unlocking the mutex.

Once that reference is dropped, a concurrent put_disk() can release the
remaining device reference and free the bdev. The subsequent mutex_unlock()
then dereferences bdev->bd_queue from the freed object.

Unlock rq_qos_mutex while the local bdev reference still pins the object.
Drop the reference only after the final bdev access.

Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d9676126c5b5..8628ab6adfa9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -799,8 +799,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 
 	mutex_lock(&bdev->bd_queue->rq_qos_mutex);
 	if (!disk_live(bdev->bd_disk)) {
-		blkdev_put_no_open(bdev);
 		mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
+		blkdev_put_no_open(bdev);
 		return -ENODEV;
 	}
 
-- 
2.43.0

