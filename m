Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F439D6D9
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683374; cv=none; b=aSprcaHAKvbYmuZr7R1nTut2R6D7eXDdTc/RL9AxjZo1j+l7vFWb/YdHpsLzKgdF9PHiiyuML52yCLMxhG1dVYdoMLFjln6oOCVx0WpQirJeeON6Eyrg3aeLXCe8F7B92vxfh93xeYWKesmrjGrlHOehDspsvDue+F/Qwx5xlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683374; c=relaxed/simple;
	bh=BqiatpiZK82yHpofKxSogwomIgLQIYYScdESQkvH10E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cglE2TqCbKx99US6MKG+c9k28srM/vs/u+gjk0rf/KYgrKkeH3qCvHwGvcy9ctxgIMi/I5WEssEjEH3wa8kxymOlyiCZGcHn4cIAXWfRwsIWrN2q1dpfFLKkA6/CG3hIilC7RjjGVlDwttwmF2I2Xx+1Fb4FuS+stOK8p4hxud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BT99HENN; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BT99HENN"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2b2503753efso28127035ad.0
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683366; x=1777288166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqaMgTOsYO0gFcKZhql6upDj4RcuT3QIXW9T6oujAMo=;
        b=kB9B7D2SYzlOwdKAKqDnfoj2sIqM9r1QIAFM4ZL7b66QXU7rDoOooemxpHY8ThmisL
         rlHXj+5+ejL4Rh+N+lNlqatry6N7W/5EjZcHCKqajwqjmoZ0hnwpbczZf8BObjSv3fxk
         bnJn8VoX18YVQz7gPzzp9ttKnlE8TSJg7sL81P0nL3M3G89yxMYjZe5pXfJA3wcjHMGx
         w8ACZ0QoBYIUqXc1iPEsueAjA+06jjYcrwDMvtgaiJYrsJZM3RRtFSU1GFXrz17kvxER
         AqcwbNQ7sUyzh6/azvHQDykjSnYmqs9NScf85emxGWCAl10rcfP2fPq62Ryc9mCYJGhK
         RNLQ==
X-Forwarded-Encrypted: i=1; AFNElJ87PON/2+nqGgvDsMwIxC8/yjjGpj+mKcyTL+cML/0hPZtvlvPNiAKMyWZ0o+DSZAvQUh4DTaZs0KQVhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKD7IRlNAbZu01qMA50xEsJ0DYmM4KPWgZIzV4+Wp2jA9HiC8
	1xwq5tJ3xE5BZRNVj2XRQBjZoq4C8b09KwzNzNPU4k2Q9Jfv3KGezs++lhYMtujVLSKsfEdZCzQ
	IIeDy0mFNaWimmgfjiSdfnocdzoy7ukx8vTNDxCouOgW+WKDssGMHSgroa8lFmIzXU5awK2PDWR
	jP+aJy6xph3c8rNQDgL2UPsg+LfVqRCvkEcbPsu6sF742AQEffNcDepfYYyTKYL+8U6yZlWnWay
	sNhnhAiKB5rNUTdUQ==
X-Gm-Gg: AeBDievYBRqrcvEQnU1mlbD51ujTvVP8x0XXTeedzjRoFXYjeeOHMc+OW5h0BQXdb8D
	rd/MImMRV8d5egNJuWLhh08z6MBq5f/ul/G/dHye/Zmx+DsYwZcC8tc1fucrtqhOtOAz72rw+tB
	6XA3TkN01GXj8AUlRDi7X/NpQ16EXvxZNd+JOvj84ihmBacMYVEKygvhgEa+I9v0rPk2ayaREBK
	VExXalhKsBzrnL/fHlGiK5oiex1XTtKRIJ6cTGOBveJS5kDjSA7RqC5QAE8NhLcUXVuYHxHjUlg
	UmgIEFHQ/iG7AuLKZkriGNLkRLsm2rZX/p+5LPyYAG6dJEjAsq6y6pvQn+jtftGtkOiZXPFT/Hh
	UYsoxm+ue7nXNV1muTDj8feXvHzd0Of51oTQ9IDMwGgBXf16G+1v8yNk6b3sL+lelCJeai9m/Ch
	74Kp3A5Jk8TP6SbkQSwreo7jLDKNdgFCJ12vxVakFCfdc3hzYObrOTUklkf6yo8ZaaX7I=
