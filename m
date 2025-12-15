Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C0433BC
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792710; cv=none; b=q5ocPEaY9LKU6F0K5/1tDgz6TywgGk178b1Tb1XgNtyD5sXcZzmTG8ig+50Q/6Nfjgo3oH0liRZrA/2Uhwsko9C80fI+nRUQ4V2IB+BidND6j3TzgmtXaTw53h1NguCbwdJStyiLKOIMvIdbd6Thvy7tbqmSo3RdZUEWhjlG30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792710; c=relaxed/simple;
	bh=erWqIM6ZSx2bz68Z8HE9m/js5xQQD6d+QSvi/upPCTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWJt4QxIJRkh1FvKnwDjIYIHL0bwAKlEascH5Niu/AaQU/XXexXqfCgpSdg2np9EzzZhBJt7Ci3mRUCIKKVcaq9DOVHYHTBR0LRGMv/YYaD7MU2Z37laMQMO91msOkfuSO5NY84jFCiljipXo2cIaD6WzaNs8uDs0wE94k4lpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbJfr2uO; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbJfr2uO"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a1022dda33so5294785ad.2
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765792708; x=1766397508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erHJWv42eR5+0fURHxPf3eDMpo7jOM4f2flihD2czMU=;
        b=NbJfr2uO266gdoOjVHD5hTtK7L1BLYcw7QwltPQ24PEyKKC+4eqTQdeRlVLLRMv+/E
         wNwy6zp8VCIzlRTd8eyfCDRFvIsaLC9K6K9HLK/ngsw9oBzJosjub82WMCR7vg2nFIjH
         7D7b+ZJn+j/rxJgNS8+D5ZCYsUKUVuCrg0aRacgqfJPk4BBb17CZ6inTpUXgmI9Z1UXg
         /xIBULUPaJjI+n0p2BC3LE4jwGpQcvYEl+0Sb7xPtT6kBd3FfsHYySsTd9dJ+CIwPnfW
         gsFuf3rIXzAa0AD3fhGtaqQ6eaGRzMJGcMGvRcgkis5v5jS2pCWRCedDd+znDDD96gBg
         Uq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765792708; x=1766397508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erHJWv42eR5+0fURHxPf3eDMpo7jOM4f2flihD2czMU=;
        b=WEIRZAHC6ApTs+9o6mN5cUl5L0+jRG9QVyZr7kpl4SKZ6oG9Y+b5Tf0Q9ZPcfBZGuN
         mUSnzf0scnUoPeYdhGcVtclK9igcm5hvufmLD2tSVtcdxidpRRwcQf3esI4PNeOIfW3O
         nemWC5N/AUqsoIfkgo5937/V1Rq8ITHFAC2mfl2Auu3JfsMf536x0ns2Dh7bfZLlNYAT
         Vtlwy+O42iM3plPNwibzAuqULXfBuCTzsrcSNdeeWWD0b05jN9Gc0BJnfcHyGp1adhst
         8UcPebUqquzanQsAUY5lXmYpY9ieV0+vryqEir5Q+Nz4wb+FdR43vah/og3Kv4W+ob+d
         HTSg==
X-Gm-Message-State: AOJu0YxJlf7HsELS0TRagzcTXx9oR3SAfoDngLzvHl9felzNMcogaO63
	u79MJa6RbWOhGJ78sgXlPiFyycH8msWjksAJb41/KyS2Z2gPRj1crrX1
X-Gm-Gg: AY/fxX6BJmcoXrDs3WYw7GT/V7RREsm+Rlo03fHtN2YzyAvBd19FbyMIX17P9NAcpuy
	GRe3tKOO2iyqixXjS0elOBFbDv+tIjuJHyjh8wVNXxezrsw9ee2p6aTtTsuiBsEt9an1w8Gc9sg
	vSumq3jj7Ost3/W0c2cUTHQWZq+OsG/PiQ6AKLhzX3ozCe9KAnfilcr1JW/oGxmRscwxADISc3K
	HyFz/kCc2hz7Y2rB8B8i1xFwVjAaVHQlliOXk1Ztn6/Ov+/3k3PtrcjRmWoW4ioAC3HmiGx/Xvk
	V4j+7ReRBNaXfySscoLHAJhhbBnxMfxo27c8ozpP07oPnV3cAa2MKHWrNDcSqa0s3bdNIvFkmOc
	rcU6TUzzU/ApF0t2SZjGgZXLnktLTiNeL/4jnPyaJEopri8sQXH7WSSjb6dXJppP7hA5PxzXFd0
	i59CpV794B5bsbx4bErMnnS6i+U+m11j87YSFPaYXgswjag9eu5SXDmHnrAVrLcSsNsGC7
X-Google-Smtp-Source: AGHT+IG3aLFhVm/eM5FvFbK5TpukoOwZcAFQ0Q3ntfULOxDhWZxUUI01oPNZaQ2do74RAUE5M8aTrA==
X-Received: by 2002:a17:902:f647:b0:2a1:5d5:78a7 with SMTP id d9443c01a7336-2a105d5791fmr14559505ad.24.1765792707709;
        Mon, 15 Dec 2025 01:58:27 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0f58d7c27sm24380725ad.24.2025.12.15.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:58:27 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [RESEND PATCH 1/1] Documentation: admin-guide: blockdev: replace zone_capacity with zone_capacity_mb when creating devices
Date: Mon, 15 Dec 2025 17:58:17 +0800
Message-ID: <20251215095816.1495942-2-yangyongpeng.storage@gmail.com>
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

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
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

