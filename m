Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276A27C84E
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406911; cv=none; b=RlucRoiLqA6l6pAQ2OI6mk0W9S4R41VeNjwwF6hlizA25Nl6NRreP4I5yOJobPKkpiokSVuN4KpfhXL1lvrRomZhlGcnOtKFO6iK1Ialz8Tn/GUQ/bPlAaxxCzEsvuDA4NgSlyc9I3fiyQuxrGp8j6l35pHQnC0wL0RQlztrvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406911; c=relaxed/simple;
	bh=b80xEn7EdjxWTN/ci1ysQxp/kAR6AhTP55Nuwyj6diA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8e9ZtKzBKj7hqZugGy3PtWNACa6Rh4h1tnHZuEv5cL+I5obH9yeacHQFh4NPxh6ws9aPttF1W0N77cBToaFtQOirvSGVUuh8Qv0o509FcrKDCQCnlOZDCTH4E62JsOHzXpIaIf0avA7o/p+iUXrswz8UzhW1HDCwc80VPay7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiV5+N+K; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiV5+N+K"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aad4823079so2259987b3a.0
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406909; x=1765011709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fxHcLru6xJPrGlRM61sm3BLmSBVukho7BhSnyNPRbc=;
        b=QiV5+N+K8rvRLBeotMRxe/ceAipnmm4/K5XqUM9OFWx31hIlK6IZHh5SfP6vTbIT3z
         Z+HDEC8rJrsSImM8J/c3LXbLeMkemS5zgfgijEuileBY7KOVDiMbG5dSZYXtpkuV38is
         dXgCZD8NV0h3nnw/ZdQhxhkVbwOLDCAvObTBfh9MxNTN+js7T6IUtvvtL+lBf4h1xFyi
         sZHodfUm50tGwTYUEMPTjRJ1JrzOGkXJ+AMJ1viFrI0uBKsOI4WI/bkgqn7nFOFQ2ifn
         uDArfq6uqsHHo8Ts8Yna3i45vAnZ7mqN9kaEXwvif4nYBAq/6KE/UlXA8mR/DZaGWX8D
         rF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406909; x=1765011709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fxHcLru6xJPrGlRM61sm3BLmSBVukho7BhSnyNPRbc=;
        b=JfVSLrayGnQi2JohiwbAVcCAUemkZQGqwtGdf8sbXbsXpFqIOGv6knCIS670rrUZNm
         0Bz4EUeP1XC2o+RPKCPDgiXS7mGMvaiAQ+cjUQv26vQfxfr2D9ysJ5ktGEUQaxbPgj6a
         pauQJgK/A0WndmSeWAB8/d0n8voEw5pCQOwnjGjFQfc1+h5U7KoHn5IFDyN4/ICYrWUB
         c0yS08jzZzipn8DCyMMjBjd9pYBSh5fDvSDVvtNRhB+yqnqsytU/g8waJPKaCtGg3zRL
         LFVAqSoe6WL1mlaZRA6bN8/so/aEwnrb9Y5+fuLDBbop+BeqxfDfi5+wzO8RNWQXL0Tj
         k7/g==
X-Gm-Message-State: AOJu0YwBtDS+CuWvL7BJm0CoV7yz5VcN+YeyZJf4DVkeVNoQNP4tj6kb
	4Ysh3QFv1m0J1fwzpF/rOomSsDSTX/dX3TnwryD5PvTtsi8V1VZaUAi0
X-Gm-Gg: ASbGncv/6TTlxcQSzvOQh4cKoMlJBVlrnM+e7al8RLVNuxJZg+3DY6xJUNc3PilF8jY
	ARRONChEwE9dZ1RWh3xM48cXoTQ3bouzvf2xMsyqEdFu+Yc3fb+6j6hf2LQBI3j35x5+g7eGyuN
	rMP/rrkOz+AIOprjQ2JdIdrUYs781Z7Wxmq8PLlfYw9jdvsxRgbjj4SCEMvezu54mnJhNCaPVpi
	Dsy4oEG20QhzgENtoSyKIZUD8YQTRo73Xx7CVHIDXxjvAdVcoD/rccq3D/RxcEm2EnFU2kK5Mqj
	Ym5uEaIgzf5XwpgJjROIOqk1VzqOtbmmlxjgrIJ8rNzLbxiDxqjQAYj+fJNqjlsFw5CJWyS2cVf
	DUEtP0UgF38ThXvrJTTcQv/UoLCDXYMosmaFGMbIo47tfEUSwXFwVuMBPcptTJjXUxmcRqpm5mZ
	ddxkCDlhNyQxluVn0PRA99Fzv89Q==
X-Google-Smtp-Source: AGHT+IFEuvilLkDJGqcsWwCIedr283xueadWd1RQPKrotWNJSiN6yvq7rXU8DgdpE+SxH743dNudrQ==
X-Received: by 2002:a05:7022:221a:b0:11a:2698:87c8 with SMTP id a92af1059eb24-11c9d710498mr16125897c88.1.1764406909336;
        Sat, 29 Nov 2025 01:01:49 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:48 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 3/9] block: prevent race condition on bi_status in __bio_chain_endio
Date: Sat, 29 Nov 2025 17:01:16 +0800
Message-Id: <20251129090122.2457896-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1b5e4577f4c..097c1cd2054 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
+	if (bio->bi_status)
+		cmpxchg(&parent->bi_status, 0, bio->bi_status);
+
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1

