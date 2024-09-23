Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AD19882B;
	Mon, 23 Sep 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089212; cv=none; b=DkOP6XlYUVVimBrbxoRJJ2g/k1IUJ4CPVUeJ6UFWIEuPQ3cGbzcOyGDpDDZ+QX6HgVcCBUFCQWXHwP9QV9fWsTVKaBgoIPeFj+U5ZvjiQDR8XxNHTA9NmIRHq2xDpD3bsNJrqInuG3dMor6t6780o3+7hkNK4CyKpQgJ95tByVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089212; c=relaxed/simple;
	bh=PWT+1guXrrHd8w41xmplQKn+dnohAlXRG9k9pw7PGLM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=css7qjX+ge2Z4EY44jLoiA5m4FH4+kw0W8HckV0WDG0y8gCenbKpDbvfYRiaV59x1oq9azV8PT6vPE+4k5gLUDD01mgtn8c9puqzGVIEdN+HSkTzvy3MPo1B5DDl22Ob863mEj7JUgHm8GKS3gGt7PjF2VNinOpN9pmTUqd/3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOumoSis; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOumoSis"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so39930125e9.2;
        Mon, 23 Sep 2024 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089209; x=1727694009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x09MtPWWqEWKkV0nUWpUR8LWmcgDU81FVOPMzYJK1Qw=;
        b=EOumoSis7aSRovGGsaH4K77u1WaHi2Wh12u3BPNBXHTkFz5QZ19BgZH1M1s8T92vxr
         o5iID4RdGGrSrDmhYQHWdjBz9pzEqWj49pUH5Uv8IWa2nqmzzGMgL+0eDs4fSYSPj4lV
         kz1Y+HlJVeRGtyDkJbkzgiI91wzFErOuWs/gREHhtmA+9+7qYskqlZfr56/uBBQHIEFg
         BSPG6uv6YEU1ujm3n+CUg4GHRjj9casKGFv1EdOV9dYRt0tVi3WJW8UTLS0WS9BxRbnk
         uHpixl7Df4Yf/TqGXQzI6gFOG0Nd2n45dc0AnZrJ/H70rKzKjevMa3LFQU7/xTTJ9Mv9
         bqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089209; x=1727694009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x09MtPWWqEWKkV0nUWpUR8LWmcgDU81FVOPMzYJK1Qw=;
        b=T15Tnp0OCtIItudX3zQ+7CE8jIXPzBXgvfKRQLZEMIVq6SvEivc98xOA83LE2dx+B3
         D9iMjrA/ujbP/dPrDnjUy3rjciceCTN6QHx2gtngaub4vnA3cSWBAGT8a+kW+/hN6UdO
         N9O8Emp6AFe3MzbSaZfyc4e2dlksBBhrI2ue6U3iq0HBwXkL9KRCN6yEuyu2zl1myBgT
         dFadODnqdp5zWiD5qXWcL3stEuvZ1REbDmvP/cfyhHwV6uZVcKJ9HYdq7TFeOVjNNjk9
         7XWAXpc0P43jq4PzT98OYn11lyql+42tOhy4SxK+pZT6TI1DDGJ0+ml3okcIiRcMsTjN
         oz6A==
X-Forwarded-Encrypted: i=1; AJvYcCU0Vrqzkzwr218fzrwksfnSOsJV3VlRfpKVuxYDYpUThtH+bJ/K2k3HqoyUM1FC9J+EIh898c4FEWNW35jP@vger.kernel.org, AJvYcCUTYjXLbSoQqotKrbxCFesY1Hkn5PRR5eX7/4A6DA9oWWNxdRNrRV4tv9u3s152DSOHuFalRMRFnxDhYGs=@vger.kernel.org, AJvYcCWzhCVJnjP38eMNwMT7aNMn02t8NPhv7ImVzuK1qi5JB3+xaWaTQBMbPc0QdDWnlHUXrVyZUdklyEGL@vger.kernel.org, AJvYcCXJAmLgCMnzGbnjv/lI1eoeP71of5PmY5z8AXMndizciZ+e0dxB86cXOdm5EpxyxM6HAaVrVr0eA6qX@vger.kernel.org, AJvYcCXXxXdS8qBC80+3D3EApLU5BAt+0djlmdY3lV3lPy7PFPWn/uQv81j+LnwKsbY/OsYtoUesXYK2uZpx@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj+lxs5HM9AYg98jTKI6nxZkkyRvC9jiJiBChqBsdumXpAMT5
	8pLZN2HVHimaFzUGNU/YISz8aInE4beGM1oU7PAKXM0/m+wmL/mA
X-Google-Smtp-Source: AGHT+IEU5HQ3C058+0DbY6a8UrN+weOTz7jAFhcqQ1j0WR4Tk3irm7jxbjBcvbwYMsdt/6iiNwqK8g==
X-Received: by 2002:a05:600c:46c6:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42e8024f86bmr55011745e9.31.1727089208797;
        Mon, 23 Sep 2024 04:00:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e7afd7490sm97856615e9.28.2024.09.23.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:00:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH 1/4] block: add support for defining read-only partitions
Date: Mon, 23 Sep 2024 12:59:30 +0200
Message-ID: <20240923105937.4374-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923105937.4374-1-ansuelsmth@gmail.com>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for defining read-only partitions and complete support for
it in the cmdline partition parser as the additional "ro" after a
partition is scanned but never actually applied.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/blk.h                | 1 +
 block/partitions/cmdline.c | 3 +++
 block/partitions/core.c    | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..f300212d3e98 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -558,6 +558,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
+#define ADDPART_FLAG_READONLY	4
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 152c85df92b2..da3e719d8e51 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -237,6 +237,9 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 	put_partition(state, slot, subpart->from >> 9,
 		      subpart->size >> 9);
 
+	if (subpart->flags & PF_RDONLY)
+		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
+
 	info = &state->parts[slot].info;
 
 	strscpy(info->volname, subpart->name, sizeof(info->volname));
diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..abad6c83db8f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -373,6 +373,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
+	if (flags & ADDPART_FLAG_READONLY)
+		bdev_set_flag(bdev, BD_READ_ONLY);
+
 	/* everything is up and running, commence */
 	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
 	if (err)
-- 
2.45.2

