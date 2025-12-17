Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E388272E56
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=XXhH1r80iEFoXmUblxjRsKIIsekyLXaygduyz96nR6JOxvHpqqAJhL0uTUNJHl7hbUwokJimdDoSQ8rq343AmzN2WG8Cz5fAj/8iuorAWn3cObTL6J6UstSvSGjfNVsk1AEYU5nrr78jOnE2E3OBGbWgjnid8b/cBngAB4LRXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=aD7QvT8m0ONYPgRJxDVX6ESAo8vcXx88PHv+jCm6Q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/F2GPtOemJkr9n6vLWskfG1fKSJzQ4V3IABUOwzgxqVSoQDCKCaj0rviGSbXRqnYmzupHbIAGpsbJ03vz4+bU/28/mlaxHQotAvH6t1pu21VZNrueAN1FhXtxRRSK3ONAcT0WMeu0f4ZM/jgY9zDcpqz5WoWR8E/g1FJ2Rnhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SmhtK5EJ; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SmhtK5EJ"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6446c7c5178so895790d50.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezc5r1HBuR8+0jmYpVSGWVnyd2FmDQBIXjG2jOM8aPQ=;
        b=SmhtK5EJSrIJ0x3+Wgav6FlA+I8HXYuKzjmlPJbyC1gVUoO+i0JX4F7w05bREfg9gb
         S/W58KcaGxU8SB+dsnYLyFwW3Zm34QG9wpWPxK50zXqdeGY3UjHq2jxhWaUjpJqlTH1N
         q/eqvt77V9pu4ngugMtpgvcojmYcGHDFidIxlFcmbmLITAOnjrhGUGBNQmNEIiyRD1Hp
         Ue9rfv2sZJp4TVYnm024/bpqDQWUzKp2B5DjpAHGJ0Q38cYv84Gz1KfWYMr/alBtLvrc
         HeEXHrm70sq/VKnIcMNakrS4SPVO5vZj4Z1JzF5XgmX3XzkdxjAm0on7sB7/jf5UDPQ5
         cHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezc5r1HBuR8+0jmYpVSGWVnyd2FmDQBIXjG2jOM8aPQ=;
        b=uwEuJXTK7gK918/DiPxEzCysSwmEokdCGYB7lTK1Fv3sd8VhuhbSJT5bYXuF1tw1ke
         0opBiVXuUiL40+kj19YUaOiRhJn5OvpfqR3nXzveFIhj59wfm1Cl9XQhMmNSoRMTo0d8
         +nkUaA1LANlHQrLnY1nXT4RXVJsbpRtjg8qHo67jo9SKTPj+iA667hdUhDpm4FN+oR1u
         HTTTa2zGd+9v7Xw/InHt9U1GM9/PnxjEnuNGlMu+wEeqOAgguVMF1q5BQM2zNk8E0VXA
         jTUl/tXMVPiCsq/i7IQRuoqVOCiofH1VOGc1ZaFDPTuUxao/z62wWGaOFme+Sf1zJCMD
         HsIQ==
X-Gm-Message-State: AOJu0YxDUigUxj1qvIy3W0LD2K46LAOlz6fymjyLgiZgIIKFEl58WW5H
	dm6BpuaehceKCQi6hx9vYqOkUCv5pg9eNfBZFknF0jEyrdP/VUHzKWc3M1BsCh9Tr2vlXihjM8K
	RsU3/SPHJhfxpz6Dpib7ysGiZ0+2nFAbZ4stQYvhwmyKMvAkxkfrS
X-Gm-Gg: AY/fxX7aZ1eIqNQURcl2O53jFLN/iE8HtWEg2FZbDbycgkl068rIhRTWGyGTuZFhMcq
	PkUce1Jj1Q8z+EbiAObdjhInhiHSZCBvdICe3Jb9TkkvJ2Z5fgzIdjoA70Kv+7EL7Yz91R7nMKR
	L/YiPFukQ8JWY08iGt9tA5ihFMEas5Yqe3f5rDNYHG2ymDUDalHz2OwejEf6DNTwNY8gAtuXv2V
	UKcEPe+g2xQiERyGviG/BS/jXDfJQC+gSlqJ/zem066h2wzMcwRS9yOvOIJZQhKvA1IVrr7Eu9B
	TnlEqm1UC6bmx6IXr8ROTY8ZjBDhfUvk/xPI6ae/6MVfz0qfhPsLFtAcvClIBfDDP4wuVKxkCUN
	2w8m/F2SLAi4AJfvUZNYzYfmoRyc=
X-Google-Smtp-Source: AGHT+IGDVPrgNu9LhhkOAfEoaeOE/9G2q9MLKqgYrJRDejIIwiTDpmwJNvXg1IgkUw3GnsHHrvT+5hI1MqDw
X-Received: by 2002:a05:690e:1448:b0:644:49be:4b8e with SMTP id 956f58d0204a3-64555515881mr10604674d50.0.1765949713087;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e747ab14fsm12279017b3.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5E6D34222B;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E37E8E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
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
Subject: [PATCH 05/20] ublk: move ublk flag check functions earlier
Date: Tue, 16 Dec 2025 22:34:39 -0700
Message-ID: <20251217053455.281509-6-csander@purestorage.com>
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

ublk_dev_support_user_copy() will be used in ublk_validate_params().
Move these functions next to ublk_{dev,queue}_is_zoned() to avoid
needing to forward-declare them.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 78f3e22151b9..4da5d8ff1e1d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -258,10 +258,40 @@ static inline struct ublksrv_io_desc *
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
 
@@ -656,40 +686,10 @@ static void ublk_apply_params(struct ublk_device *ub)
 
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

