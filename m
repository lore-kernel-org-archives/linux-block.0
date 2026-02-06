Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16427CB02
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390533; cv=pass; b=U5eeEQvWpC1yEby/KctorC/9Was7FqOBhiqvwW7s8xY983xZ7VjsMG4bPubBilnMqAzqTUfUJDSTGDTU6w9axP/if/6nhx4iAB4KUQGl5aPcfQI0C3STRTQm5Rxt8SNbeRe5d2auJf9FE9SBSMvRQ3eDbd0fbbwtmcQIUsqmm5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390533; c=relaxed/simple;
	bh=FmcW3+jk1TotXNp0abhfHHj1CNo1HgJv38wXpbipRZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq9Xgr5Q1x/usJsXdBhqJ1gxlf1qnqCQgZ/7b2r4P2H2VLvH/ma+G8r/YS3KuIE9OGePLh0iat8XTVpShmYwvn/9MORy6/UE1MUcsQ+uAmzChD0lrFuUllidIuURFQKDdtwLG3JORTefwNJUV1LIi6RzT3Z2CXUJSqtI0tJlQH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR+xHuiq; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR+xHuiq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so1650273a12.1
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390532; cv=none;
        d=google.com; s=arc-20240605;
        b=evGhsE9CKAgeeGCPhqpGDyGm1qp8FRGKDsiHq0bSUtN/PCQ78um/GtB47ZbGLkpKOw
         zdoAgJSJeD7rJo2nLl0KYAyrDxJSQZChE7Kfh5v768ar037upd3TWOp1Ue+cX2JAqs0U
         ZFiuWB/85KeNVP4rTqVIQ9T1qcXFf+S/SVi12efRIsur8GWQRSqL3k6oARcoW7tMD/E+
         jxwCfCV07um/HPoq2pj+q8PDmTnQUG7rATjI/3qR92d8hNaP1Sbwq91qTi9iSy8Zy/Js
         C2N0Uq4zHdjCxstyhBYmfQ/TayWmRH5rU7sbA+xEiGtdVLzqBycluk1ydSLs5niM+AZT
         u1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        fh=fu5FjAX/FzPTUltNlDV3vYnq2lRKAa9FG27MeWuatHM=;
        b=SWonaOJr67yQ9N37Er29pdA93+Tt4YMKwbYWvz8l1CpnO8YTSKRZvUq4SGqWNlp6Ed
         bBqhQpGsswMXDSqtZGvERKHU6fIJgJRnZyYTATxoSzXIQ6XF8VGQfw/5oSgAQskSGeFu
         wwzJUBFW5Xh3OpdvWcTJN2wDBFEfHb6P4xjYi+re2PKONfYjMpVk0zTCLEh/Y+rOoXCT
         lYPf7yIkC7srrjuFWrslkq9bJ6bZaQGLNkdxImiGR50/or+jFYQ953KSiBrTrD3rvjjO
         JVLG9ZZKOGmu9ZS1HCIQZLBj/7hs/YbTgvlmYO+oDXN5b5Fs7bTzKYQ0F0Gs8bfObIgn
         fmLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390531; x=1770995331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=WR+xHuiqvLCmeR7rhyGhO4/EwrBaQa3a6rSz1gf5I28lqTnIaym+sW0J5xNtMzszE3
         SUmp2/WeTD7mcyCB82AoY80uSjupBet0cijyEjKlIO572PNOY/h5PcRSKPib4ab9Z+4N
         /DPXqqAIH9bqx5T8gDWAubblFgKs9+y6pOgNa1a8Ah9HRPPusDwQhE/dgFeQdZcUgy46
         qEmAsWuqWsVREbHBkuG5kzqa6yY3M7PWrk3z4Moh2RJjY44U3Jo4g6IYun742m5n6Pi/
         iRddR11zq+/xH79/rzcLbGQ/Qk2Oa+LmzNUaSKdbwVOVE2YGWoYUzO7LXhaznte2lsU2
         bP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390531; x=1770995331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=H0TzRp4/TE+Rf4EGNN1Rv0lJBkThSuu6oE1O88xD8Fm+07ccs3KoTUdZBHhke1OtS1
         S5eVFo1DJcjgFEYL6fC9PSXEgA7u2OzFnvmSd9F8Q/AW+H7afbkX9W4I4KS/C5xg1SGE
         jDH36AsjP3tAef/H8wLZFcIUQ3XtbyPiKdjtIVLVzOoxF7GFzenBFSU8iF8Yx1miQq/q
         BC5zaO5KUU4x6aakZxzpwywUY88b5o59d5BbQUL6aimRt7+T8xUrEn2qdOctbeCCUl7e
         SqXT2+3WeJBgC6pps9OQGCEBdYkbMwWoJ5JaaDAG32H3ZSTxjs3Y499ilvATWcf5rrXt
         F1tQ==
X-Gm-Message-State: AOJu0YzUSLZZyUfGfmjDA6cfHL/QjyEmC3vVciF2rNTgbeDizZ2TrKkb
	+Q5z9LGPrtn0gfGNUYvrnIIZNOOv7jJcKJoOOsF9NqvzsBWNFrwSmwT2Hyu76wd4f5/qLaSnMPO
	BH7ZbAavx/WlxJadsGxQsExl/InEAuZ8m6NNo6w==
X-Gm-Gg: AZuq6aKck+DoC6XkDLFEusnPCoP2dpn16lKAFjot7WnMOvYKf+ctPgtHvJWG+16kkKE
	3Mow3SHAyEWkGFAmFYBq9+YAaMOXHKRHB1HS9OLiLVzlfaSAsM9lCmEKpaxBXh51NRGNEdnhQJF
	NTI7yBL/mv09ISw1sFbz+4KoQKEpj08l2/Px32dgcfsoMkrNE4IJySOOxPh4DCw6kzDRtSv2l6n
	LemNu2+B3mw+5FI2/E3jf1DVwE+KqA+xZEO3QWDgtYAuHwH34XxKnSGOjvBPWP3+VdgWhK/7Rhj
	ZytW7nmcSq+ATYtWRQ1lRHlnmDPRsTXtOXM/G/HoCETNuDynuFNYPFBfEg==
X-Received: by 2002:a05:6402:278c:b0:64c:69e6:ad3e with SMTP id
 4fb4d7f45d1cf-65984192b46mr1665335a12.33.1770390531549; Fri, 06 Feb 2026
 07:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:38:13 +0530
X-Gm-Features: AZwV_QhSbcTXF1vOFniIsckdgf0WRvSvELPcT6UCzLuL9aGCZaYlbLnCwaCB9sE
Message-ID: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

> +
> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
> +       spin_lock_init(&fence->lock);

nit lock should be initialized before handing its address to
dma_fence_init()
