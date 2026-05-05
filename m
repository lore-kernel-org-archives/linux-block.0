Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AB30CD9E
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989574; cv=none; b=p9lHdLNJtl1+sewJc4RlUA/vHn5NWqrnMm8g5lcnSxIsPXb2/38E4kIMUJBOBWiLMT0yzTuIByVWUGVl39Z8v76bAgcf4Snr/BTIGxbh+rFYd8CzDbg5LqSSsNTRpZLgzo0Vmk518A4g5thOiEgcBOT2ur65IhWXgm6GmsA5slU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989574; c=relaxed/simple;
	bh=Ulpt/L4zrGd+p9EPK275kPZek8UBvc5vwMR+XpSB21c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfcJgk1t4eLmFEDTvTYUTpAsM5q+fpOR1ZBkLZlzx/9BNO43mFOiwAmTxOI/OoXgPhUfLdY+EnSqMyN4NMIhHFLUcu8ehT4euuhqV28qPekKozJcag+FDpLfKCRYVrUkVLwm8X7S8JyDp5DJeSQFPjU4FO4QH6Nb61wAzC2NL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMI9I/Be; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMI9I/Be"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso47053825e9.2
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777989572; x=1778594372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//moAVaxF2eoWAH1Yqtorb3J5nhIUd2AG5x7G1Xso/A=;
        b=KMI9I/Be79+aR2PduH/ur5W3Up2oTMdFCxj1a5RNRvUGg5LPNvTLgB/ZkvUsgIZK13
         /5TXuM9hzilGgPE4gnOui0tLZRp3ZkBqm28ECtk0WiZ/TzemyD6VjQ2uGnYMnLUSPbM0
         pCenB2d8/McwvYq7EVwI5wjdbg+6aFNO0Utln8WU6XFJJf18I4+jDBpwH/fpqO0vzw9Y
         h2T7DRRy+Ad+HeU/MXYxmd1DFgQq59M9/oA8IK70tvSC1m5iTJuvWNfifp7dbEOzEtd5
         lUpx3KId2UKI7IdOJZYrJrzGNwn9uIUYfQrJHen+5gor92Q/8cjcFjV737vyAjCPZABC
         Ihdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989572; x=1778594372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//moAVaxF2eoWAH1Yqtorb3J5nhIUd2AG5x7G1Xso/A=;
        b=UORWiKr+BeeDquEb94muzTI+cwlw+ObPyiRT4riYFf/Jv73+dDabkSvQWiLIXl3CQL
         VB7OQI8J3QcvuvgFPtG2prt8OzbYfsY0jCNrFWY5qUgXEYwnb7QY78YKv/DnaY+46BsA
         cskox37TmU9sQccZm0SVqMJaijgr0hWSJWTjUoPlHHpV0pwMLMAH47iHANuySQDa4Cgh
         RpQ5jnauE/qIFNM/JO4EGTYZ2CRPWBx4K0srHO4Z7oRfidWCtcbxyaE19XcmEp3M0nhi
         aygvKwtxBFkHPNHJUg4HGS9rMd2rJOmBuuCtlo4N9fnoD71TWGQxfqMcwIrD133oD7TV
         OO4A==
X-Forwarded-Encrypted: i=1; AFNElJ+PYghvhSRBJyMHDhl64MY5ua0jZFXKvCH3PvD/HMGNMM63iRLlaEVZdXvJHGLM7uPtOktNCuzssKmP/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yygtn0EM+LHH/jFS1/KyaSs8VT3XbkLgpg6rMvWysX6scXjVdnV
	RT9mQtpbOo7pL487SfVVa7d20hTH2Qici+dIl4Deyq/T2f0aE+T7xPD8
X-Gm-Gg: AeBDievCKTKS++GsZnhX45h6lWPJ2CudM4NG1PDBxKC8s4w9w58RkcAcB8ZwCWdm22s
	ySau08rOJ6wXB5JkjYlJyLx7si3d5M3qhZ22m6bvdHhHF8oNVbR9hAHCUPAjG07hlFeqQEW50Jn
	iWBwV4J4eUBToh5exkfydepBg4b0kF7WwUUiOUyYiU3YaHuuKMl7rAu6/U4r/ixbLM8g7v81cgY
	zL/ulzyuGbmFUdTRZVGle+XVyB/3C0ZyTzh0IpP22cBz5GfsXAIPvmMahgtO9+GUAep9hzB1JL/
	4oLecooJ7a2uMnIEElIQDnbVyM+6XCwBuj33Olz1mL8WLNAEYaKT2w9KwpI4Dve2ImUuTot+wxs
	HAzKleNvCYSFK8daodInkjHZYAmub8KHFFq6OznZWFQdFL/+x/6ZpaAJLm4DrVW2jxKRxIrwYK6
	/r9ehEhWF31hdANavM9eGgRafoT+hPuLj5AzayXKZao88U+q45GKSWFVpEzNcvUjG5E24N52jwN
	JZj84JQ6yIERy1kdCKMX57S
X-Received: by 2002:a05:600c:1c15:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48a9852f593mr235601145e9.6.1777989571305;
        Tue, 05 May 2026 06:59:31 -0700 (PDT)
Received: from fedora (185-147-212-251.par.as62651.net. [185.147.212.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm340509945e9.9.2026.05.05.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:59:30 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: validate physical_bs_shift, io_min_shift and io_opt_shift
Date: Tue,  5 May 2026 21:59:11 +0800
Message-ID: <20260505135911.2072060-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_validate_params() checks logical_bs_shift is within
[9, PAGE_SHIFT] but has no upper bound for physical_bs_shift,
io_min_shift, or io_opt_shift. A malicious userspace can set any
of these to a large value (e.g., 44), causing undefined behavior
from `1 << shift` in ublk_ctrl_start_dev() since the result is
stored in 32-bit unsigned int.

Cap all three at ilog2(SZ_256M) (28). 256M is big enough to cover
all practical block sizes, and originates from the maximum physical
block size possible in NVMe (lba_size * (1 + npwg), where npwg is
16-bit).

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d10460d29e4a..93d86a6203df 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -900,6 +900,20 @@ static int ublk_validate_params(const struct ublk_device *ub)
 		if (p->logical_bs_shift > PAGE_SHIFT || p->logical_bs_shift < 9)
 			return -EINVAL;
 
+		/*
+		 * 256M is a reasonable upper bound for physical block size,
+		 * io_min and io_opt; it aligns with the maximum physical
+		 * block size possible in NVMe.
+		 */
+		if (p->physical_bs_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
+		if (p->io_min_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
+		if (p->io_opt_shift > ilog2(SZ_256M))
+			return -EINVAL;
+
 		if (p->logical_bs_shift > p->physical_bs_shift)
 			return -EINVAL;
 
-- 
2.53.0

