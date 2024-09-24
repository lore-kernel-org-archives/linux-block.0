Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B540BF2
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156517; cv=none; b=ivk5TT98PiK4Tu47N8kiQEd4V0/xVMIiXWxjJtFStAU2o90bcBesxv16yulOKwWHKVYf6jCOiFaI36dp5lkOgO15xLlXrkH8+MO9HeOmmLcvHVnlJE3jUG5gnyKo1v8yOaFIbMKcQxob4uxSSB9fgeIxB0l7+myMWo+UQjV0hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156517; c=relaxed/simple;
	bh=jH6sv8FNLFl/Kif28e2IwbxyIC15AJwFwxX0qKHVeUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMCdowN58N53k6lFobL0wf7QABFgHIX5kPdjHIBK0PRaXnTo+HhCsOqivygKegXwq879XUPOWsWaCmwAIjTrwqmhR9qgm9LiwOftAk8DBPuPAGHeJL7z9Q0WHN1E3BD8Z7qgXgddomv6I8REGm2NBfqb9oVsvS9IPppA677fM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HewoBtYU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HewoBtYU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3650691b3a.3
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727156516; x=1727761316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=HewoBtYUFcwrDJxS/LiYKia4PdxpxNFPuST4Jd7FT8su7mdpEkHebJPWVow345IjLX
         SC19yurgWbb/Vtl6/kNTDclLo826TtFg+THGLxZuNwD1/kPIXKlyi11K1mZEFIe4oIPh
         WxXGuOwc6n5fSErJnkVE+381ZWQYOWA6vsmOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156516; x=1727761316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=JLRZziXfkzf3vRXtXFQI8PjjbNXmgOEUCrNgAYSL5rI3YWI8xhSWE5X/tXY+kKU3IP
         EJe0G5LQKmhE52zfB8nq+3HOXSeGdobJr9u7xuVSQkxEu0dkYPip9Dz8+feAymgGrlFL
         YyVqI5azueshImw6njpQpFWxyf+DiIGuRdk/11ZXKTGbYFJwnHv+gzVOxOvTxBnc+38V
         UrPYAydYLWy7w8avGjvOrrNm7sr/yOwd43X9C858fE3g+qwWeT+h6y0CA7FATxGs6dBb
         05x8VKCEShYHRKLNAgVxbJaDXP25T0BovBbbUIn9ljie62adhHtJNfMx1aTQeCO0h9xd
         qQLw==
X-Forwarded-Encrypted: i=1; AJvYcCVNC8cSzl1eXnSp77LUKvvPbLHIHW4YWydhLtayZEyanW2w/IGRYvBI75t5oKFwTk3N8+37l0ot7u16qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcw04mmPxcVsgIxXUu8HVYzDLSUg+VmHlOy5EzVaJNxH/LMyd
	XerTvgQ50mEz7Ht0Zx61ofE77DFgSLP5YfTKtpWOM0bCz9Qixzf7yrzF036ULA==
X-Google-Smtp-Source: AGHT+IG1lZisxJAgOWdpQ4rLYMltGE4fxYOV29zGec732JAMjhEQW5CudTcv6H4bnb03Tqzw7xN0QQ==
X-Received: by 2002:a05:6a21:168e:b0:1ce:e725:1723 with SMTP id adf61e73a8af0-1d30a9d8901mr19524958637.45.1727156515684;
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058ee6110sm590246a91.8.2024.09.23.22.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:41:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924054151.GL38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>

On (24/09/24 07:21), Christophe JAILLET wrote:
> > > Hi,
> > > 
> > > maybe kfree_const() to be more future proof and less verbose?
> > 
> > kfree_const() will not work if zram is built as a module. It works
> > only for .rodata for kernel image. [1]
> > 
> > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > 
> 
> If so, then it is likely that it is not correctly used elsewhere.

Oh, apparently there are drivers that use it...

So I suspect it works when you do

	kstrdup_const()
	kfree_const()

// I only looked at drivers/firmware/arm_scmi/bus.c

kstrdup_const() can't tell module's .rodata so it does plain
kstrdup() and then kfree_const() (for the same reason) does
plain kfree().

But calling kfree_const() on something that has not been
kstrdup_const() is unlikely to work as intended for modules.

So I guess kfree_const() works only when paired with kstrdup_const().
