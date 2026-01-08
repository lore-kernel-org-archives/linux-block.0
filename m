Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FE42A591
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=fA3+YbzSFBLvMnBlo+uI6kmO8oiKR86wpbesuNdC0Ihf8YYrtX2cZMJQ6faS3tqljQ8MneZP+GaW6RYcnjnTNEuZnXLlJc5s8K/NQLHZUctb8QREk0W8PBLPLIKYkI+Ofm9LMFBxYl5ayDFXxIKrg9Th2i7zxOHJsI/dRzHj4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=RSIk539QU0YeMD2OF+ndA/QgOH1sYpMVe11eirRJlyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYKGI25671t6KSJzwugWphHQki0xFoi9DfMO1OklV2pZmk3lWLPgAO1IHrqAEPrVBpVBMvsbHD7pmPxj9mfV6UYI8nvBKNb3HHN8bLa4piEXYdEa/7yXIKy8RR5GdhgK+v33zRt5If6E705HEGE3WSNgKyXS/0Q3k5KKjVefbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HQg+Gkf3; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HQg+Gkf3"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a31d7107faso2152625ad.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=HQg+Gkf3zoVBei8tB0SD80KjDtxmlZXuYW+E/ghRRQJiErgN7h2dENzSWI2CzOEEzV
         VlBDfTb5KF3Rac9Yybf6pPy5p6NOwGr30QyPOO4qd6C3FfEI2ih7ULCAHAe3UcogQ1Yf
         ZimDQhWLESIBICtZnBwBde8YVGtaHXMoFm/UbHHClbDvXzTM3uDrAJOJu+uC5J3mxF/b
         THR5HaVfZBZmYJgjFq9OYbSs4bx2PBPa5J+OxOzbM8wHpshN5kUMfEM5+RQw1rXjRkRx
         YxVVLrajpS8SH0VuYalqpF3yT9Gf3sELcToAFxDgPW2C55ncE/X7Vf6UmIpbXuFYlLkX
         DdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=udFt7R6Xv75UGkGQnakGf1bDKm3BsTjEdJZtYQAtqhYgRTSn+FbHah1pfYQUs2KWIv
         UJY5u9FPAptlsZ5umpdkAbpUVGFy4qXm9iSn3Rm9F3B27+zAzigK3qI/tMOHRorXI+I+
         GPDz9xpWnungodIy73spmZpptvNUC+6iwGSDmAvnTTLh49WXr4Q57aTiAj21nmQo0pAB
         MuN7gzBELqBTRC4yQZnaMxIfY+3icXxmgdVbL5yxbkH97/oF0edw+KRXg3rWMg7w94Ut
         HsI8ngH/GHA49S6ZVaQr59Yf3v1NENPC5e9sXO4eW6AZzSgWjb1i0nmsS56Dg2C7t9Ws
         sS4g==
X-Gm-Message-State: AOJu0YwakRKI5ZLUWwMTO3Zy6x3kqYxh1Gd1Z62RVuZvbuXWXvo8M5dJ
	Bbo5xhq4HMYpClTJNSAf35WKikrFrzGV+E8xMfru/sLCs7WdhmkeINDx7jRYYt1fwQqsT3b3AtO
	XGsFRPXBqva84dFh+jnh5ZF4orCWDRw9vcOyJsmbO/gg2tV08ZuHT
X-Gm-Gg: AY/fxX5Mu+kSQ0N76uwMn5SD0x74XudKptg/QapNdocsGc5LYv7xJi63qccp2oKsnqH
	NLHd8G4DcQzzch3Y87XMsp8s+DzXktj4rdsCTZjYrXKib60xjIt7G/xFAKR0oZ0hJDjH4GwqY40
	Ex2RrCj4h4onsQoddLHL1ic46bKT1Om+9KfsCzswAsrsJ9+Pd5XDmGYzf8+1VnIH85qlw7soSJC
	ZCbIC/5engATsk4X0An0xX5uc6RJbLSy6DinpzkSeeF4V0mB8oGeA5yqU/6Li0S2AnZyrV7mNLV
	/WQgKZYu8U0U5d4xS3JqpUs3OGpaVveJvDX+WW3zJNCJ0bDlkSM/4kxMnccsq8Qek73nxIqBlTD
	aJx/eSY29MUUc0cMT+F0061yeksk=
X-Google-Smtp-Source: AGHT+IGlX3edA9YWWH1XbQV4Vo1qb/AsMMH6cjbE0zkab2OXzJttdqFOVlxVLUgkkh4h4Ydm0zkfO4NLDSoM
X-Received: by 2002:a17:903:1983:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a3ee48fedamr37868625ad.4.1767863995970;
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c4a15bsm8022805ad.25.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4B7B93421AE;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4632AE42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 02/19] ublk: move ublk flag check functions earlier
Date: Thu,  8 Jan 2026 02:19:30 -0700
Message-ID: <20260108091948.1099139-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_dev_support_user_copy() will be used in ublk_validate_params().
Move these functions next to ublk_{dev,queue}_is_zoned() to avoid
needing to forward-declare them.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 837fedb02e0d..8e3da9b2b93a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -273,10 +273,40 @@ static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
 	return &ubq->io_cmd_buf[tag];
 }
 
+static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
+static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
+static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_AUTO_BUF_REG;
+}
+
+static inline bool ublk_dev_support_auto_buf_reg(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_AUTO_BUF_REG;
+}
+
+static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_USER_COPY;
+}
+
+static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_ZONED;
 }
 
@@ -671,40 +701,10 @@ static void ublk_apply_params(struct ublk_device *ub)
 
 	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
 		ublk_dev_param_zoned_apply(ub);
 }
 
-static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
-}
-
-static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
-}
-
-static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_AUTO_BUF_REG;
-}
-
-static inline bool ublk_dev_support_auto_buf_reg(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_AUTO_BUF_REG;
-}
-
-static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_USER_COPY;
-}
-
-static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_USER_COPY;
-}
-
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
 	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
 		!ublk_support_auto_buf_reg(ubq);
 }
-- 
2.45.2

