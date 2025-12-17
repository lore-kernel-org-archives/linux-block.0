Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2931E32D6
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949715; cv=none; b=cHNU2InGHjzMgxcvv8EMSqk7lTiDlyTFsUoZ4F4Yt52NpMHARFtsGmKMLr4DV57LtO2cPzWW95di/Co+ENyn80knSRH1M33MccDZ8OFmCuaRB5ovn/ebRl+nk0Y8C7oLRkjodhXCK0fl6YxU990UMywmzwfiWyXuVndyvC7kIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949715; c=relaxed/simple;
	bh=xUW+aJ0AIyUBNjUOSWrr/v9kRnK+74dQ2K/T8dlAGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp2KKDB7hkJ7QHkl4QzWZmCmxQVcpao/aWkkhHdF35CzvzSD7DD4Q8/PQhXDExhzEFSMoKrt32hLlpTWhDTHX+PglX2Ma4/vXyu8PmEUwQVrJPQV/XyBjQAWOUMHCLexaEl/nCAucS6DUC1PG3QU4oCYDFB58cWPV2Stl5FzZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AOhkokyO; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AOhkokyO"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-34c6f6566a7so736929a91.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W7GaZySinPtNdu/28BmiINfjaLT2swubxXUIgi/0VI=;
        b=AOhkokyOhY9siyDVCEeIP+oj1r0bQGZMWzqEPujYTrRJnJ4dW2mtnDCwnirHJIHtyn
         orVNLqgxOJxiraV60BhgGG8rq6fIuSo3mzP1C5js9b4mxwDZhk42SnnVapxTieKd6sEK
         6Urp8hE7Yw8gMYgIUd9caOLXhimSFDr6pCseArUgrFfuarWSndCfG0DJlqWc3pQ8YDiO
         DABMbI2yN4hIjzHC9pUfDULLhEiqr47sSNtWtL5Ly2nkkxq/o45Q+MYI0uLmzQrsaOUd
         QVbPNjMYLTQpKEhvVsHTw5laGwEjyVvkzJSyCaXyk0JI9Ioxf4xtuoKUP1iozhmVBaEC
         JC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1W7GaZySinPtNdu/28BmiINfjaLT2swubxXUIgi/0VI=;
        b=eU4jwSgicmLHTvlwZSmZajalrCv+2ShI75AL97wVBKbXshBIxI3rbXbNgGSpVghHbJ
         A5iRZeTUt1CqyitbrY2ev/xBBB58Jhi7qsfJCQp2vxRnxCuF5Zz7uZLmnHqrJ+yMAZS/
         cqOjN6/t/txrfktOzTXB2ieUrZ7Bse6RQ66qJ9WlJrCr0WJKzi46LCJ66HNp4Z0PKDdq
         bVd9FDiol68VPzk0GvHTJyhuRQT4PutuoQQrn2xA5y+BhrcBidPCNqBOEtkAuGh5RC5t
         Cqkp7O2oY5h50x1/7T8LmikNn1Mms40TLPsgry0d5fxkeBLb7t6ifQwAbR28tENX/ZAp
         /5/A==
X-Gm-Message-State: AOJu0Yy/qMX8YCBWP+nuQb6zWccCzwAAevKGnYawBfIkX6dpPwmbEkg6
	8tcZkQWyQkU05Jx9OsipTW3Ym7KRuRBRWedCucf1KuMgPsD0/Vl//XhOKp7AeUcNTjjfS+AOWZE
	YHKKrkmnMPvBcl92qOTdJJbTQJGXrqh5ex8PStjzUlA6I3hlQG/US
X-Gm-Gg: AY/fxX5KbUfN0hzE/4LVsEhdaf2WBPdwLo+lLWAU49RVEjkDY0FcPMIfzN9utmOTYHB
	9qYujExlC5f6dKFGcW+sCxkMzwRlcGHbGoOprd73qNvnnOMt01/1DIuFDqNZ/ZH4u3aC6iHY3Ho
	dDXrt8GxEzRm5zpcGHF8c3kMFAq+5rgAq6WjcyAycCcFV0ZeRy9L1QDTnn+erx/ddqHgANTwY1D
	0BHRBwgxfou7x/UV81krF1EirwS5tPPAXIyfvoF4QgvhXKrVmH4fAxNQIuEWtfHBY48QCqOLmVv
	MJUITF0wiaDQIrtXnR1amoblRHSVFSeFFuCGQF0FLsB/jbr9xMJc/iwmFfM1XyJQBM4jOplZgLL
	j6UrcyXEYLMJpyYLhtpEZAwag9j8=
X-Google-Smtp-Source: AGHT+IGmD0xzmGqowX1/sZtnUry9Hv+YVc2UPf0PBiv6bJ1WS1oGm9qgaFTZtLXdzHr346yX/lPuywp6sUBH
X-Received: by 2002:a17:90b:2749:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-34abd898fa3mr11743788a91.5.1765949712251;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34cfce259ebsm224226a91.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8B8103420C0;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 89402E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 02/20] block: validate interval_exp integrity limit
Date: Tue, 16 Dec 2025 22:34:36 -0700
Message-ID: <20251217053455.281509-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various code assumes that the integrity interval is at least 1 sector
and evenly divides the logical block size. Add these checks to
blk_validate_integrity_limits(). This guards against block drivers that
report invalid interval_exp values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-settings.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d138abc973bb..a9e65dc090da 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -191,12 +191,17 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 			return -EINVAL;
 		}
 		break;
 	}
 
-	if (!bi->interval_exp)
+	if (!bi->interval_exp) {
 		bi->interval_exp = ilog2(lim->logical_block_size);
+	} else if (bi->interval_exp < SECTOR_SHIFT ||
+		   bi->interval_exp > ilog2(lim->logical_block_size)) {
+		pr_warn("invalid interval_exp %u\n", bi->interval_exp);
+		return -EINVAL;
+	}
 
 	/*
 	 * The PI generation / validation helpers do not expect intervals to
 	 * straddle multiple bio_vecs.  Enforce alignment so that those are
 	 * never generated, and that each buffer is aligned as expected.
-- 
2.45.2

