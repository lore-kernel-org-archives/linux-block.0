Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27A49659
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241277; cv=none; b=a01lZZkiCQJPfE/kv5DyFAXtBtSLe72nsuSF3ZhcU70uimG+DxjhZ2nlrt2VbDvOB1e7QMep021qb67H/akTuFDv6htyXSzQ1WCOCbSjRuWi8pxb4OqB6tRhFHR/MvhbrxMnGHuzFeD+FzrfXwnq/ICNrCenx3jiLOT8O1LYcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241277; c=relaxed/simple;
	bh=WSFE00FeDtnofDWlCWa6o9enLw2V0Q9YYDGI3XrXwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6jx2egC8AHF9b3y+69cVwTm8DAStYkIeNbl9PsVPzx6SWXqR999sPRCyIej/G6rQOwE3oTxIN9KzNRY/pHxHeMxJ4s66EdwJCUfd7roLqAbpm0zzWSBk2W/viIi3D7T5aS/hVWcimh+HhwwbdqxH8L99LG1yTsLFDTPmrOcEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJY+CbV8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJY+CbV8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa086b077so686062866b.0
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724241273; x=1724846073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1cKOhqUF3zu7vgZsan9VYbVtQKA6jU1ocQV29bWQbE=;
        b=BJY+CbV8RDd+/YOsQEzpiiRqI+zX6EaRnuQCb91rQUAaFIuDNyreWrNbuyyvqkepWw
         0J4MCz3D1GOJ2vQHZcRwB2UeMr+TyuiPNmfHsYZDuctzym3pdFqlScexijBA6ylSGhkn
         QskNJYyCndrEVYYZpmtgxPrVkYoxX/w55SdckE2S7BhnWFr3WLJCb9jbn1zMs+/VJ6wd
         Gy0RYIPacFntwCV0YudzvXXONL5/mFdv9ULSCB3Cwx2rI6qJ1pHvky1gfhW2C1F8OJBy
         YNDbAkGlrN4ue2KT8fz1HH9yvFGC3vr0eSAb/OxX+VBR2lR2p+KZ7CYSYfa1SasdKTK8
         /B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241273; x=1724846073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1cKOhqUF3zu7vgZsan9VYbVtQKA6jU1ocQV29bWQbE=;
        b=Cke6CFB4m3mbMdbEJ/AyI4rFTMVTuRF8iyr99Fdi2xdTEHM9YHXxwYpJ9K+BLUVvQQ
         7HhBgLd9hBw6Y9fRuwDnAnSUeZGOGWWnvu/RSWfBjeooXKKe7xdgH3vQg4WX9FIjUy+Q
         8hIqhrmDS5st4YNVjYJ1LfXNKQ8qZ/6FJWt/BgQXiza+pNSvUcbu0EMT/KcBhHaXZAW9
         m+sWH7s2jFOImNLLlq9A6pBiHBHvcTxhE84NK86fodAyziKNNCZjKtXFYSOhgdR+sidz
         yqW+/xWKIpds18F7Wr+sw24w6t9+FPHley8BdozwVkMoUqP6cG4p3zws9vC7o8NmnRDq
         tsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlyTwjGnF4hyiwtfwEtorizpTH7atn0dCVrlDUc51V2Gj+FOSX4+T46fPK+aKesEY8ZwUMhqbGrokbRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD2oDdNZMTHsjXMDGBRBeC0R3+v4veLiqPr5mIuqh9ANXhGEq
	KS0APZ22rdHopzDXpyV/uXyyEjoONAVAbndgA7EJ3i1bcVuwq5vPB7MEHMyMe+0=
X-Google-Smtp-Source: AGHT+IFotKgao7c3MvbC51pbdgpWNBmepUxyxxfJglrrTLVTS0I2aFuu4fTaeblDXOtgwgBDsM118Q==
X-Received: by 2002:a17:906:f585:b0:a7a:a30b:7b92 with SMTP id a640c23a62f3a-a866f11dcbemr111996166b.1.1724241272808;
        Wed, 21 Aug 2024 04:54:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c682sm885673166b.196.2024.08.21.04.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:54:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:54:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed
 with error -12
Message-ID: <eb78af03-b407-49d9-b605-af9632eda08e@stanley.mountain>
References: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
 <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>
 <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>

Give this patch a shot and I'll resend if it fixes the bug.

Fixes: b188c57af2b5 ("workqueue: Split alloc_workqueue into internal function and lockdep init")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/workqueue.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfeeefeee332..2fb93f3088f9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5623,12 +5623,10 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
-__printf(1, 4)
 static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 						  unsigned int flags,
-						  int max_active, ...)
+						  int max_active, va_list args)
 {
-	va_list args;
 	struct workqueue_struct *wq;
 	size_t wq_size;
 	int name_len;
@@ -5660,10 +5658,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
 	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
-	va_end(args);
-
 	if (name_len >= WQ_NAME_LEN)
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
 			     wq->name);
-- 
2.43.0
