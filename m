Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1801157487
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864717; cv=none; b=VUx2g/8lOlmq0+BXMDWQmywQm9Y0qr1oxZj3QoGfo/unxuHNRWObXjMb4ASUN6v7XdGzTRPhTejQrb8ZtFb+1e6EIckiGXLYy3Q2kZkTFutrA1s2agvoeKEr1FsF3MahwKi580xk/h/J8poBjWOi90BjjU3PcQaoVmgeh2GeaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864717; c=relaxed/simple;
	bh=XfGWwXuootHBZAI3s4NLMg9SyFeRWTCODggpZboQpk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ludKXnWSwuQo+wBPMhNUnL1Hu/EQIEvh3DR+cd2kqm8/WPjirxYLTKSDCueUMJmGK5B9mqdu34fZUa+1jP+mu36m1I9esiwIKzFCdD3RVk5WRH1aKDqEqhBWeQlIJk9MKTAr2baI2qh0XD++5kvBBrvZ5tFZLLtjwt0N4x63CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgvQMzy9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgvQMzy9"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44865cf3010so18055fac.2
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864715; x=1783469515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sbb4EcSwF6GBNr0pD5cD8wD0CiX9f1pyxQBHQk0CnX0=;
        b=WgvQMzy9CdJRNRtZBBGkT4Dsu+JkWadQRFZreXjjsvKNjPI6ZGhoOt6zMIBycWZ37E
         QR9aJTRR1iNErK5qjDPNsfCXdqGKOMHLZGyg7jWTxvvkNWH8+U5eizbJOISu9xF7fBUt
         pneVsdqkqi9aHx0X+d7Rtyb13JJAYtIMQ8ZXCplmV8ytbcVs++fQpfQGK0XL9tdwVJPz
         VSf7RrXQ57p/FNPBUAke/OjyK4LsIJqU315Inr73FU7DLwsDL0peo7UdIOXlhJCRe0/T
         DhY4F7re8M4qRyz7rM+o19zJPput2agqdyLlZlJnk4SwTH0pLbtqPAjSFEOoNGHHOViI
         DNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864715; x=1783469515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sbb4EcSwF6GBNr0pD5cD8wD0CiX9f1pyxQBHQk0CnX0=;
        b=KbPhXiA+rFPj7MU+qNuhGIAtMMkH72jC1Kc7Zbu5OUP/fGnapEg2RZeNH6DObDA8Km
         XDY8XAUPBelHXH9Vxr7QW+C+hCbc7K1asNorgT3Jd/tDI3jO/ffeSYx8Hd96F6KGYGMK
         E1DMWuqNjaXIupPHr5wObiA3ZWIV9asEbcgMFMkJ6omIGz6Z7WYz3I8Fab+Sp0IgNB5F
         +m+zJ6nOwa9zT7Ol3TzGma8syyLlq3Zc+FwYjvtJ3mhG7hLJe/PjJd//r07bnSIfwd4S
         EoS7zXx6uJcIeCeZQYiNgG4x2D/I2dkXbMY4ZcuMG2c0KsGOql1ZSqipQBgq3QC9DAtk
         sl8Q==
X-Forwarded-Encrypted: i=1; AHgh+RravOlEKF8d+og2R5pLBeS6QqmfWdhUW2907qJYOGVHZhdHErZ8RpcCuk5Q4tPaVvCZuqMIL8RgsLWz6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxteKIx0JX99yF4QxeIxdzlSStzdomBAvJhDmGGBhah/N14nrF2
	z0KP08cKA0vdu3lRrzzBbdBDcuNrJ85fzGuAMqjuM+PPKJByg+xnYxEv
X-Gm-Gg: AfdE7cnY5XC8rvsBdHMc5uHS6B5GoVibn92GrhdotGjiVUVuIdstX7MSihOO2iMZk0a
	2YtYea0QfhJMuyAK7HwQJ/TJzlJuN5bb9NXP6a4NTVXV4UJXWFW6XgVYSNQmbdvR27QePXOBjAK
	EmztoQs8Ze2GlscVf5koOwaCwtX19t/6pVKEpONe1di6H+ZjiVYK2ACrildazTzNU19yVB8Ifce
	htQC1IO6hVHOw2jU8HILjceccoUg2PeJ1obvaXgZwk+C3WE4uYSjHZE7DC4utcrl+UsPmm+8R1R
	q6keVA6lvOGH18RasNvLNFpAaDiOA5mEPHga6XxRetq0/La7wa3AThfw9hCcVCjy+kjL771N8uF
	8Ivat5lBC7J/k+24n4aNSDCJqLU/m3Fvl/HpphiE7f/eg3mvIYU0grsfdjbcymBVKwFHnMYdoSr
	R8L12Q5g8HDc+LTQ0/TKuHcKs2jekJig1A++lT0uI9D3TzfTpo8eTPKRwI7WRrALY=
X-Received: by 2002:a05:6871:7824:b0:43a:c6c1:e40d with SMTP id 586e51a60fabf-448dc4e72acmr4916410fac.16.1782864714787;
        Tue, 30 Jun 2026 17:11:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c613c04a9sm328264fac.2.2026.06.30.17.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/18] block: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:25 -0700
Message-ID: <20260701000949.1666714-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert block iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..c2721e2c659b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -453,8 +453,14 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int blkdev_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, blkdev_iomap_begin, NULL);
+}
+
 static const struct iomap_ops blkdev_iomap_ops = {
-	.iomap_begin		= blkdev_iomap_begin,
+	.iomap_next		= blkdev_iomap_next,
 };
 
 #ifdef CONFIG_BUFFER_HEAD
-- 
2.52.0

