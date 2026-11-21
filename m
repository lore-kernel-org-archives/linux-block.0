Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280993;
	b=X4MDWSJ5UqvytlnwhYjbYUpv+SfmfYnft7KGN9LiBL+GdqkD1heBOK9Iqy+mNLrJhgt1
	 ijPCkTHlnRSpc4udOBebvgWxEkhTwj+1CBHrurD3iHiZjW+ssl6z545w36Sb0U93dErTT
	 rZ4cjk4m4byNukyre0UbpKk33OX95qIVVUvSz46tLZaQ1+vSTrqOJlXJb6wkaXfcpB4Yr
	 6fD2vZcIKIFYDuUd5+HIBgmQ+6m/3JtgmoZxReRd4UL7XtEFiLLLBbCiWJS+2Gn7/fUwe
	 CSslIixC4I4HVKRtKdTLYY6I3emF/4xli6hHlkH+nuRpJMzkUgJI4lpQRxW4S3VUpEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K/+8qFq0fxk+zkew1h1e9djN/Qh04Qvqfk0yOUMbaxY=;
	b=YOxj8KCHZ70TrkpkUB2fl8+taN4Gb2m6sqsUFhw7101oFor/NzLgXNPn17IWRRdRjqiX
	 m/4/120fRSvkkQItgAlNV5DYUTScYLmgDFZtmMAg0Y4BzETEyVY6oq9RcAkmQt0LEZ1ep
	 G8WjDDA1jAME4cKUFYma/qn7dp2G3OmJbWpahorCaqdyfOUCZxOfyIPInWHpCpFX6WcV8
	 ZbYpv79TBAtkL8t5hazKdvrLAfN3UXMEerp0FXDAakdI/UdvOGej2sGVM8HBGg7WlPkq4
	 S6jmJJ6ASiPp0hqFOGW9Np5+cMfnJdRwBsrFwvGQEiCV/xl5zo1CUy/afoq/pgcEPMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f40xqKT2;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E3606A333
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F6E3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f40xqKT2
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33c10faf6easo218695eec.0
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795280991; x=1795885791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/+8qFq0fxk+zkew1h1e9djN/Qh04Qvqfk0yOUMbaxY=;
        b=f40xqKT2P6kmFYfLN7E5Ti76LIfmjmohv1aUIqhsLvE7skD8ek5/i2KDrDdPeQmBCL
         wNWNRM42Qx2bnqU+VJn+R2C9xvVk/Um8CewDIj/PAdVXZryD2oNj+mzbt7dHOqrq49p3
         3D64DyTeEgAyO1wyOelWZWJkZjcCGjn1prDfKg2NwUHUm99j+Sma+PJKimBN1KBTevbr
         jRgmQcCDdIXFPp3qL9VgiW2S+VxwgGr9790TeOENoT5LqrGdYzLan8TG2c2oSZiIhOfF
         oJB5PS1UYcgky/4Tx4H9dHceA4fy2eSmjigXGSUzX/S8+GoPFd7dZUarpiYiJXFg9nv7
         AMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795280991; x=1795885791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/+8qFq0fxk+zkew1h1e9djN/Qh04Qvqfk0yOUMbaxY=;
        b=CWwMp8KXzVReNTH2CbnFdU5V8QOHS8qb8pyig5kdKfk47DCoGaM/WvxEDA69Q3gHI7
         v4kQJsDavII7OsvlHXm4CfJdSTbl4VAIEZ092mUauttMTngxx3fIDVcRQbsBXAMxmODA
         LhY0BwegXHV/BgulrzvQzwgy61S+LFmXw6Bx3Mp49SD/zHICXcfVbkAr/nA1IXe4NpNU
         Wk0dhnEvnLt/y8qdaLVITEKIUoQPRWv2ZDz3AAZgCuO/sCK86O6fORwlf4Y1z71sLAOi
         sded5ssdtQeHscj0s13c1iiHoyaQvVYMcvAlBu5oti3bXSgb3It7oE4BG85cAEv2rDiV
         vgiQ==
X-Forwarded-Encrypted: i=1; AL+hErGc5/3TqJtGQxd+Eujtpv/L8auE4H0INWAXOEYBM984dSui1WpM9/BsSOAZ9b/8X2dtaeLMb1wA21RWBQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8D0D5MAwnFEu2fcdQD3WjUS/E+sVZvLTuy0WHb87dcuf6r4hRJ
	lfwCaLp6YLqp+7oWfbJfFzJj/Axgdr2RlYYLFeLK4do3tyfq/yGGm33l
