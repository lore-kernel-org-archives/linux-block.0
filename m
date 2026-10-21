Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550579;
	b=EH2faKGpfcF4b82RwhojED/+V6/GasOABSGyQdj10axlepmfEnYEQ9Eca2pYPcHyCMCJ
	 +66RIi8mwaW9OTIEd6Hz/QrXdGa3aKEsttMu6FQfT886/QCNthDkSAeuz0w6C/sg3fR/A
	 wZxX/szmgUoCici0xT5Dyrf2gsloPo0KGfRMefW9N7QjwVwDoXYg3HCVRKjVQ7TbIBszr
	 0H9EFRuxYJbG3MTLtSga0b2BKMRBH6NcB8c2485ZflEnUzzni2C24aS0kVWtBnxQybvLB
	 ZvuqMB6GrKhWCCQBziByAXbURsoNh2VVt6BKjcfqNcfkYA+SdZxJNKNF8M9opzdCKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LxFkZ6agSclWnjnr9VyHt4JNsSVqy4IW9aFQvxEPoY4=;
	b=FIyD0Ob7zB1GMErDzKYfGMILyE0jgG+6gk2PDkEirNbsMO+bdM2UIz2NOPZbLQafQnF5
	 Bj0EC67zjiHIpYNExf0yThWWx5fnw+QDWrh0qcPulmmRH2C3NrfuIoslw8ch/euK3Irmf
	 XepG3AQxuTGPdzbymvGSLB5rOR3venaAR1SlETZc/BuT8fSE1Bncq6G4rOIGH1llqDDk+
	 w6TZfU8mVhBkaZWnSXJiLF+AkZOlIO+Orkys4I+kvd2r2/xb4HqYAAqK0eLMPb1oAjCp8
	 TRI/5ttNw1U4EaagIuf+dZRj4ZZ4+fdNWASee2DliByNACY4X+D0nSgQTs7YA1mgjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B3AgGT6v;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539160A2619
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D539160A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B3AgGT6v
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15354aa70e8so778259c88.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550578; x=1793155378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxFkZ6agSclWnjnr9VyHt4JNsSVqy4IW9aFQvxEPoY4=;
        b=B3AgGT6vZdILr9bLrdJbPjTOrKTQo6knmhTdjFlZu+t2ZH3s1vpXbenoljOtqo8RXa
         2qHt+maSWau0NEKY1YjXpVygjqi3moqO5SITnartUvX1pbBLfIJ1NiEFvNiJv1smDRX/
         oCeAJdMm0QHfznEnKWTxDYH0n8b8ljSLEhQlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550578; x=1793155378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxFkZ6agSclWnjnr9VyHt4JNsSVqy4IW9aFQvxEPoY4=;
        b=E6W+kAsKOaoHC8bSuXDVqNPqwOl+ph91EAbsWQ4iFbIQRm6r0C2444GXqqy0EENm0G
         nU+CDlotie0LHjt0q60uHmdb/9YcN7dV5VI58zR/vNAxkqFNUJCcpJsY9ru5gAHV4SGq
         8g0Tayd4X0kZtIavGewDA1fBFHYjUggDQTDVNgtFYeFT/2LBC+rEr1xLTECPtM3plCcb
         RfHR9M4GeQGrbT3/6jtTZGA6dyP/5FeMiV8YtOOyKlDeY8dccG8sTvpPzQM2fP4CqEFa
         G3GAsCHja13QO/GiPnXK0Gx1UlLN/Fb30qYVPJ/fpktCd6PASZgCy/sranQFECIFDKdG
         dY+A==
X-Forwarded-Encrypted: i=1; AKwUvBzXoyV9ovtuKIYTctnb1z+5O/yhswQZvATJTrQAURQPlKWQ7ptoJw7E9tITN4PLz++ROHUiXrW6VoTJqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJM94sRAV6Qo2UiKICZTA9NJyJQ9LehV5nQajnSRRP0fuqZTCf
	BZhqpF/K5YFubewBiPV8wSnK3BhtzbhjuMo3zwcUkIoDX97Ijdize+QtnUGbz038mQ==
