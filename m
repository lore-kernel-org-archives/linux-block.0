Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842961B969;
	Mon, 19 Aug 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025912; cv=none; b=vCUNrHLG3hF8gERT4+5iBe6WrnnSmqTumN+1USlkTO86wCqVFuyMDzOCJBHmk56b3YauWZXqucH2qsz2ApyVDZISLOqx3rkEd3DzYCjARmoBjQMlmOpjIM0b+owupbC3feJS52or8g3oO5eCTor2Vz4cl5+I6H5PcKsFan2lu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025912; c=relaxed/simple;
	bh=7Cs/GcWpyVhL5gYxVJ1vO9vBEGivY+MxkkfwkYOb7wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiAQ1pPW/wr5A6PwWFuPDMTmrWPpCAq9lDXTcsxP1QN2W5vULVVPgNkNiyrdz5q6IeAqf+QXCOVtH2ZtTiwHrvD1oz3y/n5QYY6gcP+roLOM7OyQMFgyeonHs91J/1nHSulrmh+ezqdUovGSzevH6Q/Mt2sXitEBLPzNnE+3TOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHe2iiE9; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHe2iiE9"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-492a3fe7e72so1383820137.1;
        Sun, 18 Aug 2024 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724025908; x=1724630708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1a+pMjVUiB38viAahm/133wZD8Rs6DT0b99OGjjUQtk=;
        b=UHe2iiE9b70vdPuiU7UsNf9f3krFHevB6zZq+pklV0kZdrQNbsWVeTMqchdmsfvqBd
         PG1fFeYy6xcGjmny+jhv3/I5Nz7EexJAyOybZD0EcCrIKkBANKBkPOb8h6LLhuFYN825
         JNoCkgAV0dPHXtUlt5z1WSpdbP9wF6r/+uBByukjGK6A+YE3GBR/V/IVwVlkzE2WA3EB
         W6icG1UUj92Y/zNtuLraTc+Fy0LB06VmjBIaXw1WvaPYx9rd8ac7oNwnI6rU5Q70ReQO
         qmdeGcJwougC4Vasarzrb+s90EOvIodlC1crk4rf2PIOcmwiPyyVxz8+CeexZo1msNup
         5T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724025908; x=1724630708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1a+pMjVUiB38viAahm/133wZD8Rs6DT0b99OGjjUQtk=;
        b=gmaEf65p1/t0fVrFIcnkmORo9oqOlLCxaBvRRxfvki2VEo/+X/oYlOWq5y8gv7W9jk
         B8AnLUQpaWJlky9O6UMlilvPVfRaYuI+DJcG/zSchr3YLq8DaL19iobN4EaDkw0Rr8se
         wLOhBTy5r59l1JNp5jJ65ps5Stg1k5hAngaaMP/Ny5mUoEIixEWv6vS1SWHcM3eM3mIv
         PAYOqivwGcHXVDztqj6wuzAxMujmL6afAUQD+QXXntSzcEtbvhHGP3sM+8xGol7/oOUx
         AZuWWmWFQt850koGnGKs7yEoyG+XbhJg/NQ3ZMjjpgzM6HZ2BdV4w6JKZ8puniHTMtkA
         CmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaDaN1X1KhLMmMhlQeO0mRik2DHSTb1U/naXTA16VhcsZW/nahNBeQiqTctO0/Ogc7hZ1Dr2Jaliuogey3h62O1afECr4QK5X71ZzbDNPTuMldepXTAxg0ei4NaWOU9c4Fquki5esp5wA=
X-Gm-Message-State: AOJu0YxrL1AIh6OwoeO/R90objHKzuKq6BEvGWO1wA53GjTW7WHptnby
	IpEZMR+IZRUBPYvY3aYBoT9EVmaDwZP4TeFwcEb4u7UqhknWGRqaZT4zputY
X-Google-Smtp-Source: AGHT+IEpXUILlUPddmYo7W2CRKE66lODnIsWxAcAlmui5Shq2CFrvjGYn+cbD6SkpaKct9q2XPJ3kg==
X-Received: by 2002:a05:6102:c03:b0:492:96b5:aa0b with SMTP id ada2fe7eead31-4977990ec64mr11539081137.2.1724025907733;
        Sun, 18 Aug 2024 17:05:07 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4976ff72f15sm1100398137.25.2024.08.18.17.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 17:05:07 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15.y] block: use "unsigned long" for blk_validate_block_size().
Date: Sun, 18 Aug 2024 20:05:02 -0400
Message-ID: <20240819000502.2275929-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) and ioctl(NBD_SET_BLKSIZE) pass
user-controlled "unsigned long arg" to blk_validate_block_size(),
"unsigned long" should be used for validation.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 37ae5a0f5287a52cf51242e76ccf198d02ffe495)
Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 905844172cfd..c6d57814988d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -235,7 +235,7 @@ struct request {
 	void *end_io_data;
 };
 
-static inline int blk_validate_block_size(unsigned int bsize)
+static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.43.0

