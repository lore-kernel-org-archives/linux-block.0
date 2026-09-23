Received: from mail-dy2-f1.google.com (mail-dy2-f1.google.com [74.125.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615452FE07D
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146898; cv=none; b=H5dAvd6+NaLK/20t/SB2gtnNVx/EKn9HIQipjXTaa1uX6LASPGkzgt+J8OwjZvFIuNcvYBjIkxV83HwBMgPYWDb94xJkS7nc6V9HaaqAD39mbvcHiN9OdNSF8oZi0mXnljcUVzIu1DphotUxIwp1JRtC7Bs+RvhAzKtMYH+fx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146898; c=relaxed/simple;
	bh=obsTMBLuGpMSfaLfy22gbz4UlV890qwEszUgqrLdmyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fp4BgKP7nuNvJt62pyBFib1w5BqPtQ0UMHXL4h2qQdo6seg/+2+ia1VcxhASCGDnnG/CH2OQ9F8LUSmR65CBTg3gbL9smG1NVzEHnpL6ouJfbld1AF+aoeuEYaVqTNJ81Tw2fq7ec+Bh84+TW+dA5z9t7DpekwEeYzROvR0nhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp3w9MGM; arc=none smtp.client-ip=74.125.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp3w9MGM"
Received: by mail-dy2-f1.google.com with SMTP id 5a478bee46e88-313be8d47d4so298592eec.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790146896; x=1790751696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH4BSQ01Tb47RkHnHR9gmpoXGNiJC9eaCsuZ6hGII7E=;
        b=Fp3w9MGMiMr36MKkzALjriukef3X9UoXTSE4AOFv05DH4ABVla7syeYYpbtqoNkPnv
         veDWDvg1V74K+ytx6Q8vihBMSpaeg1PCrF92sPd3h2Msh9PtmUpJW7Wq2cA67zd2mk0z
         pFxpZkCqO9hq/DXZC4BsxLJVvLMOjD/VuUzjLAXIP+hH0O4kT7tUzk7lPfx3cqLJ+Wyh
         ciAqkyvrhYyBpbJU6fE7kjGglPR1YoZIv85mhJ8wvqMtud3HHXJ+M5ROJuj3aCYpTLPJ
         BSKArpED0IDkwzXHrM2Un9S2YvtprSq6I/Cr+rk37nv8kYP0wtoGGfUQViAjawo2QP4f
         mb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146896; x=1790751696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH4BSQ01Tb47RkHnHR9gmpoXGNiJC9eaCsuZ6hGII7E=;
        b=agJl/gx3RitXDdxGnsSw2iL+5V8jrCL4C71OgTJYnDRK6jB7Xyv9312uemgxhV2fuC
         ieIAXD701DtOHtS30hTG8wFoi7Pf6UxsUU+fWZIwDCK/a29Zi78R/ShzDf5LmnFHxf4l
         1mx1eS056AYAY6Tz4JQkg+KoS+Lz/EyltP2PfUZjYU6CyFJulY6gfCqBUcP9QNPgydPd
         BIPzX11W8FmJhvrpXwBRu/xWYDo7sbDNllzsM4BCb9AOBnHGuY6wMQYPVnwBvL7ocrMy
         DbqzBLBLcvUQ47XHi/HxXS8my+c1kMY9sn5ePeRLon4hYofnuqjAnPmXJopNqcVd2/Gz
         DNqA==
X-Forwarded-Encrypted: i=1; AKwUvBxj5Qi65+lPvvHi/RZYHakfANZ+LYAehJD95X9rqR5UMtGIunuRZMOBA5zqaYQHJn2fDAe/AW1DCYlANQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lg/1YoP/0gmgIwor9oIUdCVsfVHV8YDwzzQTJKrSctJo9aHgAY
	UlJIm2Fvs7k3lfWYRrvNJivZz+NPQsabimUVdCK9rw+3klTM/RlGHNMm
X-Gm-Gg: AYBFou3kKtEAi+gq9v/YFsEMmkn92ftrj/D101lrT1Fg7/TpPZW/8yKn/Ar19CStDxS
	rQcHtNnnsHsoeKQI0K8kxRbkobZolxa3aoa+s7Z7klX1Cxe+87i6GsaV7bG/GHvhxiwU8rhksa8
	z6Emwc3AO/mj2fVBm3NSpoKTZsQ49/FYmvTvk72jLqjZMtyI8fb7IHm5sp1rdxlFBQeZNCA7fr/
	gijc7VcngBqgfUCn8knD1RCvlky6DfiSHWe3poAGlr+KAAdc6n/MidpapIy2TSPLIvfA1deT4uM
	Tv+tiAvxYVQ+IFpVVV3WPT3yCPjZdPjOtcmHS0iNYGTnv/4msJaEVssji6d+LToKHUS9GByHlOU
	f+2rWM1XdPl6kepBw9P8ENFzNwpUeMph0GBUKJ5VOaljfbEl34H97MKYsHpgmLFaStiuNBtjvu0
	kRflIuNw6K3sDMS0XBA/vqQwJhNb3JCo1yyxJnu3H0RdUy+NqQCc+QtdYvTiX+I0PuEj7DXRHfq
	T3LbB0mycMSwvhp2mAVgQ/sDrUFtMPNjsUMpBspJDQ06y1+xgt+
X-Received: by 2002:a05:7300:fb0a:b0:33b:dd20:f799 with SMTP id 5a478bee46e88-33e8d9cd5bcmr1542183eec.22.1790146896217;
        Wed, 23 Sep 2026 00:01:36 -0700 (PDT)
Received: from Raccoon ([113.30.177.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96848e18sm3690800eec.17.2026.09.23.00.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:01:35 -0700 (PDT)
From: Rohinthan P <rokinthanp03@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com
Cc: Rohinthan P <rokinthanp03@gmail.com>
Subject: [PATCH] null_blk: reject blocking/memory-backed devices sharing non-blocking tag set
Date: Wed, 23 Sep 2026 12:31:26 +0530
Message-ID: <20260923070126.21936-1-rokinthanp03@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a null_blk device is configured via configfs with shared_tags=1
and memory_backed=1 (or blocking=1), null_validate_conf() sets
dev->blocking = true because memory-backed devices allocate memory
during request handling.

However, when dev->shared_tags is enabled, the device uses the global
tag_set. The global tag_set is initialized by null_init_global_tag_set()
according to the module parameter g_blocking. If the module was loaded
without blocking=1 (g_blocking == false, the default), the global
tag_set does not have BLK_MQ_F_BLOCKING set in tag_set.flags.

Consequently, blk_mq_run_dispatch_ops() dispatches requests holding an
RCU read lock (rcu_read_lock()) rather than SRCU. During I/O execution,
null_queue_rq() -> null_handle_memory_backed() -> null_insert_page()
calls null_alloc_page(), which invokes kmalloc(..., GFP_NOIO),
alloc_pages(GFP_NOIO, 0), and radix_tree_preload(GFP_NOIO). Because
GFP_NOIO can sleep, this triggers a sleeping-in-invalid-context bug:

    BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6031
    RCU nest depth: 1, expected: 0
    1 lock held by syz-executor:
     #0: rcu_read_lock at blk_mq_dispatch_queue_requests
    Call Trace:
     dump_stack_lvl
     __might_resched
     might_alloc
     null_alloc_page drivers/block/null_blk/main.c:878
     null_insert_page drivers/block/null_blk/main.c:1027
     copy_to_nullb drivers/block/null_blk/main.c:1165
     null_handle_memory_backed drivers/block/null_blk/main.c:1388
     null_queue_rq drivers/block/null_blk/main.c:1711
     blk_mq_dispatch_queue_requests block/blk-mq.c:2872

Reject configurations in null_validate_conf() where a blocking or
memory-backed device attempts to share a non-blocking global tag set
(dev->shared_tags && dev->blocking && !g_blocking).

Fixes: 14509b748ff5 ("null_blk: add configfs variable shared_tags")
Reported-by: syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=95fdab36405e5ffdb680
Signed-off-by: Rohinthan P <rokinthanp03@gmail.com>
---
 drivers/block/null_blk/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4a9beec..64b8bee 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1940,6 +1940,11 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->shared_tags && dev->blocking && !g_blocking) {
+		pr_err("blocking/memory-backed devices cannot share non-blocking tag set\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

