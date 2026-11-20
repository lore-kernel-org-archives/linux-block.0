Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143496;
	b=hg53/XwUVr3Z5595S9MsuaquKE+HzrtCIg6DV7SzvpxlHJ4CPXGSs7p0nACVdYp72oDv
	 ygWazl9ENjsgjT7vRm9rg6jmkJHMlF4L/4YEfQa7xySSngOMH+7nR/b25yn+lU68sI/o0
	 9ygoegspJfIjOBcCju90ViZLKyJ+LgSjVPm/JzoOmUBhM2iuC7ly9Qtxw37GSYeFXCraM
	 Ff+IORZGcimsXKt9pxh0vXNFPPTmebY65ok65tzNjJxqrHfPNZ/fdhA0SKJXMjJGtIioV
	 a6LaIAa6yvowpzMsRLw1OckKL0aPJ5NR7gjkX9KRWaQYl99VSwDXOaAW6YSXNYv88Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aC/g7xjWVfJaoPMEUZKtxHfBHePPvpHU5a/3ivgfcfw=;
	b=drO6+iEdOLJhlsrOq1nzKak5qp17JLAgFZTAak56BH5gO7sHfdbmcUxr42b8GPtjOo5L
	 MJoRP029wPHFLcsrkXLIZmF2876xRMIMAdtRhomJMstHO8Qxf7d4pWBY/hoNs0XOFPFlA
	 ZYeulRJ/LWIUUrOPsZNJGyJfO05dprocv0WQJrzA/E9L3wRdKUn8Lg6VNpPr/Ib4Sf9XT
	 lcTlYiNoRWbHbVn/Uw13wfO4ugkQlfifDYPOuxtXtUhn8gSNc+xC3xFnHaJhEFlpshLKy
	 OMxJmghhr7HCoqPCVnfWTXt+vD2/5V2cOt4uVX4MOQC1jY9+waWpsP+YYAGDtssfqxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="J50P8s/6";
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA3606A337
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11EA3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=J50P8s/6
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so325856b3a.3
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143495; x=1795748295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aC/g7xjWVfJaoPMEUZKtxHfBHePPvpHU5a/3ivgfcfw=;
        b=J50P8s/6yNhUJi5/1Yqhy3qIpky+0BmU4qEywL7YwT1TCTLNVijPnYQgeiukadJ8iK
         jGaITnMXUmnhuvhPgv1IGPTdjSAA7VrdhQK+GUUO4Zb0Ug6YHJSGLvBIrO1PHlGqNxZq
         bSeLnXzZemsGCc/gyfCKd6hcLpn67GE8wuLtMuehgozSmB0xsGvoL7bFqjes9Za/rU1O
         yungO0OzOWa5Za2l0kFjOtNnG8E4w2hzg+ZjCs2i+JCnFRApm5QRbJeMniSl1qrAOrCE
         PBcUm0PRQ9OPrZW2aFQiIufh+hRYu96sx8e9VeLbpg39jTnfaq7Z7Ny0Ns2F6/AkLiiF
         eXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143495; x=1795748295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aC/g7xjWVfJaoPMEUZKtxHfBHePPvpHU5a/3ivgfcfw=;
        b=X5qKAPEV8mQzmapmRFBIoLHvnzVmDsXGqIuxIC7WlrNynDLNHhKPZUJ5akYuDRfsdK
         CGJBqvyo8veAzH7XzRZ5t6upsVuQv+tL6zfKd0Nfse9ii9HhEyt2do3p+biEfAZDvuuH
         K80+Ku/svK2pyTLlNOoOCkgf981EfaCGRj3vH++9a3Op87hU132KtoUJK9zLlbFBdOqU
         Quu1nDd+4++ppXPdztNnrR/OY8VGanFNE+gtvqpoKWLQl5oACrIMGZthjWOB6UaHsHPx
         3W+0lfAxOjYrPES03l/U5CDqsXk9C4NkWtxavcRYQW2UqZ9hSX5YMGchLM5GXm0evgTn
         a5Iw==
X-Gm-Message-State: APuU4Z9lg/HfJatm0e0Z1FHvXFB9i/jFM//pssO6MO1/go6svb8ggR4w
	Z3cHZ+Jw9lMvWiS/CVpIK45p/r4qKKX5OgktnprWMiWNI9AyXBBu4x2VDq+NI5yPiXdfKDv0lan
	y91+JiWnk4DYdqhxkTwzjigzzJYMPYaalG0L3F4j7LPCaFkQ8wztVukYYQw==
X-Gm-Gg: AYBFou1eULc06F01RK6vMoSXxDVnbDTDWojPCbz3f7WIse1yCA27QN7StVyswLyLtlK
	6ZFRq7Eb123h6CgcckxzfmMGC6k6n+nWZG8gCUhmJFK+etkrzB6nrVLj4Lh76wTZcTngBl+o87K
	nLK/UbkA3CxKQqBsGTN2LNwewz9Jlz0EppbZJmT8MFoBocg6TgSslm+ur+a8bmyL7GHc6TUztYo
	grYnqT9D5QAt43nRag44tRqEan47EIYYUyTzRrogSi8KB1MF5med5VT0T96XzhBCwMN15eRiPik
	fXs9Yv/o6fuipHnBZwZtGozXz5Ovuktgtd24jYQRcwEtCl1svLW158s129RbS+uBTLsUhpN5R4H
	EhIfyy55EzDcb+E298sTwzPljh91I6G1pOPv5lY9RXREFpmubsux9kb5syFy8nuYhf7ufGlddxS
	9OUeSv8YqbbzFOwa5SO7zkgdGN0/1uD7D1jJa+IDRWnuaKtnbO07w0C6SGJR7Dt9fKJxLpDy17H
	Vp9yFGP+BkUMgabF8DuR+hQX99/muL/tYfS0HoQ54lu6SC3q2TQ0NsvTC/xBUY/8U3AqRMumqI4
	Rf7n3GkVlX5nDcq1i5kD34QBHZlFWhhsCUNruu92sv+NEOkp/eKhfz4ozv0=
X-Received: by 2002:a05:6a00:2987:b0:8b6:3e44:8aaf with SMTP id d2e1a72fcca58-8c87b4ee9c0mr1457486b3a.20.1795143495294;
        Thu, 19 Nov 2026 18:58:15 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm749647b3a.31.2026.11.19.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:58:14 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [RESEND PATCH v1 1/4] blk-mq: remove stale comment about non-present CPU mapping
Date: Fri, 20 Nov 2026 10:58:03 +0800
Message-ID: <20261120025806.1065295-2-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120025806.1065295-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
 <20261120025806.1065295-1-lei.chen@smartx.com>
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

Commit 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each
possisble CPU") changed blk_mq_map_swqueue() to iterate over all possible
CPUs instead of only present CPUs, but left the comment claiming that
non-present CPUs are mapped to the first hctx.

The function now uses the tag set's CPU-to-hardware-queue maps for all
possible CPUs, without checking whether a CPU is present. Non-present
CPUs are therefore not necessarily mapped to hctx0. The fallback to
hctx0 in this function handles tag allocation failure, independently
of CPU presence.

Remove the outdated statement and retain the description of the mapping
loop.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..59452b855afe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4173,11 +4173,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->dispatch_from = NULL;
 	}
 
-	/*
-	 * Map software to hardware queues.
-	 *
-	 * If the cpu isn't present, the cpu is mapped to first hctx.
-	 */
+	/* Map software to hardware queues. */
 	for_each_possible_cpu(i) {
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
-- 
2.43.0

