Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423A1FE46D
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661091; cv=none; b=LL14f+B9hO9mTVemJ6QlRNXQRf02RsbWG8TKbmioE4s03c2I9qmMgTvPj8Yl68/GQDLFE8hX05zeTOqKt+fgOMPM4tx5JyWEnQVRfJ/WWIKoFutpjzlCOidNTMfBttFpeYm1DphWJRrJ79ObDWOhWxKUQv7vwnIrx+q+1ZY8Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661091; c=relaxed/simple;
	bh=RSIk539QU0YeMD2OF+ndA/QgOH1sYpMVe11eirRJlyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8BRMe3RYrVHUe7dnjdhBxD9BcJSL+sTWiCZ6MnVenEEPaa1O5GSjEFW50ji55kK9AFI48nzRSiM0v+OaOzayRbubhdoprQ7G+jDsFShv1w3kdHSPa7BDnuvXd/Tvr6A+mYmhGgdbvntfS6brewzAhV3dh7pcadzaXl4fNzy7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BrX4KviQ; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BrX4KviQ"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a0abca9769so713855ad.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661088; x=1768265888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=BrX4KviQsz+XG4J9E3zXQAD/ol+fsN7fTiwHMP6mCOP9vuaEqPtosgAag4llHOaFX7
         1sVuzEJWzUNDccetaHTxYGSNFVlObsJmt8cgsgE8O63vQkV7bntKD0jJ6nJUsoRtJa16
         7lbfkeObnE/HTvBQu9TWTGOyvbNjM/fmlZ3/NS6HtzwttbUCYg30oC/lJWidpUlYxNx6
         39DqqCx9mQhSpno9JS6KvARCSIR+eneyk4oza7bO7UWIayX/dwYQ48PuZkFFl7BbnMlz
         5rcB3GMq0oNskhKn2Gq/g+XRelzZypqSbFEjNVd1xpEmlGGUiJCtmjicXteifZqfmHX2
         p8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661088; x=1768265888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=eqY9/dtBKF3kQEcS7dEKlNFB4MttUQO3OWEp3wO0BzGaIG0m3DvtoZt67lE2J4Q9en
         GVY9URMBKhl6sxMLwC3Hwa43S2ZLql7sBQPjSLxdloDTblV431Qg96E9/Lu2RAG9oGMp
         c8Mq1mjTAr/5gnKRybPGPnCk7X8m3efmRDjJHJR9QllFmvC/7bTsU8rC/qQtuLwB3qgn
         CNOtIePEZBcZPy4PqJjmPCQMRsmeWEqzunBTgKM+npUK9tlTD0lM5mJB5bDBCrJ9a3Np
         Ij/fdlxwU3w1NTC5jIN3qHJAl53vmt6KMVIjMp63XyTRLG5txPYgrTqXe7zBJfobo3At
         3F4A==
X-Gm-Message-State: AOJu0YyfZHyuEyvGK4sslYt0kJUxmyLixnU7pk49TXKhndpVn+U0pSYN
	FwdpEI8ptsz3dmFjya6Mt6I2PTIgGRa+aPnKPXw+88ZGq2voeSXXCEgXPqF+GUo0xywdXvqwMqq
	ZZBJ2Zyd+4dN7blf+Au0jN+4oQfKra5EbzDU2
X-Gm-Gg: AY/fxX4Lnof6Ums+VRZhy9xajd6hywvJdLnekQAysXrxx4S9n4YExhmL/kYdtQacbAh
	20BivbP2X++q9fLfkU3VoauFEudu4Evz3R/OZjTxm+pD4U6YTkdc9BulJlwbd+cCF4BnEVHseyt
	UrFrPKf5hT/v+W5NyHPgjH2r2ccuIE5PzaZtLs2m4UiZRTj70B8I3P38h09abOwbOmlQ/5ue34t
	TH4SfJP0CClyRsBvcJmwhG6RZiuLDWso8YIWrwA83+Kuol1+S5y10mlDnQvUb61wR8kCCZlnysx
	5KEVQJ3zuomICAu4u6W2JrFg2dnMaGrF6Ph8vq0dLPfXgl7prS2YGt8bvCvD2HnurA0QOEF/jVf
	BNQuPsBWAlGdX9Y/9e9MhIcl2RXHTVlIQaYedZ//0Uw==
X-Google-Smtp-Source: AGHT+IHKb22UjylnDKoA0W9fny7bybwLOIO7bAf/WzC4axVyVJ8PaetqijQugZHk6m8KpWwx3aSCOjDDD8PD
X-Received: by 2002:a17:902:e741:b0:29e:3822:5763 with SMTP id d9443c01a7336-2a3e2e5c956mr9922685ad.9.1767661088568;
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4ab4sm821145ad.44.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 07BFB340960;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EC714E44554; Mon,  5 Jan 2026 17:58:07 -0700 (MST)
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
Subject: [PATCH v3 02/19] ublk: move ublk flag check functions earlier
Date: Mon,  5 Jan 2026 17:57:34 -0700
Message-ID: <20260106005752.3784925-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
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