X-Received: by 2002:a17:903:17cb:b0:2b2:67cd:9963 with SMTP id d9443c01a7336-2b5f9fd5c04mr129878765ad.38.1776683366330;
        Mon, 20 Apr 2026 04:09:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-90.dlp.protect.broadcom.com. [144.49.247.90])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5fa9fb81esm6571735ad.8.2026.04.20.04.09.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:09:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so39549875ad.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776683364; x=1777288164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqaMgTOsYO0gFcKZhql6upDj4RcuT3QIXW9T6oujAMo=;
        b=BT99HENNdkFPbqIX+H9FN3Yq2y/j9D0lnFMcRO9dWco5nCNgWgKqxOgE9PNfedzQF0
         qfHUdJjgIphk21frDtTblu7/VQSFhq4mbm5jK0JxbJWbhzx9Wn8LTQOcCRCkDfNX1Sea
         gFB4i0fr+ty7KYsJLV1VSJjdjEvkATsGIjxGo=
X-Forwarded-Encrypted: i=1; AFNElJ/REyKyPj8WZuZ8+HqnW+1sR2EQ5qHnBzqhAH0LwCfKNkve7Zr7R8AtLeOYDrj/FigZjVN3VqKXHwrllg==@vger.kernel.org
X-Received: by 2002:a17:903:1d2:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b5f9f4e110mr143585575ad.23.1776683364392;
        Mon, 20 Apr 2026 04:09:24 -0700 (PDT)
X-Received: by 2002:a17:903:1d2:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b5f9f4e110mr143585245ad.23.1776683363864;
        Mon, 20 Apr 2026 04:09:23 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm103115415ad.22.2026.04.20.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:23 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v2 0/3] scsi/block: NUMA-local scan allocations, shared-tag path cleanup, and SCSI I/O counters
Date: Mon, 20 Apr 2026 17:08:36 +0530
Message-ID: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series contains three performance improvements targeting the SCSI
and block layers on multi-socket NUMA and heavily loaded SMP systems.

On multi-socket NUMA systems we observed extreme I/O throughput variance
of 50-60% between runs.  This series identifies and fixes two root causes:
cross-node memory accesses due to NUMA-unaware allocations in the scan
path, and false sharing between hot atomic counters in struct request_queue
and struct scsi_device.

Performance notes:

Tested on a dual-socket NUMA system (2x 32-core, 256 GB/socket) with
an mpi3mr HBA, running fio (random read, 4K, QD 64, 16 jobs, 60 s,
direct I/O).  IOPS figures are in KIOPS (thousands of IOPS):

  Configuration                    Avg KIOPS   Range (KIOPS)   Spread
  Baseline                         6,255       4,200 - 6,700   ~37%
  Baseline + all patches           7,350       7,000 - 7,700    ~10%

Key findings:

These patches combinedly reduces the observed 50-60% run-to-run variance
to under 10%, significantly improving workload predictability and
improves IOPs by 16-18%.

No functional regressions observed.

This patch series is based on Martin's for-next tree.

Changes in v2
--------------

  Patch 1 — Same functional goal as v1 patch 1: NUMA-local scsi_device /
  scsi_target allocations in the scan path so steady-state I/O does not
  habitually touch remote memory when the host has a fixed DMA/NUMA
  affinity.

  Patch 2 — Replaces v1’s ____cacheline_aligned_in_smp on
  nr_active_requests_shared_tags with shared tags removal work done by
  Bart Van Assche [1], rebased for the current tree; it removes the
  atomic counter- nr_active_request_shared_tags that motivated the v1
  false-sharing workaround and, in our testing, improves IOPS on the order
  of roughly 16–18% for the shared-tag workload exercised.
  This patch touches include/linux/blkdev.h, so needs review from
  linux-block@vger.kernel.org; an Acked-by from the block maintainer is
  requested before merging via the SCSI tree.

  Patch 3 — Replaces v1’s cache-line padding of iodone_cnt with
  percpu_counter for both iorequest_cnt and iodone_cnt, so submission and
  completion paths mostly update CPU-local state instead of bouncing a
  single cache line, without inflating struct scsi_device for SMP
  alignment.

[1]: https://lore.kernel.org/linux-block/20240529213921.3166462-1-bvanassche@acm.org/

James Rizzo (1):
  scsi: scan: allocate sdev and starget on the NUMA node of the host adapter

Bart Van Assche (1):
  block: drop shared-tag fairness throttling

Sumit Saxena (1):
  scsi: use percpu counters for iorequest_cnt and iodone_cnt

 12 files changed, 68 insertions(+), 145 deletions(-)

---
2.43.7
