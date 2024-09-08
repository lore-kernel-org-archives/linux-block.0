Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CAC8D7;
	Sun,  8 Sep 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725815446; cv=none; b=CPrRyBzNUyMuHB1oO+D4+TutsBrI4nYc6j9hnFcAQMV6QiZHPNtX39yrmWg8/9m4P5si0IsNZfCBK4Mhb8n/o1DBuWJnDs1+cFQngeCCr8eYfQ4yVdaiNhsXQLinKELhOPQwFoCEFjxKOEgAV6uVkJB6b46V2wCsZ1yduIV5FzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725815446; c=relaxed/simple;
	bh=ETmEyKY/wmFWkgs6oDDGLtk+Ums6ozmdGe3NhiKv9lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTD/boe5Ox5vpwisyftPDhY8CGjoOUvu7Y7lstAY6TWeYqP7bYK1mBbtt6JHAZtWXFye7gCi2uMcPC0ehPQM5Bd9F9RZEe6RBOoW6raECTijrKBKv5JzQDI3e+A1RsApXF4F1GBh+E+NNObfNExZe5ox3cTs06KeNv4CT8ecMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOdtHTwP; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOdtHTwP"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2705d31a35cso2209011fac.0;
        Sun, 08 Sep 2024 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725815443; x=1726420243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=byBuFjgDxI+Clh3ypYFOuNkNtpRkS52941a5a/b/UG0=;
        b=BOdtHTwPrOOjojLoDbmFRbPIVtX6oaA1v1yUduuPaa2TBrMBVwSt1w3vbxaHjDIW5v
         eqavkodYHP0b7vxK6qn1YJ8h+OS42I7yXI4B8sp9BA18bt0pQGklMm9r4zPQ49QLx7jY
         lwpircVHV4d8g4TbS+sJTdRVM+o7G3Kq8ShEjB/UuEG8DtpLBaRIE24i8inUhH2YhpXK
         8mci7DErRBHm+eUE998WKueeH5CZrtlydSHL/HeZI0JtSDsazLgMOIfQhpvt9TkePydB
         g+8ZAnLYntTEyWiMUXMiLWpFT+lMa8pIVW4aG74SHviz5keSjDQ3y6i1TSdodSfEGlRK
         Dz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725815443; x=1726420243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byBuFjgDxI+Clh3ypYFOuNkNtpRkS52941a5a/b/UG0=;
        b=JfNRon6kIH+66fqmfVq1iT1m4MzE/N/lfzjSM0JDxKDEEQ5ATrV5w8Rej3dTMloBLo
         nZ/3qa7+iITZjT069GmQTpjsvk+pv8JYg6npZGBme/0rbyaC9yS6nNVjn5Zcfna1EQ1w
         8YD1I4MOmStA5I/35kcywXleJ01hPCb3Cx6n2GkJDLNcL7HSfXWEm50BqMsxDmA3mJ52
         SUw6g59cxt51cY+fZfxHAAuGteseWXIqE1Ad7b4ud48B6J8EtdbditHas4OsTh7IiJAn
         YWO9tpxFxAJDVBjfc+mZQOmvQ+l4be56KEBnIghZE0xfUArVSavMYbClcHXYkszNadkx
         W6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoPIV6oHHAyzFp+AmEZsr+CpUFcRUIN1bBGs8dDzGSsYq6Nso7NCcElOrBNAX6Dy73bmGijiRHwmPiZjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/Ns2Ti6690/PWP1166+SOf/2wWo524xPqeWNtkuRQlf3kqzF
	qQj1YbRGHai41JXW2YJVFF5AJPKTDU2bZEOTbKmWkNhMEUgRvRjI
X-Google-Smtp-Source: AGHT+IHl3f6WSZw7QaESPgVzFX6GH959Zxb37RMZB5GYNtWCuMeDpv79hH7EnhuumG50S5l8PS7Hfg==
X-Received: by 2002:a05:6870:a54b:b0:278:237:57ea with SMTP id 586e51a60fabf-27b82ea9594mr9741493fac.28.1725815443447;
        Sun, 08 Sep 2024 10:10:43 -0700 (PDT)
Received: from fedora.. ([106.219.163.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d82092e957sm2610168a12.0.2024.09.08.10.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:10:42 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] block: fix potential invalid pointer dereference in blk_add_partition
Date: Sun,  8 Sep 2024 22:40:36 +0530
Message-ID: <20240908171036.71874-1-riyandhiman14@gmail.com>
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
Compile tested only

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

