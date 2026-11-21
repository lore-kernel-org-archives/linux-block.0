Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280997;
	b=c+vAl8otr/ZiWRD629BKXUppN36eoX9rcK09Y88DWDDsBi+mKddYX1tnGoAIOp4WHgro
	 xIAc5k0pxqK54EElsUDGjXcFmXZaa4evPyNqYzeyGrAiIgJtZc2bNddGmtqQkeg0/Xr0R
	 8QbfF/ulZgX2R21QxsECK6KrcoC3fBx+7sR2DcwE14ci3XAI/aa5GJqJa5kkOGR2pstVm
	 W3QP3Uk4jkKgfJbrjmsqNxQsafU1H2PK6hQ72kM1kMlvtf46nAXmCttr3vsQFSUNqqcqz
	 JE/47vCNxQVZ8V+QQBhyuXF0Qk61PQhiGzm3sx//EFMyCvRsPOt1CfqGx+c3w5mJMsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Br5Wgqfcd8YHOwGqfpu6oGdHrpDSdRTUFKUwp0MuJ4s=;
	b=YpTXa4O298qJ6jU+tITaGjE2wys/Mz+Pjmdd/mDrS/PluDK4fSAmz/zGOL0xbwWLDmi9
	 yz1EfMI630BYuunQJcpJCivVUCgwrbtslFc+/EQ+6+w4rZ3Xt3+L/lZR/xW67UGNRJ5a6
	 gZIwSNPio9UQ6Coe88j42KFcWjqrvqTDomIwNK2lWKUUI44ZF+DfuIYP5VkjYUfxI9bpK
	 lhU26N/ETMF/zw+4zgMlZ5jpKEZeJ/kaR8NnVw70S/dMHfswpjpfqeKEZw9D5C6ZLAcPj
	 Nb4+A/UWyf1+yVB+veFIubn7eoaiE/yG8Ysm+OqahOTTTCpQo2RWm3lvG1EY9ViWeVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCadNJo0;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EA606A33C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9EA606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCadNJo0
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ac926f28c9so52517c88.2
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795280997; x=1795885797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Br5Wgqfcd8YHOwGqfpu6oGdHrpDSdRTUFKUwp0MuJ4s=;
        b=rCadNJo0RuTy4jFssOn9xacINLHzWjmJxTdjKvRrhiVu6HdOrggab0VO3A/AaqbvOC
         49BsKjxg/fPaEGq3Cv39CFPq6zIUGibO+7Kky5UoOFDEG/AYGTjZ5BjwIYdJ6bN65Ys9
         CMeZT6vcKt0ElhdCg8ITMvelT7/McAJ77Eu0jWVSLKedIpSQIo9ECoTOo1nr3EqVgq0K
         2I8Sk3xEf9OPgYv8N0zO02V8GvlidU6WqQbSghETpkGwvqU6B8H1R89l8dKVZCA/2mvz
         I8Q53RLh88QrJkVhXSS6CUJ8lI1CVm8FXRUbvnjK8M23l5ncLK9eiIzAQFcV9vT/OnOI
         S+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795280997; x=1795885797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Br5Wgqfcd8YHOwGqfpu6oGdHrpDSdRTUFKUwp0MuJ4s=;
        b=kTC4fvShrCkJESIU0YZZLHcPgIVHhzagKgOID8lrfUPuWL1qSxoRTLlcAYl5yZuNyV
         eLS711I/TMHOF/2nQlg29suSJ4wYyCqdttublFxsbXH7IkwK5TfFUFBufCYYvW5WBxWj
         qsNrC7syFDBp9c7kdXD4u4SmOX1iwwROyxGUzPrtzctwZAgk8XtrsliE32YWA51ZTwGE
         vkclktzlhuTpr7NCmiWDdebNmhmm4jow4OziacY3oiljQ+KYckBkZyd/8n8a/0PRCiCM
         e9IeycQyNuULBdsOevmohSJOnoakJpfEKvpBUZeVgZbWufiJG5LH/bgmrqsK6xjV5v1N
         NvwQ==
X-Forwarded-Encrypted: i=1; AL+hErFnzw73igKwewZD2XXZuuBjIHPeoJJ3DSou+JiO/8QGeH3gf0fX1ib+4J5Q+Tw2F26LeqqiaihcnOxTJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rJojrnm3HW5k248NvYlvCpkkTgPPnB3+/okDUBxvo0vEHy/c8
	kIBsf574QOHKC3uHmAcnRObu9gYPfzK6sCyl+oYZ7e9eHkUdAnawVqtC
