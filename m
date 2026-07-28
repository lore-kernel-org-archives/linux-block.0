Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA129BDB5
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201717; cv=none; b=frX5nMngquoWHuBkpJdt6ejXHUSMiVZ4I1wmA/0ar4kk3l/C8a8uesklUKWpPh/yIU8+3KeotS8/Rci129ocbxidT5vzgY9D4iprZdlC/tdLmqssL/cn+KcF9A0yhmSHaR8/QJf36lWf47IeEMO+TBGKKzKbqhsySNTRZ2jj/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201717; c=relaxed/simple;
	bh=59SepOBnOTWQAoRu4O4tuvGcv9IQ9O/dln4/DxJ+Qng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtyxazqQnWwJ/qiBe16W9RL8PXkMHkRkQ/D2fjTC7SMx7KwbjVoqj85hNQzN38leL3D88BXG3UeIL9OYgMvLiXgChPzcOQsOFMn9NpUPrNi5cAqn6PZv8tPiKbpMZxqnuO2I2kOOyCnmrUNBay/pY1in15llCe5V4WdlzMe6PFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JL3LwXgm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JL3LwXgm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2636841a91.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785201716; x=1785806516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZV2NgdSRup/CLWLFX8aQM/Qa3Ry0EPJ0bhmPTLKM/lQ=;
        b=JL3LwXgmL6LSvxHxWAo1ZL9i6rk5YiDkXHxm49eiWpiv6z8JjQgRTF4R9n7YSUWcgV
         JD0XlQxgLlzP71eUuwRKpU+tzNuRrgyzRnV4o3WmHaqYtoqyx9HtWg1PBMHJLXjEfhYC
         gxqPTkOu0qdB0DHhvgCF0sBz4ZH8IAIlzt1Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201716; x=1785806516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZV2NgdSRup/CLWLFX8aQM/Qa3Ry0EPJ0bhmPTLKM/lQ=;
        b=oaqEa2St+cjRB/BoC5+xNe+zLJasVybYtvtAwnKzgHcj4y++b1qIm94Jz9dec/ZqTQ
         QNQzXLwTidvjKlHEhCgCBlvIWUyVkroVeiWYTZ2pa0G6+ZMLmMrxv/fFdeMKD91+ryXh
         HPwooKSGDMwK1wQyNcxaePzBPvBQCHuC2bBXkVlyKOkXTXBfQRUlcm+ZmU0rNuAIYH8B
         +9220VcvVU2Gy3kOga/9nzjPLVdHUjiPL/SZNV4PvpUtZ6NKmChkW/TwrpvZeAyd5ktN
         haVWGyeFSkxAsGCmpvpumGwPD8DZPkCpSwyXhwrLrtJprmx8NpjPxQkuwSdyDyH9cwNb
         YTZQ==
X-Forwarded-Encrypted: i=1; AHgh+RohoOOQgXymAJC62YRnKesKfBnmKavn8Z904jmEJJx37m1lBkhCgTJfHW60DB8eej/nb47wceKTrquqVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/+dMwwUKrRzmjG2JaZk0WNRZCRGNgWNR/WllhXrwgpPyUNwl
	2lpfbE4cfIXhmLne030cXlLEHKXvRuEZ9BMrZM8pw017T1lov+q9CsFNjNDyMAxCsw==
X-Gm-Gg: AR+sD10aAzzwH1q07LYk+npbnySHEsClk92CLoK9NvA820g6ieLfbDEMyv590Djn3G7
	Hj5dOXw7TQhKnUyvOM8pYyzYE03jUrseznwEikPD7W5DASzBVVg9pv2xnrW1WvcwBvZ6rDejtlH
	sP4xgv5NhB8kdyZhCsf2lLrx+mOXWFWwO4ucsUOVkwjIRFijOLQTxsLbUQzeHluqMl2OkhOHoVn
	YTihEPZSwzFgMH7TLj/VQq00PUVe7Eu5PPf2ucN1Yc2lJT8jNpqFWYPviVfjOW0EAzX6B/5NKEF
	k7w+r51RoM6U1XEXJ0xoR8mpGA10OeEJJEbZIAIXjRkzSl7V0RbMGvIf7WuzMFjrV8I1R/NvjF7
	frDM5rowhMn7ea8gBNAahB2cRez8/vBaLdfExKPl2nkEhQVMgqz2nzK2kIIjJJwnkA2wjuts/p+
	OZxWgoV8xUbGHbuPmHCRThF53Logg4ubMBv7ohWd0y5Q==
X-Received: by 2002:a17:90b:5112:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-38f6a471aa1mr302118a91.16.1785201715692;
        Mon, 27 Jul 2026 18:21:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f891:e0e8:e2c3:fb20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81dcc1sm42831605ad.84.2026.07.27.18.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:21:55 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:21:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 1/3] zram: fix zstd dict use-after-free on per-CPU error
 path
Message-ID: <amgD54HG-KPDVpP9@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <amL0Mb8NN4DhPgKm@google.com>
 <CAEjiKSntJKSaEeQe8YbtNe=6574=kx-y4CXKph6u_F04O=3kFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjiKSntJKSaEeQe8YbtNe=6574=kx-y4CXKph6u_F04O=3kFQ@mail.gmail.com>

On (26/07/28 00:06), haoqin huang wrote:
> > > zstd_setup_params() creates global cdict and ddict stored in
> > > params->drv_data, shared across all per-CPU contexts. When a
> > > per-CPU zstd_create() failed, its error path called
> > > zstd_release_params() which freed those shared objects while
> > > other per-CPU contexts might already hold references to them.
> >
> > zstd_release_params() sets ->drv_data to NULL so we can free params
> > only once.  In addition, "while other per-CPU contexts might
> > already hold references to them" -- other CPUs cannot do anything
> > with those params, the device is not setup and we cannot handle any
> > IO requests, right?  There is no double-free nor UAF there as far
> > as I can tell.
> >
> 
> You're right.  On the init failure path, drv_data=NULL prevents a
> double-free, no IO is ever submitted, and cpuhp_rollback_install()
> properly tears down the per-CPU contexts that succeeded (which only
> calls zstd_destroy(), never touching drv_data). So the system doesn't
> crash or leak -- it just means the global cdict/ddict get released by
> the per-CPU error path rather than by zcomp_init()'s cleanup label.
> The original commit message was poorly worded, I'll fix it.
> 
> > > Remove the premature zstd_release_params() from the per-CPU
> > > error path, the global cdict/ddict are properly released later
> > > by zstd_release_params(), called from zcomp_init()'s cleanup
> > > or from zcomp_destroy().
> > >
> > > Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
> >
> > What exactly does this fix?
> 
> It's more of a correctness / ownership fix than a crash fix.

OK, fair. Agreed, let's rewrite commit message and then we are good
to go.