X-Gm-Gg: AYBFou3CXLZt9YuAQEYIgqTBIi6KUmCgNqteAa9TuKO08DT7X5W+jthVeDgzLQjXWE5
	E3UB9xafw6FXHYG40EFzJWqDIuvAvwtcIGJIYUYAZ68FlQjc6lSY7HwBgGJXThLa/A3z2aGZox0
	zwZOD5bFOV5lk//Q5Tlik4LDhbg7kq0MhxbRr2Gt04x6f+1MRpddy7COkGvaMSdU/ln4m8mPpNa
	HlPAId0lpEhyoHKdnPx+x5BQvlznbH5cSUzf+nQw6z1MlsSLk6+jR15jTHTdcZpaoFgGOfrb4EE
	I2YZ0CRZAkeRUEwjQIVd2yMJFtMfvkJs9u2aN4ainSFTolbJYE8gxWeP+nsCeaVJa/NvaJqM/xg
	te6afMks+Xxf/CeNa0m9bJSCZRFsqNx58i7piFHxP4+oyTXRfQkkxnspncOR4pt9Zrz0Ta61D4q
	uCrEdODe732wjkV0QQ84qQJdriuoBabv6wUBQvONcEMx2arqLCSUxxH42xBZzHFqy9GNqWkihG5
	rH6WNVxp4ojMIaSL3c1znY/2rQ19Gu0eqGxdjG1G9aOksIuJVzOtp9Yydz1PcyTgUr85d6ZjsV3
	N0Tof8Ebk0mVj3rv420DA8d/47ff7NMqVxvYXami/cEh
X-Received: by 2002:a05:701b:2810:b0:166:b307:5855 with SMTP id a92af1059eb24-1909aaddf34mr925658c88.0.1792550578027;
        Tue, 20 Oct 2026 19:42:58 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:42:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 05/13] zram: lz4hc: pre-initialize dictionary stream in setup_params
Date: Wed, 21 Oct 2026 11:42:15 +0900
Message-ID: <20261021024236.1787884-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-initialize the dictionary stream once in lz4hc_setup_params(), store
it in params->drv_data, and memcpy() it into the per-CPU stream before
LZ4_compress_HC_continue(), matching backend_lz4.  This avoids resetting
and hashing the dictionary on every page compression.

This also rejects dictionaries larger than 64 KB at device init time
(matching backend_lz4), instead of failing every page compression with
-EINVAL.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 31 +++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 5c009835a684..f3656c27af21 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,10 +18,20 @@ struct lz4hc_ctx {
 
 static void lz4hc_release_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream = params->drv_data;
+
+	params->drv_data = NULL;
+	if (!dict_stream)
+		return;
+
+	vfree(dict_stream);
 }
 
 static int lz4hc_setup_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream;
+	int ret;
+
 	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = LZ4HC_DEFAULT_CLEVEL;
 	} else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
@@ -35,6 +45,21 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 		return -EINVAL;
 	}
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
+	dict_stream = vzalloc(sizeof(*dict_stream));
+	if (!dict_stream)
+		return -ENOMEM;
+
+	LZ4_resetStreamHC(dict_stream, params->level);
+	ret = LZ4_loadDictHC(dict_stream, params->dict, params->dict_sz);
+	if (ret != params->dict_sz) {
+		vfree(dict_stream);
+		return -EINVAL;
+	}
+	params->drv_data = dict_stream;
+
 	return 0;
 }
 
@@ -93,11 +118,7 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 				      zctx->mem);
 	} else {
 		/* Cstrm needs to be reset */
-		LZ4_resetStreamHC(zctx->cstrm, params->level);
-		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
-				     params->dict_sz);
-		if (ret != params->dict_sz)
-			return -EINVAL;
+		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
 		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
 					       req->src_len, req->dst_len);
 	}
-- 
2.56.0.212.g129ede20d9-goog

