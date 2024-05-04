Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54528FD
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714802537; cv=none; b=Lt50S231vU9o9C8k1NBGx6sZxHhpj3c5RVr/u+EUz9L8/TOD63lMiwSH2e2UKTUpiRi6ZAdFXBi5pil3gzpv9hmO0Ykg5u/WbXAT98MzUDmuiBHXZ8wBmiY0F2+Noeod87HRo5gpzjLV++854Cp5bIRsDvwTCufTw3JGOYuuMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714802537; c=relaxed/simple;
	bh=QNxdE8XEnHl6uXZt8I1uundZI1OzA1eNbsJ07NtLMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9ZhMMSutYNLuV8uGS1pCodl1ghvid619qo8SP3PL0Ctm7rfbyohzLjrpPdin9qBTzag0oToTfQiRRKEM+nCLUsnLcfm4QWqCng9S/WQ7s+x9Hk//2l1OMZwT9Cwl2TYT7a9v3Hv2D282ib6Xmz4PxUjCh/8dBpz4wZToLM8rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EWuRQ51a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWuRQ51a"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44b296e02so185244b3a.2
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714802536; x=1715407336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRvyWG41PYoYuhLyhTnYN9G8n9dRpCEoa0AKDj0Jn1g=;
        b=EWuRQ51awUZFbsXgacY4XdeoDVjexcBZ0AiO0ZG4XiKxw8X/znsMnObrCFuclS6uu4
         witwJsrzfupeALVjpbgTDRsWOTDWOgNPdnYy27GlcVoq88EJ9Ra9rDw0zr4wQlNTNd4M
         AO4IeaHxauCls9ujQB2oMx7kI8e+X9EVHtggM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714802536; x=1715407336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRvyWG41PYoYuhLyhTnYN9G8n9dRpCEoa0AKDj0Jn1g=;
        b=MkzBkwwluINWD6UtdEhRP9p2UliJLqnW9r9+d5VQcBN0BipIcuIswH06G4ofbECbCO
         /0whAExK6fLqveq3MXauXv4ypd7ZZ/44rk9JrvBP83EUAnrqWgIUb4d5GoxNAQwgU0lc
         D7G5GCy9bDyicFTrUMRKHQJl323Nx3kRXdH10R/Y8ZjPTmFKKjfasBKd38Q+g7SGQjHR
         dRP2ddsqWf/pJ/X7c255peAGiB3XZliBP93Zi4ao19lnobepSi5JAGy+/hnNwl+a+MU9
         +NzOWk4uLNG8165WobS6DDHHbj2qpIXs73dkpjS/BTiTjfgUXGGmVherKOTM3E2QbjA3
         MfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEoANsUSmkcYt/yoVOOPADoaRte7cZJwtvfevy1/vaksjyVX0wgoMT6nXAWdzJgUmDDdANm7FAc5/ieGqoW6gKdXjzPul+e6ogs5k=
X-Gm-Message-State: AOJu0YzdhCRpKmMPx0qngWHH8S4ufILrGMegCKQziIYrIjNvuyOtzI78
	E9EI1oOwyHpWW5FXAAx56fIKEUY+ys/bNhl5HDa5To409eLwaaESY+a1SNTd6w==
X-Google-Smtp-Source: AGHT+IFUO+CEFCoN7TlImHtWHusMlMi0XYn0uzySokxZVJLphayei5VRGyym00K3lQbx42uw2RsCOA==
X-Received: by 2002:a05:6a00:2316:b0:6e6:ac71:8b38 with SMTP id h22-20020a056a00231600b006e6ac718b38mr4920802pfh.22.1714802535870;
        Fri, 03 May 2024 23:02:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a616:7211:d0ce:9ad9])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b006f454a607d6sm1118488pfr.148.2024.05.03.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 23:02:15 -0700 (PDT)
Date: Sat, 4 May 2024 15:02:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] zram: add dictionary support to zstd backend
Message-ID: <20240504060211.GG14947@google.com>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
 <20240503091823.3616962-14-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503091823.3616962-14-senozhatsky@chromium.org>

On (24/05/03 18:17), Sergey Senozhatsky wrote:
> This adds support for pre-trained zstd dictionaries [1]
> Dictionary is loaded once (per-config) and then loaded to Cctx
> and Dctx by reference, so we don't allocate extra memory.
> 
> The patch is a little non-trivial, as it seems that noone
> ever attempted to use dictionaries in the linux kernel
> port of zstd.
> 
> It also uses GFP_KERNEL gfp in Cctx customAlloc(). We probably
> would want to do something about it. Either make sure that we
> always (somehow) fully setup all Cctx contexts from non-atomic
> context before we attempt to use them, come up with some sort
> of custom allocator or stop calling zcomp_compress() from atomic
> context.
> 
> [1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

JFI
I reworked this patch quite significantly in v2 of the series.
I guess I'll post it soon.
