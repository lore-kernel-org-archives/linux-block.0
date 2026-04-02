Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC801388386
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114236; cv=none; b=haGvI1SIUFTiWhsyESaNB3RR3zohsJvgLIGyypVah/4ZYYaYMeEpu2PBpUol7lnDp6eu0gLOEsb2zZ+hRR8IWJSLdRkcZCOGqPoyAYYZyl1VMRGe64ZUBYr/RjX+TwouK02XRY+VxyOSK7eUWVHpvYuIKQqsgl7tMWZWh7VS0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114236; c=relaxed/simple;
	bh=SlVs8jIJZ4AW7Wxo9yxSZjpREVYQTXUK4KKxeJVHWVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7KZHHszzb9FXIFXtT6MVlAX+M0X7ftSNIYRf6JaIfbGPJJRvTvUg/oUauwNoIH4vk21lxOtXlxMKuzNZrhH2JJMA11H+5RtE9vlFVczZ7t8rXG3Io6BEfSC4iU/7XHVSAmYIHlSipqQ02AF4/AW+7aunfuzrBF4a5KEsvl6iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tx5JVxYi; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tx5JVxYi"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso460530e0c.3
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775114234; x=1775719034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1nvpVvk17JfQ+DD3OmsLO1BM+aJTjprL5lAoSdl9sw=;
        b=HNU3/mnAOa3pWJ+SFWGHryxsA53IfmfDKt9YYG9z3dQr9pOa/FUMqWaOB1c8+TxkJn
         SsaNhLsxiiFFnth6K2w4SQEWdSpD6ZWyLFdDCpDxENYpRx3EnB2Bj81dbvy5CDNNLnDv
         KRfmo+H+RMXu5cYB+D+akhxdNaDxli45UI1ejwutHrGzAEupDEQR6qsCDD0/j91AqQIs
         yYKj/9bkgPDqA7vUHe6qwd3P83rmVl+DMVB43RBT4spvw9E4/QJT6VhgZzJz8LKQbGuG
         M38pkXUeRKZVFY3XEqCAVWJSfG24ZI1CIpxsWOGIwBH0b3nQeJ8I7WMxptSBlBb6H+F5
         Ou+A==
X-Forwarded-Encrypted: i=1; AJvYcCX/MRBEock6TWcCvtgTGZx2oE/M3BbvHPU5eC7K29AYyDrNefYjD5hTRhk/K7XPyEn3L4t34lQ49pk1Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzs/CNnRaz69iKwVimH21I8+Rj2+k6K9836ZqzLzWm6y7pl6b/
	OS0FytyljCLvpJxb701efzMwdkYfxN+LjgIKeWwgDKrSSSGq/46TSZ+uMmkCxcPlyKXAudHgMIV
	fEEXgC9x+XcLiLk7yQZa8lBBINpCPd269vXaZ7aXxGXY5taX7BA7T420BdCbioEZP9QAz34cX7m
	x0wmMmidpwCkzIHV0/tOONVfQdC2nbNiSwwDKkMdwIDCfaKMFOQe6fqlMiyPEVoxpR/xIyoqVWz
	6wIl2JOPN/urh4i7hlV
X-Gm-Gg: ATEYQzyFkQc1cyNematCasUv+HUDFR06oztiZR51EfwJK5C1jBsjBMsp2Slq/63a0rX
	6C0RABmy6IWRBik8dwxfLCkWYIgO+rSOhf0uP/PuZiLO5WVShMJbqToL58V4z4eUKWWoDSClqCp
	6UuwIlFL1y9sxP4KJWbugRPLZk75u5HmdDMa+iaD1hSmhjvU/3/SgoU85aV4LiypvMG5g1oy0o5
	Ge6OCYT/hPDe8AsOZgzBaK7BdWlpX9Q1pc/QY/ngg7xyTEepHUowp7kxulYvSRY7vWAg9fIRajN
	Rp9K4ohg9Ws+Tr62K/bWgCY/HNbbUp9TqgENtUW+CoaOsIGS8rY708Ovqt0Uhq1FPCUkkkx1GXw
	8hMcsgUvY5ESmmFvAFjRbZWgyDx+2GuOkaV/3q0Q13qyk4WeP+nkH1XECl3fwV1C1muxgn+BalA
	nQ5aV3tRgRsk6iH980mUtmpTYELsNAr3f+Mf39eP8lrjEc6DvNt/YzEEik
