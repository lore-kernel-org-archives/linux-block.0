Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416823D2A4
	for <linux-block@vger.kernel.org>; Sun, 10 May 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424547; cv=none; b=QYwK2+jwuf5CLDqywH5z+8s6iV82HkNn4Wc/Jtb9afkjBzmJxcKNiph5M4vDp2kD3VuqqVKf5TfLn4eFL2Kn1WDbF4xQiXkubJyCNu4Uwn6wUBK/Qbke1GvO3UuwkWN/bsKVuopvm1dsMRAWcmG/rhiWZmgtOJWBe/2DXvwoNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424547; c=relaxed/simple;
	bh=ZpGIZooHvyCaM23X8KoDD22lte+g48sZVhJpD4CQjZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqiK2MXHVKdhml+YeOqKJn2lFYz1Cd2BVIB4k1CZup8z1dbi4YNhh2YM1piqi42phfOCU8Li/ZOhrF6cSfOIw1fLsyGnNQCye8schpRRfDnpB0iQUl4dTv2Lsxms+6TaPkU4xiLDncuw2EK3ELTxzsqrPfpEB+ctKYP1NYlqHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSPlqclW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSPlqclW"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-688a8e5fe5eso1948498eaf.1
        for <linux-block@vger.kernel.org>; Sun, 10 May 2026 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778424545; x=1779029345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKeKMzVuN+Q4+ggIv9AxHnpALZ5wahySne+sxkygPIc=;
        b=ZSPlqclWumBFSkrLX5R1DeVzwyl3ygGHeQVE1MQFUldHV4kTDGygbRLFPJUISYMP9q
         k7C8zaNeQROMp07iOtk/i2p8GGIEAcVShLyRb0RP8EA7/OxBBYrhBWEyEXpGXSAwc7xx
         8EXAku3X5lLugqJg50g458n5tJIxlM3zbCfpLMTrc+WP1bgYCpUW7u1sCuaXjfjIcidn
         AXprQm1iyjhNiZLQnLU3ihg1t8PAepfgZT3ojvi/h0jcQ+HgjUPj45fptLyTPJZMND8K
         WOv6zfPpv3NaGkRzwGOMUWWSUPis02KnGekMfeuuKfwKNNko4UiUCG8QcZj8aVzvHXr5
         xtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778424545; x=1779029345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKeKMzVuN+Q4+ggIv9AxHnpALZ5wahySne+sxkygPIc=;
        b=rMiOK/np3F8/E+fRl5gWz4vHpuVU6jnicoxBwjtDdvir12RJPaHjBOJU0mc5gQkFKf
         uapYe7MiRIIkxeb2E8FUvyHtQdvq+tAYrlDkW1wHxho3twP2jgaZ85YWg0ge597p2Bnk
         oYwY3fLcmMJCNstGYsR6yQFqCtSbhPSMYgRr4HSWB/YU7JdaBvvL7+MSaXB0XUlOdgI7
         8jD0tQ6i0iSzzvFOnF0cD9EWukfTKHr9516+vGzNZJimUYUGbm3cyKtXxQUMrzo5AO4L
         FdYrz5BMKGneoAOEtn6fL3n2VkVUaeU58ZbUlUpClRN39DR+23SUxA46pKzCCyuZ2xl5
         zLAg==
X-Forwarded-Encrypted: i=1; AFNElJ+tF03mgtuh8lCNbRz2U6qg4jyBhGPZKcrVQ6nBDvYFiSKfbHe/Z2yJLA82OhGjMRnCMkw3C2mlfO4QQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHovHoS2IMC0LYyXiQrMzqkDnFacKrjG8dw9qn0cwhU0fZDSCn
	eymVrQb7dQdVSDL08aSDy7y3pkO44d9LcdIkuprevJSikfDI1xTT7Qkk
X-Gm-Gg: Acq92OHT9zsifP++usK/936eWfVrZB39nKW3wTE9U5TMwYlLFxlHm7y1r41RoY44FHA
	Wxy7k/odIeWnVN4LXD9NaulVKjbjbmzUo5+KSKtoSlXFMHdWZCJBjWV7ONMK432VubPZ577D4zL
	6innGuIRJ5Kvt6DcC2SW0QsCbXfn07B+ogvMIshr3oGJzp+7HUqOBlOFk1wu0odiHpw6AOv4WVr
	cbZUr+qBJPIKO20RvX4xJ8+R0ERyQVXUPvyyG/PpwqD3wzr9+TbJURs3l2Fvfl9FW1jocELOH8k
	U5QdppklBQaAHUtxuj6dfcvwB7ogPaoOwya7R/vT7LaD/xORpGJq+MEpFhwNY6fNFmb22g9dUlM
	4Uf0sA7C4J2VniUiEepmvXYakBQ62fMiVrDNpfNAJ7cI7BbeNGSwRLPSSFhr3BVtGg3TbpqxWuY
	Vs6flS9YvXa4a2bSDq7J3mPXdvs+ng5toPNmZ4wHH9AHfiBMFV
X-Received: by 2002:a05:6820:1794:b0:696:32ad:e894 with SMTP id 006d021491bc7-69998cbe086mr11444647eaf.23.1778424545066;
        Sun, 10 May 2026 07:49:05 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c76cc4sm4482300eaf.6.2026.05.10.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 07:49:04 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] ublk: reject max_sectors smaller than PAGE_SECTORS in parameter validation
Date: Sun, 10 May 2026 22:48:43 +0800
Message-ID: <20260510144843.769031-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_validate_limits() requires max_hw_sectors >= PAGE_SECTORS and fires
a WARN_ON_ONCE if this invariant is violated. ublk_validate_params()
only checked the upper bound of max_sectors against max_io_buf_bytes,
allowing userspace to pass small values (including zero) that trigger
the warning when blk_mq_alloc_disk() is called from
ublk_ctrl_start_dev().

Before 494ea040bcb5, ublk used blk_queue_max_hw_sectors() which silently
clamped small values up to PAGE_SECTORS. The conversion to passing
queue_limits directly to blk_mq_alloc_disk() lost that clamping and now
hits blk_validate_limits()'s WARN_ON_ONCE instead.

Validate that max_sectors is at least PAGE_SECTORS in
ublk_validate_params() so invalid values are rejected early with
-EINVAL instead of reaching the block layer.

Fixes: 494ea040bcb5 ("ublk: pass queue_limits to blk_mq_alloc_disk")
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6d13f1481de0..6c041eaebdb9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -920,6 +920,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
 		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 			return -EINVAL;
 
+		if (p->max_sectors < PAGE_SECTORS)
+			return -EINVAL;
+
 		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
 			return -EINVAL;
 	} else
-- 
2.53.0

