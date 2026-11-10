Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292819;
	b=1bUfJCzxi6ZwAdPw3cgNgULQXnd8+q3qlTg9jQBcnUkR3Us8MwtDiA8zmpD4KVjqksrA
	 aKKaYEwdS4JrNK2w6CAUKymDnXrENY7MjigsDoY9q1fybCH/dLPMitcV6Jr4IDmcbfIrS
	 CQLK8etKiyHM/MkIu/E0VYzJU1LxmVSBqUWm3GqjzCUni5hfWlC6hWk3NmhY9fU75qlwq
	 XlmiAMjrUBxParNzcrTnuOgiz2t85Z1mVs5AcFv1F5dvAIVmi0DeCo8yDt2bC78IUVK4Z
	 fYoYtEE578FG1JE/Bm4T/8KgaSV6liqoxC1kXdzYzAaIQ+jOX+noBTM0Kj8qGA7kbmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=30Y3+K4f1eGRVFoUBblLntMtWkSSsaPfJrriyA8Q1b4=;
	b=DI8WBIO7cyju1SSPguYgf0R2jEv08eISMo1/ZqfK30PM8xnYfn1mWfsE8+FJiZx2veJr
	 pf2bIGDTXfFS/I4HGtMdPPSOiwfOxiljmzbGy/69Ncex5gyNgkonfbE2zY6bLrB4hPVUI
	 Sk38owTAu47JEveQnDAWhFig9xOAXm1q0wZBJmHHaHqB6wgkWM6yiT3bJqn7vBajoEvbF
	 BECFbuUDMnaTIe7hd/ZBx+0UCAkBjSIq469gn5i5GSbcILvVgQ/WQsHyvz/FIwD6sb+N/
	 FFcULtHanrC5lZ9YTcVMt6RMojfdruf9BQlg3IRPUZTWNUZchhPAvlHB0HxbnJZ17fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ju1LXvaL;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D8606A321
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 06:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ju1LXvaL
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso963092a91.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794292818; x=1794897618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=30Y3+K4f1eGRVFoUBblLntMtWkSSsaPfJrriyA8Q1b4=;
        b=ju1LXvaLqBO5kgzybhsbv3zRgCGu8niOwIDhEXiGbLiUasjW+BBbiBvEr02X3zBkXy
         5k+Dllxj8Zim/zlv/qvEAiAlTS9UPoddJpxd5i3sCYJ8/S8Vqc0cM46mlokO4TLTeFov
         dyGfkFuCNuAy0dLC/g3M3DKMtzFoYBvle/qQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292818; x=1794897618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30Y3+K4f1eGRVFoUBblLntMtWkSSsaPfJrriyA8Q1b4=;
        b=vyHax1VWtlLgtzNj8z+EQuyV4gE7d4KNZSveknrDnDheSoHfpr9W8eVewW7cBchTsZ
         8GLXaAA6dgTMSfjBmO9Xn3AqmQ/R0aREQX+bU9uwn//djS3qLUZIBAGmeq+rK495kpSa
         1l4bygHYA0wcZW6LOk1KWrB1t8mhrfiMo6hvo2v+g+NQnBtm/zDu2heT24Nqb7CKLYEp
         CsIhuc/8SFARHZm9520SeZcOgCN6xNWeBvfiEprk5coqfTBLepMmDPNxDaWQpOYPvQam
         MTyYTiU2HXjyTeig226WyNlaQBQsVHjQHH3bDB37wyExZRFbImvppbpsV9SLt24R5Ckv
         yVVw==
X-Forwarded-Encrypted: i=1; AL+hErEB3DM7SVYenJpcwIFUMkJ8QxwaV9lxPQSwJi5762tBOgV9+7LjFMzwL+eHiUEinpKBIEpJXC0ovmWutg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/OeyzCpXU18vCklGOe7De/icUgFluh10JXU/XGLidFYZ08Mgq3
	x41ZTMAz1cu9ChV4U1kbGNk5WuDG19yVWlSts3zKyQ0cRno0axsxOeMrpZHdd6E3/68Wa9defRi
	Guis=
X-Gm-Gg: AYBFou1f/5SwGcJtW56iyY7q+iIKrd/+ihwPcDYjDGO1vCoQrz2YjQS/dtfVJRkrs0s
	NHDx3GQU9T9YOma4iAaLLeqkIb0P0MYQGUVT9g2BvrTYA0DeS1cR+EaY/5met6NOg0q/pBVTMj5
	gHdRCa6sCSvBRlktjlVjFSB8Tv4whrh/0wypRDwBA3hI6k/WQmEKAX9TPeAuoxJ0e3OgMBRR4Co
	gkXXpEQ9FeKkWUOJNSEf5w6g4La/zTKHOcDzqaRFBqTUtDQxlAfE8cJu+95o4PMDsCGm8MmMx3d
	SDRYD4T9fKZj/Xg0ouh96GRWJuT2Su3NeD/LDMlXMmvsrv+d926bsYdKBR1EfYBlUCojZv/0sT/
	tJ8Lh+nbT7RQlHAl3Q6DnR5pKY6w/PAWTjCkxKhDf0XztO7OCzws1jM26tL335x2TOrDmhvQS00
	verMopnL5H7yDGqzHbCNYB3+zUfSx6th3f5s+CBI7WbjvT+rUjPY8n4pZbvpo1+hXdw6ENjAYMA
	GZqe7GGbTIa8pLM5BVxu9CiyQSkiE5IEaXHu2d3MieTsK8bF8maivDfOGirZTVbQYKOYMGemNlW
	xDbGmRyMeKV+kPzONw9gYZvTrJIu7aPTpArzPCsZ4LubGhkJkLGFLr+mAJb2a12J5yF9Xw==
X-Received: by 2002:a17:90b:224f:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3b166d0512cmr2059326a91.41.1794292817853;
        Mon, 09 Nov 2026 22:40:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16fea4243sm595945a91.14.2026.11.09.22.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:40:17 -0800 (PST)
Date: Tue, 10 Nov 2026 15:40:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, raoxu <raoxu@uniontech.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Avoid duplicate slots in batched writeback
Message-ID: <avK6Y1VmIYIBrorl@google.com>
References: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>

On (26/11/10 14:18), raoxu wrote:
> The writeback interface accepts multiple page_index and page_indexes
> parameters in one operation. Their ranges can overlap, but
> scan_slots_for_writeback() only excludes slots that are already being
> written back or marked as same-filled.
> 
> A slot selected by an earlier range is placed on the post-processing list
> and marked with ZRAM_PP_SLOT. Without checking that flag, an overlapping
> range can enqueue the same slot again and submit it for writeback more
> than once.
> 
> Skip slots already marked ZRAM_PP_SLOT while holding the slot lock. This
> keeps each slot in a writeback scan session represented by at most one
> post-processing entry and leaves the existing release and reuse paths
> unchanged.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

LGTM.
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Jens, do you want to pick it up and route via block tree or should
we route via "more traditional" tree (Andrew's tree)?
