Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002837C11D
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780230942; cv=none; b=qyXNW0sdG77HDqVVln7VmbTK1urVAjt7/i9aFpQMKTZEiHp2V5pi/uJKVb+LaLRFq5kDl1/+vppqeCmPotxVlAtuNi07vCJU36n6b/mbvol+CjbFifD9vGJo1eQRRB2NpZ8i2COxwlLrcUQnyLuFLozdFnt4rXt4cseRet7REuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780230942; c=relaxed/simple;
	bh=5K6jI7JFHe7FUIvV9uN1RWnD5dUnVYFc8z5pQxjkUFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JVUXgfZgvS+335c1VxAGsecATcKbNOP+DQcx06zC0qsPGnsLihsqZ7P5QqaYaE3BIhUByyFFfhacFCDonEsfbv03FopqVc+LTdUgdCFI7UxZ/ThRfocj8M9rkkqBUOGdFT+1uXSi2jBeKxF9R5l1kSdbcKQgn5qMEJpBOMzGpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L150oycC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L150oycC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf18c30bb2so18500995ad.0
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780230941; x=1780835741; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfgyKc7oYPiDXAc6Y5k9wYfmjU0jfx8Oqt1OQ3/P3TI=;
        b=L150oycCwJvPVlmqoJ070JXaBJvwybocWMIGBBDRVD8o8jgpKP1RqRaZ7khGwIa3HL
         +h+2SOa7VY0QWLx4X9D46AzMc/arwWWb0kkFr7rRFykTlyzQ4Xwqcb64+iDevdkvdiJN
         QBiSC/zIM3tkZBSpmF9O7IiQcG+ShKu0eY00B6QjL89JYgM4wkVNLGMFj/7R2OjSkkUS
         otd0YX3LH2nXtDBWni2SuMX2Km979sBoaGWxFY9Cvhlj4uyITfvoY5tkgmFmGrqZgHyy
         0r2w1aQtjMWEbcsus0qtzIDeu9WcMZgLCa8rAzK7HQqQ3AOx5Ii9Hvt96NBQVI+khcn6
         XCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780230941; x=1780835741;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfgyKc7oYPiDXAc6Y5k9wYfmjU0jfx8Oqt1OQ3/P3TI=;
        b=EXeAZwJ5bVygGhh4TEdtr0B4A4KMTl3zT+/I8vCQKPt68ts7YDIRxlQ/F2jU4TW3KW
         c7GG4/mpRxBOkwfZ/dmCDa0BkE9a1H+evq6FRZN5h3RX9xXeB72mPZo1dGS7X7JlxrWY
         af0fEOL9o6GxRZrWVuYP/a3bQFVTDTi/VW/NMAyop9Ew7Cy5JiEpE+wDA9/XPreWAnLG
         nxPGPfPQbA5Nbop8aqcQx6AdDS3edIOz8StJx3NrUFPmgKVcTDIUw/9MDRtmcOExzKKn
         pXDF9GwojzCi4sUPDpfJiGdjRlReE9NIeUwRpklyRzHoH0GDinLQB7m0PSh3eirf8Z5i
         hPZw==
X-Forwarded-Encrypted: i=1; AFNElJ+Kv0e5dzDve7Ip3/0CK4K772I/4vcSXQ+whitZQu9psxt034sQuzwbFfMi9idWYrG//lmdNJcgHk390g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0YnJ7oSCGaEFe/K7Yr3g1MyTHG2zf+2IuhegLTIF4gMp8N03
	ohajHN3Lfxzuc9OoPlFB35QRnZzCnGuVPjQodRv7wvsb13tmgGqLcIdP
X-Gm-Gg: Acq92OFgY0foeuM7ZVwyYWF5+N09VKdmZBiYO15g65L4ZSfey1D2n3H8EzgR6q4rkoB
	aPpS8lHs2A2rvRumdJvUV6E+JkfngPQ9uk3Rqdt1jeUsHZAGb65fnYgx8wlAgw7BS+8HnyMy3FH
	AysxtVbOiDIiY1Cy0EKE8CyeOEFHh2vHBnIeHHcQ4e6dQ6FahDsbGkHkLXMRac6qNGdhbRfDBCd
	EbJD0fUeQ92D/rk0Jd4uohH+Jt4/4YBS0sYywwxwVNcSIfSmMlyPECNeBw5v1YB9h2hKh8DICiC
	hJW4S70QqA/UCxo1Mn3CWyydiZmb31ZmVY44BsNLxe2TS3vkQjEy074EN9kuv6HSbo+s81/9prK
	Bzh4XDE4zU5qjxe5IPl1rlUR71ET69kagjKZy3KD8QpF2OJiiUeT0V0wwvsvuWj7fhv4viRQ9sW
	f6axdegGXsf2VJKkh/Z3mSYoPWwNMB8cCuTdAq8JvwVW6PGV6auZ+ae5+BukYdXR1v3k8k8KGV9
	4wnY1eaNg==
X-Received: by 2002:a17:903:3585:b0:2bd:a5e:4c66 with SMTP id d9443c01a7336-2bf367c2510mr81775325ad.14.1780230940704;
        Sun, 31 May 2026 05:35:40 -0700 (PDT)
Received: from NV-J4GCB44.localdomain ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011d3sm75581205ad.52.2026.05.31.05.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:35:40 -0700 (PDT)
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Sun, 31 May 2026 20:35:16 +0800
Subject: [PATCH] zram: fix partial I/O config check
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAMrHGoC/x2NSQ7CMAwAv1L5jKUmQFi+UnEwxmmt0iRyEEJU/
 TsRxznMzApVTKXCtVvB5K1Vc2rgdh3wRGkU1Edj8L0P/XHv8Gu0YNQPFrKX0hM1I+cUdUSehGf
 MCWkuC3Lw98vJH1yIZ2i5YtK0/2q4bdsPilMcgnoAAAA=
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, 
 Jianyue Wu <wujianyue000@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1780230924; l=1070;
 i=wujianyue000@gmail.com; s=id_ed25519; h=from:subject:message-id;
 bh=5K6jI7JFHe7FUIvV9uN1RWnD5dUnVYFc8z5pQxjkUFc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgW51Zh3v9nG0Wlld2Ti8ylp1TnO7yB
 H+z9CbXty/WEAQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBkwggpDqSVHNBr+N81oydCDWAZf7H8FHq6RvO+oz1JCXQJEzyz8+E3c5iCUO5K71cROfmO25gN
 o1oQ7x00ADgE=
X-Developer-Key: i=wujianyue000@gmail.com; a=openssh;
 fpr=SHA256:gVWBPJbHGWlCIw+V8F63Ff0k21S7AB5+rZt8+huemvg

IS_ENABLED() expects a CONFIG_* symbol. Use the real Kconfig symbol so
this warning reflects whether synchronous partial I/O is built in.

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
zram: fix partial I/O config check
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6e1330ce4bc1..72f89fd5572e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1510,7 +1510,7 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (!parent) {
-		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_ZRAM_PARTIAL_IO)))
 			return -EIO;
 		return read_from_bdev_sync(zram, page, index, blk_idx);
 	}

---
base-commit: 404fb4f38e8f38469dfff4df0205c9d18eeb1f57
change-id: 20260531-zram-fix-partial-io-config-check-on-akpm-c62b972416f8

Best regards,
-- 
Jianyue Wu <wujianyue000@gmail.com>

