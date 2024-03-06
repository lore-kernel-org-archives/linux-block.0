Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59933135415
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733864; cv=none; b=LMgPR+3vbY8acsEW1mpUEv5tuMRE4x5yU+zMYhRyZgxeASrPH5hJzFLH0aQC7EOx7EaDt/JXXh4wat/2fAx5UF9GRw1ABzbu0jev0PqMVg4aAOpV548L7pwtq/DIp9fjVA2gdysdeusfb1on0BH/aYjg4QguwkipD5ryYQqcxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733864; c=relaxed/simple;
	bh=U7UnfI+RMecaJlJgcpcpWgNe991kEeQXv+g7n/Zh6K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2WrvGKm7t963zM6KQtExsA8oEvh15EIOC1/haC+pmk0i89srmz3jT0/DXn81W4uFGbnE46MlsooWPTRvg2b/mmTc8vTqjHIZS4Lp3GK++hJ0v2jeyLAeNv7UVuSP7zMTmvwftC/co6n8F3oa9bZUbHDIVavZ46pWPJDm2LgQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=WD2mcxQh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="WD2mcxQh"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso10293027a12.2
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733861; x=1710338661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddcEzANygbtc3ybmp2B4OrDAWMjMfbP+itxySdBOqeo=;
        b=WD2mcxQheKBhwabjGCz0T7DGj3RmwpbFsZyuXUw7Pk79RGX+BH9qy/IVAyBF2UmwtY
         sqM4/bB44zp599Mhe+9yKSUpoaTRxYuRiPdxECJl8kpwjQeteTjgtjKU/MTJvfyH/OfS
         VlW3uHW2M02nez3F4p/Jykcui5LuOrZIMV4cboJNaJdm2Zi9hpRdoGD8HR/QJcJ0q2sV
         CdtZa5dCzRIQtSP+ypsDo2JmHtqv++oVtjWane6fis1D/e7RikN5knYWfY5FNE6UzZqG
         wxxb7omrG7aflbyMemNujJx1BmQXT3tootMgJN4bs3XgW9IDALzoMXsD71yqETm0GAAy
         CTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733861; x=1710338661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddcEzANygbtc3ybmp2B4OrDAWMjMfbP+itxySdBOqeo=;
        b=wX9vrc4ECPzXEO/WcDNj9ezuUHQ1f0lFe20hW2bk9N8+urKZXVQQqIrzRu7q3lZPor
         EjDZkChvCNuJyMB7UBEx1tTa11xmaRBpcoKhjDBSFLlwmD9Ja4pjl/CpJ7eBL09HbLZk
         aCUIzcNLfXRe0dVFMWE757WeB3RCnCMXN7cBvB8SuXjNk7FZEUor4UFppkWcSSmC5PAQ
         TBXJP8jcgqT+ysS/zZqNiGcpDvUpK/NtB+64oS1WQ4FPuqRmzAp+tfR1EVPjADvkb6di
         H6RLHgcayppZ0SAOafUPoJmJctVGNN8On3U4vWQYLzcxtS+AOGpL20uzFgjnT7Sn65my
         FgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3wkKdwbWiLnXhzDWuelGCplz6scHk6RgY153DgxKk1694qwSESzOaD5vo253q+Tmi7g4SCsoSKzK3JIHaS9Nfh0T8T0H1sid9/bQ=
X-Gm-Message-State: AOJu0YwmOqKpwN8m7J7Ox+8lAXP66yVMWX5PNK0XSYLDppi8sjcL2v1N
	Y/4ATa0w1f1UgM5DBvaYFvijvSZjq8XwBSe2lhf14fwdF5nt5K40ntASPkOTiQM=
X-Google-Smtp-Source: AGHT+IHUhpFjq3HzoKT3pD6jLwRx4Gr7Yp6Yi0B26xPnRLjrZL40RznfDozglRseSLyoU7bAr6UZKA==
X-Received: by 2002:a05:6402:903:b0:566:95e3:1759 with SMTP id g3-20020a056402090300b0056695e31759mr9427437edz.26.1709733860883;
        Wed, 06 Mar 2024 06:04:20 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:20 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 6/7] drbd: split out a drbd_discard_supported helper
Date: Wed,  6 Mar 2024 15:03:31 +0100
Message-Id: <20240306140332.623759-7-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Add a helper to check if discard is supported for a given connection /
backing device combination.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a79b7fe5335d..94ed2b3ea636 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1231,24 +1231,33 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 	return AL_EXTENT_SIZE >> 9;
 }
 
-static void decide_on_discard_support(struct drbd_device *device,
+static bool drbd_discard_supported(struct drbd_connection *connection,
 		struct drbd_backing_dev *bdev)
 {
-	struct drbd_connection *connection =
-		first_peer_device(device)->connection;
-	struct request_queue *q = device->rq_queue;
-	unsigned int max_discard_sectors;
-
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
-		goto not_supported;
+		return false;
 
 	if (connection->cstate >= C_CONNECTED &&
 	    !(connection->agreed_features & DRBD_FF_TRIM)) {
 		drbd_info(connection,
 			"peer DRBD too old, does not support TRIM: disabling discards\n");
-		goto not_supported;
+		return false;
 	}
 
+	return true;
+}
+
+static void decide_on_discard_support(struct drbd_device *device,
+		struct drbd_backing_dev *bdev)
+{
+	struct drbd_connection *connection =
+		first_peer_device(device)->connection;
+	struct request_queue *q = device->rq_queue;
+	unsigned int max_discard_sectors;
+
+	if (!drbd_discard_supported(connection, bdev))
+		goto not_supported;
+
 	/*
 	 * We don't care for the granularity, really.
 	 *
-- 
2.40.1

