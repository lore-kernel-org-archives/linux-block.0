Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A7191F91
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298970; cv=none; b=gMtvcys8tOxC09jn0S5Xxqe3iLcLeaLw96j04JscJeG4P/s19YFTjzMYfN/AYikc+0rCjuNDYaK10HXwNJ4hZDpahbQUgZDE6vMBjK586C6PBdxIx5OAzWBMF9/EwRqzGOzrpxeNVd0GEPRETZS+UtJjAYT31AVhhCHKIe3X+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298970; c=relaxed/simple;
	bh=ZsNzzGBZWRqGf2uq6G6j10Q+trCcIWrDEn8dRrN0A+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+CDeAsFjc6XnFvcRZXjyOo9GGipMJ1oX7tACPSF74xtAHlv3izCHfbczu/5nGcKNthwyCNWkOCfN2/pTJu1JixMVBMpgswsmOyHvUAsg/DOuQ4pPW/L2pmI63c3NjG/LM7wqmdXFtjBFYjayAXibKDWe8MeHVG6d63LDBjKq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QdBkYjZg; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QdBkYjZg"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-82f1a4c6792so109775b3a.1
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298967; x=1776903767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32BeK9NcDM0TTacs4Hgu5YnQIjPRb6EDjdK365GBPos=;
        b=QdBkYjZg4GcvOsulgVGLN6Yty+QsEbBvYWqsK9h3dF7jbJWgX4mCT4/D1D0j/8Tv+J
         5Yp8rJivwDJkNZhw5M104fimxjMCPZnnsmI8u1dgc+bt+NVrD5r2WfXs64QLqtEvN6Kf
         eOEZhVK0EguESYlUsx1HhkNgzXn2izp+Sp8TViUDzcdF9lLNVKyJqQqdv0XXtnGRM9SC
         QbYOzhhluh6zuQT6kbEs89FUCKn8CMAVSbgP5gEmYEl/JTWaG3fDweNWeQUicDi1mdOT
         PuoNMiwN5YHh6s7cdPf6rjkMU4Wm62fG3ASI2FKa5jr4RJzMVIIZmn9bVDy81wgPC9lL
         K3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298967; x=1776903767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32BeK9NcDM0TTacs4Hgu5YnQIjPRb6EDjdK365GBPos=;
        b=F9pYzbVTMOreDjuENhsTPZ2fhx6xGDYYINQ2ZVl9FiXuRa41aFxfjqWv49UwZlp05o
         oZ7ZsG5q1cnI2jybqyT6DleD3ipeVKWBubzvr0TR4Badsn8Mwp4a0YI7qxwI6Dh1kV93
         UlOH9msg3Z6EqLYrkG0BTshpJ6Uex5P35I1nWHVUwHpS7BZOgUpCNTuIwaCu2RLghFbD
         sTSrUbh6gxEhrntBUJoUKZ7MW4T1fVlnPNeAh7APL4TNxWjVGYpTNJWLKUp1QZ+8UBy/
         Xp13cNxHOEnBWgOeucIUm3MxVJyJYqOGdWlaFVAMd1RneBLdbcIkxuM+OLeDsEgTL1ow
         Dglw==
X-Forwarded-Encrypted: i=1; AFNElJ8ioHU9VjlA92Tq2I1BmP+ErzBQUDj1UjHdS0oqK2XuXsX3F3fzvwjNTcXIwnFtqlc3dKSIpJN5dPEM3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqr3D+cS1A9ni/io7+GHHB7Sy0tuo2lvNThErUSEZv2R3RYdu
	Mu08VyCpA8g39AYIxVwMfZVVID4JpVPsi12GseSlmPiruP+MqqXkEAdjTNY4t3miMy5G0O/oQqE
	FjDaE4890oTgrjmuom5dq3aBUAxaeRtYMfL0N
X-Gm-Gg: AeBDievxsgtVem32LSTNpE5mp3rjTXoQm/xgS4sQCEDxxHNolUMSkLCzcRr59T7CX6W
	XRe/7/GBFcdJRme4lNXOMxpr9YcQaJCPal6IiOQIjMsXv/t/whlubOJeurSsTXAhPP7Bcn/8sLV
	ec/LfTTAuwZVXgg5mdxWNDRclH192PyiIu6J8pcTX5pjtRzOwLSr16ABEbc9ibuJLwygJP+J61y
	sPL/92jjl7UCnaeAFpEJlrRW/ERBeLTqJDw1gpbrducmGcmQiFQxASwEw8vXTBVA7GPXn33x+gI
	kGmGp+N5dPDnk5lmCEHmzApr/bPlZGmVulp0DskQgL0T40edSl7H9+K0ue0xfU3GMnpGzAiIQ0z
	VXWNYu0I00Ha6FF+aLtv/cnjh526XScmesuwh+VUwiGGa+zuIflIKa2dYccBEU46+
X-Received: by 2002:a05:6a00:809:b0:81f:453d:1ab9 with SMTP id d2e1a72fcca58-82f678215a0mr2547248b3a.3.1776298967035;
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82f6741a4a2sm280415b3a.7.2026.04.15.17.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A7CFE3405AE;
	Wed, 15 Apr 2026 18:22:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 914E7E41B93; Wed, 15 Apr 2026 18:22:45 -0600 (MDT)
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
Subject: [PATCH v2 0/6] block: fix integrity offset/length conversions
Date: Wed, 15 Apr 2026 18:22:08 -0600
Message-ID: <20260416002214.2048150-1-csander@purestorage.com>
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

 block/bio-integrity-fs.c            |  5 +++--
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 28 +++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.45.2

