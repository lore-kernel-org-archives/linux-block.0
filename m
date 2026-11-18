Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037814;
	b=ftOwRnvYpjLUcHgNIG4Byrd5zkCKoCW5pyV+0HZh2yDFD0ER63Y727ZBtRMx6YNC0tPM
	 vZK/FCCVpZWBOU3fVv6isyIQA1Kwo9qjArvRIjlV3CvtZx2mHD0acWlpZr6khu0eM+QjT
	 FuJEiXHgJpTDemA2zptC8GkS3faSOz4F3p0iOM7La183mWj0Dt/kZVAGyCAVXFFJh7abH
	 EMV9yRwchKHDKdnp8DPFJk+0+9huETCnTOp72sZwC6Ym4JABcWXIkw2keUTckvpZVxSOp
	 vdqP+61m/SNGIhL6S679lJoYAfwKBw85+bqIjGE4qScjSkVYNAuOutbW9VEzDYMazMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQf5dJ6mZzVBJljDb9w+mCIuacjIbr/Xh81Uvdlgp6U=;
	b=kWTfTfOIzjAScfNDhIWXAO7p20GR6MQGZb3y98l0xLOHP4Mc8JTwVGMMtGzjUb5vqcpr
	 Jfd54GPqvZaPuFDiz8VmHgVOF0SL6N30PtdSYaHwxhL1sK6juBG42LP4Jmtk2eB0koS4z
	 14NQBYhH4rhvv0gb6KO2+4pTHOvhWvUrK63MXHfQUpdgA/yobP1Gjl/6iJrgYLcUEoHXk
	 q3/QUimNELPo2rxcqQsddPxNfCIQ66gXkV9gskS3+sQh/uauhHlGyyJPNv9FxyWYHydmU
	 +8uB6MRCjF93zms740NN1qgtZEczAMYuS1r6wVZXdSpp82Xtcdyoea76SXInKnWOEpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjP3nF7d;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B4606A320
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B6B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjP3nF7d
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b503e2a87bso11338547b3.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037812; x=1795642612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQf5dJ6mZzVBJljDb9w+mCIuacjIbr/Xh81Uvdlgp6U=;
        b=AjP3nF7dzMkdCR6dAy67vTe1U4aTO+n3zhermBnMqV5Z6JXx/N9Ry9NEio9ktG51z5
         VtTojbPiXI83JMjA5bt/YOEto9S13jNZ9jp7onOI4cki0vlbQlQ1tALhOPQlXglFJ+oa
         2H+JP02xZiR3b5KG9MK4dvQbHsOg7976/Wd3eKZliS4tBaobdYmSjx2vJdQhy6p/sO7p
         t1xtwgbKGDsfPzWzNbFUYozvhZFn7PSWGuH4cQx6ob74xcq8kh7RtFxWORQt1LjPkbAD
         jLRc3rM2Jw5OgS8MzbaSq3IwG+3SFzyEiIH/z07mGsTZa5sC5cv/T2U60TZxF3xoDlO4
         DzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037812; x=1795642612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQf5dJ6mZzVBJljDb9w+mCIuacjIbr/Xh81Uvdlgp6U=;
        b=YXZ1GGBdkMsY76YmjItGOPINBgndrMqhlFma6GvYuY+tAlhiFXN1J2+y2eIdKg2PYx
         maENDLpAMTviU4pk4PLZSSV/9p6A9iZn3Sxy08QIVoFuNk7m9gN6IhlYxNyJCrk/fiMk
         akIq7WYsfYq6gL7IKyFgRI2ufa1eBb4lymA++wBFzJPXelP1q7MfgEPQbCSAwi28nBsx
         KbYcn4h4V4ehhXswzhfajkRv2UmX2DB0zDSt1rho6yCcE7SZmD8p9uUSFoqz8FAI1MZJ
         n9DdbOm8MdA7wKQITNhBAmDZ2y3K0+8lBu6s/lx4BbnZHsZV96YXdcR/+G8ddBaQbhH6
         uL9g==
X-Forwarded-Encrypted: i=1; AL+hErHw3RQ5PhnamQGhyg5izgyXeCuy6YFO3AC7jDpi0oJOJTQRmJk+LttF+EABav725ltNTpPE150unWML+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+AlkNXnO6ya5ZaRLd5NDRD+s7M0ahm9NVvd008G2+w47aTYNbY
	ujYJKMDEPip/B5D/KxndTUTwQ0SOlrepNJlkrTqzzSY3BJiwlUvPRszh
