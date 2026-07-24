Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2A35674C
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870384; cv=none; b=sI7psxC/a/aDp2BmfojzY/G4C8xWUSOMNOSkAqwbajGFH9jxhlAbWYycYQpp3R4e3pimUcy9avA0Afs8sKntEb1sXP0HXNfpVzeTRwcLt/HEZNIycmqkcvNvqgqp2Cr+fMHNrIi2H6qbdTknB8kTiEaW+Dvi/OjpC1/Fg55VY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870384; c=relaxed/simple;
	bh=rAeDwFHAlpP+kf6lVb+g3u+SaL6AUhIvbglwFHo9Axk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffYUraLqs0JlD1XJ2oqoZpc5vOhF8VWRS2M+2b/d+rZPA8iJI2gfbZr24ShZOKPI5Nua7s3UV4Atqk9NttZMn4nGOxzYCuOOMdn8oB+UShQhaTgKUHUChx7zLJvxFSb5KeC2zgpVratoVvjJHpe1EwYqasou2ZJFFxjj1z0Mdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OPcZ48ZF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPcZ48ZF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce98cb8165so474575ad.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784870381; x=1785475181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpBzpVbyjq3irNQ8NZt+4MS84b8k4vNA2XPSiTe8b48=;
        b=OPcZ48ZFQWBEp/YAQvvFF4TlFTiNihg1F2oKxzYjP1ZkcLa34pMQX0PICaibDLEMbA
         51qyt5GVEEb9wj70NVZhK0VgxKnxdEMdH27rxsEIQstlgYBnyATW/07MC2kHDqSSc/qQ
         RFIkmnRmyRevCCgvpgNK4LHFaeVf+mGxwZ4V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784870381; x=1785475181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpBzpVbyjq3irNQ8NZt+4MS84b8k4vNA2XPSiTe8b48=;
        b=cc113PVms0PEh6FDX3Zul9SXlTq8hoiApbPxkgcHZHq/J4g4CK06dbdru9MOrQ6Keb
         ImxdkxHAh71L3WHvqnybs9/lf9BX+b6KqFsmznrow2CYVfto9XhhAZN6F5Gr/IFiHWQW
         JgzXkYz+l4oYv+uuczC5u2KyqAjnSUtGVGXcbL8aS3Gr1odztyM8cqnFMREN4dQXmYk8
         qUaPNDOPh9qa4BpUS4Hj8PpjVUqWhpzjWF3tkgC/4DCjVHyimltKgHeqpB1giVqDRs9Y
         4B4kQO3Ka20RKcr3d0iVkUfbgL80afNrfzYt0nef0UWeLJYlIn5ZTOkGJ/3z366iwB/p
         FnVw==
X-Forwarded-Encrypted: i=1; AHgh+Rqn3YXM5nMKnaIu4FHQ5ec4Ph+tUwSW4yQghHTHX9oWWdc94Nvjz80IUjhmyrdZvdePVpPuoyUAnXVpzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i/Pox5CbEa3lAVrG19OFH/TOhgSqMLYXL0pn02kvJON+LlX4
	4oKdXKraXoId5Gv4Pkos2IhF6LdWM2rDcey3dPbbu9mM2eXCD7d34Fjk076AddvBwQ==
X-Gm-Gg: AR+sD13Lhya/NDPig39TzVsxwhpDkQ3Zu879uB6wKiV3aNvRo/FwNAu7Z/6mFWCWf/r
	HMmy7N9WBqjxHW72qVgHjCB2BoKDD7SCIUZNv1w+fiDFRS/YgGBPwm1VXQnsyt5c9iCwtGtlPqI
	Mtc0Fnsp8N0pj+O2Q0HyerKVIbPkNHsDJbTwEhvpXE8gBAB53m4+HB0xfphDClxDDB6R+WMZva4
	C3nH4kZmemjaEdEmHPqSM3zW8+LHx/GBNdwCEM1Oel2c+crULcbfqT7nN8JJf2/D26Fi61MMl5V
	utcWnOgRZ5jRaC2UlflRtfXfg1uH1tvum/x7VwfpDyf6GVRjo1376dO+c9y6A9ihFWijBKEDb8d
	4vmKq0s9J4jxKesv741/5W9BDVEBqlKKShDqwz2Ik06fO0BrFnO/9Dd8TjsZVUFO2Upy3qVKQBQ
	qyrd6v5dljS4SonyNaDkevRYkfmqjlHJj69iYZnLZgdw==
X-Received: by 2002:a17:902:f682:b0:2ca:2390:ff13 with SMTP id d9443c01a7336-2cfa9430714mr65536685ad.5.1784870381310;
        Thu, 23 Jul 2026 22:19:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5ee6sm45222155ad.53.2026.07.23.22.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:19:40 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:19:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 3/3] zram: reset per-priority params when changing
 algorithm before init
Message-ID: <amL1eeXH5lpPQC8i@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-3-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627070216.13511-3-haoqinhuang7@gmail.com>

On (26/06/27 15:02), Haoqin Huang wrote:
> Parameters validated against one algorithm may be invalid for another
> (e.g. lz4 accepts level=65535 but zstd does not).  Although algorithm
> changes are blocked after disksize is set, they are allowed before
> device initialization.  Reset per-priority params on algorithm change
> so that stale parameters do not silently carry over.
> 
> Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
> Reviewed-by: Rongwei Wang <zigiwang@tencent.com>

I suppose we can do that.  99% (if not 100%) of zram setup routines
are completely automatic (systemd, mmd, .etc) but why not.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