X-Gm-Gg: AZFdTZeWIIURlt3IoenWC+QAjMzTRRv/AnrwcY0Zkl0oIYiODThZFdSA40IwaGfbITz
	14+zxLnC4cvdzs/pDYA6rvWnJaDQk2gwgiRfZpi1g1EtnfjSPCtiIi7HUCdiu3dNUYjVODrG/MH
	O0+8i8TJmMZXz9ixdMZq1neEK64vQStW1D/nnodaR+b3oU4g0H8FyJKDlAuAuxPUBei7Riwa5JA
	SOfyjU2KjruxGi4EG8TUjlLiygQTtZgJmzKClr9maZlH+W4QEDaEYswGz4eWUaSloC353AfTmnN
	sdklSjePArw/g7TGCX6HjZJo6O1X5pbEAB9uPrTOCVWXHsqmorD6xRIuZ0mFeRjgpXlAbnoqB4N
	S7c1pC8gbd0Lwfph/15R36horfK+sd9Qki7cxxqcg2TT3oA5ZrDkrn83tBys7EKzKAZLaoyx9hh
	bpO/pRkHYQsBpAWu+steYuqUY5/OtI4dv23EUw9veaS10KeWvTmMlWUxV+1in0M+V4sTmGuCeEo
	OnLZLRSiGyJN4izf3mGtPFIdgK8UCuaTo0x9s6hB/W5P0MB4804J4KnN49XR2GBOy+Lh+dF3mJY
	vCDshDpyxhYf5g7kFXlLq9Q9e7IAf7H9193qNQy3zfKbxfDfDQ6OoXivRbkwIh13haw=
X-Received: by 2002:a05:7022:b90d:b0:127:def:dd72 with SMTP id a92af1059eb24-1b55687f1a1mr8704565c88.2.1795280990776;
        Sat, 21 Nov 2026 09:09:50 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm22813152c88.14.2026.11.21.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:09:50 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Sun, 22 Nov 2026 01:09:24 +0800
Subject: [PATCH RFC 1/3] zram: allow backends to decompress from two input
 buffers
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
Message-Id: <20261122-zram-split-decomp-mm-rfc-v1-1-4e69b08c0fed@gmail.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
In-Reply-To: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0

Let backends decompress a spanning zsmalloc object directly from its
two scatterlist entries. Keep both fragments mapped for the call.

Use the linear path if the callback is absent or returns -EOPNOTSUPP
before writing output. Propagate other errors.

Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
 drivers/block/zram/zcomp.c | 28 ++++++++++++++++++++++++++++
 drivers/block/zram/zcomp.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 028e2f0f587e..265108b9f332 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -159,6 +159,28 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	return ret;
 }
 
+static int zcomp_decompress_split(struct zcomp *comp, struct zcomp_strm *zstrm,
+				  struct scatterlist *sg, void *dst)
+{
+	struct scatterlist *next = sg_next(sg);
+	/* Each entry from the zsmalloc read path fits within one page. */
+	void *first = kmap_local_page(sg_page(sg));
+	void *second = kmap_local_page(sg_page(next));
+	struct zcomp_req head = {
+		.src = first + sg->offset,
+		.src_len = sg->length,
+		.dst = dst,
+		.dst_len = PAGE_SIZE,
+	};
+	int ret;
+
+	ret = comp->ops->decompress_split(comp->params, &zstrm->ctx, &head,
+					 second + next->offset, next->length);
+	kunmap_local(second);
+	kunmap_local(first);
+	return ret;
+}
+
 int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		     struct scatterlist *sg, unsigned int src_len, void *dst)
 {
@@ -177,6 +199,12 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		src = kmap_local_page(sg_page(sg));
 		req.src = src + sg->offset;
 	} else {
+		if (comp->ops->decompress_split) {
+			ret = zcomp_decompress_split(comp, zstrm, sg, dst);
+			if (ret != -EOPNOTSUPP)
+				return ret;
+		}
+
 		/* the object spans two pages, linearize it into local copy */
 		sg_copy_to_buffer(sg, 2, zstrm->local_copy, src_len);
 		req.src = zstrm->local_copy;
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index f38fd31f9e4e..92a93630aead 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -61,6 +61,14 @@ struct zcomp_ops {
 			struct zcomp_req *req);
 	int (*decompress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req);
+	/*
+	 * Decode one block from head->src and tail into head->dst. The input
+	 * mappings are valid during the call. Return 0 for a complete output
+	 * or -EOPNOTSUPP before writing output to request a linear retry.
+	 */
+	int (*decompress_split)(struct zcomp_params *params, struct zcomp_ctx *ctx,
+				const struct zcomp_req *head,
+				const void *tail, size_t tail_len);
 
 	int (*create_ctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
 	void (*destroy_ctx)(struct zcomp_ctx *ctx);

-- 
2.47.3

