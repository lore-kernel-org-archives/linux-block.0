Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4F3C0619
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745116; cv=none; b=GbUoxa4o33pyIcT5BwJVHQHcuVdtMItvPIxnS1JLisM+bLC97jTScZz0G/nZgSwuMdqTC+8pl5RgtDRK1DAxvu6XkSIrmYsKsLpBrFsVDkvvAvIvIktIEmLSoBX9uwCcPWKKorupKlvRgAxCKBCz2YjfD1CyALnkV1FQoToEn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745116; c=relaxed/simple;
	bh=O67pmowHWgU9F4aYcvvzY0blvwu6WfZnDRzj7fLaGd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKbS0WodP9Juet1xW/XmmyuYCSrYc8XDjCClopjNgne0DlXYU0l7Pd5sCtZRA5zJhOH5bhpJzouDU2ZiYFXj342LVQtDq6/NS+Daweib1WfrfAGcOZyYs3fWHCIt3sbdwQANSlNlvJNuVJcqgn8vNfiYcqSi+xMFGgbZR4ax//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt/JkCXe; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt/JkCXe"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8edda5d56a5so15765016d6.3
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745114; x=1787349914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+byDgTzEgx4Gr3ZSkskCbtI+EfBHPCCCfhKahAfUKes=;
        b=dt/JkCXeb4jMZ7ptoYn6JAe7wFpCpPmbR7hf9Q4CpOr94tcSererFirBGqS2Yqf6Ku
         4EBcGR3B5mJMaV69RX+Y6mS+zdjHah/HWlXnu/FXjMnqgs5HAVLVVnW2PZp8Z3/ClJG3
         4aYdgewtBZqEITYQNIHeiG5GjA+VOXFNKRj/tnJdBFLD7bZe8Mnk6Rt3hsxPFPUDEu2h
         3BSo7GMV8nhuADwYaFHWHSObKXofwXN2Tt+fzWfHKZN+ZBj4WWakedO5giXmxaRXo/vZ
         OV7fbRLK9IxvVPvQAJNpBncAEK1TXzMsj/aCVMz7a2iwUInbiJvE+2oIv6mrYH9CbQWV
         4V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745114; x=1787349914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+byDgTzEgx4Gr3ZSkskCbtI+EfBHPCCCfhKahAfUKes=;
        b=U0RMETjbrpMamNL82J+B75WclQpYHqY0oWezGFLOuvHPQtHFXuiv1NiPsYY9WppXre
         WUB0vfI2GAjCn+qxqxGQL/hGZ7PGOC7yJDaXrxps31j5HBYo3WSf4t1SMNNZud267vAR
         GnuT7pTbVcNr7zvv6tVPtc9hDIfQGww+c6ytUjDsY71xytLYQF21vKu1z+4jmDMM7jDZ
         4UxtyAuXK5NqOoKhHxBJD41qTxlgLSA9REtyS1oFftEX7hHu7JAMwmn9Iv/70/a7n+rI
         EfK+ghJMy294F412NLbYMlSOxQ5mRcDgGKWtNX5KDuI2en9y0v0hFw4BIrmzveRpk/zq
         nTNg==
X-Gm-Message-State: AOJu0YzidZSLqkwL7t05+VLsiHVCUnyyNtV+6Ruec4eHOJry1Ejf2teg
	rh0wktWNc98FHuVMVV5BELMSrFIjPnThhIT6OjjDMFAd58apyk2FEf9l
X-Gm-Gg: AR+sD10ZIy96Re2jpvcBIelZU5XdzotpmYd3+0lg4QXI9b+tc3/hXYoiswKxfoYHCWj
	XZq2DilP5H3K14tOBEkxvipQnnRZyJrZUjuRGSKCoPp9dPlXEqLl6jfvNWMqwECOrM/77QBwpJe
	SqrLBVBPguM++d3HrFFLVosH5FDZ8awsGBA0YOaOgb3BOfNie6x9lmFynAWRflRJMXuUI7Wtdk3
	yzPgLMm8xF6jXYJ8yV01Rcv8jFZ/T/h5AhFiEJH6FYdn9AqB/yi2dgKxnWahl9bUl4TyfqEJgwt
	xbKujkNiOMrjLENFGCacFzKKNRDYbcBErsCIDRQoveMqfKDd9ORwqwC5JhYswrscy0MTFA4GrsH
	MeZ7TYBZQBIHp7VgJWy4sPgLgh4aCH4EbFQOLm0E1OMOPUwTSyknckTggyhpV8uzJ/Gk6gInwiI
	gSAkaaJ6/+SCc8MoItJl5qzvxbsqKRRLNqz6XcKuU4aaM0Xe2c+s/qbQXfpiweFDK7427A9lSAv
	zgIidJf8KCkNHHRiQ==
X-Received: by 2002:a05:6214:428a:b0:908:951f:415 with SMTP id 6a1803df08f44-90a91d350efmr118520916d6.13.1786745113943;
        Fri, 14 Aug 2026 15:05:13 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9350678esm26867806d6.26.2026.08.14.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:05:13 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: clear ia_ranges on sysfs registration failure
Date: Fri, 14 Aug 2026 18:04:48 -0400
Message-ID: <20260814220448.4085032-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disk_register_independent_access_ranges() clears disk->ia_ranges when
creating the top-level kobject fails. However, if adding one of the range
kobjects fails, the cleanup drops the final reference to iars and frees it
while disk->ia_ranges still points at it.

A concurrent disk revalidation can wait for q->sysfs_lock and then call
disk_unregister_independent_access_ranges(), which dereferences the stale
pointer after registration releases the mutex.

Clear disk->ia_ranges before dropping the kobject references on the child
registration error path, matching the top-level error handling.

Fixes: a2247f19ee1c ("block: Add independent access ranges support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 block/blk-ia-ranges.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 7be8b58893c9..2430e475a8e7 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -135,6 +135,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk)
 					   &blk_ia_range_ktype, &iars->kobj,
 					   "%d", i);
 		if (ret) {
+			disk->ia_ranges = NULL;
 			while (--i >= 0)
 				kobject_del(&iars->ia_range[i].kobj);
 			kobject_del(&iars->kobj);
-- 
2.43.0

