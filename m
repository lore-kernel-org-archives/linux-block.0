Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1A2DC792
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391070; cv=none; b=nAhun4peKGa6VBOLFwpLJfL4FX16sPYgA3Ar0tnJsbDVUhuIl4M3h8y/YAyTKf1zhc+Y1XST7x0Zgr6za1NGGu7OMIQ7FXbtCbw1+Ks0he3EKBeEQUysR8NeG9ZQRmZctoRjRXbo7177ahMJSiqg5rCVk0vTPnk8gtaBZYEw7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391070; c=relaxed/simple;
	bh=4rwKcoxtwwyEUMs+lZSg7yRkJNPnm1I0J0geFKeIcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ1/+czDqoP5JZW217MnCnk2SqOqO7vRKMx8+Lk29F/poEsqVyrpfj3iPIjPhyH59ie9SloURnpaylw5EebBLEtyUKkevbzrcM7hx4moRw3LLeKvAKjPY4QfVT84ucitnfY3CxOVE+0DJA1Y9CmJwDNq8xvvyQhfr1EEUtgCv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dxq58Rwp; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dxq58Rwp"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-651b17f1bcdso25417d50.3
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVdvVaugSDz6j9AO/nmgKpHbKb4qPtoLkQfjj793Zaw=;
        b=dxq58RwpRQQBlt04OmbEH1R33EnT3d1TCgA1dmt+LGq32r0ELoA/TIOYRSQEvWuZlZ
         /clMEcjdCCnXogPb0rQlAKPufdE44kTA6l2oWn6MZfQJ57H5wwKqMjKGq1LxIPZoeEnh
         H8HoCZM34DNvvaepcGHdySfabteMnvohic2kflq4SLCtYo75/c01bbGnvAtVQv0YAVrr
         0X+6n+OHnHkCH8puWj/ilZejiiHAfXg8pFaFqQG3UWqK71rSAMtQ+7ylPV8JjtkEjpYO
         BLV1zktVZeMe+LRHU1QCcyfdw6t8ECeV0ErgrYYGk2JDs4Lqt9xzQwFHkdg3vGWHnA9K
         8B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVdvVaugSDz6j9AO/nmgKpHbKb4qPtoLkQfjj793Zaw=;
        b=CI/6LpmjRZay/oTeLAr4FnZjZSaW3gK0pbOZjpYzvgEbHlgvU3NRtojjPR2NvqaZoj
         63uq27EsPmY/vm4j+qnJqDEoUQUsWgJHCl+HqjddGzjy8ZO2nCczuO+fcbhEXo3602Na
         hqCdLT+63GfGduTjCGfIJ567HV4bRnv2BfKrWGz+Jb172ljogtD17kCRwukpSNUN0Dhh
         BObVbq/O82k5X65LvOuHmW4/lX1AhiPFEJ/WZUSOswcN8I86lj2fS2/+v3hgDsBGR375
         vC9uyOZiVsvjL/ca0CgRT+l1pSvnAPctiA6iZYkg0cnPJE99isERmhcTYfaQ59O+frlw
         KMrA==
X-Forwarded-Encrypted: i=1; AFNElJ+wyY3iBxcDygCH01qU4D2cnZ67kIt/kaz9ucJjDcH6lyW4HA4Oi8MsC3nID3Uewv0MT9dPZ8xdq3hQhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWExg4mxiOPMlcQ4EMUcYlwosXbQCRoaU9/h6vN9SqThezcEBX
	2F2mCqsQBaHkGjGCOWEZsR9uFULQMypa7BSeBNUhpMXO3G59HE/KnkHWEVOslQ9SxpbWb4hAVsV
	DWJFBUWTBeTGm9io29I/Y7TLNAhk3oiBz5Q96JmidWl/v3o5czS49
X-Gm-Gg: AeBDiesF3Msc6M7tglHnDLdHlUMF0qIY6CswovLQHMCQP2vSgt6dUVMxJ5dPFPS/R3O
	hSDTN78RxU/V5U2wgEQE+TpqXiRU5NKqreIto5qyKD6iymVuU8fkFjPn975NfNWIxCVE0/Ns8VO
	WRtlaHzV/IZfTDQJPrO693vNpJJufAY199u1/d6WA8w3mE3CqROhN8rW2BGgQ3BCP0P+5Nc7pH0
	r5f36c6cCeiIF+6DzrR/Tv8jUnTDmGjmDNvWFac3PAbbpikZYMSuY/mOa8hFyMeSFtfqgYZi24v
	SXFxzeQXCumgcBNRQ2DLCFAVczPr4s2KH+Yx1amHvE4Pw60K///OVoBRrDxzBNrmN+nuZ2b6oxb
	TZ8kAqw7ex7UI1BC3Xwhco3weWmR10j6v4W/7gPFxUqRBGbszpQ==
X-Received: by 2002:a05:690c:4b0f:b0:79c:ff02:a03e with SMTP id 00721157ae682-7b9ed037d1emr5894277b3.2.1776391060655;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b9ee9a8042sm125407b3.21.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 295C2340BC4;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 25C2DE406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
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
Subject: [PATCH v3 3/6] blk-integrity: take u64 in bio_integrity_intervals()
Date: Thu, 16 Apr 2026 19:57:29 -0600
Message-ID: <20260417015732.2692434-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow bio_integrity_intervals() to convert an absolute sector to an
absolute integrity interval, use u64 for its argument and return types.
Also use SECTOR_SHIFT instead of the magic constant 9.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-integrity.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..825d777c078b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,23 +64,23 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
-	return sectors >> (bi->interval_exp - 9);
+	return sectors >> (bi->interval_exp - SECTOR_SHIFT);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.45.2

