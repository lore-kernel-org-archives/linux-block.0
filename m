Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21054BC6
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750904462; cv=none; b=Gad+ejBo29G1N9zlWQdsbexcTxKwbzJH+YXEtdFZNNhW+LI2YvanNowvbofuv4TrCKU0WluhMkZsA4SxGgxBKkYDxalceOE1KJpRNsBerGAiOXdFv016yX3z1NxrVcxZ2J5dbYw0l0p0kH0fntmjUe5qp+yLQ8daP1fPvgMdTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750904462; c=relaxed/simple;
	bh=HPXBglY+AYOXjtsFf54oFT5uRXb/MBGz/corEsE4J00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpyp17FAWbWQAbjJB3PsU7vtQTPuYfunr1YGSxvwqkZfFa0LSUfc4PuM0TWdynS9fIRIn3pxyo4bvnBYdlD+U5awU08WN+1W31Q3OxIB0nMfdyp9nY3S+mwYVibY4KHaKCZUHzpOW18OHzaB5XAwXFTalq1JUSw8FDMrvRJa3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOeH12WW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOeH12WW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d366e5f2so7624245ad.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 19:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750904460; x=1751509260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GdKVIY4EbAI22afIgD2rnlpxRpKioHneUVHEC7WodaY=;
        b=mOeH12WW14YxSTqt8DZxcCck+ZL5VBZpzelQHNBDXNd4I6rCIKWieAoH8SUFQiCKew
         XTEkYFTRPG8zRPGGgba9FXfCODZJdo2IJ/0O98TbQUGPBiBuQ5vjUdvZnUIhw4IcSPI7
         IygJe3vPiWDR3Ky8FDKSgW7IWmY/XFKK5tpkWjcMqDf8Twmav6+3C2HnwZXFC71o0Wog
         GeHqlSBo69JiBk5QDJ6uDKYwzlSQ7wUm/GFshsuSs55kXMhuGVkwBIGoVnpbKAL7+5Gc
         83SEPMyPyXEPHs2uqd0JWb7KhTMRxncRyIxaxKBr4sgte4ZaY+5aLJgcC5XbiGwMcuYp
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750904460; x=1751509260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdKVIY4EbAI22afIgD2rnlpxRpKioHneUVHEC7WodaY=;
        b=INWXrK3SkRTXCR29Xb1k2x1UKI/69f0Tef9dEGx0EsuN8xc3pHHWTixV27YDSA6KSt
         R+9VcG4fHz8zSCE02DM3+kDeiQ+Cd3LU6wTfbDChQLOjXdRXJJjSMwffnka25vlvrYHu
         MMZGfkCHYwRmq+E5HvWzHzDV+1N8K/Z1PFML/9TbAIYx8WYum8QGba9fh2+1jLyvmcWw
         B9dvFYtkBZv13nCV0nGaYVyu14q2UyegB8bTqkTHnivxdGsqb1dSou1ekVEwP8xfTF2N
         VbRjAnfp9JxToJD8O3e9TsqK0bQHRWVWhGedejV7hJu9YPqZ+OXHX4sz+JCh5WLrT0m6
         FFOg==
X-Gm-Message-State: AOJu0Yz1C7cczkFy+EA5CLXNknI95qOZ1PWFNoz5a1xUG0S6Mlr+00kD
	qcwBatdVVuAbdkcW4c7r0Ns+GTec03yL3ClOtlN18jP5zHVxuIDRXU4Slx2ZIw/U
X-Gm-Gg: ASbGncuQNgFa0TTbsOZXKjoj5aiaog0ikeXEQ9I8NLeliMRg6NIkGAMmbHXxsxIdw+3
	FBe0k/csLMbsg1q3+LQap9wrVFr8kclMqMaAKOZ715HSijj76tAs2B4HBw7Bw7Dq3mGdHWMKYxa
	oCLZ+jF3TQDF892diFP4l0FI14TA3ZCd1OM5Flfnon9/DxrPhn0qrWuI+j35Z6pdQowV2DGPkff
	dpW76ELmqbZReEA1dFC+fbh4JNoObQ76iH19lNn6nKBi9yRY15kucSKCwm/5ZmxrPVHJn7fspBP
	+Ok5d1F3w5v6qt3R0yP3DPs3E19bftq+ZDteauhUnvcqHViS4/6Zvw2iWCrUwqj+xwKMgNbxu3d
	ycvY=
X-Google-Smtp-Source: AGHT+IFjxGIYaFnxzB6Ud6doq2ge6mKBeijzjnuR00BnKf2sP2qMBtoIpUhiOX5AYjw/cNAC9wJ0yA==
X-Received: by 2002:a17:902:f64f:b0:235:a9b:21e7 with SMTP id d9443c01a7336-2382409c77emr96727845ad.48.1750904460057;
        Wed, 25 Jun 2025 19:21:00 -0700 (PDT)
Received: from localhost.localdomain ([180.216.2.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83d3af7sm144410065ad.69.2025.06.25.19.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 19:20:59 -0700 (PDT)
From: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH] ublk: sanity check add_dev input for underflow
Date: Thu, 26 Jun 2025 12:20:45 +1000
Message-ID: <20250626022046.235018-1-ronniesahlberg@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ronnie Sahlberg <rsahlberg@whamcloud.com>

Add additional checks that queue depth and number of queues are
non-zero.

Signed-off-by: Ronnie Sahlberg <rsahlberg@whamcloud.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d36f44f5ee80..471ea0c66dff 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2825,7 +2825,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
 
-	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues > UBLK_MAX_NR_QUEUES)
+	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || !info.queue_depth ||
+	    info.nr_hw_queues > UBLK_MAX_NR_QUEUES || !info.nr_hw_queues)
 		return -EINVAL;
 
 	if (capable(CAP_SYS_ADMIN))
-- 
2.43.5