X-Gm-Gg: AZFdTZevOcIHcoTtkEopb1pbbxFH6P/ZTJvWkKCfhQzW4KmGWy9bZ4eVG5oukpflo23
	3jDCFwtYcQPwEdsdUzWwzKwPg76AwXm8haci1pEH/yHk5WEFz30or8ialNIMl0qKyCo1JtsjJCW
	6pp8U5avA/p9hJNHLJnKDEzKoLre6zRkNDZpf3RO3Wgpp5fuZDY3nPjk5iZWF4NFucIVmamnnpD
	qFQYcbMyicbckNcXQrZyVKblwbbq/NxKkrMkABLbx2SvWYijBYwhl2YL3lKKxGUfdw50a9qY9mN
	CqKZXj/LvEywIiXFNr12jKL17wD2PO9wYsuv8u6A92GjtNIhRxsRcxBClzG5OwiXMAF4bTC12yq
	D3oMyusTSwPZn8+KQC+CtF0KZqfXVFvPf/KI2iyYonfpD6JG/mnly4pbcXXTSvr1+Pa/U0R8MFm
	bKYEi8I/rUrH1m6QT9aHp2b9wT8eIYeHqkrWfW7/R02PfPIKIw1qBzRBIvK8a2csRmO5bR3TBx4
	nLPQIw6eUzeVB36fCQf/bviA/TlfObVb79b+QHCpXfj63v6G8zCL0KF7tcA+AOgrN1/BeXtL3ZC
	tWZeMCalC2XW/8zDT7M73I/SYuRddVfOBZtu25+YenvaI8kGpuTZ9/c=
X-Received: by 2002:a05:690c:3181:b0:8b3:5eaf:2a01 with SMTP id 00721157ae682-8b4fed111e5mr16245357b3.10.1795037812257;
        Wed, 18 Nov 2026 13:36:52 -0800 (PST)
Received: from 5163NRD-SPrabh2.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030be2sm24565697b3.10.2026.11.18.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:36:51 -0800 (PST)
From: Swarna Prabhu <sw.prabhu6@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	riel@surriel.com,
	yeoreum.yun@arm.com,
	hch@lst.de,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH 1/5] mm/gup: add struct gup_out output descriptor
Date: Wed, 18 Nov 2026 13:34:54 -0800
Message-ID: <20261118213458.377258-2-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118213458.377258-1-sw.prabhu6@gmail.com>
References: <20261118213458.377258-1-sw.prabhu6@gmail.com>
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

From: Swarna Prabhu <s.prabhu@samsung.com>

The GUP page table walkers hand the pages they grabbed back through a
pages[] pointer that every level bumps on its own, which ties them to
reporting memory as an array of pages.

Add 'struct gup_out', a descriptor the walkers can append to instead,
along with 'gup_out_add_range()' to record consecutive pages of a single
folio. The descriptor keeps count of the pages recorded so far, so a
walker no longer has to care where in the array it is, no matter how
often it is called for a single GUP request.

The @folio argument of 'gup_out_add_range()' is not used yet, it is
there for describing memory by its folio later in the series.

No functional change.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
---
 mm/gup.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 3b3888578a7e..0433579ed618 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -482,6 +482,45 @@ static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
 		mm_flags_set(MMF_HAS_PINNED, mm);
 }
 
+/*
+ * Output descriptor of the GUP page table walkers.
+ *
+ * GUP hands the memory it grabbed back to the caller as an array of pages
+ * (@pages).
+ *
+ * @nr_pages is the number of pages recorded so far: the walkers simply keep
+ * appending to the descriptor, no matter how often they are called for a
+ * single GUP request.
+ */
+struct gup_out {
+	struct page **pages;
+	unsigned long nr_pages;
+};
+
+#define GUP_OUT_PAGES(_pages)		((struct gup_out){ .pages = (_pages) })
+
+/**
+ * gup_out_add_range() - record consecutive pages of a single folio
+ * @out: the output descriptor
+ * @folio: the folio @page belongs to
+ * @page: the first page to record
+ * @nr_pages: the number of consecutive pages to record
+ *
+ * The caller must hold a reference (FOLL_GET) or pin (FOLL_PIN) for each of
+ * the @nr_pages pages.
+ */
+static inline void gup_out_add_range(struct gup_out *out, struct folio *folio,
+			      struct page *page, unsigned long nr_pages)
+{
+	struct page **pages = out->pages + out->nr_pages;
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
+
+	out->nr_pages += nr_pages;
+}
+
 #ifdef CONFIG_MMU
 
 #ifdef CONFIG_HAVE_GUP_FAST
-- 
2.53.0

