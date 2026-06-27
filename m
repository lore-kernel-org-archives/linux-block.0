Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38535F199
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782541182; cv=none; b=VCY7MgglT4F93qOb50OkYBFwXsO6zqFScPnC4tTASxtxilNk0Mfa7B+3YB+i2FcI1bfFPFrW7msC+CfyMpD5VpR9hsZlqC+4TqmV7+Sfb1etorxnpzCsjIAniMBqjPd4ymoGiecOber+p3VsxQXe/qc4HZW5c3qlKmNnasv0gNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782541182; c=relaxed/simple;
	bh=d0M7wh+b9oxyqpa5s4l2JAPnkxWgIlRGgutMaLK5E5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKS1lO2Z0U+7bhgcwdtLorasWnCKDqo1uYLgZKSkZ3yeA/ubSiOYBc+VtvoifgHaX5gN2FufRL+b5vDtXsW1a9Og0An0uXmqXTiiRF5N2Jm0Gy07tWLhMhuJDg7SlOhjydRCi/IFWxS5m8T2XB+RonaG/qCKyfiOBQ4sTBNCfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBJzvHHy; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBJzvHHy"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-37c5dabff14so126703a91.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541178; x=1783145978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDhSqgeSsmOMGL+q4n2G7rVfqWeNyMvzos/MllXGj4U=;
        b=LBJzvHHyouEyd8u7VMHf5xH8G8i/kGtDWT2Zo75GWlIIrFAxMVjhEiHBy4YZkk+nK/
         EOlMln4o7nfQKO9RDIFJweK7tO3v4pQYxpiY94dU86a8SVqaHFWZnpRgWU5IyH6JwNAa
         5PsKD8e+PUnncWmY90EeCAvaqqvrvCJu1lKEk0gg/UFKsSZFfYJBa9duRq6Hub+4eIka
         f6pzy5RL9nUgHj28D/HG74WR+PWP4CREXTZE2Lv8Eb4/xObIEuyLnBqw/VtxUY1Uho6M
         zQrCSHA2whpe47ZefxKs+wPioYjmCrCwyid7ACzRoMDfc1qydgt2tyayXaGFjpx1KSJy
         PKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541178; x=1783145978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDhSqgeSsmOMGL+q4n2G7rVfqWeNyMvzos/MllXGj4U=;
        b=N2bcAT8fxrurA3t4bGqpjqT4W+SAMpZKCaKJqaKluy9QszLX/KB3tm/yldhESrPpWF
         aynwaTuCUKIv+eOUHAJm70rQn8ODb9J6R1tatMhF3808L7E0XX37C4bKDCTV0o4BLWLw
         S1XbcFK4eX8wPZGlXpynfmPiVfZcp3zs1mizbd0Rjc/yP2fmIVhSRFmmT24CxKm35tdx
         J1VwmiT4qpDIQmYSdoamtdyER67JT0OWlmwS+L58xctHJQVrmNVe+DUXLdJoZKt1IooG
         M5aOsswF8q/31vYS4wHQH2Pn9vXN/IZYNgLTK6yE1LqqUwtIeZSQEJOBpeJehY3j443J
         P20A==
X-Gm-Message-State: AOJu0YwMIV73Lna590VSjSqQHU6PbdoFVoWJRyrXumK+1nGWvLKetmiW
	tKXmPBV4ozX5cdbm/X+ki0M7qDrGBYrk+w1QX5MzfU15DzBuocFTXVbigfFAnw00uYVIMSlreko
	d1iaDsTI+AckVS6ItvXMKJQuvF3SJWkF0+0wQ
X-Gm-Gg: AfdE7cmbAECkUCVEuqbtGElRmSOd/P5Iw0+upzEnNJ3iqWD4LpxwNIx1069m9TcqAtv
	Iu+rvRDDYASZChcARTYnuHul64mtbQbfXGt+ZRFL8pKgaWCqMhjg1VJHw0kKZirS+3quc7KmcU8
	QqPEz1Xnr9wfTPDG4iw6f0cJ3h6QbMUOiMAeX2niKnqrv3HzW6BVAP8gybSLE0LRlmnqdy5mCDP
	9oeOn6xZERvfHxo89+YzvVYiNUzWG2bVlDQ46Bm1eiKJoEvw9BuWAdhDKmGMYrra5T/RS+2W3Ud
	5SKOzq7vO7QB+/SozEf+yxrCCnW8u6fjAZeTgNeNsg47trovXdNEwSD5GhQJSH55NRboWebMZXC
	ioB10Pa4FqZjfOPt/skcT8I+dSTeuzA2tPoydXulksQ0=
X-Received: by 2002:a17:90b:2886:b0:36d:cc9b:2f60 with SMTP id 98e67ed59e1d1-37dfa27d18amr4991337a91.4.1782541178343;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37fc2abbd48sm47306a91.4.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 9E1C240146;
	Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 986B7E40789; Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 0/2] Avoid software ref tag remapping for NVMe devices
Date: Sat, 27 Jun 2026 00:19:31 -0600
Message-ID: <20260627061933.2187447-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, each bio has a reference tag seed which is used to generate
the sequential ref tags in its protection information. In principle, the
ref tag seed can be any value as long as the same value is used when
blocks are written as when they are read back. However, some devices
(e.g. T10 DIF) require the ref tags to match the low bits of the
absolute integrity interval numbers. So the block integrity layer always
"remaps" ref tags to absolute integrity intervals using
blk_integrity_prepare() on writes and blk_integrity_complete() on reads.

On devices which do support an explicit "expected initial reference tag"
field in addition to the logical block address on each I/O, the software
ref tag remapping could be skipped by just passing the ref tag seed as
the expected initial ref tag.

Introduce a BLK_EXPECTED_REF_TAG_CAPABLE flag for devices to advertise
support for an expected initial ref tag. On devices that set this flag,
skip the block integrity layer ref tag remapping. Also take care not to
merge bios with non-contiguous ref tags, as the merged bio's ref tags
would no longer come from a single ref tag seed.

Set BLK_EXPECTED_REF_TAG_CAPABLE for NVMe devices and plumb the ref tag
seed (if provided) to the NVMe Read/Write (E)ILBRT field.

One potential concern would be NVMe devices which already have ref tags
written by an old kernel, which did perform the remapping (persisting
ref tags set to the low bits of the LBAs). When a new kernel that skips
the remapping reads back the ref tags, it would expect them to match the
ref tag seed, which would fail the ref tag verification.

Caleb Sander Mateos (2):
  blk-integrity: add BLK_EXPECTED_REF_TAG_CAPABLE
  nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE

 block/blk-integrity.c         | 18 ++++++++++++++++++
 block/t10-pi.c                |  3 ++-
 drivers/nvme/host/core.c      | 20 ++++++++++----------
 include/linux/blk-integrity.h |  2 ++
 include/linux/t10-pi.h        |  5 -----
 5 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.54.0

