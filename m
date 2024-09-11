Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76F1A265A;
	Wed, 11 Sep 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061406; cv=none; b=BjcXarEbKzJJOiReDwrLcgtrHYDP2YWCo2vBkIRFsYD6B8h57E8UJGdZpev4/VVQtJyCmPOoCOWUwXZXzdNlV5KqmfaVlnwK5iWSV/y+t57m4B/aKE5eBKqtAG2SXcUFzWGPW4FwYHTHQKCv9f4Akq720PhIhhEUjXBTszOAOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061406; c=relaxed/simple;
	bh=dMhEphHy+O8j39E5txrufUCudty2PVP4cqsdsV9+XAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPReWUxvVFBJjpex36u73c+1e6ZfD8tMPJ3uedNeHn1HXWF3T0WcxuvrKKyGe/oFZVEaKZkGXTiB3FNc2pNe3c0tGwzKUbVy7Sq7eOKh1MKVTBmpJZ6/+WZIUz8ewOI1qIixw04PU6JS0lPIxiZRJgcGwao94UIvdANpILy5phU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N72ZPXwu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N72ZPXwu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1596921a12.3;
        Wed, 11 Sep 2024 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726061404; x=1726666204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlcZXnZFv9I9uByKvWIO0FNVwpBbdTye0whj7Tlruj0=;
        b=N72ZPXwucDkLphGrPu9NRxsTyXAVlW8XnKP/1/J3tHucEdEk6/1zsU7xjw7tn3QCW9
         3WwQp5eMZ2peUJRtOXCZfubYheZZv2E3hXst/lzfaNG8PPaoHWRAyoezEKvGOHYIslDE
         G+/wuwy5YPRkHwEUc/uesMQLCHPLFgbHuSK5FqZ3QKKPTpEswvD4hmnrbWTUO2bX8Iup
         UZBztTMxe3E6tvoRlfYUluURc/j2wOgildwPl27QXQ6KXXUQQTlVYDvtNZ9Y7O0V6bVX
         dL2aazX/AbrLPwZLqGqYaOyyPaEe+X4gGYad5NtGcCra+M6PMvBkMHI3ywu2jM33CWZZ
         odlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726061404; x=1726666204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlcZXnZFv9I9uByKvWIO0FNVwpBbdTye0whj7Tlruj0=;
        b=KFQ7hCWSpCRMWti2k5LXJYvjcULrstTMqtRDoj8vE2WioUZyxjQwjL9sy8jbOYcAtV
         9MB5l/PlBp/eDol9a34bSzO0ua2PKZDgMMJ/0OOKquTXJuaLdD25ZzA59J718onSMd5d
         bTyqCiZvz01EPILOCkYxV004PQlIOb7x3/R7Fc/wqtsRbYJSL9G6wMCghVGCP+MyRdsK
         QWavVJntkcDTdiCatBMg7fWMsRIc1nyBhFOGXZct7EYhomIzq+m0bnRQ3ebK5IAANRed
         S6C7bsYn2/iqzwSVzfxHnq0ivw4eMJkdihRHTEEBWpInZHamnyTmhT5XypF8LpnTZDIU
         ctvg==
X-Forwarded-Encrypted: i=1; AJvYcCU3T7aLWJYfCBaEmV9bu+Urixc2gIb47CAuV4DtcdDw73uvOVyfdedIFMtIVz5RE2I4yN2gM531lt05d6JB@vger.kernel.org, AJvYcCUCvqCgmHy8MY1O4SKIKzuFPReC/hBQd8gsbvV7eA6vWVd0BOkeff93JCAli1ToF29vHWGew+fMD1xO5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvldFTQIw+jfOw8H4mS4cn7E77ZG8kH7T4kCWmOotv9SodNuSN
	ZXDKUQto8IP3DV9Nak81l5Pak4teL6lWWKrzsdq488W8ZLklkqU8
X-Google-Smtp-Source: AGHT+IGOv+OxMXBI2jZQjqzHkQqEgB82w8HnI3pTqrR6G/ldM1+rnr/L4pV1cx1RTVwseXp5Av8Pfw==
X-Received: by 2002:a17:90b:1e4c:b0:2d8:d098:4f31 with SMTP id 98e67ed59e1d1-2db82fe9fd4mr3629539a91.17.1726061403557;
        Wed, 11 Sep 2024 06:30:03 -0700 (PDT)
Received: from fedora.. ([106.219.162.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc110527sm10543906a91.36.2024.09.11.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:30:03 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] block: fix potential invalid pointer dereference in blk_add_partition
Date: Wed, 11 Sep 2024 18:59:54 +0530
Message-ID: <20240911132954.5874-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blk_add_partition() function initially used a single if-condition
(IS_ERR(part)) to check for errors when adding a partition. This was
modified to handle the specific case of -ENXIO separately, allowing the
function to proceed without logging the error in this case. However,
this change unintentionally left a path where md_autodetect_dev()
could be called without confirming that part is a valid pointer.

This commit separates the error handling logic by splitting the
initial if-condition, improving code readability and handling specific
error scenarios explicitly. The function now distinguishes the general
error case from -ENXIO without altering the existing behavior of
md_autodetect_dev() calls.

Fixes: b72053072c0b (block: allow partitions on host aware zone devices)
Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only.
V2 -> removed line between Fixes tag and Signed-off and cc commit author

 block/partitions/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..5bd7a603092e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -555,9 +555,11 @@ static bool blk_add_partition(struct gendisk *disk,
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
 			     &state->parts[p].info);
-	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
-		printk(KERN_ERR " %s: p%d could not be added: %pe\n",
-		       disk->disk_name, p, part);
+	if (IS_ERR(part)) {
+		if (PTR_ERR(part) != -ENXIO) {
+			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
+			       disk->disk_name, p, part);
+		}
 		return true;
 	}
 
-- 
2.46.0

