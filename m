Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B915217A
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324417; cv=none; b=qhA6aa3Aa6IEQeUQDeE3kqGJyudbIebS8C//HhyHR1hAiSES8/IzD/Kx9/bwXs6u+ghyuCERK/+n6wKN2k58f+NcYlhdZRnLHgS3GLgS6E+beRB5zdfOOXkdxPYMsYt1pymGGc4+fOk0P24zQtxKsFLnv2VggCR19vZ37nsXXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324417; c=relaxed/simple;
	bh=fiMdTze04blYBNgjtZ9jLx68WaAxEZXlRKuAWqnbJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn0iiK3UHo5HmikoTyYC4tTmC7i4yfMILknEL4sDTFCp5/8/BAROlMZfGd0bvGkiQNQwg1zGun4K235AQtCw3UfIwJBRKlf/xLy9RHVH21AIlSOb4VBX2WY2Awv3YkhiJwquQu5GybSoujNI6DPsEDs0XnjRoR82Fj3bRGqJBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pgm0dJ0F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pgm0dJ0F"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eecc71311eso14160235ad.3
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715324416; x=1715929216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wu4CHIE3/fZBIgCCsH77G3GxxIsG3jfzOZ7W4gSAVM=;
        b=Pgm0dJ0FvBMKZpGqEH6RntlUi9SlnLr7YLc4/wH4z6V/qCHQLT6AQR/54sqM8rpZ74
         EMKe7fL3eIl94oCQoF5l6pO0NdSgdChiWctJnzzBAqgXSF2h4E45HUDJTadHC2dHjB3c
         hwmutnYDgVH9uhsiwS2kR2gIiEP3gt5BD5e2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324416; x=1715929216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wu4CHIE3/fZBIgCCsH77G3GxxIsG3jfzOZ7W4gSAVM=;
        b=fUJIVcnx16vl5PsQguB1qU8qT113l1N9/Zx5s3K+ahM2lnSyO89hw3Iq1C1QUbdOvi
         bCvXogkvKZBHtCHjeZnS+YRx7lR7zb/LFLcAX1k29doUBUhgI4lxALLV/yp0C5YvTAww
         EvELF6dlOWt1ge7ECs98UZ5G5iaW7mTHGgvzwlzuEcSD8Atvopjb0UdDVdKz76UfqzUs
         dDk62fMWbpzNaoEz/78TfQk8X0Wko4+E8djde6CLwrZSgDxcLNJ8iUIMscmsExtqrXQa
         JEN8D/RkFY/rViALME6oDN1ShHi7ZPCXjLReOuEJsnQ5a6B9330A4DgHjhxNeZR0aSvZ
         L4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUKEGjfQtQiT8Rd0rpP+7Trp7C5sl6E8hrpsLvv2q8zt05L18PRYsHjNQgQfGUwxIAPHG1uGyFLPLd3cZ0UAxZxAqQJJGxP7yd+MPk=
X-Gm-Message-State: AOJu0Yy/kPx+P6mRMx84oqdFdDVgvtQnejjJ5TIsYPurvuTiIRPP7zQj
	hUGx08kMgs7uA3mUZ4UcF7O91DfXLBvbufGlenxiFIT2MOKwdRjvMIygXDAKRA==
X-Google-Smtp-Source: AGHT+IE9VfE94edGBZOSRivuvAcBMgUK9hlc6HVQ5lofeqMc8TG8iJGC4ySvtTJmystPdlRYhmHMFw==
X-Received: by 2002:a17:903:1108:b0:1ec:53de:a51d with SMTP id d9443c01a7336-1ef440585f2mr28002415ad.69.1715324415801;
        Fri, 10 May 2024 00:00:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada410sm25189735ad.69.2024.05.10.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:00:15 -0700 (PDT)
Date: Fri, 10 May 2024 16:00:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3 03/19] zram: add lz4 compression backend support
Message-ID: <20240510070010.GA950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <20240508074223.652784-4-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508074223.652784-4-senozhatsky@chromium.org>

On (24/05/08 16:41), Sergey Senozhatsky wrote:
> +static int lz4_compress(void *ctx, const unsigned char *src,
> +			unsigned char *dst, size_t *dst_len)
> +{
> +	int ret;
> +
> +	ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len, ctx);
> +	if (!ret)
> +		return -EINVAL;
> +	*dst_len = ret;
> +	return 0;
> +}

Apparently lz4 supports compression level tunable, which is
"acceleration". I'll slightly rewrite lz4/lz4hc backends in v4.
