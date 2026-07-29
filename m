Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30793BB48
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291626; cv=none; b=A/v4bnjmpgmxmDskp7xC3/O7GWB6c4D4L5sNY+3px/QXh3jG2fXmPr0DIEa2b8+BglwKxkb4w32b1tSYNQZKKk1MoZyWViPI0oCIH0s0JNTfjzIwqFPhZtTHgzBzuER4S+CV+jpiMN+cNkrzL6+Fk1Tlqq6ME9E5MHiNmCb0t/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291626; c=relaxed/simple;
	bh=r9x8Fysim5hVjtPUDGKxdgGClLYIvPD9SrYuzWgfCPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daebYzL03ovVkL3DpE0+Zq2IVbg8iMrdd/jMnlDQueEAqeT5Ms8BH+XUrHe+BgMlpHWkPykSGK5EcDv95E9Yalm8TLk3A51GHIrIBeUxCvHodX2X0ChH4syysHHmikwMyNUrza1ZAjEV5FWuDtK2ibffK74R/i5gHmIHO1eD2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZfmeS8zH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZfmeS8zH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84874b52eabso610876b3a.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785291625; x=1785896425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HHcwyINt33m7baaducLDDGQsoqsndwm8e5Uygv0qJdA=;
        b=ZfmeS8zHt1eXlUMs8oO+sPBGFqdW/uFUjWjxxYRZlrfcVIbEjdKPjeiJ1kOkRXKOC5
         XIJC5Nqi82BwZG5AttcG+5LG9F1SMOGKLtnngs3gCn/iNCcng/GZZqwZehxWimb0VO8T
         sSaU5GzEpNEysMKfheSO30H/sS5YcE5sXV7Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291625; x=1785896425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHcwyINt33m7baaducLDDGQsoqsndwm8e5Uygv0qJdA=;
        b=afd5+sfn3gCD5H0Sk515PfMCS/hP6Ina2QIdQ+AkvXlgD18KbxO0+YWJcYaPILCuue
         PB5CS+UwQhLcyBo7+tcuF7MeS7C8AygPy64zrkzSKKk40XU+j97vjG/JZISorGnuk/SZ
         Te6w6EpJuDCsjq0Qrylt6+N6S4Er3/gLvDi6zRrMLwpCupQkbSLC03DYdOdY/yRg+avS
         ykyQQgXIXwYpV4LHU3SU1aIWA9dJCU0+s+1eLjLYBNgoEgZDjO31LR+YgVgWvwDl54Qp
         ZKyb2G3yDmlGPw24+/oAoq0d6KA6h0/JLb2kgIzsppReDJThwiqyy66AvGePvKwSk5xu
         lt5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrl+XQb8EKORGzY4XSbi+sQpUALjc1VT0Y9DQ8R3swklgnE2hrWwKjeMeX0kooZf7BuwDYeIMjo0vgndA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywum0OvLKOjSO0NR57p2fcMROUU3wbvUc5TAFuKSEKV8/NqeGpb
	4DG17CM/hR/9KwGYtxaZLtobNx5DZM9SDRgWqW3teKjaGMtW6+bs1tlEkpQqr/in7DAqmgOA8NB
	d82A=
X-Gm-Gg: AR+sD124SBZTUZ7UdzARuKn83fszRrtpJr9Z2pfi4wXQPNZ3rvEz7LwRY+zwuuPQv74
	TX9gFn3VIj1BXOalh74CpeiJq3zl9cpW3TWzAGcmZy1f7ni0bWN5d/HTm8lH6ThwcqjZVBpLKia
	UsqdFEcVLRBBSz+uW+zNKsSTxxphGzeQpUQgT9I+SvoP4wImFk3lI7cXoSBP6N0kK3yc8ag0Eg9
	xbz/MWfmCFeP1mKj+fozFGR6OzH1RDjH4AwKMWHT9V2MoGWOf4lovD/H3vmcUu+Lgee7V9Q1bMB
	rbwikY5JSZkEmxNBN62bcfc4LlAPVjHI72iBFhuY+yg3iUwXrMWT5q/9WmMYx/n0mp43DVM14Zs
	xVJAHi9tydWIAORvWF4XGPvA97R6rDT9C5ibQbJOTxdZSw5kiZw0RdKvoEPkQ/Nmd5yewQTe0fd
	xyYhEUocg8Jt84PhrmLIfacSOCLuWQ67bfg0t14L60a0iAYJgunstAfrxjGPsoS3zlMID3GY6tM
	ZlC1aBrcMM6zD2R3xkplVEYKYTW
X-Received: by 2002:a05:6a00:94d3:b0:848:77b2:20a with SMTP id d2e1a72fcca58-84e933203d0mr5000504b3a.39.1785291625053;
        Tue, 28 Jul 2026 19:20:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm612552b3a.22.2026.07.28.19.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:20:24 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:20:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
Message-ID: <amljC3jQduwortXG@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>

On (26/07/28 17:29), Haoqin Huang wrote:
> zstd_setup_params() creates global cdict and ddict stored in
> params->drv_data, shared across all per-CPU contexts. The per-CPU
> zstd_create() error path called zstd_release_params(), which freed
> those globally-shared objects. While the drv_data=NULL guard in
> zstd_release_params() prevents a double-free on the init failure
> path, this is still a layering violation: a per-CPU callback should
> only clean up its own context, not release resources owned by the
> compression lifecycle (zcomp_init / zcomp_destroy).
> 
> Fix by removing zstd_release_params() from the per-CPU error path
> and replacing it with only zstd_destroy(), which properly cleans
> up the per-CPU context without touching the global params->drv_data.
> 
> Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")

As we agreed earlier, this patch doesn't fix any known issues per se.
Let's not send a false signal to stable folks that this patch is
fixing a bug, let's not add Fixes: where they don't belong.
