Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2F3D646D
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245285; cv=none; b=oFqgeYiEwycmAaC4ZPaBrMK7cLS+T3Dy0QEaVim2MWP4QvijRDCMWmuhSKfZfC1Pe5LwHUI30coAXu8mOX0+br2RF7/y0zLbuuSThg2NfHTgYkX/Dm4SggAQAprhcdf8fej8Z+w4Ib1CtG179gmDd5MhaSKnz2C+HG1rExr4ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245285; c=relaxed/simple;
	bh=3X8FVNCusqycQp84YyxWQtssypswH6QLhLTJE0aKENM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmyTUJJEHZEDyAN/vKkp7CV4S0eXSfPxfJ0v3VDIgq6fSTiSw7N3zVj+N3Md4uJu3BWH4mR1+78fvBFUKFH4B+rc76Um4dIcLo1D0nA3BbGqU2enZRCvaq4WZgzQIQx/AffUJXrdKhvEbF3QsP+LhIm3LAS0j1eiGeeN5cI/FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qc2Jf0oU; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qc2Jf0oU"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c65c87f73e3so137253a12.0
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBT4yhY9HCpI609RSvOs0NG7s5YjLQ+PXcfiCvwv9X4=;
        b=Qc2Jf0oUPwOX5x18L+T6AtHmmvUM/LGEgchVQPfoPiyPBNZI20CiqiQOMEHqgW6VmN
         IDhYEc/istquK+3cbLEOcdQhxZwEIGzO3KNx+kvZ25jlnlO6OQr0Gns5p9B4zhcRMFhr
         QzIVqD8yxEPf9z6KzdQHBXMuwIi4ylmbzynmjmuS/bjYrDQX2vQHQVOl1WGjPETYM6Hq
         asja5Ze3I5GEl3o6FzyDQplyD/7cd2u23CL3FbPFOYiEg8tpW2Z3TZTEqwDUbRRVmvOu
         MMG2aibMnIDdhRIOXctl7s86IBX5jjpOYvsWyOvQdoB94k4jZ1LX45XbdtRIb3D3IQSs
         vsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBT4yhY9HCpI609RSvOs0NG7s5YjLQ+PXcfiCvwv9X4=;
        b=YbiIAWR40Ktx+oqPefS9dHV+xPSnPXevlCAeUpneUCmr7oanQp8eeATjyduFrHGWl4
         29hcMAQxWJ6op1j6vFgekZ1d/RzHyCh8ta3xZURNObUYkD6o6xjXfmlgKVESBsozIzBI
         LLkrkfL8f4cIH8K6zPvuDwvDg1U+kU+JCTU8f+EOy8Si+Cq4EZFtuz9aoKVQxU7M7BNB
         ELtj+itn1EYTN8CNXa4qV3crduTDMw7fIsJ4zQCho7W9P7mo5x2V1derSiakEG51ns5o
         Cb7WOWmYyWDROWvdWHh3mIk+JqCfm9R2C5+N8qu+VdY5o1HgoJCPC7s625kOuI1oaNU/
         CLfg==
X-Gm-Message-State: AOJu0YzaQjaX+paLoN8I0RNsvwYqlAZEIxL63xXlKTCTg8ZRoFRLnpcY
	WEjTgcCKus+OVrC9VSMRxSBS0lIRYOhuKM5FvhGeqB2kafQs7k2Bx5nsDr1NysCrwsv8d7R65GU
	83sQv6Ej+e/HjPjLyWlfm6onGCGD7ejWyTLgu
X-Gm-Gg: AeBDietkmhdJujB9A7YVqPkNuS3vd9tbxppPmxHlgbQnQtzmNPVUMOSF8kX4WwV4UkB
	ATdZ4FM6tFvjWmV9EmuDoXDNvgfN24jCFpVgYWJr/fkrqCHiQw2r1rXRxn4615PpPMXfHur6Uym
	E0MeDeZWGEqlEMFfcT5NL9uNbr5EGP1ADcj3OCiCEyAWA0lbfDLrnQx5HC2KxUn8fyK1xDKPnns
	Y24oPfMgE3ciatVYWRDGoGtDWQDD36xi5k3plG2ulXG78wjyvooQVrC4NtWxVIvLok75RYQsnDL
	0Wbd+5NnAnZQB61H6tVjFlkX2kR8/QLvbbfONDcpWMrWmPXoqczlK3p/Itiwmj+KtY9OlXBs72L
	SYwQsHFBZ9ShJY1X7Sb4vx5MXwEpWP1sGHiextCEeat9tjxUiU2yoPw==
X-Received: by 2002:a17:90b:4b52:b0:359:ff8a:ee4d with SMTP id 98e67ed59e1d1-35de69d98a8mr2252048a91.6.1775245282098;
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dd3602d2csm550564a91.2.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 583413422E3;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4EF9EE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
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
Subject: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Fri,  3 Apr 2026 13:41:08 -0600
Message-ID: <20260403194109.2255933-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 36475369cd16..112015cdeb72 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -540,11 +540,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.45.2