X-Gm-Gg: AZFdTZfj+oCoE1PYYvGyrjnErccPHySE3S/HfhZg5Bp27J9s1jgk/BC8QRpuG4u22kv
	5smgowP6hM4i+H1vCMXMUx0Kt4+yHKssaLSzWTpiIOQR+oUeTklfb4W8CsB4+0lN3RV412tBWhR
	W0o40M30aNisw8uo3p9V95ySIEa+rz8l80BFQspM9O7s/ePDT3r1jlEq08iMKS5HJ4LQGVWvSvw
	N8NdJKXg4wFT+RfuAJm2zjjV5e6ZcxNdGMcPVOkrC3Fu/DAuDXEFv9zZ9+kSjbn9DBPf7QHpq9c
	9KtwoHm9Pl9Fey/uWKyQAX9bOapQ4JOuDX0qKv/Xy4vr8rCu2qUG7N2Tp5Rh/qjBtS58S3XD1+T
	xUq31GUNDccvGE5IS+3jLFzK3nbBfE1p8VSZzJ84FbAXsC5PZRrZReg+WJl54IEf3uyfUDYHGz8
	HvP/JVwl/bdyzwzqWfs8Or0UYLVM5fUZRMmQR3dSagz0Ir4ATE0pLRxdZ39v+drK5COjCQq4GxA
	DvnM0oZZ4gJ9GANoAi57FhkCaLjqjQivphGLszwalRCUWIRU+6ttIaX5vyVa42Ckp+HxI8FVZWv
	tbnWIn8gx76set1s7cvoJxyej8wPnKNXqScJOTM1JSAHSWcejhgkMVMxV7qpdGIXuHU=
X-Received: by 2002:a05:7022:7f12:b0:1b4:fc41:3b2f with SMTP id a92af1059eb24-1b5568a1b89mr8928389c88.2.1795280996213;
        Sat, 21 Nov 2026 09:09:56 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm22813152c88.14.2026.11.21.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:09:55 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Sun, 22 Nov 2026 01:09:26 +0800
Subject: [PATCH RFC 3/3] zram: use split-input decompression for LZ4 and
 LZ4HC
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-zram-split-decomp-mm-rfc-v1-3-4e69b08c0fed@gmail.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
In-Reply-To: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0

Use the split decoder for dictionary-free LZ4 and LZ4HC blocks.
Keep dictionary-backed reads on the linear path and require the
split decoder to produce a full page.

Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
 drivers/block/zram/backend_lz4.c   |  1 +
 drivers/block/zram/backend_lz4.h   | 19 +++++++++++++++++++
 drivers/block/zram/backend_lz4hc.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1e4ad31d39a6..2cf8ff656f13 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -150,6 +150,7 @@ static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lz4 = {
 	.compress	= lz4_compress,
 	.decompress	= lz4_decompress,
+	.decompress_split = lz4_decompress_split,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
 	.setup_params	= lz4_setup_params,
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
index c11fa602a703..6c1736ea1a87 100644
--- a/drivers/block/zram/backend_lz4.h
+++ b/drivers/block/zram/backend_lz4.h
@@ -3,8 +3,27 @@
 #ifndef __BACKEND_LZ4_H__
 #define __BACKEND_LZ4_H__
 
+#include <linux/errno.h>
+#include <linux/lz4.h>
+
 #include "zcomp.h"
 
+static inline int lz4_decompress_split(struct zcomp_params *params,
+				       struct zcomp_ctx *ctx,
+				       const struct zcomp_req *head,
+				       const void *tail, size_t tail_len)
+{
+	int decoded;
+
+	if (params->dict_sz)
+		return -EOPNOTSUPP;
+	decoded = LZ4_decompress_safe_split(head->src, head->src_len, tail,
+					    tail_len, head->dst, head->dst_len);
+	if (decoded < 0)
+		return decoded;
+	return decoded == head->dst_len ? 0 : -EINVAL;
+}
+
 extern const struct zcomp_ops backend_lz4;
 
 #endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258f..56a6eecf8d67 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
+#include "backend_lz4.h"
 #include "backend_lz4hc.h"
 
 struct lz4hc_ctx {
@@ -134,6 +135,7 @@ static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 const struct zcomp_ops backend_lz4hc = {
 	.compress	= lz4hc_compress,
 	.decompress	= lz4hc_decompress,
+	.decompress_split = lz4_decompress_split,
 	.create_ctx	= lz4hc_create,
 	.destroy_ctx	= lz4hc_destroy,
 	.setup_params	= lz4hc_setup_params,

-- 
2.47.3

