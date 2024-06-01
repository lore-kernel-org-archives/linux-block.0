Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69506386
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717273463; cv=none; b=eiIqZGy549CekSj94ETuLmq+PwnA++c2dn9LPFEh2QLBe3mOoYAWAbRERsnMcDZLkXR2VoW7K6PSlBgpcYbLmay2w/hFQBffT0ql4GB7pjY+UD/Sq6sZRIsaxckvTrm3cV0gTHAbZOSeJOkPXrmPSuMU1zWSziXg4SL9kDinoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717273463; c=relaxed/simple;
	bh=YXg0sJEHG1JNmDmWn+3aihlbT685eZ8lKy+1vssih1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjWQuZo6VrMManxb0feaLTyLUmKILFc5CyLWCJ2I2f+92AlI10+ny+JYQ0GwpJXmwx4FKVBojvSA58NA+PHYXx4OFgLpDun3IUFKjcadH8g2t8++9svHRyg2Das9FBSx1icAtk3lEl5MPtcYanGrlcL7rbIWQL2t3MvDdIPLmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=RNP20Vz2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="RNP20Vz2"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso47889911fa.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717273458; x=1717878258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lE82Snz8MzIXw9HxE7ksfPmYVUidTWq9kb5E7IW25jI=;
        b=RNP20Vz2RoqwnsODkshjpfwgVupIQufIkbGSFnVHsilxyEIyi8vUGcueugAgB6eaf1
         Ot44Spjl3X15J+8pQaFVBl5eHTQmrlIOPSOn1z1HRhxicRacbQV1IKrweoQZ3PhdPqbJ
         saobC21vg9WyKuthf7lmE5BNI97pC6+2cF29Nz8HjftG4BFoeq8Cl7vPkVb16rdyDMC0
         kozbTO6heK83K2ATnj0HppvDfH3UhVcwUP0OHl3ufj0MpKJoCc6RbjuCR1iuQYulXa1F
         Q6xuyByg2LpA6t4BbByKB84cyeu54RwOIgS2gHgxAzIZ18D+9N8YQaULui7eSI0ywDrj
         pmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717273458; x=1717878258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE82Snz8MzIXw9HxE7ksfPmYVUidTWq9kb5E7IW25jI=;
        b=e+Qtg86eoP3DEWhjPmHH8cVklcHaXtxMboS+wkXmQgEhQAf5Tvjcqvmfjcyze4M4+e
         XmkkWUZks9lJSUvOCTAodkVw43jMYCLqwzLOdgb2MmYmpNp6EK89k45fESMAWFKwo/Hq
         SHtW45HgK4A/BVVKtutn1Lph0F72w3/MkU5Nq24hXkeV0jy4WpC0i9oSWyQKQbTuG9Fp
         XKn93PNQ3RgKTKZ0gPdFaYD7uiWHsERNgZ4zHPyf98A+4TCNuEJM8YpttUYG7gj8f0Qg
         8UPsryI6Wx6HP5/eGDvNRbAYjejBZtMQfv+5p0wcx6qruwJ/jFvW6vS3HW81D4W60Ebw
         cCPA==
X-Forwarded-Encrypted: i=1; AJvYcCVBNAM4iWofAj8C0uqf+wG1aq8C2WsOg9Bew83QTrX973l84fbSK0/5gdyIkfBrSSoTEp//e5yMf68hhuInutBUv+ZzDOncnZSxz3M=
X-Gm-Message-State: AOJu0Yxf7VVxZU1gK3/TnTPFk7W/GGXn/RMy+tK2yKmuzX7cqGRuJn8r
	Tu9mhNSz0cxMZK5Q5Jc8p6HL+cIZktLLme17BqNo7AzeH8/ODtHlSoumGh8S2qg=
X-Google-Smtp-Source: AGHT+IFLsoaIiImdFPdqMk9Owuiby/QeuscoKOAaWhgAQWdntLqPGCtlswpdzpAqz2qUzWDXU4U/YA==
X-Received: by 2002:a2e:9d1a:0:b0:2ea:81cb:5532 with SMTP id 38308e7fff4ca-2ea9520a217mr41188441fa.52.1717273458251;
        Sat, 01 Jun 2024 13:24:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ed647945sm4229766b.9.2024.06.01.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 13:24:17 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: fix validation of block size
Date: Sat,  1 Jun 2024 22:23:51 +0200
Message-ID: <20240601202351.691952-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Block size should be between 512 and 4096 and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/null_blk/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb023d267369..6a26888c52bb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
+	    ((dev->blocksize & (dev->blocksize - 1)) != 0)) {
+		return -EINVAL;
+	}
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1