X-Received: by 2002:a05:6102:f0a:b0:5ff:fbe4:8a8 with SMTP id ada2fe7eead31-605681a83edmr2820433137.25.1775114233552;
        Thu, 02 Apr 2026 00:17:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60582e11fbfsm166709137.9.2026.04.02.00.17.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:17:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0c92ff4ebso6444845ad.2
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775114232; x=1775719032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1nvpVvk17JfQ+DD3OmsLO1BM+aJTjprL5lAoSdl9sw=;
        b=Tx5JVxYixENut1zM61o1baMJ4WDWPqMSUKRqmZAtw03xbVMNSlH1ZlBNlKAg7OSAx9
         Oux+let+Ubiw2unSTisLOgun40T9lYF5wlI9fBkU7lx5wlXXrLFqrjI6NIfA9rdg2iQP
         jPJkVMvWaLcSFxh/5lfqauuDXhEpXGq5kOw3s=
X-Forwarded-Encrypted: i=1; AJvYcCVO8TvPHhSg0hF6LVAgyssRXEzF6Lqye9tL/fE1z7uHfgdfqXACw1P1Hx53gvXkvB3VUOuEjZG7Jv855g==@vger.kernel.org
X-Received: by 2002:a17:903:384f:b0:2b2:57ee:c04e with SMTP id d9443c01a7336-2b269add3fcmr67138345ad.18.1775114232158;
        Thu, 02 Apr 2026 00:17:12 -0700 (PDT)
X-Received: by 2002:a17:903:384f:b0:2b2:57ee:c04e with SMTP id d9443c01a7336-2b269add3fcmr67138025ad.18.1775114231667;
        Thu, 02 Apr 2026 00:17:11 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm24612825ad.27.2026.04.02.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:17:10 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH 0/3] scsi/block: NUMA-local allocations and false-sharing fixes
Date: Thu,  2 Apr 2026 13:16:34 +0530
Message-ID: <20260402074637.92417-1-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series contains three performance improvements targeting the SCSI
and block layers on multi-socket NUMA systems.

On multi-socket NUMA systems we observed extreme I/O throughput variance
of 50-60% between runs.  This series identifies and fixes two root causes:
cross-node memory accesses due to NUMA-unaware allocations in the scan
path, and false sharing between hot atomic counters in
struct request_queue and struct scsi_device.

The first patch makes the SCSI scan path allocate scsi_device and
scsi_target on the NUMA node of the host adapter.

The second patch addresses false sharing in struct request_queue.
This patch touches include/linux/blkdev.h, so needs review from
linux-block, an Acked-by from the block maintainer is requested before
merging via the SCSI tree.

The third patch addresses a false-sharing problem in struct
scsi_device.

Performance notes:

Tested on a dual-socket NUMA system with an mpi3mr HBA, running fio
(random read, 4K, QD 64, 16 jobs, 60s, direct I/O). 
IOPS figures are in KIOPS (thousands of IOPS):

  Configuration                    Avg KIOPS   Range (KIOPS)   Spread
  Baseline                         6,255       4,200 - 6,700   ~37%
  Baseline + patches 2-3 (align)   6,653       6,000 - 7,000   ~15%
  Baseline + all patches (1-3)     6,649       6,400 - 7,000    ~9%

Key findings:
  - Cacheline alignment patches (2-3) raise average IOPS by ~6% and
    cut throughput spread from ~37% to ~15%.
  - Adding the NUMA allocation patch (1) further tightens the spread
    to ~9% with negligible impact on average throughput.
  - The combined effect reduces the observed 50-60% run-to-run variance
    to under 10%, significantly improving workload predictability.

No functional regressions observed.

This patch series is based on Martin's for-next tree.

James Rizzo (3):
  scsi: use NUMA-local allocation for sdev and starget
  block: align nr_active_requests_shared_tags to avoid cache line
    contention
  scsi: align scsi_device iodone_cnt to avoid cache line contention

 drivers/scsi/scsi_scan.c   | 9 ++++++---
 include/linux/blkdev.h     | 4 +++-
 include/scsi/scsi_device.h | 4 +++-
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.43.7
