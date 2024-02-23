Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E090111B5
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663899; cv=none; b=A7cr3lKTL2JsB+fROgltJJDlj2liFhB0ZdfVfXFQecH9pHhs9+qalVUnIGutVC/8suUB3LdEB8PteDpTWbYDxH4Wutqbll5tfU4z4kjJmvya41AI7NivarqjiSiZWfYPQsbXylk39UDpB6fK5vquIkKgN/40gt0QXIeZUdYJdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663899; c=relaxed/simple;
	bh=V3Npn3wabQXSYppjsM3JVxZJgUuigJGgWq1r806yQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt06EpJoGD4H3U4W+BZHQLyTQG0+xcm09XHbQyK3Zb1NcCmdXl2SP0YfPVLwsYS7dvXI/LCIGPDkfnGk0ZSB9Txx2rmf15V49Kp8kwjD+A0kV/KZGuBa6do1q/FiWo9AUKPmzhRLNLiT/KaUdMwDtBM6HoCFQS4VxcmiKVaelN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=grDiCWQN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grDiCWQN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso319998a12.2
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 20:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708663897; x=1709268697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyfVn1iwxylZLLoWYCg2pfNNrBNYSfri0DItXMJEGuo=;
        b=grDiCWQNH73sdyuOZ4XkC0g5sLNYQd+iS3tQ5GmAmXrYV4EnxWc1cgT8Rq7/XHqAu4
         cS1vSH+7BsCnBZG7YqqcPGXxDbOYyxvT6ItfGcjqOxrTSoiD2bJe0Wvc80hciO7J+EOt
         cOQvMUmzBP7AtgoV3xJYE1oDTFsNLdMLYrMOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663897; x=1709268697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyfVn1iwxylZLLoWYCg2pfNNrBNYSfri0DItXMJEGuo=;
        b=bQADlsaJFkOdChj+tdjR5juDsRAO5MXjXXDIQhq5ZSyQJCpLN1vHM5xGTrWRgdVlRC
         pnH00qZcIcRQb76dyF4C+GtIH0rIs+gAnupxaqlgtN2f/6Q027zVq/xe2S9iOGVly/i0
         PLLNVYb+YdffPw9FhfIsLEkrmqHP2hupsa7/gij/tW0MyAt4+mnBo3Sw+0/y4unn/f2Z
         LGQ7QA1APG/GHmfTOrQCpPC/nBo6HN9F404c59SCYnfqanQ3AAY+yR+u50fGH9ZYtjM8
         5TMq4/pmI8zMgt2RebAIMThYiHBGkQWsyI78gcBAS7yKPGtar38x8CVmleWTKLkcVIUf
         wipw==
X-Forwarded-Encrypted: i=1; AJvYcCWA0CGETgYuXUckde5PnbD5FgQIMhL7LwIEQyAo4qNPaLcGUhxZ+EBM0hlqwQkOH1jD2aLqyLNX438Za7zPyYi/3hAudsxC2Jx1dQ0=
X-Gm-Message-State: AOJu0YyRvKKOwIeWmoVVv6PUqoqOeLu8tx0Wwb7sN9nHg5xRpdsk9Hyo
	K6fdVwzHHX7TtDAdQSU4yAZmxiChAdDglqWuZeduHUmGhaPx7mYxrcV0P/DBqQ==
X-Google-Smtp-Source: AGHT+IEtWx0eoRVoFdevZ/nRdWdFaxRcLnJtYSotL1tOFfcl9+IduEB3z+vqBMxsRfsA3KooyjzTCQ==
X-Received: by 2002:a05:6a20:d805:b0:19a:43b9:d460 with SMTP id iv5-20020a056a20d80500b0019a43b9d460mr984209pzb.62.1708663897513;
        Thu, 22 Feb 2024 20:51:37 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a928500b0029967638141sm382718pjo.37.2024.02.22.20.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:51:37 -0800 (PST)
Date: Fri, 23 Feb 2024 13:51:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] mm: unify default compressor algorithm for zram/zswap
Message-ID: <20240223045132.GL11472@google.com>
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>

On (24/02/23 11:55), Kefeng Wang wrote:
> 
> Both zram and zswap are used to reduce memory usage by compressing cold
> page, a default compressor algorithm is selected from kinds of compressor
> algorithm as the default one from very similar Kconfig, also both of
> them could change the algorithm by sysfs interfaces, so unify the
> default compressor algorithm to cleanup the default algorithm chosen.
> 
> Kefeng Wang (5):
>   zram: zcomp: remove zcomp_set_max_streams() declaration

I'm afraid this (1/5) is the only patch in the series that we can land.

The rest of the series doesn't look beneficial nor correct.  Sorry.

>   zram: make zram depends on SWAP
>   zram: support deflate compressor
>   mm: zswap: default to lzo-rle instead of lzo
>   mm: unify default compressor algorithm for zswap and zram
