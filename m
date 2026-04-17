Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CD2D9EDC
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391069; cv=none; b=dlcPIMkX6+eIrcUlwOay2he8yxzb0vRscPzTUDaLCswiH9pEYJl60yiqWSBdXko8agaqJ/VEbqTWJ0TGB756oKqMDOSXcpLS1RlfLn07aQJb/8T2lK6DHsA5Xml6cP92wY4hmEs3eNNxnv3qH7zD+dfyT4+y+/FgDwAm8o0VB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391069; c=relaxed/simple;
	bh=H7gpgcOZQqlOz3UfsDNLcCOef8f555rSPNFVL/tklSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuqk/uifTLuU1x0mOptPujhZ/gKik4twq/l1abgjEPwOhkemqchV+9iJiBMCxMPvRSPucKWFVd6vbdeZae4hCfn7Snj+DEbS6fXWx8kxr/5KjaxBP86WhFIfNQKU5a+HqTkmSCQt+VnZG9Ff6pLzqS5gj1PdE0u4q/ULWm31qco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YTorg9Qi; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YTorg9Qi"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-824acdfb73dso25982b3a.2
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391060; x=1776995860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUQOgbnR7fb9TvRKeaJrBXV8GjBjh4S9IAVC916d1UI=;
        b=YTorg9QigkhvWrGwYpyHFmDLxSx/S4R0Pzjprjlv7CD6ip11GOgi5S9Oj1icBdLbDp
         lR6OjeocUkpFTQ7A0SbnMKKOlW0YQdUb0UmMxtffNcTuwvC4UINYWePE7IHURHWaO9ur
         AjYE9/EXfuJZkMtQuPJ7BF/0ctNw0y3jCp4BgcIc3QUlEOY+QPD+zzZwcqZO2hEyif6G
         uURk6leOkEO3cUosW6Veogkvdpt0vLKcx+Z5BciDtCDZL9IwlKB0afS32VCKhN15wwwN
         2jMVfw6n3FfyXzKavj0yshFRCfmhNzhh7W2kdTsgbB/HPYzNbEAZvOmjqy68lWYz/t6S
         eZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391060; x=1776995860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUQOgbnR7fb9TvRKeaJrBXV8GjBjh4S9IAVC916d1UI=;
        b=rUcnoDpRRGFf9j/1+VC1DmYHO8kOerOZPIHK47/NrH25av7J6bv23gciFZMaiP14Is
         /rU3+S9fydtnJiYt6iO2ReqDX3bvDLSIYmNzook5m0ZcnipS0yuAJYkDu4Y3XtFo19pB
         5CtpC2sHCotmjlAvC1nrmwaQyfoe9UL4/pFSazTf3CU41/0LlL5G5fHb1iHhexPSMWA6
         ejcZYDQDgO8LatDqeyCsT/j/ofFgxae40E53CEkRsNDKXs4hDgFTDYY3Qa9pmda9fr2N
         mfgFV4VUnqeBjxtZCm6GS0JPRX/pF9+9yxYlZH0cTaJtthlDzgD9vn5qxcVlMiC5dVeg
         z7uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0KduBAZozkkPIVPcevnH4kvStQXj40iFjlQ6tJL5KaMHwZNKS7AXqdAYcJf7fdBOa7eNqV3FKhECmJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEANsaHgiMdGL/wLZcOok2BLmBWzwTBwJlDJ0WewEpwJrljA83
	AGOQTd7Y+5yje08DwHOjduZ1VKFliwYUTdURpcikXxtaVHgWiTyBK9hFKZNICh6LuTYnMYm/w+i
	bkctCZHSwbouVna9YI8xgcvuLzX70L1FLerMG+xhu1YrfcRj61OBn
X-Gm-Gg: AeBDiestxVHoLaI9pvgsH6Xja9XvFkELNJvzYyyTYcfGGBCD/iVBQdCLeqXaU7F6Xp7
	zzMOpQm5TwcfgRRMBxw/1NJFVty1g2FYrk3adngCn9pIM0J/DlE34jGOqolK4eT2CJd67oZAIvi
	pN8fJJURGqipqUu64DornlI9EVaN8GlLqJT2CKRcka1cNbtnky/ULJlgKRnRNC+jgNuypwfIoIe
	ugZd1G8gdv+RbGbmi3CDOvtxHRS7c3UzdZWKLMmc1KKDfgNIqFm4i9yv0cZDZtr79yA67ft0ylB
	FbFV+57HE5QURR6MoAD+up6/ioHoEWDwD7+pPXAjCxu1083518HY3j9vc1H+MjFooaW7d/1jcsQ
	TFvGGQEDxCgXHJWvu1GLD/6edIuZFFMcCWVqnXJ0X9et9e8Bj6g==
X-Received: by 2002:a17:90b:1d52:b0:35f:b204:c62c with SMTP id 98e67ed59e1d1-3614022c036mr490528a91.0.1776391060538;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-36141943c35sm24518a91.3.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C637C3406AA;
	Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B6B12E406BE; Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/6] block: fix integrity offset/length conversions
Date: Thu, 16 Apr 2026 19:57:26 -0600
Message-ID: <20260417015732.2692434-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block layer's integrity code currently sets the seed (initial
reference tag) in units of 512-byte sectors but increments it in units
of integrity intervals. Not only do the T10 DIF formats require ref tags
to be the lower bits of the logical block address, but mixing the two
units means the ref tags used for a particular logical block vary based
on its offset within a read/write request. This looks to be a
longstanding bug affecting block devices that support integrity with
block sizes > 512 bytes; I'm surprised it wasn't noticed before.

Also fix the newly added fs_bio_integrity_verify() to pass
bio_integrity_verify() a struct bdev_iter representing the data instead
of the integrity. Most of the integrity data is currently being skipped.

v3:
- Drop bi and bip arguments to bip_set_seed() (Christoph)

v2:
- Reorder fixes before refactoring commits
- Use u64, SECTOR_SHIFT (Christoph)
- Don't take sector_t in bip_set_seed() (Christoph)

Caleb Sander Mateos (6):
  block: use integrity interval instead of sector as seed
  bio-integrity-fs: pass data iter to bio_integrity_verify()
  blk-integrity: take u64 in bio_integrity_intervals()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  blk-integrity: avoid sector_t in bip_{get,set}_seed()

 block/bio-integrity-fs.c            |  8 ++++++--
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 27 ++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 35 insertions(+), 29 deletions(-)

-- 
2.45.2

