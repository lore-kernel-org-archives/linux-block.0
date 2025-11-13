Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE53161AC
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013821; cv=none; b=pXoV8tK/SV41fDa76vmrKzHgnFm7B3TAulvjR2peXfe5WzZrd6GFmL6WL3jkNvBwEp/cPhJulAFi01xB4dGcY6EvZU1gndV9kt/dRc16b3esg1+wrHoVWvMWFrRFLEaWTHI9zBWPVIFkIARFwW/UVa5G1FESZI4C4+dgvsR8/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013821; c=relaxed/simple;
	bh=c8vY1wPUxAKj0bxZ0jHfN63QqwK1RY83S2/Hc6TAEJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbZ4YOwk9+3DH73BLo2KEplWhih4UMutICjJluuR0L92O6zWQaOH1LljfBlW8pbEmS8AfwyEHZJjl6vLE1SYeCoYoMhF6fFfp9nN/dZF4HivnrjFdYAQ7pIAmXHiEUc/FWHvqODcjpNFM4aklE0Eidr/F79xM9w2POXV1SyMw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARVAYC7U; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARVAYC7U"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so540309a91.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 22:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763013812; x=1763618612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvuh5w1/ZAKgFR/QxFiPcrUwFuMeEU+LS4Dm3RyAWa0=;
        b=ARVAYC7UODvJsr1OeXNIEUm/26Fx8RlInsfqLuP6qCVOnhelJnmoZoxweRiYW/zFkV
         tGEURhi8tahpHP5juPFXtiX3jmnWmstp1QLnhrTYKfrrlemHT85hcZtkwtwKmt4J4Os4
         flMrusE45RjxjShPLaGBz3LLRcSwPXD//cJNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013812; x=1763618612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvuh5w1/ZAKgFR/QxFiPcrUwFuMeEU+LS4Dm3RyAWa0=;
        b=LUqCInupdPsKu+lwaL/T9A/2gRcrPkpLo8VQN7MhNsiS0z91W8nA0J9RUjhNjWz6+t
         2ae7v/I7ApEEkRqnKT7QfoqGv1QTZFfGUBS56N9AE+d/y43h7qKQLlWrO5AXc44XIKXW
         bYJKQlcRhoRoClaUxA+zTx1M05MW3Ol/AYWThwNOm33YiKHaOg3KcKm3CVNKh+im+i/c
         SSO//tTzAZP1R2jfDlU2NvSAyfWsEL4Lf2kQtUX5k2hanNepOTGAptYW1qMpWAlAjpJy
         gXV9Kqv16szq3fOb5b5jzmzlIcuzQNIFenZope8asOJk8Ng/lgyFOc8N3lzgkaL0vwy9
         b2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0zmGz/2NsY5ehH2wDgZhKHlj+YifHFDE6Ji41QnUxDg0HMGxXz85EL/Gymw2hR/EEcvbHOOXzf1EfOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88RpMQvHJVJf3JFznXYFuxknAStkR0YpH35Q7uaPqn3gHQQ+j
	APg/IbIKWE89eZ5pTFonOc5kZHLHTZBUGHHolkHbr3R/m5zUpslHxuT/dQTe6KQlbT1iPv39r93
	CKiw=
X-Gm-Gg: ASbGncvbI7SY8BgTfNZBVHmGGrH24b4hscMxGqyy8qu4h0Kg8g2lK5Tpjmkwo7Dw5r2
	a+gC+cqOsMJCwN4liYe4gzUlbxPBkHDSraKnKopCvTIxjWhSNRpmNABINl6l+22LfBsrS9t7/Z9
	3JHs8j5i6F9GmpJHhnfycJxOo9KYUI+yGuaLBpIXu55wMRe7HhqGEKEFc/9kdL7ewNDL1a67idn
	J9Djadz+Gq3T1B3KZFaNWfDKaMRCHDzCcx9PTyGDCOVgopL+7YS2UYFTyvc0Z82guHVQlNHmLIw
	efYQzmS+1LPXa+rxcUOXzv1ZIChqwr8prLUtZ4Wr90p0XF3XQdioQX+V/9tPoCgjA1SIAOR+Hkv
	nNWlj7nbthLpvKTeV8Md1Vbz57sLAk3rjC7SJOq2nP5DDNN+8kAT+72+BBfbdsCkWyLObItg/gc
	zhlngm
X-Google-Smtp-Source: AGHT+IHJSK58zJfETaE4wa/PjHdjxMZKbnTlC1cgxs6GeEpxRx5OPn8ZRrdiWfc1MRgfi/HYWIglpw==
X-Received: by 2002:a17:90b:58cf:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343dde6f801mr6239881a91.21.1763013811608;
        Wed, 12 Nov 2025 22:03:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed5331e3sm1090918a91.11.2025.11.12.22.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:03:31 -0800 (PST)
Date: Thu, 13 Nov 2025 15:03:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Yuwen Chen <ywen.chen@foxmail.com>, axboe@kernel.dk, 
	akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liumartin@google.com, richardycc@google.com, senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <kyprvtaorfdq3a6fsddaww4jg6ixv253rfonrdv2snyhq4pkuh@zdei5bgqzd3o>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
 <aRVvTCCZSjPyAF_2@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRVvTCCZSjPyAF_2@google.com>

On (25/11/12 21:40), Minchan Kim wrote:
> 
> In my opinion, it's much simpler and strightforward align with current zram
> writeback utility functions.

My preference is [1], which is very close to how current post-processing
is implemented in zram, w/o complexity that dedicated kthread handling
introduces and so on.

[1] https://lore.kernel.org/linux-mm/45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org
