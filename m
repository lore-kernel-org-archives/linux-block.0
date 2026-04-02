Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D031E828
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114250; cv=none; b=szK888af73sRrd49ndKOZyGXCkML/ezYOvjPJif0FEAj0xefzki5K02rSyyKJ7yvCwVLM/Eikve6BZBtvdAiTdA3j6sHgH41lp6BHAQTTSjlosS6YLF3iYvxgZWBuD95o1QOpdC/sj2CQEhBjrNRW7Cl7KG9LND1epV6As9OzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114250; c=relaxed/simple;
	bh=2R2GMZ73Yol7gtDOUlrMhMWsyLM7lFI5nI31CwQKusQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEQxT/PITESlBcwAyfXjEMTLn3uhHz6agpguWlw0VRpuZnmwIVyIGTs6Kjrm2hTWlPLNLhI+RbLdgv83PfaasD6JM+hfFlgMDB1bIMP3MF+p/w9AUUTRqyYukXZNpzHDY6CzDk+kxSK5xExBfxfLiaqUYl3mo6NlM+Gk2D6Q4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iFIL3vyT; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iFIL3vyT"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35c1a131946so1057863a91.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775114248; x=1775719048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goIi9ZqVO3x7phHT0vr2LplFt4y4whfau7BpPAyCJ1w=;
        b=aqohho8lkXy+7oYCt4E0t6I4JC0Ctqlqfot7WtzOLTMXmIJsYiJULtgf8SJ6WQsv8B
         mlVmjjdGtPv2koxK2RAp1O5fymAKKNZzqbauljO7FHpWAxpUlF40AO854ErqCmYSi5Kg
         8fNRzG9ielwVz6nI4f5ejz4pzM34hxtdv7rdKVMN09KHEibbFz0BUbAuOuyeU1tdG5aC
         YR7VUTlQ7BLPh7HsGwEGA5+FGbvFujR7p1UK68oIu8QblpFu5kX3UDrrk+u6yEaJf0jy
         yCaQ1HAF66n2Bp/K2DSv1TbnSLcfD7Z4ZPILsEEotKqLyL88pcf3j0fZmJV1MAE92qoa
         L/hA==
X-Forwarded-Encrypted: i=1; AJvYcCXooqE5ZUeMwLun/olvbIwrSvGitdm9s2RSzj7JSqJWgTXDshZ+bfjQnZskfvwqVJ8PZfLi7VPiO0xlQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyD6wNpqMWbot6Eg1xRHgHx6mNOr0sLualOJemDP3Dmf3ecnO3
	Z3siGS7JWj6fGfzJwdc+tOuL2d3w54uDeDsva6TGFV7qPecH+l5mzy2g/JAuQfo0YKInaviYF72
	5+O66ratsSnpZAgaXn5V2jj/yyTcIDZHzHkfF4rmq4rXfnYo4Yh9V0qJyg6gAgYKbqz51kCAUsE
	chxe3ad92EmfYYksSd33dyLgQYNPuhicncdqWzKIiCwlE7rZs4jHG/oLYrxd9xUxOTFMpCIO/H0
	s7o35/OhSNtdgLjaL1H
X-Gm-Gg: AeBDietWAYYOPJWibyM6jJRwzopXGwoX1mWOj1GwEbAE/OdNOO2MtWbyhxg8HCx6h4Y
	mQzoFNGSOMkWW6JN7krq3hoR4wWbYOC9QHjKWdDbRBv4Lc9Z5ZzJyyf+dM5vJ9njAWJitvRiBZK
	6IJOW7n9W15ApNmBX7Rjm2SxICcOuChXGTZ0epPeMTDeYGJ5kb1FZZFBOziESEo3vNhnUzfi9M+
	0CtHhOwB6uX7mArJUf8ObXryyuJiXSGX4U8IQPI+uoz5wuJ8IZYJ/GO6hv3sSdPfeYyAwkMuX9F
	LYeVtmDkwxUTt1DsgK6eQKPARvovwlz1esG7JS+Kbby6eP+P/S/do9DgwIsq+KPbAEPMGo0+Ls5
	GiNfn8qWIpi4XRVCDPthkCZ1xQMeawj9e2rtaAPf6iRXEBnRjt6LPr0LuwmBBoKj+pk/veE2s3Z
	YlDBbJOHX0jnkJ9SkUSrbMYJeMKeOA8QTpjbBim4A3CFZFAnid4IkP5L6Yevg=
X-Received: by 2002:a17:903:2ecb:b0:2b0:aebe:259 with SMTP id d9443c01a7336-2b277e31cafmr14713055ad.19.1775114247621;
        Thu, 02 Apr 2026 00:17:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2748a3536sm1644885ad.33.2026.04.02.00.17.27
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:17:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d93a8149bso2190660a91.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775114246; x=1775719046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goIi9ZqVO3x7phHT0vr2LplFt4y4whfau7BpPAyCJ1w=;
        b=iFIL3vyTUGzbnnVslATYFihJ8ZiA+7vr9plfccVTKwUJW7GkQx9auV6fSwNsjAhobk
         Rq9b6PCD2ERrtwPdpf12JUnANe3oPi05qgcURpRHyClkY5CeMYb6Hkts7w15PHE6D07+
         fOjrnfIc2Fwu1QcUScPBuxuhPWqfNQtbvr1uQ=
X-Forwarded-Encrypted: i=1; AJvYcCV3PGA+mwjkieTSzXkv1WsjHaC1JMloKUmthqh8UZVI0PQv3GfubqyOM602Ij4+gclZnc4FoD54jp+pzA==@vger.kernel.org
X-Received: by 2002:a17:903:1b4e:b0:2b0:51be:f9d7 with SMTP id d9443c01a7336-2b277e2cdb1mr13499545ad.18.1775114245741;
        Thu, 02 Apr 2026 00:17:25 -0700 (PDT)
X-Received: by 2002:a17:903:1b4e:b0:2b0:51be:f9d7 with SMTP id d9443c01a7336-2b277e2cdb1mr13499295ad.18.1775114245334;
        Thu, 02 Apr 2026 00:17:25 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm24612825ad.27.2026.04.02.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:17:24 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH 1/3] scsi: use NUMA-local allocation for sdev and starget
Date: Thu,  2 Apr 2026 13:16:35 +0530
Message-ID: <20260402074637.92417-2-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260402074637.92417-1-sumit.saxena@broadcom.com>
References: <20260402074637.92417-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Rizzo <james.rizzo@broadcom.com>

Allocate scsi_device and scsi_target on the same NUMA node as the host
adapter's DMA device to improve memory locality and reduce cross-node
traffic.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_scan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index efcaf85ff699..b98c5b7d8018 100644
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
 
@@ -504,8 +506,9 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
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

