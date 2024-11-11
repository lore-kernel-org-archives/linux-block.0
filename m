Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474E146A6B
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317217; cv=none; b=TBG0mp6s+5TDarqkVIP9b28FiMRVBTTOiZwBjKTkKF/n8s6ULXRW2bZaXFScNrAzBwSmg6pLfsCJvQ3B0qUiBMM2GBbjWdSUJwE4Np/grfPNTHTHgq+vIiqTdSN8LjFJh8DzQFnDdmUyihDDXVDkZ8mB0K06p7OiEqBvKkRinC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317217; c=relaxed/simple;
	bh=mgnfN2q0S7QgoKKl/Rauu5sGyAO9tc59zopJz1rrAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qphimCOg4M1JGEIubr4QZhYi0m0dF6YIDzC/xtuQBKLtaOOFMdaLHN678OocBE209R1JSETY8G6Uy5XFIi0Ugh5EIZyL2r/kry6dTMyUX7DwOZOucdrj+nOg0jFGFKp7MiLCe2OH+haWgNAZEq7UlgP66J0EBdpZ/nSort3xmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X0a6FEtj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X0a6FEtj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eae96e6624so2874412a12.2
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731317215; x=1731922015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brECuhaURidIOgej2HcdOUsYknBD6I4Lcs1/D1CO8rs=;
        b=X0a6FEtjcQ2FpXrujEcQAoffCiUlhwkIw6utF+m0UGWyzrfNPlyjtkUo4DVqGCPReq
         gvryHQ6TnFrmG9i/URxIUK3A67dnhsnQaJyEIQRjnG94/ivqimQAVMmWgNK92foC/yx+
         wnpOxl21X7ZAQVktl6j4txAYbWtLdtI7f1S1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317215; x=1731922015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brECuhaURidIOgej2HcdOUsYknBD6I4Lcs1/D1CO8rs=;
        b=qKGiX7P0crMFMvTULMzvkrYYCRA2av61P45/UNjgcRTF+RyKnZp/2xVK8L74uSY/b8
         /hpo5Dm0XAuT/pVwb/YxiX+PHAILmCzfKyLNmBhbBsGKHjGzXqEQ+m5+OtjQvfRtn9PQ
         RAWYrpNqYYlxMLutsnLZfZ3+rSbOmdFYf+/Yr37roU4uM6+WCSJpIT4ETbTdyuK3qrrR
         rDgQo8BN6kQ5/4Ok7c6nKc2bBaQ3c1RUAzeVgl1bF1jOGxleDHm3OwTWCkjRDGEpi/8B
         LNWY9rtDRQ6kpzqE8tzIhsGFU1eyM6y8xS6mirMjvv6Mjse+0fPULnMOh6QiVMzBQC3M
         yLPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQjCmAxPl6EiBs7uMBDqgZ+UwMQF0CAbiTTRbEV3Pe//iYGI5NKtXoh3l4VlJcjmO8U9V6cAp+UazX4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoGc/MA7ag1uzLbApQJevx48rcY1JD+kbqBCx5QyQo4k0uEqI
	e4Zuso8ai5yFOrVluZ9kuHPeapLIEUNvO1R9Rx/7ZHR4a0IF7ePq32kQPm8aLA==
X-Google-Smtp-Source: AGHT+IFv3/Z9/+3X9loXLTyXmodu1y1jPdWhOQT6PyEwQSEN4yeKKN8edDW3dCWplxOZylQnJGuxzA==
X-Received: by 2002:a05:6a21:32a1:b0:1db:f087:5b1d with SMTP id adf61e73a8af0-1dc22b94a7cmr16452244637.37.1731317214962;
        Mon, 11 Nov 2024 01:26:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a43c:b34:8b29:4f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a42sm8662311b3a.17.2024.11.11.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:26:54 -0800 (PST)
Date: Mon, 11 Nov 2024 18:26:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: ZRAM_DEF_COMP should depend on ZRAM
Message-ID: <20241111092650.GB1458936@google.com>
References: <64e05bad68a9bd5cc322efd114a04d25de525940.1730807319.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e05bad68a9bd5cc322efd114a04d25de525940.1730807319.git.geert@linux-m68k.org>


Sorry for the delay


On (24/11/05 12:50), Geert Uytterhoeven wrote:
> When Compressed RAM block device support is disabled, the
> CONFIG_ZRAM_DEF_COMP symbol still ends up in the generated config file:
> 
>     CONFIG_ZRAM_DEF_COMP="unset-value"
> 
> While this causes no real harm, avoid polluting the config file by
> adding a dependency on ZRAM.
> 
> Fixes: 917a59e81c342f47 ("zram: introduce custom comp backends API")

Sort of feels like it might be 3d711a382735d that introduced
it first, but I'm okay with Fixes 917a59e81c342f47

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
