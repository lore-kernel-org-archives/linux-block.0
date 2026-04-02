Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B65370D66
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114260; cv=none; b=euLmA9YE5QQ2TBcIkH5Y9PHsrQMaHQ8zaKWrWwhYgwR+yz7u76cMBN2/Ap4d6+3pj4O+ZGNhCpgD7czxFsR4QiC7CC4TrAvzQ+CrecFlcxBpgCvKgzufdguKS/juGwPaDSBstRdZpSqYMfWrCl4RIpgDtGHt1JKZUKqxhuuXBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114260; c=relaxed/simple;
	bh=1gdV0SawydOTOqfq2ZqweOb9opxXVWy34LHBBXGq3jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bnyr5g9dXU/UarNY3TdDZVwovCBTpkgP5hAnnfcyemp1+UecPrhFbJ1oUzytwE7fP3/vqw/YXENjOb6dgSgeKgYCFvP4Ro9itDNsprDAB5EMsq9l3RAx6/RRX76MhwoNVJB6Ha8ly8mIJHAoSk5oxM/AxQGHYtPJR+mxSZ+4niM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f9qvXdtz; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f9qvXdtz"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cb3bae8d3eso62646285a.1
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775114258; x=1775719058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iANOw+j+FFixYv8CP4Q0aUKUIdpvufgAkkTBaFaBfMM=;
        b=eh0d2yElo+3BJOcq0pcd+tcN2D+FewlnH+4SYWQOQoqRrp3rYxD1GlldaSWQRPO+mI
         98bDJBZu9xgONMbrb1leSSsHhzv/WuIjSCYVWXyJyOSw8mjScGz8DeTLuWgjnijTob49
         PDNEVn4ybeXP132w9jYT68/Or0ID/dohoxIwRvXjNGpd9pbZ85OYyqxWtfREa2552iQE
         rESLYcqXs3Qi7wc7eR17skIFq8+iUfgSrJl0QtF79wo9J+ssacWRRMm3+h/vHTLpMZW5
         vPjIAzeBLnJ72daEP2kPRC9KlfnsnCaU+3UZIF8weZJzLg8d//0bHm2ZK3CDGTzE8iEt
         RgtA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6vnObRG7xXUMCKmWxzmIVK7LWn5khpd+aEvcqCoC21LxgW8XSI6IzHZcP0F+mc0gzLk2+BgYpSqsVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8gMhzMpmQt9m9FLw+YYoBCBFa9lFVMcvNWg5t+UPP+UnXnXe
	iX4lAnqCK8IRNZ57PH4sgVtwcaFC5FbHIG7m6M30gqjWioNElY6yvGIL97Qplltk2pPdoLI3SjF
	FkNlRQZjjzXgI/rVS1dxd+xZOJSiQw0FCWtYFGo9UaZr3O8qrt6ZfDL+niURIDybLqhSyqqcgy+
	a/JMRVXiPeZumF0wiOdsgSC20c0JNzETkXudUvXZfink0gt4mdp90O5rGSTsVfD3RbMzShRZoN4
	J2WZhomqX2Rja7Pjg==
X-Gm-Gg: ATEYQzxbiDT6HmjGhXLJofTQ5K/T//0B4yYQ1q2LSe6pQs1xNXcfvHv/4O8cMfCse2R
	mgohBCUZzfoGK0p0b/gwGxLkTsF/7IhRcH6HysdxKswsHT2unwlNNrVrhANumY1YiNej9+xamsQ
	Pqsepo5srUsm/rmYMtjxlp5d8BkH2nBWc+FuIbANzmCykMF2NF8vTVnFJatOu/8IwHOu1T5HBDe
	3DL67dJMeVOFcrklwj7y3CxMIdV33pUGYzqHUqALt4KurEurUkuD6wx0Vwlab0YwBAWxLn3Nni8
	21Xeaz1MK7gIV+NUYqNEHgJqP3urzCZ+eeaZKpCYSrQmvAP6hKSzdJEiQjII+MTW1G9cyMlkTH6
	pbwsNOf1EdTIIWAiywa2CM6dAfMTlvWv0JBA7rNEBKDuWjcHr9bIifuY+dK370njnSRl4U3CN/F
	wGaguaPx7SoWFh8aXs47piNpweyyPw7srgc197hIQ63FqXfbg3NsuzME9BErU=
X-Received: by 2002:ad4:5c6d:0:b0:89c:d808:c255 with SMTP id 6a1803df08f44-8a5a10d1ebamr38338286d6.37.1775114257874;
        Thu, 02 Apr 2026 00:17:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a596ff78c8sm2029486d6.23.2026.04.02.00.17.37
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:17:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2471321dcso16580795ad.1
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775114256; x=1775719056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iANOw+j+FFixYv8CP4Q0aUKUIdpvufgAkkTBaFaBfMM=;
        b=f9qvXdtzvQVlY0SP5FBqiswyZ7ffWHFiAJNw0lKwK1NBVfmfgTR/LB+5jlwsZ5/oqP
         kaicCgBGDKcEjAiOQLsHz7nrHe+cFAjXhZaoKcpe8syaS4m3Y2VfD5fC2kTjX7u9ulB9
         jNsPKk7mqkhB5WVRRZW9ZpFE2WK2nxiUUvde0=
X-Forwarded-Encrypted: i=1; AJvYcCX9pRs9/GpLzufP8HeUeQOaQd3bL/eQN0HpElI+tplgM+wudX2Frgvw8ASFx+y6VDLZIE9wkrWqxeFQSg==@vger.kernel.org
X-Received: by 2002:a17:903:1a2f:b0:2b2:4e5a:9471 with SMTP id d9443c01a7336-2b2758c365cmr20897085ad.22.1775114256632;
        Thu, 02 Apr 2026 00:17:36 -0700 (PDT)
X-Received: by 2002:a17:903:1a2f:b0:2b2:4e5a:9471 with SMTP id d9443c01a7336-2b2758c365cmr20896855ad.22.1775114256232;
        Thu, 02 Apr 2026 00:17:36 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm24612825ad.27.2026.04.02.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:17:35 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH 3/3] scsi: align scsi_device iodone_cnt to avoid cache line contention
Date: Thu,  2 Apr 2026 13:16:37 +0530
Message-ID: <20260402074637.92417-4-sumit.saxena@broadcom.com>
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

Place iodone_cnt on its own cache line so it does not share a cache line
with iorequest_cnt, avoiding significant performance hits from false
sharing when request and completion paths update these counters on some
CPU architectures.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 include/scsi/scsi_device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9c2a7bbe5891..86c2a3a6b206 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -272,7 +272,9 @@ struct scsi_device {
 #define SCSI_DEFAULT_DEVICE_BLOCKED	3
 
 	atomic_t iorequest_cnt;
-	atomic_t iodone_cnt;
+	/* ensure iorequest_cnt and iodone_cnt are on different cache lines to avoid significant
+	   performance hits on cache line contention on some CPU architectures */
+	atomic_t iodone_cnt ____cacheline_aligned_in_smp;
 	atomic_t ioerr_cnt;
 	atomic_t iotmo_cnt;
 
-- 
2.43.7

