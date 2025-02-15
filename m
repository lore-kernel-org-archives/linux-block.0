Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E74191F75;
	Sat, 15 Feb 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739620308; cv=none; b=DpKLP7oH/2S+cXg2wx1K4KDxzC1KESJEka28PFJADwHveeuwMqEU8WL/BitVN+J5f7hEKsfqgr1R0hd1ex8wK6Y3URGanyZA7/MT9qYG+FNJzJaSxifLpA5mMyx8jocrVu5Q5P8uHg8945qgREzkjqjnp0oVGjL6ZSQG+kvA088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739620308; c=relaxed/simple;
	bh=ODBV7XxULaEKMbWW5H2hCBCAUiFq5HPbBkqQ992RLs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAcWrJECVRe2fEWBunTaP3IwIN4Rb0Q375w5XA8TTJgZ42wxUa5Pr4r8rIg4Tc138+y87YNgZhwWCJKEr39uLJlPPk9a7ZbjznOl4xTjWrckTYZ4h5YgvUW4r8E8sckIgdMDkuARPHN+y2ljgPuKE6o7UWswjCgQbWCPrUv9WC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZoNOGM0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZoNOGM0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso18303035e9.0;
        Sat, 15 Feb 2025 03:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739620305; x=1740225105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E8cBYvEaPMhQTBmq7LkfColA/xNBOcLLm60gFA76t0=;
        b=OZoNOGM0R4CtILKvTLFtUztQObab8k/apdQDMwmdokQKwpuSYwyCxZT6Wgb3yfiQfh
         u6uT0o/l0TJMUtPZoul4K1vB/sJJz4Uz7kV3aCeHqAWkeYzYZs2h8MWM36/oThzRM7ei
         AJKu3S0V5gqCkclg3J83xynsdkUpE98ojCuexveGfcui0gDL8XJUGTXn5UWJWXTDRTiH
         qQ/1YWcR1Oz4DjnZpf9aVTxzy6ToaMUkU9QKus5lXWcEdzOCihsxDxJpBT9Gs9BlYdt0
         +58dm4LyeBd3O8VVEmghlFz2CpH5gajZ2JEWugA2lobHcDg9tZvGQz3kTU5b94x/WAJM
         jCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739620305; x=1740225105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E8cBYvEaPMhQTBmq7LkfColA/xNBOcLLm60gFA76t0=;
        b=rQ19whl+KW4EUjokqg9H9isEq6vU0xRHhpxs8hThWym1nrdt5UECpaTurQepeRtwkg
         Snp8TJkCqmlWrxMv3NYAJMK+fmo+m2lvkW0qOfpqZvwG6NIRYLxHWtioomNQM9b3cWLi
         t5xWideYHkhU1o37TuYbEObH0wvM5EiGeUcEakcZEOY8znsoFsCfr7sjnkPE/SJOaTvQ
         cwZcyWOJfmLfv4TQi1Vl38gHIp1Ad3bQ39On4Pas8jtcwY7mhGm1CzvnmOh50mMF+mnw
         SEvPlvZXxsKbCqqREVKPhEQxDLlL6hzVxLPURrF1kebdc/JzCZdh8YiaTjoxluMX1V5K
         9Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCUgClhxrewZkfo7t3Ln8pm5Y/EefKJDwiq/1vHaBE/WjQi8kC2/Ddko6mfmzsPGyDnBZ0Ybz04AyrfSJw==@vger.kernel.org, AJvYcCXD413dRedTuDC4rxCwuVJR1jCuc1ilMaHkCrnbAQ5+nUqG8eOCqp+3fUJOoe1JwzGavWBbriOx2CBhxTBC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgb9wwIRU61PWfUI5ANc/rMlHhzihYt3HeakKqQKtrE0gKDSQf
	+pMVzDoQTUnPL1XhK4zldjWcziGLirjB8vJh0mH9oCRjQBaow3hD+w4V7Q==
X-Gm-Gg: ASbGncv62REtVGR085zaT1aupI5C3RVtZufHbmbLyQVk7kTEgEfIMZWy0MvxMTy8Aeg
	LZU8BiNCsBJ3/BlmMS9dPA17n/eySFkLCD++uwgVubqAQ2zdU0WU1IfrCnvNNVj75ImPHoeumLz
	JldEVpA2MXsjAwCxwVb94sxosLv9vV4e2o5RsDWNH9G8y7A51ZwDoH1MzohSbpqAVrG0IgxlszP
	vFPiWwzt4qWG5qiHqtj94XXNzlDyEicqlIXgZ9O/HDHS09E61eu26pymePoSvj5ownslWWcD3t+
	GmxlFlv/baUp9p/W9H3MaOAjCKGhYaB6B4b4Xtab+xt/gnnNJY20XQ==
X-Google-Smtp-Source: AGHT+IEQawC7SQVa9UF4slkO3lg86OopnWZ3aLTLVKEXgIrmgEgWz+bCG+8HW/R99D5VLCZ0Ld7EOQ==
X-Received: by 2002:a05:600c:4e8d:b0:436:488f:4f3 with SMTP id 5b1f17b1804b1-4396e70d13emr25278915e9.17.1739620305242;
        Sat, 15 Feb 2025 03:51:45 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm7124144f8f.33.2025.02.15.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:51:44 -0800 (PST)
Date: Sat, 15 Feb 2025 11:51:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/merge: remove unnecessary min() with UINT_MAX
Message-ID: <20250215115144.6a10dad8@pumpkin>
In-Reply-To: <20250214193637.234702-1-csander@purestorage.com>
References: <20250214193637.234702-1-csander@purestorage.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 12:36:36 -0700
Caleb Sander Mateos <csander@purestorage.com> wrote:

> In bvec_split_segs(), max_bytes is an unsigned, so it must be less than
> or equal to UINT_MAX. Remove the unnecessary min().
> 
> Prior to commit 67927d220150 ("block/merge: count bytes instead of
> sectors"), the min() was with UINT_MAX >> 9, so it did have an effect.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  block/blk-merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..39b738c0e4c9 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -268,11 +268,11 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
>   */
>  static bool bvec_split_segs(const struct queue_limits *lim,
>  		const struct bio_vec *bv, unsigned *nsegs, unsigned *bytes,
>  		unsigned max_segs, unsigned max_bytes)
>  {
> -	unsigned max_len = min(max_bytes, UINT_MAX) - *bytes;
> +	unsigned max_len = max_bytes - *bytes;

More interestingly, what stops *bytes being larger than max_bytes?

	David

>  	unsigned len = min(bv->bv_len, max_len);
>  	unsigned total_len = 0;
>  	unsigned seg_size = 0;
>  
>  	while (len && *nsegs < max_segs) {

