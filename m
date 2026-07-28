Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C627A477
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202036; cv=none; b=JpigH2AS6M/15MJLK1zeIKgIDkIPiMUuiRp4GtabTYBB3S+KqcP+tGeWKe6NlTPOCWyhnWlqrUhWcBX5tChsAohYk2vR6GaomS+iy0prprddIXVxOgDQXHsYEdYJeXXjyaNaHAHC3h/hKUPVdNf0t0uVcpDs+ZNU3ZDrPdGH6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202036; c=relaxed/simple;
	bh=UIbZciPovUm2FwY/oWf6dRvFtb600ENTKS8OxWCoDaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJRr4VbBU7sx1LE9yFzHFEOHhwz0DIEw3lH8W4XDhWnQiD3VmfSZjjCm+m8q+cnoAzwIRISXhijLhskQJZzMtZ+uDx8LKmleQe0sqQnVJ28EyvoOEDSzlzK2ykXphURV2yyJuMPtL9GFDqb61Zpw4nNxM4MZLdMtzR8H80WZoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QqoVBLAM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QqoVBLAM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381b831d535so4133323a91.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785202034; x=1785806834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XzAhvapxVF1tYjqtCmxxMQq36wIjX9fnlT/lFh0XZW0=;
        b=QqoVBLAME7tgqMKptMdgpuc7yrbhy11O1pOllLY/LR9kZL/gOqHwnP+WtrA8CuWFmv
         IuYwENTI5yNJ+X8Q2Tg+LblyUz9/0SH/HOU5nddISksdQfE6rCzTZ4fRA52vhxSZqmDw
         nMoCmfIgEdS/cRj2Ok+zBzNr9q20+Ibew6mrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202034; x=1785806834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzAhvapxVF1tYjqtCmxxMQq36wIjX9fnlT/lFh0XZW0=;
        b=l56npIGWSbecI2VjqmZKxGJsqiGIJH+ATwYp9+HylxwLTU0fUvIZgqEjcYjAW6NnHP
         czZYTad9t0mOl3pnWDxN1LywCrT4JGXObg2QKZ5yWYCje50HVvKrOW0T6drqoF+P8GFR
         juN1Uj+/+SAR6i0zrUXVQJWtE391NUBO6yvLNIHGjk2Ze7xWHEdsL6DHh2+lCXcJvZaD
         R+xVjKjggL5kmjFOpVZktQ0yUJysC5czSVBcZzkciACS7twYscA9Wbb3uIxkaDuAeTO5
         +NWSA13lHbcVmacIRZ7y/FKlL8/98JI39ipu8bnTgO1oraBOS7BO9Bg6Nk9PJUMNeGub
         6MFA==
X-Forwarded-Encrypted: i=1; AHgh+RoTkfUX/YLaqNw7W1PhYcuB9utT2zw5po9kJKCM72rR179RWLCLrEZjSZv/pIbWadU3qo00IaQji7r3yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vzassuWtoUdOcCuoTYtHuZ7pv0Q/oOdWiPGlObutfWG4AU2r
	QzDrTpfTbutLpk+VcTyP1yJbNz2uRZx+RnmZF7OiKcBEvegj6LsqZ9nChgxC/5ykXg==
X-Gm-Gg: AR+sD10uhuTabQTTFfelq7P2f6c7nCyOuPHOfsWsABBJPb2kf171+yONomiP1tTmgcL
	HJaexX7GG+s0rHc/obTmnPB5W2Yx/ZwVLbw/pmEx4qoarq2s8FoT7auGS151bG6cjfoDiumFZe5
	J23wD9aSK82aDG6oO4j483eL2O8+21+MJ2M6BtF+DPWOpum14OOWpqCFUEMXJoED7bNjTd2kGhv
	uInLlbZRfpWtQaH7kvBbi3QjtUHfOm0HK+BFmu4kAZf2v2x18tCQhmQgwhHvZE7UGwDb/KG/GCh
	X47b1cxVAIXdnQvDtB3YNHseluJQzY9PsGc5pIHrM27+2YlCQlZcaqw7a6IaChCEIVS1JIaxrS1
	TxGsiMJDWu26pjRv+gscTSpicn9YFGj2Sk3qsX79tkCAfaHLvNVFSk9H9ds26tH8yRFvpD1R0Nc
	6FFZlwdx6V3Xp3/kocHrW155ld4OFnJTMSiG88Fcp/Qw==
X-Received: by 2002:a17:90b:3a8d:b0:38e:6c37:d95a with SMTP id 98e67ed59e1d1-38f6a445e64mr273457a91.19.1785202034479;
        Mon, 27 Jul 2026 18:27:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f891:e0e8:e2c3:fb20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f1a759228sm2742180a91.1.2026.07.27.18.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:27:13 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:27:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
Message-ID: <amgE5z5QEYa5258-@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627070216.13511-2-haoqinhuang7@gmail.com>

On (26/06/27 15:02), Haoqin Huang wrote:
[..]

> diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> index e295d4125dde..f4b26844e53a 100644
> --- a/include/linux/zstd_lib.h
> +++ b/include/linux/zstd_lib.h
> @@ -1241,6 +1241,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
>  #define ZSTD_SEARCHLOG_MIN        1
>  #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other strategies are limited to 6 */
>  #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster strategies are limited to 4 */
> +#define ZSTD_MAX_CLEVEL		22
>  #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
>  #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constant to an unsigned results in a tautological test */
>  #define ZSTD_STRATEGY_MIN        ZSTD_fast
> diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
> index 6ab8be6532ef..db3b275b502e 100644
> --- a/lib/zstd/compress/clevels.h
> +++ b/lib/zstd/compress/clevels.h
> @@ -17,7 +17,6 @@
>  
>  /*-=====  Pre-defined compression levels  =====-*/
>  
> -#define ZSTD_MAX_CLEVEL     22
>  
>  __attribute__((__unused__))

I think the zstd part wants to be a separate patch as well.
