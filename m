Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F3BFE2B
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700617; cv=none; b=DBVt2ny/IH+G0BRKET+iHtBfiS7q8ENffwE8SRDv5kAli7Vdx2k5PqGXYMCidVtmyNN2BTHhGHbNo5k1XBkk7HnVGUmaSvK00zbA3PUvCs+tg2f/61i/KhKAGrEKxgNyN7tv3oOzhrROLr1LJRsCse9FNIcQyWot0tyBIbNliOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700617; c=relaxed/simple;
	bh=GcP0ekSnlpIcak//FEHpTaiiGhBce4p6ErloiT1pBgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm0jlub1ftsp7kMqp5Zav6tV9ntebJdmIYzmmsxKikopIu2aF8wRB95L7mLI7bE63aXkFVFpUaxPfvnJAiWYq9+hKVTAcHnZM4KLvZQOY+ldRtY1Wbxm9tyWyklsUG6Weu5AowKj3ZwwwGeojkkdJU7zp0e4dr/7y+Z8Y8V1/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU73h8Gk; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU73h8Gk"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8241a56cd70so711461a34.3
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700615; x=1792305415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGN+MkknzV34QFKUMAyu/yIpnssuO0elJBERfBBFQdM=;
        b=GU73h8Gk6tCdl/RQVwzGQyDe2J90FfZdXdRbvTGCms7wfls/GstFx1gcgzBFm5T2o9
         OKvwN68svOiasgKWW3PpRdaE42rGWeAUCrDmBy15wSC2ZDu9foRbO6I1lLmQZOyT2TzO
         Ufnf01RysrjXG3dkyZq4kG7GBIYRlJh39HgzELcQ2CPTaR/ptb/VdZPE64cEWEUOnjXI
         UxU/5mJPJiWC2NQq362+S1cPJ9Xj0o3tke0oecU22q7d3qj7vpofKaDmGH21lr3WwsCb
         EP03Au7/ZD3ZInfz7hnMe0Iegua0Jqi7u0dZSuOHG6AUyIZZiVf9G8CBNMlBuTCXdtKY
         yFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700615; x=1792305415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGN+MkknzV34QFKUMAyu/yIpnssuO0elJBERfBBFQdM=;
        b=nGHuNxDDqIS8luDNiY9eMVDkftHFiHrd/Vt62sgj4LqseRFdQOEamApe7vzDeJ2ucM
         7wMkedrdBwxUFR/34KEJYV8JBeAYRx02goLdSPuoKUtrW/IcehFgvV/hQ0CFFeNPKGl5
         j0O5KgxID/5lUQVZcvDFEW9i+1nXNot4kaYnwZHhkpdKiSqL0iGm+kgjKWxaXmHoGsXo
         zS0qAfu5eFXYk84z9eULglsLO7CmWfQ/Z5uJe6AjgoUkeN0/HdqFzIQCyFPiiTvhG0kZ
         gRXd4f87sUGjl6gBWMSCyjuhVgIFbk9K3pk7m6jqshTTYft+myEnIq14Z0UXIrUxNTOH
         N4yg==
X-Gm-Message-State: AFq9FYJnRi/quJbcByZpmoqjrY4IBBtSCGSLJIbjuoQgSYSWkQoS/Y79
	oG8TTwht/Gy203gQ/IeOmWXrci94s1yA6dMCmSESOl0/rilErrEjOyemC+Rw3S1Q
X-Gm-Gg: AYBFou1iVui8z+BCep7+2u2KjIq5UFvQZU+8eCFH2t5p/E00v5znHA58QQNCRrjLOKd
	4kYIxmgBmovQ5vaWV9osa4RZh3Z/M6f5wtJlTkdzbuONEmCP3flW9gL7vNz97nqqJSgmee7S7kW
	s5KDJKbIZc75qlSv5BaQcWZPS8dwxAYCksg/UH8OiGmOQZxJ+ShYFOu5cLL2EuYy1w8ZxeCoiwq
	PUAHDIaF9iCUrpODL4Pxk831IbEovdmYJ/VZPLuJ8TudZN5aUZfVCofh+kLIf4ckbN69iI5z/kz
	NFebYvsjyt6++PgYzwLy3pfF3mSZWQkotmRgv64Hy5/0TIQteBx/Qnpl5q8Z6+OcUvm8MCFJzyH
	pQqMTFX2+eHMg3EkOeaGYaLjYVwIBEKDVM+qqosvNhxemvNwAZD4qPEtyky/kt99gxxb7j+gVmJ
	KCbqiL/rA4w8wyd3WNaDRZ1cznBnfxy9UYUbElyTBy2oyERNfoYE3wUlaytctUA0YUgyOl9FJQd
	lykfrVuL07zKJ/PP+nu2S5udgWrP2WN+fX0LnSg/tiMbWVZlkq/DrbHlHau+QolUF+QtV3J5ilC
	P/6XHo1CS5rkr+zyGqeLaAEbxY4=
X-Received: by 2002:a05:6830:680d:b0:7fa:5c49:524a with SMTP id 46e09a7af769-830966e90b3mr6857622a34.17.1791700614966;
        Sat, 10 Oct 2026 23:36:54 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:54 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 12/12] ublk: use global index for reported zones
Date: Sun, 11 Oct 2026 01:35:55 -0500
Message-ID: <20261011063555.1142277-13-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

ublk_report_zones() may split a zone report into multiple requests when
the number of zones exceeds the temporary buffer capacity. The index
passed to disk_report_zone() must refer to the zone position in the
whole report, rather than the position within the current request.

Currently, the per-request loop index is used as the callback index,
causing each chunk after the first one to restart from zero. This can
make userspace callbacks receive duplicate zone indices and may result
in blk_revalidate_disk_zones() updating incorrect entries in its zone
state array.

Use the number of zones already reported as the base index for each
request so that zone indices remain continuous across all chunks.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Tested-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 24a7f80e191c..1e84ccc68b9b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -696,7 +696,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			if (!zone->len)
 				break;
 
-			ret = disk_report_zone(disk, zone, i, args);
+			ret = disk_report_zone(disk, zone, done_zones, args);
 			if (ret)
 				goto out;
 
-- 
2.55.0

