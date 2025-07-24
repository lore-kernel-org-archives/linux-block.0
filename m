Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A42F32
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345809; cv=none; b=ZCms4L5kdqjrXqfGkSveXH2sq6o5cdN5ZK9dAPXZvgXKX53AKTFVHcZrDoH3Wu/8RW4vzAahHBK/VjZemTdvKR+ClUPAkcsjOBhgnrHwg2ewZ4xqncRRMZpno6dV7CbNm/NwNTvWPbHQ4p26dVIrKkEsPCysnlLAhGLuJPuoqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345809; c=relaxed/simple;
	bh=RhsgSAQGQFtDIfvSyeWQbNoGbCtBEUjX9d2Qx45JhyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zh5pWeB+I19pgtS46mXVmyBJ2MkJrBVQ8eoLwWxjpLzs/2kT9sOUwqxzhKVmaBusFJjCuTmw/xTKROWcxT1VgoB1ZxQRUFDWAUr1B/fj9/4MNLYtmTElsZaVfHrz656mM2I3HZyagHlKcGaqhfv/MkHmDj7H13Nhe0Z/mV7S/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TS91u/+W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TS91u/+W"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363616a1a6so5432905ad.3
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345807; x=1753950607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKf0o1pd46V8fmDIDERJDbcmOFQ8i5tGGSMH4OBumaM=;
        b=TS91u/+WQz0kY9sGJ/uROtWtCz2tVlUyRTsz4Q8n9vu0/b80+yLZF/EN8ekFKk1xIy
         zDwCN5btT/TMGkouqEUVV/0TKomK2hmOXN6kzaoLOj395cEPQD++aeww+5oYwF+u2M5Y
         MPwqzD2QJjCGUEJOuUOm1r8PYJBTlhiwUQ6CwjpnHJ6qRMFUWwT29r9IMZSvxsyfHM/Y
         On/2dgWFVoaeDqSQtbxz0ETh7TcZ1CTjFiUfSCDAUsDWFgLp79eqNg2F2Kj4OwhFxswT
         MJayGKpqr9qxON4fb81DOxftq7dG4QxG+lV5di2KVmsFiR+2TEDLPUW7kgTeerhcVDAi
         XaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345807; x=1753950607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKf0o1pd46V8fmDIDERJDbcmOFQ8i5tGGSMH4OBumaM=;
        b=w4RIzCimY/AnD40Y4KLJgKFol0TyoWMNaiIF71n5cFsCEOYWL01hHQOGbKX8HxgU9N
         jxOMiP+Pcv+F6C5RV6GChuNKSXOncaxjzoSZPI+T3L3VQdntop8e64P2+mP4d4KRun4S
         kG+IqTfY+SRbZzM9uBqTPPrQr6Htd2PVpFKuESAr9me0Sv3NLRvAURhrCn2JCsnwl0P0
         lZLckKXNekEiRBndpCdsvKo0StkHrZLrR89qBoA27fG+pX6SDaMl+LYe74tuSWpWDXIz
         NrVIeNrySNJmd2CsZzgsNYip+2E1tOtWzDqsV7T753KtMqwnCMYB5NOPw8mAAngFg7fi
         lT3g==
X-Gm-Message-State: AOJu0YwM8pYXfbr0V/3CKkxzB1zL0PrvLPQz+3h2hKry3k+Ok2QPCcjf
	w0PP7ZvsZl7X/WXMDpyoZ4RtCHHIQ0XZBtr72jqkJRbNNX0O4usRZVhSozdZeYlcUJo=
X-Gm-Gg: ASbGnctiLqvuBxd5DwRhvtMixWtnho8ng1AeuGpTHEYBkDuhmygoTpjPS/8TzZp3x4n
	cA8YrG58KYAGFv/J92y6D+QaZW2GiJnRo1SQFcXr/KwOck6plPV/6j4fdZAsOUCKeLurUt4MmZe
	0HDtaGKvX3XlQknffm3FvxBmybC6D3zBgZLyR3PBKbMfGwJ7VK3xB6T5xNLbloSm0am3Erdb3PC
	nC9eYJwumWdkmIeh04vsVfERh3SWVGvNtZBrMBBsDDQJGkTh2T5OjtTxyiRz6Ymw7LAcSHNYfdj
	Mzcji57SVYICyBn+DlPZ4oE5rwbeUcUpe5iyFBDsJLMSAbKTWxcZkjIBq59v61AzNa1gbS5T57+
	SX8rOYUU=
X-Google-Smtp-Source: AGHT+IEc7yW4IcBvIpaJfOqUvH/v+MMuyxoDj3ESBPn2WDNOIekRHFtW9rwogcRsweMGOMT9KTHARw==
X-Received: by 2002:a17:903:94b:b0:237:d486:706a with SMTP id d9443c01a7336-23f981e5ec7mr88899825ad.48.1753345807258;
        Thu, 24 Jul 2025 01:30:07 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:06 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 0/3] Optimize wbt and update its comments and doc
Date: Thu, 24 Jul 2025 16:29:58 +0800
Message-Id: <20250724083001.362882-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block | 10 +++++-----
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1

