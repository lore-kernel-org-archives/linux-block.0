Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180939D6ED
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683377; cv=none; b=avqy5EndQAXZl3m/nIRvp3kiHnZhLfJ0y1kPBkeE+GFinm2/lhZ2wb6EHqWO0RXkLdscRv7GE917bYDPykbfKcthkzGySu0hgm06Zc0kqMWb3y3GbeXuJa27OQZVDTqANV9F9ginea8TEE3YUn6D4tHLckqSU5oa01tnVIn/NuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683377; c=relaxed/simple;
	bh=KvosSvUYYt87Z7DauV7Mb+cE9OHUaVO0rJKoqkbrhKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMzMKZRUVcRw7ldwxXEJIdvr26JwQg5Inl20qvqI/lVXPaPE4QB9qF9C8VRx9wgcH97a+8S0MG9uQEixDc3Mph62ps+leP3qQEDvp5UPYLAYqpu1/3dLHugK5lfG3rP53OQPvD0RbHvc0OLb4E4tdKuI09jt1EksEI6KZbW0NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M1nvyp/R; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M1nvyp/R"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56d8a5f0e44so3613771e0c.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683370; x=1777288170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvtElR9jgLe1msoqA+SsekbRWN4DGaUCVyyMSUvV2mk=;
        b=XC3NA96dIizSo6TxLfwyMmDBLKDIwejNPF7gFaYvXO9RvjSlne2kmgGUm7hiK9hTcP
         erG8OupJOG+I/bo1tuE3D6SIaDIai4a3HOe2N/D0qpTmygvh+wR++BEB4tkq8XaNvofv
         UAkPzEFzx+5Q2ze3b8zYKJuXpnrEYH+v9ikB5PM4ANFEEmJ65cXL1dkRxDgNVTwZIw7+
         VAd6Uz5WWYuhECiyW4/A8vPNHpAi0jRTkMrVnz4RPHhl5CI3wnjE1ZxQZOSWNLM2TvO4
         86w11gUhFIcAOGCRH6Y3omWoMYxLQQYLlrvPsJqTg50QBNe+BqseMrwI2PCHOmqUu8rV
         hljQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NOU+3sMuBI1KlVBaIivct+GwkMy84i66WPAJaClDX0cSOx76BuHZxlPCg/ymyqHZRGjkAGK+pb9K7HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNmHMBCBDPMzr9AgjdNyAvOPdrNCFqwnk0aaPSH2ITVNWgyRM
	imdE3iUQtJFVHOeXRmftP7SMk4YFWuTzPaPULM6sPa8vQu2zMsJzLf4rHqxGqiqXLbbDm4E0jlP
	GbhOOd4rA1RJjjEGfeBjGV7SKeWXar1My93ifHKOl9uChCKFItA9kNgxMjzbTHy7Km+hogSRcW4
	Fxo5oA/7mR7MCDQITiGEnoEpQtDLG66Ye8ycz66/Uo74ePdC4E7SX7Y49oBI5hVMCTRGsxiuzCe
	c0RiY/KcaNaJ5v7og==
X-Gm-Gg: AeBDiet/2QaMdryvvEGXqKYVp+AEWsdIbHL5uaRGUXcM8yaGKcocdBAmmpZFkafHan/
	VCsF4g8cUzxPgcijIhyRboqnhgOu+GsOe/fzdvEJunF6G5YufZ7xi3Q1F/lUt0FP776TeY64aKb
	OIAo22dczMmmLTpPT/CL0525j1FEa+gt1ehA6B0js/W07lx5YCfRdid/mcGFt4iF3MmfHZUyC5u
	LvMRyjVg3t9L2bbgFvDoVVPgH6Enf89i+sVKlxpcjU6ravA1uhVB5XUmcDxMFL90VyZ7wMzBO7C
	BSvva+Raqjhf/yNYsLqtm+WfCOwUwH5A8rc+bI0j/l3UCMZF9doxxW3WyTrMDudjoM8lU2aqrYk
	8MKb5XzxPn45JZ6uhsk7bWsGOk4MP/u62GVMeqYHG3mx9CUThnd1yHgewREBbm7v+15C2zOs8lJ
	92BVFn5nbzqafBbMmYfQOilpLuCy+6Sjc25/rPTt+UE4qhEF5c8fnBMbBrgYlxzXgtw20=
X-Received: by 2002:a05:6102:689c:b0:609:444:e4be with SMTP id ada2fe7eead31-616fe256d4cmr3863248137.18.1776683369758;
        Mon, 20 Apr 2026 04:09:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-617488bba19sm738720137.29.2026.04.20.04.09.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:09:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24e9b4d82so34068985ad.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776683368; x=1777288168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvtElR9jgLe1msoqA+SsekbRWN4DGaUCVyyMSUvV2mk=;
        b=M1nvyp/RD4stzD1YBCzYQUJLyARuOAl2plrwqqFJGaVYuUL4ibKdFv0trHRaVoOHKd
         obGT0nDnQKtSUWJdoQ9O/R965GtoN0zGSDlJ8uKaWWqnSNBQRVTRdedlfoTYVnAZ+Jsa
         UyEvIy7iihMk6JIP2rgCVSWVMRIrVbDrTJEnI=
X-Forwarded-Encrypted: i=1; AFNElJ8fDzCz+vaXnkF58Me1PflNrShqfZLpxhbwBxMzlb5G0xnPe+F4C4gwL6A+zsJj1yYMm+7rtb8V6cdd9Q==@vger.kernel.org
X-Received: by 2002:a17:903:98f:b0:2b2:6fbf:ea2d with SMTP id d9443c01a7336-2b5f9df1eccmr108162645ad.7.1776683367733;
        Mon, 20 Apr 2026 04:09:27 -0700 (PDT)
X-Received: by 2002:a17:903:98f:b0:2b2:6fbf:ea2d with SMTP id d9443c01a7336-2b5f9df1eccmr108162475ad.7.1776683367267;
        Mon, 20 Apr 2026 04:09:27 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm103115415ad.22.2026.04.20.04.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:26 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v2 1/3] scsi: scan: allocate sdev and starget on the NUMA node of the host adapter
Date: Mon, 20 Apr 2026 17:08:37 +0530
Message-ID: <20260420113846.1401374-2-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
References: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Rizzo <james.rizzo@broadcom.com>

When a host adapter is attached to a specific NUMA node, allocating
scsi_device and scsi_target via kzalloc() may place them on a remote
node.  All hot-path I/O accesses to these structures then cross the NUMA
interconnect, adding latency and consuming inter-node bandwidth.

Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
on the same node as the HBA, reducing cross-node traffic and improving
I/O performance on NUMA systems.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_scan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index ef22a4228b85..9749a8dbe964 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/async.h>
+#include <linux/topology.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -286,9 +287,10 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	int display_failure_msg = 1, ret;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct queue_limits lim;
+	int node = dev_to_node(shost->dma_dev);
 
-	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_KERNEL);
+	sdev = kzalloc_node(sizeof(*sdev) + shost->transportt->device_size,
+		       GFP_KERNEL, node);
 	if (!sdev)
 		goto out;
 
@@ -501,8 +503,9 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	struct scsi_target *starget;
 	struct scsi_target *found_target;
 	int error, ref_got;
+	int node = dev_to_node(shost->dma_dev);
 
-	starget = kzalloc(size, GFP_KERNEL);
+	starget = kzalloc_node(size, GFP_KERNEL, node);
 	if (!starget) {
 		printk(KERN_ERR "%s: allocation failure\n", __func__);
 		return NULL;
-- 
2.43.7

