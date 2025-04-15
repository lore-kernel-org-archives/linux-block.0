Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42668BE5
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728707; cv=none; b=EvtUGHJ6EMGjlVjfxAyghtwTVHXzulITbTZxtbh5VWk+T2gN4du2AHRdCzXxLMye5jbHl7FcDu9vD3PZ3d3qXebmghLQOLpTHbEyMlayqDzI1Aooi8MVQVNXV3HJ5v4BSMRfWku+4RH8z7OopP9LpCEfYYCLzl3Ci4nshDpEx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728707; c=relaxed/simple;
	bh=gR6FFFy0sjufrWzUUrN4/vO7OGKwn4Y73XCEgyDjThc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Cqp9OLsUtKd0a8861d3S5KxFSVXeKJsS5HHlk1dUBgepoWMncDhxHlqbYf3YU9bRiPGPmciRKuEE4Usj1WgxlS5Fzw0kHJ89RCIieTitB9FGU7+2iqqaXpmLbz/Ro02uqphZmie/6wgcvc+Hsl/hK8pUYOIaorFXxi9BVHEz2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ickUw649; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ickUw649"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d6e11cd7e2so42786815ab.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744728701; x=1745333501; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lf3tEQWotFxDCRI1w+F+4wVeEZ+ikqfwdzLLjmnXE0=;
        b=ickUw649jtFb8G7Vp/UW5RoKsY8DVMcGVIbHU23bG9QYzgkUBvabt00ymhqSvMVZCJ
         U7x1WPz3oZljGFL3RyBALVOaCChYk8pX6xfIlwyzNA58pi5gk+Stx5EOTECLejsuPSIE
         D6d6uf36vwabGSfdbSybGxzWbGeuMxOIKSpU/970OHgD0fjT+RZrA18f74PO6zszL0me
         Eshusea3dFsqVNhT8PIgC/QbBv8L+cD2c12PQLXIww0L+VYee/T6wnC8ohsTPUYwIfkO
         dUX5MVpY3hkRia/aCU2y+Wa19WPW/ybIJ8fs22ceJRLST7LqCdumrZkQ89YvWaHbgRrA
         6E8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728701; x=1745333501;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0lf3tEQWotFxDCRI1w+F+4wVeEZ+ikqfwdzLLjmnXE0=;
        b=PyUvMpH1w0/hywXIZsNdIT0YVIN/aZSTuaNhrSiVP3sptT4CSmHfcBz0aEEIQOKqrY
         BhW2DZtVSazWrXquDE95YINItJvAWlojVQggIQALEOBMt+qEci9E8oiAqJr2iyHqgwIa
         EV9czyLSDkwmzOMWXpEn3Lj1ETyi+NwyruuB3WqbYHTtI87L+a6QhdfPGxGNc249SnuX
         z4TUhdBJ1j6rlwLpGHyQk0b1rfiHGFWNh7LTvdP82C875PlaDmIpaxe3sDKJio75/cFp
         bNoY2XdnpLKXcZemGiyUhkU8Vgfar2bx9KY6bqgK5B2P8sEYPa1js4TjCkDtrg8I8Ljn
         y9lw==
X-Gm-Message-State: AOJu0YxWz2NC86A1ka+lmbxyGElwk1Ho7i+5Ev5xnA5NLLaNiMDw17QD
	j/dz9iI8WpZQcclnV7ub7RitEhJLt40nrANx1KJYxxMA0wH93xH3gIzDTMWifom+/avTzdqpQB4
	W
X-Gm-Gg: ASbGncvlgIyg9yY95ATyQiUrmsDLHUn4NtAtJORrQ28aso2suQvxrRa/j4KYndSd1ZK
	CkgakB4pP5Xt9qFYt0qs8COwJK8kqPQnwX+brc5yCz3ONfymj01ssRtFRqZZJb/35MCBDmocAZ4
	3S9qGcjPh0XL9wk4dM76rsNgEm7NjcmcRuBmhm9TSIhemJ6it3D1B4e0sWdVs8ZxQv26nGRPy3X
	3MW1ImJ9G6rXBTuTdJ1Im32f6aJPZFnKXtScFj4quBilpQdZkIXI1Kec2Q0GFvglLGDcD4EO5n+
	s5hAuTGiLkq5Ri5sHbRUyftJM2MDaftjrq7drbsZVsR9edcc
X-Google-Smtp-Source: AGHT+IExSeDtlryIjKo7XNxy8tbFmEWN7Ds5uoCxfhnc+F/X6WdYSx/BeZY9XtW3xPdehBzW/Se51Q==
X-Received: by 2002:a05:6e02:1449:b0:3d3:d4f0:271d with SMTP id e9e14a558f8ab-3d7ec21bb5fmr170284585ab.12.1744728701317;
        Tue, 15 Apr 2025 07:51:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e02105sm3135968173.90.2025.04.15.07.51.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:51:40 -0700 (PDT)
Message-ID: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
Date: Tue, 15 Apr 2025 08:51:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On x86, rep stos will be emitted to clear the the blk_mq_alloc_data
struct, as not all members are being initialied. Depending on the
type of CPU, this is a noticeable slowdown compared to just ensuring
that the struct is fully initialized when setup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..9fb43b09a401 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -584,9 +584,13 @@ static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
+		.shallow_depth	= 0,
 		.cmd_flags	= opf,
+		.rq_flags	= 0,
 		.nr_tags	= plug->nr_ios,
 		.cached_rqs	= &plug->cached_rqs,
+		.ctx		= NULL,
+		.hctx		= NULL
 	};
 	struct request *rq;
 
@@ -646,8 +650,13 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 		struct blk_mq_alloc_data data = {
 			.q		= q,
 			.flags		= flags,
+			.shallow_depth	= 0,
 			.cmd_flags	= opf,
+			.rq_flags	= 0,
 			.nr_tags	= 1,
+			.cached_rqs	= NULL,
+			.ctx		= NULL,
+			.hctx		= NULL
 		};
 		int ret;
 
@@ -675,8 +684,13 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
+		.shallow_depth	= 0,
 		.cmd_flags	= opf,
+		.rq_flags	= 0,
 		.nr_tags	= 1,
+		.cached_rqs	= NULL,
+		.ctx		= NULL,
+		.hctx		= NULL
 	};
 	u64 alloc_time_ns = 0;
 	struct request *rq;
@@ -2969,8 +2983,14 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
-		.nr_tags	= 1,
+		.flags		= 0,
+		.shallow_depth	= 0,
 		.cmd_flags	= bio->bi_opf,
+		.rq_flags	= 0,
+		.nr_tags	= 1,
+		.cached_rqs	= NULL,
+		.ctx		= NULL,
+		.hctx		= NULL
 	};
 	struct request *rq;
 
-- 
Jens Axboe

