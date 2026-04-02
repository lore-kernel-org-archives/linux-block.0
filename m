Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D398382390
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114255; cv=none; b=RCFaLgdq97oI27FHIC3sfr9heSPbDIGjJ0qWq2FKPFd1MMiiAJMiCgk61H+YQgCTwWq1io0Et2n4DCFH+z0AJ8T48JUZG76EePbILfmOVtVsT6NNWGpYzb5UGtFlMMjxbATHt1MT0sJid9oew7zQ8CaXv3ZZnBh0WoXpFz2gSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114255; c=relaxed/simple;
	bh=8VtY1s07JsvpgjHmz/k4durVfj/YL5x4wNgvwrQk6Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWG5j84oMncZ8foWVcGjeujoAZ7s1oUY59d8E64uVAj12MuOyCmn6BxWCnS0nYKZB7X6ZYvh6sP9dLIiaBj4PJgIGkXyg2Hl0CFPAKpGkHhFlv0YfAYgRhshh6fkpevpPbhgUxvuTMbkFILvVVqQsGRfsTLE3UWHlOOLaTydfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U/25INLE; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U/25INLE"
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2c1632faeb9so1247115eec.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775114253; x=1775719053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TftjXKzvnuKTg+BCeN292xhOJ4TG6xE+i1ind2ngbzc=;
        b=Z2y9/IWqBNEsWOO/lndkszvRsGA7BqQLTo4HKLJEt7Vr1wWS3pU2kCjtYgeotDcoSQ
         KiU4+d3FKmQZ8VYlQNLo//WFKJvbWrPMnjwbCIUwIWRTm6wbCz/hxjwNNs5ZWzF3NZRx
         Hrje8ZlS2Dp1w3pDfQ9ejWpCDaouBKI0BjBcHAf4GUJ5NFSFwi8fSr05t/oAccqNBSvC
         y7CY4xf53PWZYX3y+NT1ZAXCrLAfJD/HsXlU9FFsbfnO3CHb4KTkrsC4/2XtRudO5b5H
         J2yjGLSizQ1SrGFHywc2zvMLpauK5fwxSs4wZSLNZ4ruTns14+edEhJYR96oClXzcnsC
         WjUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/XAbZWFbuz0nitRcDowZXM3B1CkKpgPW22tTQvNs8xw00XzalhfgArmxmNMJ5NBDEDh5mqwrFxOTG8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ28z96vFQPhlKkRtIU2IyaBAM5FO3/cbPiCg6N0OxOBmXTSF
	HoZgaHVmxIq+f8+jl0cwIdOSqZv5/Wmd26nuwJ5n0iyFplehXGKImt54+CkGzAjOMACwQyKNVpz
	GSEjnt2f27GafjuNKY3KRPau9ssj6aRV+OH+523XXDwcJSgw9T26+Xt0uuIw2pI7bPnNqFqu2kH
	jzzTWgobzrQptyAuQul9X4NVabvk/DFi0cndO2aUose65YKK160qW+XJNm0XMdXxVPHLxh92WVn
	nneONMsmwTMYOtKXJme
X-Gm-Gg: ATEYQzzb18EJUhakq0oMVxZHKQrt7HhI20lInYKt91JcyYR6XBe4duoQnCNGC89AOzm
	tZvenDOSL0iXipd37wk4n2zQT2M/rJqxXZVZfd4rf+/dzW9DPSQ0qpZihGMlOtBvcruPe/ezebG
	p+Lmz/tneFUxEL1o715FufPJIA/b5mhPlqE5qhBBDVrOTCzu4ModKw05qutzjxYJDHpw0VX1sqG
	MtWfgS4vBA1Cg5yJ1aOWGkF4WXVxKCwXSeHSPVW20/y2vHcHUmW0NUPBxuQe6KwMTNeScRr2Lwf
	Jf7dOLtMEuRoLorax4CWlnkJWGh5Keub3HUYNBANDHh/aE13odtTKgEQiCBfo1uBrdMJCAqMRTX
	9F0NPRfutvg/dK5yDHlFxfvuhfxbCV3TR5jxe/CjJzDBbnytawfpli2ssLbsZ0GXu9B/2s8lXgq
	KzGbYY
X-Received: by 2002:a05:7301:1298:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c9323b8df7mr3667171eec.21.1775114253395;
        Thu, 02 Apr 2026 00:17:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca760b2404sm152560eec.0.2026.04.02.00.17.32
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:17:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24611696eso3687885ad.3
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775114251; x=1775719051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftjXKzvnuKTg+BCeN292xhOJ4TG6xE+i1ind2ngbzc=;
        b=U/25INLE5V5WYvIqsku7osmS7drm3kAvUorZ0HPUSiIdVUs6F5cY8t176bGD/CqzvM
         l2aB43/3tJfdwXGFbTiwwD+s7m0ApOfDHVAJDNtemoWlVk3z9mUeq7V9/PypOOxTJeeW
         o0btTHDUeurmMtIbAGJWng6lB9NF9g13dRvkM=
X-Forwarded-Encrypted: i=1; AJvYcCV3k4/WKJ3UVoANImTPRXQdwLbDhq002/e955weZx2po8MipfyN1rBVET9o3y6M81E+G5cyfNkgxD+sBQ==@vger.kernel.org
X-Received: by 2002:a17:903:2984:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b269aa3b7emr63373955ad.5.1775114251507;
        Thu, 02 Apr 2026 00:17:31 -0700 (PDT)
X-Received: by 2002:a17:903:2984:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b269aa3b7emr63373715ad.5.1775114251087;
        Thu, 02 Apr 2026 00:17:31 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm24612825ad.27.2026.04.02.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:17:30 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH 2/3] block: align nr_active_requests_shared_tags to avoid cache line contention
Date: Thu,  2 Apr 2026 13:16:36 +0530
Message-ID: <20260402074637.92417-3-sumit.saxena@broadcom.com>
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

Place nr_active_requests_shared_tags on its own cache line so it does not
share a cache line with nr_requests and other hot fields, avoiding
significant performance hits from false sharing on some CPU architectures.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 include/linux/blkdev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..7ed566c81c1b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,7 +561,9 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
+	/* ensure nr_active_requests_shared_tags and nr_requests are on different cache lines
+	   to avoid significant performance hits on cache line contention on some CPU architectures */
+	atomic_t		nr_active_requests_shared_tags ____cacheline_aligned_in_smp;
 
 	struct blk_mq_tags	*sched_shared_tags;
 
-- 
2.43.7

