Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F07337BB5
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245283; cv=none; b=TzKwG0/xlXPxo8gEM8e5bgDt2yWdpMKRKd3DcKSPjKqiH1gI0pBnI4qZAZt+Khz0wfIr3xResmJM0Tt2vzcFALA8wR64F+N3Ru1sfujH6aP6gxgmCvozJmiIOAdS6UtROodRWLyhxqunGNSi5aHn36ujHVpE9xuQMMTb1Y/wmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245283; c=relaxed/simple;
	bh=s7a0+emFgbEKsMfKwqFAYZyCvfuCzCFK+lgraS8d/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMtlUmqCETpGPLCbNRED6RdXoxljidNUlImwwZJw50IjofhHw4yRC24uAvBdaXYpyP6TMlSP7O9ULzTtw9zx70GBghgpC1Ri7J/rFabipZSPfOlJi+gqintz1L2Rd2SrQPFUVQUq8jxy1AQCnS0l0PmR5/H6oWNu9iQv87GBLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X732gt4d; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X732gt4d"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c76c90716ccso70708a12.1
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245281; x=1775850081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7691Rpd885rtdqhZsGvsmlwE0WhG23SmYwp1iH7phM=;
        b=X732gt4dYDZzpBF8SuUQOx8NkFdM1i6ui7jdBAYvQe2ifH/A+vh9D5jpdIh0KgpEs4
         fZtxi34Ik5ZVDX2IIqhCIDGtSSmokaQgy5KN1ILrSz/QAmfz2cLAHARVsyNxbN0C31eG
         7rLkiYfVUhwX8lWuXZoYtMs0nZfdgjLcgyS0kSnsvsDLq4/YPVTdO2MLJqssdwwgKlug
         M4wfJ/BHnC1lcHyHHYSNyO7kswBYNLGf+bugvgBdfFa+NWolNp/Ie5Pp62rjh6fnRqLV
         tUlcFoCnceB9lXZPpqItu2Mks0m8QIEIVLr80iYFLyIWkFivMH3GNlCjK1nj6I2rvdwF
         9x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245281; x=1775850081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7691Rpd885rtdqhZsGvsmlwE0WhG23SmYwp1iH7phM=;
        b=lBcOXSrGiot7wSio2vp7Fhc4k1YDDOFbW1b9D8E2myqdMZ8MYau7UReVTc7aHFWThQ
         dawzMULEg91IjnrQh8ZoTMLYtFNKwWWMo/zYgIgT2X1W/4eLyAzzUs7HO/Xd/kobJuMA
         k5cSDPJSjXwkm1hvQw6TkRgZKI/VpUYttGEy/RWPGtZsc9fhRDQ81+WfkcB9+fWOkfVS
         PcjCG6xc55Imh1UJvsUGd39mh2t87SmEDBfKvYXW+EIjrqhHLaF6cupCW2AN/1FsBQJV
         KaMsrDOMbjh+3U/Oq68bDTRs9vHQ+MBp7Nmx1MUe9pLZBLj0kKNMD50Vc1txffOc3ted
         k7QQ==
X-Gm-Message-State: AOJu0YzZAg1DRByrxNsnwD9UiW2p6Yc9xFSaO6eVRcgObwgMYzYAZwKb
	HijjbLGWpg8c2WPchppFR+YYOuU8adhiTgs++J9ub9f8sxECEiSW4hbNLQ74HmgXttLZzfphIWN
	OttA9UA5sIpkNLTVQ+yqmDJyrAgAzLPiW4iLuXfdd5fpUnbvw7J+i
X-Gm-Gg: AeBDieutJ+Zy42uB6N7hKvgiHMOSZZY7cKifZyl/bK6LBxJoSqm0D8fvv5XhM91xhLJ
	WJc3hDBBefgTqfHQ+4pOibchteqROivZFMLEJA1i5lCPjuvBks6XWbj6SkUPrgiBVSKEnUcq6RR
	DXi7uwUp8dnyqwVoNL08jCJGRKt0Co0THoPpiMHxpuiXG7KsTdzeGOqaiW4NoCGodioOvfSBlqm
	qFrfRCs24H06cXR9InXFMeL0AaznqDqwwhXA3SKnhbvt42lZTLDVizYVyt0s8GziVsZoonin155
	Kbsju5RklDqUFL9sfzQw2eff3eMDpucChQHF3uTTsN9lBwVJpTF6htaZsikl1em1YShmTtWVHIg
	fdNiNz1A9ITB9L7aeOdXwSZ2a++P4gnDoeMlVAFA=
X-Received: by 2002:a05:6a00:2d12:b0:82c:66ba:5f80 with SMTP id d2e1a72fcca58-82d0db7b707mr2480662b3a.4.1775245281177;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82cf9c40eadsm676630b3a.8.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8432334014E;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6A065E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] block: fix integrity offset/length conversions
Date: Fri,  3 Apr 2026 13:41:03 -0600
Message-ID: <20260403194109.2255933-1-csander@purestorage.com>
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

Caleb Sander Mateos (6):
  blk-integrity: take sector_t in bio_integrity_intervals()
  block: use integrity interval instead of sector as seed
  bio-integrity-fs: pass data iter to bio_integrity_verify()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  target: use bio_integrity_intervals() helper

 block/bio-integrity-fs.c            |  5 +++--
 block/bio-integrity.c               |  2 +-
 block/t10-pi.c                      |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/blk-integrity.h       | 12 ++++++------
 6 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.45.2

