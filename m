Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB92EC54A
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891367; cv=none; b=L8F6FY2jo9c1CeG5/8VO0jeQOP6VZ3uUJT6GZwzjD2pJM+YH41tTeNOEPlURKckMdjX1jtGBFxNKKO/iOxxrAaKKpEYbCTZVwCKjDAmjbIEVVGqZ/vd87vwoIyAvZjO0heZujen0jNgoZqh7aQQzeUdzZOxKi/wl4ZG/K5RmN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891367; c=relaxed/simple;
	bh=rwIJZwdE0h/vGwpewVyInBfM50pssfa9h16XffX+lY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Lyb2wQZIX6h/mHTcNi7Au6CCLQSOpiOTmPVxWO/XSxIswvxN7tx+aSw7oNl6fjjJUjXMdonRB15u3AztZQho8lTMYFBEuMxCplz/xAWLVmYYRfk0jtUQjuCGTax4iZ4XFZcNK1M4/L+hKInKWIGMzuVlEjwQjTiI/5EzsflcXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln1fQQSF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln1fQQSF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bea7176c72so50170385ad.0
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891366; x=1780496166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzVcryfU9QxZddocswZazrJnx5GUut5UQLQcVR/qt2o=;
        b=ln1fQQSFl0ff4QyEjpwc2jwX4jb5xohSdkYyhO7cskouo+sV6UtJ4uNasSNa+o9Uvi
         7/nGDdns10Pr00EBix2uEQMzAaGrickjx/OAiIgSIoQdaarZ1DvBBqihQcx0YSCR1SIa
         tXDwQFxsq6Gz/jWOluXHX+QRkpJz74rJP90S5AAPx0pGHb8LcRdGkDP3xoazP/YXmdGE
         +af1f4gGpfJEjLW9bmjG/+7MdQd+bHzhr2F5awNFQEML4IC3VuxqSIOUAqCjTbuwZIll
         XIPiW1n7SkUpLb84DHoSR6V9PiZ4u3/9PNvFGDnuiPaQZIkictcCqhRaip0zwLCifiIF
         fAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891366; x=1780496166;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzVcryfU9QxZddocswZazrJnx5GUut5UQLQcVR/qt2o=;
        b=cz2PjtZmdtQr/hnoDl+K3OZJJwK4aBvwxw4f+ajWvdnkk2NSTolAyUDyIbq6T0RlYQ
         EWgQk+ggMuha3Qt/lJP/L9iZKVK7xAzwUh8n+tWhVwkje3mEEC2Uab51HP93RxtUwUB2
         R2k/9zTI9/4t5gXdFc34lrMPzHAkSPSNlfXQhkqj6psiD3zGFk1n8TB+PKstSOuzg8hR
         sdnnSB0a6ZbGVJTpS2sEr//vSATWBRW7oBdaRge83D9tqXAsoxDpCMdcVb6ouIyCIdy0
         isuaNHEEYsnd6+RMhsBST13aiPN/Bvf0w0tY7bzzSpp/DV2uzFpuJiavxF3hzR12foA9
         HfBg==
X-Forwarded-Encrypted: i=1; AFNElJ+yyIoHWeGTPbNKDo+jsUdbrcGokxamnRt/lKXI45+cRmhzr3VtyXIioHTAukvb3BOc3ADP1Kh5vGpuIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1Uup3ld/hypBUilxF+TdUG3uyu+9gf+GAM1R81ryxLQI2Fmw
	SS9sWeoKV9C0CoFtvIfzg/AOTP9jm8rTJmHQnNuTLbt0Dk5e0vJkvwTE
X-Gm-Gg: Acq92OHorzb6Sw5gwJ5HwSKVilx5IxR0Lr0tkYWzOu0bpOW/JhDA+jg9PMT5VCMQjgE
	VlPltPSVEAGoIWioCSs9NvGm0qSmggmOmK8Kl/PBIOy7a5Q2y32+MGK61/aU6RCiy6yhIcD4j8o
	fZkzpaHkp9Bm64YDBih0DLOCnWDv/WTU9VWIR3L1lWhJGuWxzKucV4adGcogwdnLquT4HuPGo/I
	06xRt2a6tIVzoIm8UJ+sg1rmMm6+3VhbcY3EpGR0EIf/Nj9dCFUeTwEGPdJKGY4vcSoPIoApExI
	y7Jv4exf3cj3cw39Z7xd0Ksda0O1B84gtvhZzLdDsPbmQJdhhQ5j3oevLfYOQD+rmF4QKbzY58O
	gEs7WKYcKNKCY0Npcv5k9KM7EENcN2y/yTAsXpCx/80fARrsQdnwxeoHGm8xaWlws8qqi4FebgF
	IFFpBkGzahyBg3k6YFY6/wotTBNGRbnDd86btc76tsDAx3AXQ=
X-Received: by 2002:a17:902:d4d1:b0:2bd:a5f:1d04 with SMTP id d9443c01a7336-2beb05bf787mr246093385ad.9.1779891365968;
        Wed, 27 May 2026 07:16:05 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3085sm154156885ad.53.2026.05.27.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:16:05 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and drop dead bio plumbing
Date: Wed, 27 May 2026 22:15:59 +0800
Message-Id: <ahb8nzeug80MJ8Pw@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ahabSU6QcGJ4T4ZP@google.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <ahabSU6QcGJ4T4ZP@google.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 04:21:53PM +0900, Sergey Senozhatsky wrote:
> On (26/05/27 12:49), Cunlong Li wrote:
> > Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> > happens on PAGE_SIZE > 4K configurations when a partial write hits a
> > ZRAM_WB slot.
> > 
> > Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> > from zram_bvec_write_partial() and zram_bvec_write(), no functional
> > change.
> 
> Did you test it?

Compile-tested only so far; I haven't had a chance to run a
PAGE_SIZE > 4K reproducer yet.

Thanks for the review.

> 
> Looks reasonable (unless I'm missing something):
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
