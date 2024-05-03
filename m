Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233214F9D4
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727941; cv=none; b=TzBn0JQq1qzIGxGhQUp+0mQnVMrRMjq2mjFa9JYvwYYmLq0Lkx8KcA+rDJjh385GRt2u1ACzAvlS06hmK7/rUMaekZt5BKJ6Vtu1ne7tKwpWCZ0UUh/e+Q09W+5+K/9X1sr8Sc5gLaPm5LTLnPdp9Ga9Z2vP0LabXsuyakd417M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727941; c=relaxed/simple;
	bh=k8QWr7Ce151M14jHiuPdpQHPaGdK/slKGX2a8ui9kaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhnHHpJFYLr0jRdoiCp8NPcvry1csXF9VL4uw4Y1kCFjAopkfh1OUqu4x5UddLrtXpTFIukuhu6rrUUkefPm8cZUpyG1zQ4y0HLlcCoiAxhL50aOhnh30XRX0els7B8LxEUjPRwNA2eWMMrrgguKdJOL9Co+XpdY7Iwou04d7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FguGQgNS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FguGQgNS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f451e36eb9so9801b3a.2
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727939; x=1715332739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=FguGQgNSAtCarhd36ZQr7a1hEp+HWlA/2Oijdb2XB/XFtCmYVeije1y//w+op7UCEq
         uqW/haLV9rHs9Y19iM72DI3EPoai0qBvikOJpHDN7QjFSD6hRxAvqaQvky3QVY9rGUsA
         9Hn4/meQRgKsFJp9G0to/nYGva34XuIHRgCWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727939; x=1715332739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=e59DQPwa4MYXEblrSx0BPDTdjOKQMHn4ZgB+b149oyGRrvJyFvgD9pCHANyhJ+9nQ1
         YUzXcRSkkshzmcJ/CpEDmQBu08CPVSoHYj8h9S/bOwrXwwEnaPmNJCcsIsxgBhCHhZUp
         W2ZovY1QEQPh6SwCcUA9JNgEwC2Z2hX6fm3tT+qnRFOnSvaeFgablxvRdZQW1VLOpUvg
         em2LKOy6jtIU/0AfU/XHjReO+pJkTUYorN1PSKTx5sDwjAZmS6cx+KaC0k6oXRH1Dxxd
         pB62Bt0E4ZXKhzmQGj9nM/RGUBF7dB7WIwhDqvVky7pD7r+OTXEIC0sMTXJp0DkjRxj3
         F51g==
X-Forwarded-Encrypted: i=1; AJvYcCWe0wrHYEoGnHISRmeHQQZdw6ZHHEO49KNSjQO2uwcpZWDsvgxxo+BzF/MZbEovlEoPMNx6u9pkQJhc7tbEG+YLS1BhsCS/F9ZbPQg=
X-Gm-Message-State: AOJu0Ywh9Zy2o7IBVZOXlunQndIIRTVJ/9VoiqcDMBAkQ37FXzQBfJku
	6KA+UpmCn4MVIRJRxCkxiWICccMJIefJiUuNTBC25waDJUh2W2sRTPXlckPzdQ==
X-Google-Smtp-Source: AGHT+IEi/BtypYR7vdNaB2RUEIhY9IiRwbwbnt0WGI9N16JWZ3DGzLGPyubKNTp4cKKZUqqniNQ0Vw==
X-Received: by 2002:a05:6a00:140f:b0:6ed:4288:650a with SMTP id l15-20020a056a00140f00b006ed4288650amr1850681pfu.19.1714727939079;
        Fri, 03 May 2024 02:18:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:58 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 10/14] zram: extend comp_algorithm attr write handling
Date: Fri,  3 May 2024 18:17:35 +0900
Message-ID: <20240503091823.3616962-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
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

