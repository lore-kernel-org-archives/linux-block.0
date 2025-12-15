Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32428CF6F
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792336; cv=none; b=EdYLJxSil01LixKYqcCdr7Az+5llfw4+6xw3ixYgLjCfslj7hbdrVmvk8ihBev22cqBdIjA8CBrDg9FbM/GQIDhz58MMJxLCFK7/E5ALlw6vQCm+GsoJWXQL5+qLyaY8f+1LiCqh4Gu9tirDSEksmWFSJWQH/+Wac+wmNWXq8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792336; c=relaxed/simple;
	bh=gI8tNxhia2pIMeY36jPYkFM9x5yJfMfUX4jClXweBEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hx+wM4HIuOnH2K8U2iz9icYZVv/g8whCLID5AvttBWCgyczj8DgTDV3giTIKR7o6fBcJOiVu1x/4SusRbIdh741o4kFHE1sNONg2pY+1+Bpz+vrh2DS7LBi7PCFbpnwWymR7rLa41CUSRxps7we+7YIVKe5c4MkbOPz6Izw+OS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCqTzaDX; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCqTzaDX"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34c718c5481so825863a91.3
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 01:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765792333; x=1766397133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4ciVJ7aamtPIgOYSgD/1Gz4e5eZe7ufgjmRlA1cyXQ=;
        b=fCqTzaDXUpf7oxxOK7DhtQl9uwWDp7akm/uWlVBvLpLmr2Ljx6Dg6GZPs9w8I+GjR2
         awYhHJ3hyzRXbgJ2ivoj05cura00ewgeKR40cRbzXsL6ksFUfUBO+HQTUNuD9RhT2sV8
         UIfbrj1/R7GRsfCEuXfNhGvAfUEYZ6McD7NBO9SanJfyCBeyQNMRS5zu1K7S7txKjoCG
         YZHGL6ubLO7JtZFJnPFrL8RnJQRJtD1LlZvg36bRQJG7mzoo7+IPQYYwxXUy1Vipqyu/
         y558qTcOSSNF7pzG7+deM+/w+0fxw+AHXZ4w8ecduX0Eyc8LLH+zxplE1qQHMghAADr4
         enCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765792333; x=1766397133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4ciVJ7aamtPIgOYSgD/1Gz4e5eZe7ufgjmRlA1cyXQ=;
        b=OzT0lDDbt1I6UAF+fw+uzZNrUDjS7UDaCPP6gUv4JVC/yaQxIy2W82s2M8sgJJn4e3
         Q2nROvaeYhCrJ7J5job3U4i2t6gR4nx8Mk3RGt4Yd/Fq5IqR4AQHdRjef0oFthyN+Ga/
         8reZqQoqxnwTb1I+35jKWvLbgDnv9TM84twK9OeLLbYm/spfmN0lDODZaC2UzXbQEj9Z
         bls+t04Lf56E4aXRjoBh7d8v4G7f4DTQ6oOzwBG5q8xK1LuTjLQgq8T0r25ivoUqTcQA
         0T481zaetURj9NS/d6iXJYeWqX8N1++/MSHUvevE03dSWnsQGplZwyJRirT75YQxi8ZA
         vpbw==
X-Gm-Message-State: AOJu0Yxd+cx78feBRFbsxkeUaRsz9ACiTDvnm5e33HnqPhb1QPbJ7hRi
	mTL8Wi7BevQpYBu+7/uin2nHWOeZRpkhW7p0e+Qb6M96WuwZ8pIb0Rn3
X-Gm-Gg: AY/fxX4dM1NCL70GawKBH0srk8aZCvRN7kHJms/lYW3EQy+375bUMC0VyXrgBOnY96T
	WVmrCVCX8BqssE0Ak+RF8AYgCJo7365DbpoUpgRHDeL9UNpZ/qWappGlFGvFmv51wIe2vArpyqn
	Yz2gloV9L5kkZREg03VCW/q1XzyOY8704508/j/QD+2X3oJc70kKNjhFl8Ok7dGmi4IDiDgMClT
	BxR/PW065gc1M2kFQgghYHHIaz76S+1Ry/ux3fRCp1XV52epn/U/mWTNtX8QdO7ZLscbeUfQqxL
	3bMM0GBzCZoCOiMzjoALa97EU0X6ewws+AsQqW4b7fy0UYXn2amkQccYa5A4El5U4mfZ70LsCPN
	y8CuDZGsHCKTW+iBmgtOiQ5P/6l/404P8n4A9ncoVGdqwZ7AjZJl4E1hHxiSop6diC3BLP1fgp4
	1hVr79L0MzaL2b1atwzaydZIjXlW3NLRwKF2Vbg43ZNWzxcKC0F/5Pfywvqg==
X-Google-Smtp-Source: AGHT+IEJbMIduxLFHFK//1a07qGKZ1U2RE6zDiI9pqN+Fv2EYH5Lb8cJ+jvZP9BTh70M+HCJphMEyA==
X-Received: by 2002:a17:90b:3d4b:b0:340:b06f:7134 with SMTP id 98e67ed59e1d1-34abd768b65mr9472586a91.20.1765792333347;
        Mon, 15 Dec 2025 01:52:13 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba5eesm8288688a91.6.2025.12.15.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:52:13 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH 1/1] Documentation: admin-guide: blockdev: replace zone_capacity with zone_capacity_mb when creating devices
Date: Mon, 15 Dec 2025 17:51:50 +0800
Message-ID: <20251215095149.1494265-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The "zone_capacity=%umb" option is no longer used. The effective option
is now "zone_capacity_mb=%u", so update the documentation accordingly.
---
 Documentation/admin-guide/blockdev/zoned_loop.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 806adde664db..6aa865424ac3 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -134,7 +134,7 @@ MB and a zone capacity of 63 MB::
 
         $ modprobe zloop
         $ mkdir -p /var/local/zloop/0
-        $ echo "add capacity_mb=2048,zone_size_mb=64,zone_capacity=63MB" > /dev/zloop-control
+        $ echo "add capacity_mb=2048,zone_size_mb=64,zone_capacity_mb=63" > /dev/zloop-control
 
 For the device created (/dev/zloop0), the zone backing files are all created
 under the default base directory (/var/local/zloop)::
-- 
2.43.0

