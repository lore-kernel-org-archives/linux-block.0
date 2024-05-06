Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE61411F8
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982354; cv=none; b=iA4zDiZyUEHXiG26KLVm9R7ODxFaAouVMpHF2x1aHCsLUM8FgQGXi1h3ct8XhNoshBigCifgdkV3/K6OwWIgL6yQDQltAXM5wV01TzFvODMHpH7iVVDxm4TqH+Ou3jeCTr49749xtCx+3YxnQvWvgHqp50g8p9yTVXnUSOYRhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982354; c=relaxed/simple;
	bh=k8QWr7Ce151M14jHiuPdpQHPaGdK/slKGX2a8ui9kaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+IHgGO6Ob0O5yGu1NgULNlJgSdTkx0yZPESQqmVGPA/h6EzEsRxbIP88JqN3em/ywULgMg8/qhkouBiXnclC6DEQ+VeeVcM9avI8J/q2zOJg2fhTWF6nIYuqW2C4xBs/bOgPXuT4gBFUvA+jDOIpNdSU9MFdbwKkRkesokeJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=awEsttkZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awEsttkZ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso991380a12.2
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982352; x=1715587152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=awEsttkZoYVD4mYwcv21cz0wNIF0xRxm4gTzCc0eVulvJfhIu1DMhfxjOGwyaibI/y
         8kQ4mYg2j2ttMlDSLrJRlDK6Txg5Er6dvndjOA20ozZfUoLofiEsxbxAspRnme/9PAOw
         g7Yj5gvyf159yaEVtbW1MCabr7vJSu1jSKAi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982352; x=1715587152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=ftRTNl8r2qYXz3MC0wwv9SaO3oaup86OJVfhnXmn8dcPYM0Fh9MiK/va6+GOBLPMNZ
         MUZ1Q6iMkqT+lDsqkpRACp6oDxTlAxhPDtNJht0qw/PYTJFXoIpSXI+6N1WyQAqXEnVg
         TdiE1G2iOmkQGbdODtm+Lbt81oAOM73n+YLtMqaR9YqaLs5d8yXkfmy+mdd0Khiboevi
         Hz7pEDFe2Z4PqUX4o+ZAG/f3Uhc4evZV2ZQumBor4XAhnfZLTvoHAJ5fR8ggMD+iAUz+
         0j6DD7sj566K4Gz7oTam7cdslOCkUmpyYpCFMs+AA23KHRVFx3xpt1DGXInYlTxPGMd+
         r7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzLTxo0pdQQ1f/vAg+SfgnW8Mt9bF63U5sB69FlaaETQDRJlP8bzPf6+R1eadkmIHDBGB2kReE2aOeKCXkgG+vH2xzy4AQiSGZF0=
X-Gm-Message-State: AOJu0YxQMC9pCYVfs0TNSd5MJC2AkG/kmp4Etfol4M1Rk+gAUqAHegIW
	7CSDXcr5PRBJwxM6VBv93F2cZ9ecjk+iOJ0jD7SM5aO99HRP+paX8MxN5ivjGA==
X-Google-Smtp-Source: AGHT+IFI/ZSB9K3QVOfSMmaBz+TlUwMRiyAXAGYpMQBEi0KptgFE5NvdCMm1zm04lt/IfO56n8Dyng==
X-Received: by 2002:a05:6a21:2d8c:b0:1ad:9413:d5bd with SMTP id ty12-20020a056a212d8c00b001ad9413d5bdmr11397267pzb.9.1714982351980;
        Mon, 06 May 2024 00:59:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:11 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 11/17] zram: extend comp_algorithm attr write handling
Date: Mon,  6 May 2024 16:58:24 +0900
Message-ID: <20240506075834.302472-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6c36cd349431..bd8433363cbe 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1028,9 +1028,33 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

