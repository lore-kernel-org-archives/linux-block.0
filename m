Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B98F5B;
	Wed,  2 Oct 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894460; cv=none; b=Ex+yCRl/joRY5eH/YGhzhohgSgsInhgMZZ3Puz1Gegi7YVbdaWPszbnVryxRbAgX5zVGHShtEDOUiEpQcy9nDtCEhwrNoDgWNNJla5ld3F/ggpUUsGqmDhicm/Y/tmwh7ygZx/w0vLqPNxvi/2QEJX5LG4FyFddNI5BauFwqs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894460; c=relaxed/simple;
	bh=+pjCHhmMDLULM5RPnD4dyOlm9iMtw6y84s+Kf/s5YRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y7w5HqoBDbppyV4AYtPv7x121sMAhoPOSwySvD25EX48lq0UZU1mlrJw1p8NqSvEqSy1MTS627Qh8F9VbJLnXxBZXPKoAdj/65MJT0Fy1fkssdazMU68oGMgIdSSFeH2j3NugBddRRIMfYhWBNBHIa1Dixt8ThT7S3+LuUX01ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ4s17HO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ4s17HO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso46680a12.1;
        Wed, 02 Oct 2024 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727894458; x=1728499258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hh3Txkpe6Mn36aJsRLUJjj0dcHOCZq+pV12NrhpCsDU=;
        b=nQ4s17HOOTavm13y47MeNYKydN9AYkrxCZCWrtTtBpbeFuLCYpr89Q6BbJjXm0oMDS
         FTdZFKRxAj8oLMdWcH/GaV/RKzTIVmB8U24OsZRaMBN58eaOyL3w3gCyzRDQpCkwYyMp
         JyDugXrF2wtWyslKC1YZhNWiMh4G0Hfh2vF3QcBrO9fm+ZvkxELsNM2w6e+ntjghFnKF
         zQEFCShVjOB3zh4ouGAcsDG5BBTdrV7jflnzCOWeJGIDEcSWjSAgle2CU3RrADxqhSSd
         vO/WY+kSfc6/8JMM0AGGRcQLmwnEb6/mc9K3sPbp/B2+sJPPxC/ZHxEsLhtpjCeHQYfQ
         HrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894458; x=1728499258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh3Txkpe6Mn36aJsRLUJjj0dcHOCZq+pV12NrhpCsDU=;
        b=imYWB6MgstsxLWZXBOihjHF1JzAE2yjVSthvejN/Y0DJjiNgIpyKdrPmroL6s9oSzV
         xr2x2Han5HwW7fP4/kW3yIXz+vjaKrwlnt5wSl+oIAH7Xt4tVqtBwZNWIQ0aPGwGJ1CK
         5++fjZESEhZqj9Soluxy+tPATA5J3Lo3htJumcXFm72Beu7CRi9MgACfQaCmQHp2WHVh
         jeJO9az1BoiNtI8PTMAPbFrQp7d13cr0HTh8UiZX3YC2OBUhLjUP21c7vKBwTxJInMEa
         5rswUdQMIn4vhgNXVUCb5UWVPv2aZDWJAscTDTqEebg9WB/FcuZFSy5Mw4DKLTK2+i5p
         KxvA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Sw3bCIWSAVZ6KeYWupvPU1bxxoc7pgnrmaXlKpb/3L+HVQdDJ+cX++BhByEb/sHh2a5jTjV3X1rNi90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzju0WH6jGIM3jEyugVKL1Nl0+obw3cSUrdQNERT14+umvBXUkV
	Nr0XggU2in7QUm3AA4Nff6mruEjfJ+N0+w/NTKqGwE9oZ3DGZp4d
X-Google-Smtp-Source: AGHT+IE52bfgAhBKdpyCJU5/eQiANCV0mLmSyVLvmV7wsa31coD8XqSjP+wfxiRWmdgS5vAf4wgzCw==
X-Received: by 2002:a05:6a21:4d81:b0:1d5:1252:ebe2 with SMTP id adf61e73a8af0-1d5db1a4355mr6063365637.5.1727894458100;
        Wed, 02 Oct 2024 11:40:58 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23f:2448:da07:92dd:5ab1:f38a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26516098sm10140561b3a.121.2024.10.02.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:40:57 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] block: fix kernel-doc warning
Date: Thu,  3 Oct 2024 00:10:40 +0530
Message-Id: <20241002184040.18315-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a kernel-doc warning in blk-integrity.c where the 'rq' parameter
was not described in the function blk_rq_map_integrity_sg. This
warning was triggered when generating documentation.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 block/blk-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 0a2b1c5d0..fbe436377 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -56,6 +56,7 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
+ * @rq:		request containing integrity metadata
  * @q:		request queue
  * @bio:	bio with integrity metadata attached
  * @sglist:	target scatterlist
-- 
2.34.1

