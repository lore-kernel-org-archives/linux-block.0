Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1919CCFC
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401135; cv=none; b=r0Bt1piPRxWgrfJXWmrJ3fcPgg30q6ihHQTCp7UOW9PmP3pibjV0P+2F+own0CMfKSibSLLl36JnpsrcsVjz5pBeYOBYzoVrao9jDex1tXnpYKyr5GWU2NfHKD5FLyl5uzFBKFN5mbs7/fcGMUlLIe34lbNwQX8vfHyzzgZe5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401135; c=relaxed/simple;
	bh=RSIk539QU0YeMD2OF+ndA/QgOH1sYpMVe11eirRJlyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l197IesVzFsjRekRk4MsYGKwejOn2i8EJtfkyN9+7Udocl5T1zNoWn6ktO9yZiVEH7aF8C8F5KK1AKN96Xevzfc9VZ2CNnYviuLO1SR3wc/zzzqUMGfnJRxXtkVqBh83LISFRnLGUUOkfsbVZSnhn94gG4HM5RDTgNjRrt7Pv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gGOtChO4; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gGOtChO4"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a097cc08d5so32621465ad.0
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=gGOtChO4a1MJF1UZmPgVd18bvoSQuAdOL4OxxWWLuG4EvV9yrkCUcHeLtb4NbRgA1T
         1aWDxJtN7+0TdTOlN52ZlQj2NWOib9mPgjWfza5mvLwfk5BA8KbLGnEOf8VrQcXNu2Fu
         ++AYx3DNnfuGefCZTGLVDPFzXTU4XTW6iNRBM3cdU4krGxdxNOm3w1iVPv8xiTEQPtI8
         qWWVDCizCw1BGG2V+yw64/A+PTAPNz9YBcWLkYvZ9cY9LdYXAvKph8A9PsfzGlKZfzZK
         S0J6IFmaL4XThJMHU3RxQuXwY2hF90mF0rJ4pVOUBZzNKjY2nTBuoqGKneT6WwUPHlsG
         jIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=cYDVPJJkMA5a6RHQd+YnByn+UPDSJnR8JBrjja6AS2fuAA29cLtwmImOlW3Ea1QxXP
         vpErvhrSQBeqIWmgP+8dBK4s/854pIzwB89krma+c6G50aan2TwAev4r1ogmO1Mrrc8K
         9NF6N8OnLwrVfCb0jQEkCwNHr4HGIQbxuqBY0xcUw0vEFA5g1Xcd/xD7YidgHmpwN9gQ
         8ZGiicZQRFvGeK+7fe1teM6NJn3jd/dlNMEY7dxbxBpDuJRST2zE9xrfMv6EH+W+3Xn5
         NwZ4mbrpVKMV51gHmMNexKEKzHHU1cCOeZWQF55wVkQp9AU7mvgGiemBtS7N+PJoYbHM
         2wrQ==
X-Gm-Message-State: AOJu0YwdobQiS2dIXyhzHO4TqKUoh9ym/D1sPoe62h8+ktbBJ5qzI5Pf
	Q/s+k3X/PMLQAGtXswNGhYFWYa2HqYFKC6p7Odo9rZaZvap3pY20Li3CMkRXG16cDDkqItGci3o
	cyFVn2nzK0TX3GlWzl6x+FjuL3fVsCQAYXwq5
X-Gm-Gg: AY/fxX4CfZEcBePrsUoEFDEvZLRzdlqgHFUbchpywOcmOnlDEFlNtEKcCK1T2dEmfIj
	3Opz7cPwOPTchbIhQJIZCIGECON/+PhcpYZ7+NpF9ivlZGQ13LIzfSDU3JDjEN01g+cC1ni5aoz
	en8aVdftvzQTSVTBjsnla7zVdRBzkUWCoqnel9sbwWAZ5rM8LKVMhxFRhBHdpe+bnZjWxwNCxkg
	3V3WG3KZA+TFNoru/AojEB/vHL/ytn0DSUS7oekB9uewMmDcEwqTNnmwMx3D3rjfYit8aXznIh9
	YiXreZ+q42tZvDpD68fYF/qIrJweO6uZLyHJJI5747gqooda6IETd1C9U2ECP2JuYgbfunWaUXt
	W2OXdt6QRsgWLh1bPyPp8+KJVcd7bieEx9mbjkX7F4A==
X-Google-Smtp-Source: AGHT+IE2FRIx0xy1b+Cq6CVpRkD5xG7QBPVIGJ6d1KMLEQWQxFtHKAcbl/g7RX9k7xKGZ2eSCM0/VCVKps+g
X-Received: by 2002:a05:7022:6294:b0:11b:98e8:624e with SMTP id a92af1059eb24-121722e11famr22921497c88.4.1767401132583;
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121724cbe73sm8963998c88.1.2026.01.02.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2B45A341C73;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 273CAE43D1D; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
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
Subject: [PATCH v2 02/19] ublk: move ublk flag check functions earlier
Date: Fri,  2 Jan 2026 17:45:12 -0700
Message-ID: <20260103004529.1582405-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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

