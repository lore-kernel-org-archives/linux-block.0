Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986D39768A
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566520; cv=none; b=E2L+dSP0LxemYSe9iKrYYqGNzNCvpXNmI+6i2xUdf7ZVh1ZIs6cyQ0ExRmHPZJygkT2UpOMS3rrt3uaYWxCjjizl+qfiwGmebv29nXx+yB+fDStFfHSD7a2Kpvnu7enUrZmaBS5r31drFyHnBtVY2eAcSniVk+8bWzEddnkEYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566520; c=relaxed/simple;
	bh=xTHkte2RUvSWtiFL+zim574JKvRQEGOa3ktAOhw9pjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPRUhT+NLVSCB1ymti07HxYtiYRjRqKjvHfa63axbkaCbn0ysjbvSix5AMoKsoklfYU7OG4OdGAEQPmYJ4yC1LmiBzGLqEH9I+9a8jPE+JTeXMsrynRedMqf2YE9Dk25AE9JH91X43go62EsU70xJ7MtSKAwPzOOekY/AHXv220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=uBvvwSOv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="uBvvwSOv"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3fb47559so726863385a.1
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772566517; x=1773171317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTHkte2RUvSWtiFL+zim574JKvRQEGOa3ktAOhw9pjM=;
        b=uBvvwSOvBLhGkAa1GOmTMqRh3KFBIk3CR5QIlUEXsdKSbq8+ugoWCfnfrVZM1n7mzl
         pNeWGvrpwRJhy5ESpvb1xy/lNb/FXSXfY6xYfOo5d0dtvlhggylRkOBcw1kVghO2KNNm
         /Ru8jR0aLfw8g6MyIo+DvLWYUZqrwZoz2sD7SB2Lw11qj6Tr4Z/vzg93vIwp1pK4gCwR
         v+bQvW/h2vXV+xPXBgv1v5/v9bxt7q3XRbM9VyDUugDvvPPAAqNmjPZyZTC8AKB8Sp8/
         PHOAiDiQGXWUTR7pB9W20OcaEYMRqv/7ThiaeVB7VDiSaLHtAaK4BMLY7uZqOTtUCyzc
         kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566517; x=1773171317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTHkte2RUvSWtiFL+zim574JKvRQEGOa3ktAOhw9pjM=;
        b=MZsYL0i3KOSLZ268IZRtf9gPEhCyQGFFxCcF7YPeVI7337EGHFEBsgXHz+tybtcDTj
         5PCAd11bs1sM0L+uq8JYs+lAHH4C18FjrrNnGThU9tdynTr7hrLSp2MACsTmzn8W9UIT
         vWRh/YAPHsx0EUcRoKxFMPtf8NcJNPxOn2ML821PUtTNySAr/PSzAyuXEEHWVlktlVNu
         ldsMmqsnDvPc7DjPyz+CIXu8tZCZJZ6ZTuk1kfon4nRN63iyrh+/BosQPrwGjmXL9td1
         SRSUpsGMV6a58F1XiLFW60YocplWdt8u9wJpNNyp3n5gT7lb0lRx3luKEv+ktJsBQ3MO
         FBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUF6ZgJje7mkODSV4U1EFZnms2vtOeFkUIBg3xbYXPDgfdaGA17pdbuVkpaz41MygNGXrV/qWY37a8cHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TSYheJA4uR7ldWClUflCWT5LS5sVQywAnXQaWF5BCUqiDkYz
	qdyOSzbGkQLEW5pAlgWrpFcJz4N3j+qHrBRNrZMBSGrqkFQtEMFOlhttKzkGBWW3+5s=
X-Gm-Gg: ATEYQzxz467U+zMPZnXSOpFa6Yl0bxv77p/ax0xB4PNlDlJ5pAr03/SrfLUHsJw1Epl
	HN92uCq3u9l5+xmJ5lg7A+bH+GvdSqKvX4o2hE9s1QPLsZ1yyE14G9Jo3XD8kHu4FHuITtyHyCq
	zV1vSeyVRNuBee410hKtA9okA5Je2KcFynJji/ZlLT/QiPtNzFoNyKMZrqUJ8ROnbJbB2B6hllY
	oGuhuO8tijgkjZQfObRx1gSqSOG3sIyjrLi2ubkTcMrtmKf0MkpslBERtm1nQ7Nm/7UIVQDy0QQ
	vHdd3Lh/uGGgQXHvrqlqY4Fm1giJgQIZKkKnyHJPaXWZNSzUypH1MJabcO23FZ3nDTj6ZKSENRn
	gFLNTlbTdkY11gr78pGsXZpkFcZ/rU9DD5bqtXYlgFmsU/u2vbD3U+uHOnnip37iDQ7To5TtvgX
	tWaW1NXGv+uJ+7I2c9DEM2Pg==
X-Received: by 2002:a05:622a:190f:b0:502:98a3:3496 with SMTP id d75a77b69052e-507529912c6mr206565681cf.45.1772566516729;
        Tue, 03 Mar 2026 11:35:16 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab2fd9sm133192891cf.19.2026.03.03.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 11:35:15 -0800 (PST)
Date: Tue, 3 Mar 2026 14:35:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <aac38JHJCRB0PbjJ@cmpxchg.org>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303115358.1323188-1-matt@readmodwrite.com>

On Tue, Mar 03, 2026 at 11:53:57AM +0000, Matt Fleming wrote:
> When all active swap devices are RAM-backed, should_reclaim_retry()
> excludes anonymous pages from the reclaimable estimate and counts
> only file-backed pages. Once file pages are exhausted the watermark
> check fails and the kernel falls through to OOM.

What about when anon pages *are* reclaimable through compression,
though? Then we'd declare OOM prematurely.

You could make the case that what is reclaimable should have been
reclaimed already by the time we get here. But then you could make the
same case for file pages, and then there is nothing left.

The check is meant to be an optimization. The primary OOM cutoff is
that we aren't able to reclaim anything. This reclaimable check is a
shortcut that says, even if we are reclaiming some, there is not
enough juice in that box to keep squeezing.

Have you looked at what exactly keeps resetting no_progress_loops when
the system is in this state?

I could see an argument that the two checks are not properly aligned
right now. We could be making nominal forward progress on a small,
heavily thrashing cache position only; but we'll keep looping because,
well, look at all this anon memory! (Which isn't being reclaimed.)

If that's the case, a better solution might be to split
did_some_progress into anon and file progress, and only consider the
LRU pages for which reclaim is actually making headway. And ignore
those where we fail to succeed - for whatever reason, really, not just
this particular zram situation.

And if that isn't enough, maybe pass did_some_progress as the actual
page counts instead of a bool, and only consider an LRU type
reclaimable if the last scan cycle reclaimed at least N% of it.
