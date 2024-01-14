Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D801866
	for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/ImXZoM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e636fd3d2so23166745e9.1
        for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 00:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705220754; x=1705825554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsNiefaBBGi5hINiXLPmv25llqmRAL3p5gd3l/cqd8o=;
        b=Z/ImXZoMkVA4gI/gSMsHEZlPz3d4EGNPXGGuiJR/JBBvEsEFGAduwEn4H1Q2Odp0Qf
         kz2mc0K1FUnswToJgDDsbw14l0IMUxohUfdzOmaaQbWMsr/5MsrMorv+6lzroF1FpDSM
         aLR+TSTefU11Czw4ijbWdLs89qjYcWV3TuXYdZbfSBYN35vWO8jS5nHLuSy9Tc9FMPPB
         VQuPQGEDD5dOT8tXFJst/gBr1woLKng2cPYZO6sXL+DPk+xO4pYryrVRRfR2tsxpECO4
         7p8QaBZ+2q+p7TyNTpH9swgOCpV17nZSWN5LclXVEzu6AsF+p5Ra6bZhNUwfpqUDxXmh
         XNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705220754; x=1705825554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsNiefaBBGi5hINiXLPmv25llqmRAL3p5gd3l/cqd8o=;
        b=DDfqtIlk0SkJADm3rvkfVZUqwIx0jZxd10VHO0WKwBH+BZzy9aP0naFosoHMJsmFkY
         rAL1Dvn7xOBwgSH1Gp5R5dPigRw/5+hQ32DvhsvSd5yzf8yC/cm25HFA98WluVQsMG6P
         TzeNN2BprRypTAjM++0NFxru6J8O0w2f0XEVVCJM7EEQ43bOynGz14RsNFQ8OwWd61Qt
         jzHn+wgOgYQmiehoJbhWWe447SmcOnL2gqWqbun4+BmVHv43yZBs96ZfH9IJ/bCXgHxi
         L/a+d1hZzv/s2szb9Wk5PIf7neLPl4lCZzggegacE2568573qlLXOAWdDHj6CESVocI6
         wUvQ==
X-Gm-Message-State: AOJu0YyAbVxIwrqKK/K6+FB8ut3vbi7qY/M2R2heWku+ed5ys8NePjAx
	PkRLBD5pAuNTrujPumrWhfA=
X-Google-Smtp-Source: AGHT+IGECSWfZXK6MhMn5iXw19qJm94E+fvLrsHnlSANxc3fYhW8kt8SAe7/wgOs6pfLVZl1iuC8cg==
X-Received: by 2002:a1c:4c09:0:b0:40e:6639:6708 with SMTP id z9-20020a1c4c09000000b0040e66396708mr1661739wmf.49.1705220753724;
        Sun, 14 Jan 2024 00:25:53 -0800 (PST)
Received: from vega.home ([2a00:23c8:1885:3701:6438:b7d0:8388:3e7f])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0040e6b0a1bc1sm4955886wmq.12.2024.01.14.00.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 00:25:53 -0800 (PST)
From: Nicky Chorley <ndchorley@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Nicky Chorley <ndchorley@gmail.com>
Subject: [PATCH] block: Fix some typos
Date: Sun, 14 Jan 2024 08:25:32 +0000
Message-Id: <20240114082532.10751-1-ndchorley@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct some minor typos in blk-core.c.

Signed-off-by: Nicky Chorley <ndchorley@gmail.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0..8fa002bf1017 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -839,7 +839,7 @@ EXPORT_SYMBOL(submit_bio_noacct);
  *
  * submit_bio() is used to submit I/O requests to block devices.  It is passed a
  * fully set up &struct bio that describes the I/O that needs to be done.  The
- * bio will be send to the device described by the bi_bdev field.
+ * bio will be sent to the device described by the bi_bdev field.
  *
  * The success/failure status of the request, along with notification of
  * completion, is delivered asynchronously through the ->bi_end_io() callback
@@ -934,8 +934,8 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 	 * point to a freshly allocated bio at this point.  If that happens
 	 * we have a few cases to consider:
 	 *
-	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
-	 *     simply nothing in this case
+	 *  1) the bio is being initialized and bi_bdev is NULL.  We can just
+	 *     do nothing in this case
 	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
 	 *     this and return 0
 	 *  3) the bio points to a poll capable device, including but not
-- 
2.35.3

