Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D015309DB1
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857374; cv=none; b=KcIE9c3MwMzCsVb6fYOWwb25Z16FeHKh8CJR1ippq77fq+T5t4kLymBR1oxpqF5ooGNdOvF1XdOU/TN9XINIv0WepirAM0hmlvpIGfHz+DvLjODqZomjvtbuEgO39ImbMRkX3teiat1vrCY3MRDRpj607bUVUKviDxeOuEno+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857374; c=relaxed/simple;
	bh=GYq7eClao3GaV9lgjcsADvNLW1hhn25v8rqXYSyuj3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx68q+s/y0ga53U/T9z8bA6IS8qv29Ijj1dMufdPL5wecVuO/go8vqS3sMhjSXmAGJAgq7d3YghcSfsoWVc/HdVVTAT91HOFW4+qcEsqRw88ABzOxURU94/XshK6vbhe4zoXZLB8p+GF81rmhlHRR8N0puCHHf4a7O/tfAmEFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehKKIGMy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehKKIGMy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba21d32776so83128515ad.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857372; x=1780462172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdeTI3Be/i5d72s0tyEQ/VcPybxiAdaZv+qc7OW/TlU=;
        b=ehKKIGMynH3pBDv7rLxR4zIm4GhX/DIcUpFSMyiiAHjO8wK4veZ1Opdcryt7TuXZyi
         OAtsGq3iSuFBZeoK6bODIFweimgGSXPWNxu3HVRdbJYk+XjClvnecXx/uyYgR5Da1uje
         YcAjDqGQI5WcnXJcj2HRMsBHCAsoBCA0cnYbxD+Ug9BgjCV/nWqs+ohrnGbUS6ZOnE1c
         kRMmHrzCl7ebiqj7L6fMnCVNGCdEXM8wRzsOoddSUqKzyQHaubzt41rtuJ/v/DWFUyvA
         lR/lEAoFNsPOHHKifPvbqEKgK3/HwI3dBSdAEyXh4ESk3ffhLwxKyyaglxN9Ezlz9/nl
         oKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857372; x=1780462172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HdeTI3Be/i5d72s0tyEQ/VcPybxiAdaZv+qc7OW/TlU=;
        b=cEI2oCOBYh1bD8QmNluvi/POpZOMuvSbOwSD2bn84Eslv05WkAoRHx0EcYigysXk5G
         +jSsxsNyLjKE70HpFnxGMNseZL/Drh4asFkKmi36Gj/4b+vk0SwDf6MTMQi7ZO5sHLOi
         PgScTnBscW1n3ageMFFYE9ko6gk/K1sYm0mH5N6FzJsBjES3GJpuKnK4dGib69cp1MWV
         6px/+5FTpt0QarmpPSFyZAB1mkdLGRily+oEzEMKVph0cTfFigV9uQG8Nu73s+e/mopV
         tupSe8s9i4UblnhkNPmcW+nDDSGtWm/pBaSyq5EPAYMvoUyMnZol6v9/wMolZpOrnPAt
         avfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KAoZOLBlQPc2b/ud32Vgi+1CpwxGvD6vih8eU8CkHcUe4UQkDm7HPLdTAkZ5NoSynKi36r7FRvm84QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEVCYWU7aC/HgVLVpG3o7acWa1Y/3J378l19GP7BVe6HdiEzi
	kIWgRrpmcSjiRdRc6lVOvEzkKZ8DwSZmKbAyTtL8OBuIfuQLu17u/nTH
X-Gm-Gg: Acq92OGkCjfJtgysRk7tquDjfr0F74j75e/ScVXRrSxHj5U/mNett1SbjhFcqActut6
	b1a6VzdqRqJ+q+Q2M776Ep1a9RdDqMKZypkcirRSEh3iTu54oaGA0lwqYfE+krbi1DpUJcioK4h
	trCzpbnEkLOAFOiywR+dvfEkC38q1hc2s0po0X4dZcS/RdyL0dLT3NcBc6DWwJoBwyhsIShpRwd
	GyV1TznwNBQVfctmUYH27iVvybbzu3RW7P/8x792MIQwEvVJsuD3A3UF8TpNa9w7hcjohzJfTFA
	GIfm/FbMmDH3cuKCLU78Y4QhxmXJl+jKgYWImOp1W1ilWnCXuAzwSx9OIyhF1Ch+WIECyeX+AEj
	FKH8JX6nyASOcfqljtpkkuLJeoikILTx0bZtwY4tvJT5ouUdorCYMUJ02xiGmeJYtqDz0/DR5F1
	TmMn8TNjOhMTmQGNMdbfOHdumRgIBGhsj9UQ==
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr233822145ad.10.1779857372512;
        Tue, 26 May 2026 21:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm135704105ad.66.2026.05.26.21.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:49:31 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 27 May 2026 12:49:24 +0800
Subject: [PATCH v2 1/2] zram: fix use-after-free in
 zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-zram-v2-1-2fb84b054b5c@gmail.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
In-Reply-To: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779857366; l=1429;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=GYq7eClao3GaV9lgjcsADvNLW1hhn25v8rqXYSyuj3E=;
 b=y0NCB/JE8egqDA7ZvcgiKHXXTPhJDt3eJNcyH9vjqfcf2urXXxuO/7LuiX3+8OQB5bskhQHGQ
 e9j1YvGYcbyBEJhvACdZy6pB4TiDjVceAUvbcQ9UF8MJErpnJDy5PYO
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

zram_read_page() picks the sync or async backing device read path
based on whether the parent bio is NULL.  zram_bvec_write_partial()
passes its parent bio down, so for ZRAM_WB slots the read is
dispatched asynchronously and zram_read_page() returns 0 while the
bio is still in flight.  The caller then runs memcpy_from_bvec(),
zram_write_page() and __free_page() on the buffer, leaving the
async read to write into a freed page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the
write_partial counterpart was missed.

Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..b23a8bbb687c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

-- 
2.30.2

