Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0783EBF07
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649808; cv=none; b=fVN1znhFMa0a5C+KIdp9DhpmjXutkm2ccBDpkFSXRk3nvG3/BFWVw/EYuzBA6bXVJi4p3Ox7UkOLxxfvK6zv7hcjCd0BwTMDry3blqWa51PjF+g71LZDIGEG0aDXUmhx01dKP4MwZnqeN88UVrHqj0O2L2GaAKKRU7cVtuE+3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649808; c=relaxed/simple;
	bh=HiKrd3eV2rwkL3o/DZk2JSzup1z/32LkdO/qyn2di6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRvvfiFnDcBTsOHI1uA7hxptpuPDlq4M1C3v2cjPqfBKsOikHZbgkUcgSl+OSQgLmW5CHN+pefYRynQHp6zdYKy3+wPQ//3IsW3miWBbUmPkNH88B0fMeUKTeKtmOKWwnfl8QNdK/zYig4deyRCxv3KEhjNhoctFSrvocaYf1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtq2Ukwr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtq2Ukwr"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39652a6e963so398966a91.0
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649806; x=1788254606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bp7aIFrM5Ow6CazQpbG7KkEXOIatOW1QaOjDzgI64Kg=;
        b=dtq2Ukwr9za2V5PoIQ8FjRxoW2duQYps8omNrXS+5qK8wDiq/LbvLnSR2cI23eAgCB
         BqBSwED1hK7wIBXNK+rTETLPVi+Vqndmi85b0wDpze+EvEFF9DKMxpR3tFEcfsO3SSH8
         wjromQxHIJ00Ot1b9219wM+tld7X9+nwiHZ/mP/CfW8y6IWsfRw8ztVeLaLD0EmB5yJa
         MfMfKPgGj5t4o/Txu4OXeX5KIG28nHwMdzul6NEj8AI4mVkYvVieOuvnljdYOq/gRo52
         nK984v9I6/o/5O2IP+qluwzhvWye3orU4y7QLqsxzfk+CepBDkBVwKFoGYQLqTy2K5BS
         onKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649806; x=1788254606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bp7aIFrM5Ow6CazQpbG7KkEXOIatOW1QaOjDzgI64Kg=;
        b=MmGaWrj7Ll4UUPOqEJz3l15SnbhYATV+qcJGG1fyUyvqhwhLRitLNPG0fEm09sM9QA
         JhBDjQAu0V6NB1SEhidBkGV6EXKgVnYey/Ti24pUIRrZ/dJf4va2wMcU6DFYjoQYsOgi
         jE8b+N8sHa6iD/iMFK/ndu/e9Jit4dELGxaz+6E5pDaIE7v+IxLNYROx/EAKxMPrk/Z3
         QLBsE1+la1XQXXxy0KaIWdQhIWYLO59Ez1E+OLUjoxJ2NnLkYt/jhX+I0tJ5W2GGNESm
         G6cpGT6JzfCvLLctG216TLIIDXL6cH4ZVIP90J/cT7o/Qcmd+Hcd2mhb6M0TpE+fVrmt
         1QXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkMe9l6R2Pup3jlcGIm/WYzElvv1+BmzkogB0AKNEQNVqxozl1IdEPi32YfHlcqAaol5C6fGs2M/PDMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mEe+BGbfP1eJLHnOdpIEdKClOGY0aoYNrgy9znXcEsuNG+8zcj
	OU+sm7TspVg0tpHT7uzWdD6pOAZpN7fvZYGR2ogTfVybep/sqqFGZHiz
X-Gm-Gg: AR+sD119W0P3MnXzxbzFzsdt7HHHO8rZAkmbVX401+STsZVtJN0zL3Ju9SIbhj1lOO+
	6OAhMHPeiNBWLp5IAEnotoDmJ1SF2c+kYs8t94PwlAuG4bsxKxqoVYdPYa+v3l+Jcpcy3LahxT/
	0miDJNfBPq+/neau12OvR4FgFZWPKhwtwQrAUi1BgghhxzDKovlgDt68YjFLqPhv3n86Nc15Iz1
	xIzahDtcwtznFEmjKIr+amK5u0pM0wXf0vCzhh80M10c6U8u5O+b0vvhgtiyvL4+HCR8AP3l/l2
	M8l+1ISh4pJPyl9MobHXExBCX61KW8NzPeXkgr4+g0BBRZOGu/gg+5lTDMWXlOWwXPM47iVp1Y1
	AOL+zYqC9z/xclCkEt770HQ72LiSaxj1dKfQltL2w5eIex2CVgID5BQ7yQ35ClytHt25HVfDRN7
	gGpX6jh5wmyc1dAvu1NG7BtG7ZCUWtaeQOW3PkE8VK7tR1WS8/CaRuY+scDKT3EAoV+88VcuIRR
	9bePTNC1iyZ6kU=
X-Received: by 2002:a17:90b:4b42:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39645b1c818mr5264179a91.7.1787649806023;
        Tue, 25 Aug 2026 02:23:26 -0700 (PDT)
Received: from localhost.localdomain ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645c06e02sm3048627a91.17.2026.08.25.02.23.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:23:25 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH] zram: fix idle age_sec underflow in idle_store()
Date: Tue, 25 Aug 2026 17:23:16 +0800
Message-Id: <20260825092316.69658-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
idle_store() computes the idle cutoff as follows:

	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);

Because the left operand is cast to a 32-bit unsigned integer, when
age_sec exceeds the current uptime, the subtraction wraps modulo 2^32
and the huge result is zero-extended into the s64 cutoff.  mark_idle()
subsequently marks every entry as idle instead of matching nothing,
breaking the intended semantics of /sys/block/zramX/idle.  For instance,
running echo 86400 > idle on a machine up for only two minutes causes
all newly written pages to be marked as idle and handed over to idle
writeback and recompression.

Drop the explicit cast to perform the subtraction in signed arithmetic
again, restoring the previous behavior: an age_sec greater than uptime
yields a negative cutoff, and one equal to uptime yields 0. Since a
cutoff of 0 is now a valid computed value, it can no longer double as
the "all" sentinel. Switch to KTIME_MIN instead, which no ac_time can
be after.

Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9b3bb1d3bef..da51f70b7121 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -438,7 +438,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 		}
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-		is_idle = !cutoff ||
+		is_idle = cutoff == KTIME_MIN ||
 			ktime_after(cutoff, zram->table[index].attr.ac_time);
 #endif
 		if (is_idle)
@@ -453,7 +453,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	ktime_t cutoff = 0;
+	ktime_t cutoff = KTIME_MIN;
 
 	if (!sysfs_streq(buf, "all")) {
 		/*
@@ -464,7 +464,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 
 		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
 		    !kstrtouint(buf, 0, &age_sec))
-			cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
+			cutoff = ktime_sub(ktime_get_boottime_seconds(),
 					   age_sec);
 		else
 			return -EINVAL;
@@ -475,7 +475,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	/*
-	 * A cutoff of 0 marks everything as idle, this is the
+	 * A cutoff of KTIME_MIN marks everything as idle, this is the
 	 * "all" behavior.
 	 */
 	mark_idle(zram, cutoff);
-- 
2.34.1

