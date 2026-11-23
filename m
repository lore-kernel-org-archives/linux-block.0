Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403688;
	b=ofqGsUOKRpve+XxAjJeddMlgNParnjELMNxLc9NxlQoAK2jwRi7aqFDP/wnZ03lWu+xj
	 ErKDhEkBloZwShbR71LQbeKwz0xVgJdek5sHxi7Ft9eqvHKaqHJqmQcZi65HafztjJb50
	 HomOpYjPZb3DW0hFl+cp2pBLHxhLCIJKhe9KR60FeDfpv3dPk1731cRfMaKFPdPUpzEjY
	 FDnCpNXoQxN9KaZchmH1okBvznBozHQSEqPMQ6hch7fm6WSmzBoJwSQ0oyxOQEmwlxCDO
	 Hw8LooV1LBj2PzzpkUgk2Ul15FUDWJnvkg6Nmhb0Gq21EsuM59jSFVMjHPIZ/Qrifow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WmgsHFkL+h5rhuDAcwccXtAUWFqNQ8ooJCVW/O2Ov/8=;
	b=S1Ho/EaY6YE8qk9a7rTa9o6dLT3Yz8Rx39sF2ZBd5ZLoIxdImNajx/WmDnlVCQhiazM3
	 M1mKsdeWco1YIfkAjThDrRQzQjtMHN8cDZ5VlxPa/S+NWsfqp7OnECD3NcL4qTISfCuLA
	 3NT9hG8tlOeShL1f1VfRFJfGYC8yyD2TMWMU5ewiJVUbtr2JxOTlyMWTlq+BjrOH/t7AK
	 ZsMgCz9MadzCX5+yPAfQh+TdtlWcbOhurLNqbIoi7m0RTdY+Jz+2JbeXUcCYDj/vp2ypj
	 xSc1wEWz98OolZPU5bt9tx4cElxgSh5/AODLaUvhvvbBsqTp6USlP0hroFGv0P8ejzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WnOdVWyh;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2251606A320
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 03:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2251606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WnOdVWyh
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2575217a12.0
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 19:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795403687; x=1796008487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WmgsHFkL+h5rhuDAcwccXtAUWFqNQ8ooJCVW/O2Ov/8=;
        b=WnOdVWyhp1gkrfxHlEH2PWk6G9rSeBv/1eaEH1icWinqo2eKIbt3k0B0RAy2laNiyi
         h/WJEVTljgFwB7AWcEDVl1eb7BulHCnbBlw/QJjV4nW18uOPOpAz6Zcb6u1J002+staA
         2tldpYvcKVYtztHhnZQYO6iNSYVkPf+sTDiCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795403687; x=1796008487;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmgsHFkL+h5rhuDAcwccXtAUWFqNQ8ooJCVW/O2Ov/8=;
        b=vMV//Ej1At8WjeRQdhe1ZvmlF5qafVBGPdou8E5h0dUA8mrwrqdP9kaYlk+aMghq47
         48wF6CgAO804REl4GKwJQyL5ZjoKZqkoTT1xVa/zCCOoFVGT3r8I6fj68qPsAbiHT0VL
         44R9r75++utRptJOxfGbrMQXqANWKpqdQD+c/mWRk1R18l3c9+eCiD0fa8LTgj7Nt1uV
         bIuNYFT7Vno2ChpSA7wZkeB1KDbuUv8VXeW7HKlwpkyhiqDlOwIoMr8AYTjXCT/C9eLu
         f6tHi11h4tnSHICb6efIMCSLt88bPBq80qhDFeaZ2Yxk6d44L8Zg78syybYFRPH4iaXW
         4RwQ==
X-Forwarded-Encrypted: i=1; AL+hErFUI9Jm1EhRS0a0H8JS1+bsL4Rdfk+Odn6lPZVJ4Jb6FY8K0IbiF51AKHl216Y+/YwKHTi0vLKTQokw5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9KKYvW6nBV/BqpW+as/j0THGAgsHrwp5rG1cfV2HV7zrTJ65l2
	q9uuWfp34zAMlzyeJEuHql08YOqS2oErd1t95eVrG4Cc0VeycY6yVvVSSwwd0LEKgg==
X-Gm-Gg: AZFdTZd0rUoYbryCjpJeSrLWn11Ny5UwjDFy2X8MOT29e1m4IyNRWPV5J80HXPJdjFG
	v/Ab2TbEKGfbVFtS/3lTPJeJoKQ+Z7Hl3Kl635oSmY92nALsiQ/Py29WuxCAF9N7V1QuKRL9zjS
	3KXVBaj6Rs+ZWVdWS8eIFKtOP78eoXoIUDwlnom2LVv+hCWvdJefR807qXt70M/yfVegd2PAamp
	y6rNlxzkjVMGvGyyVpyY+VcJi+GKSwaCX+yVBv7vN1aLuNwGIPgHz3l69eBNY8gVIRVypxXJhRv
	qKMIz15yDQd9ETM66E1fCS9KOSZr4nXA/S1dVCktjk6Eer5RE6tGeuE7KaXOZgi0kg2Q2mY9Xso
	lBjejuxQmy8BGBBb5Ge9fbjBdPMJ6wu5r46iy3QtrsIGWQ+7b5C2C5iodXd7nLAsmGX6uxNIHEz
	1RJ4wJQfTIuJg9lzAH/r1cjx6Oh0M7ZmU7WYEIXNK/Stn9xV/RdZ4fZh/jAqFRKKGheX9oqGp2D
	XsAwN9Mr9bVgF4BHbbGaE/CHmQUm/27uzDpTEUeYnoYabbzr600Tk61cbLHaGME5OKMbebdUbGi
	juiuWlC47U+9/lEpCoHjMr+uYnddMF1USOZMt04+FG4C0RVgIJTuzaTSLDgRvjXTq+KSYg==
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b41c8d5a52mr9034938a91.17.1795403687341;
        Sun, 22 Nov 2026 19:14:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm16010576a91.1.2026.11.22.19.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:14:46 -0800 (PST)
Date: Mon, 23 Nov 2026 12:14:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, 
	Hongfeng Chen <hongfengchen@xiaomi.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] zsmalloc: free a zspage's pages in one batch
Message-ID: <awOvXnBW_QWGigkX@google.com>
References: <5666c1c8c04998784c81fc8fe751e35aa40af578.1795403342.git.senozhatsky@chromium.org>
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
In-Reply-To: <5666c1c8c04998784c81fc8fe751e35aa40af578.1795403342.git.senozhatsky@chromium.org>

On (26/11/23 12:10), Sergey Senozhatsky wrote:
> [...]  The batch lives in its own noinline
> function, which also keeps.

Oh, the "which also keeps" part is a lefover from a previous version of the
patch.
