Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4EB30674E
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294204; cv=none; b=rUuQuVjaoLYt7AHDVQzk0GZ/zu0dQzpsQgj0LYspB6KCcTDXkvJiKjd3daVtYpZWO2QMRP8/KdeC/5Abl1J9nQbiBH2yNpN7Q8jpdf6y8H826eeDjTuxrmalhzEgRmXDfD+EHOmsZXijadblLnqG2dgQSD6/EeemWnGYYPH6Xf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294204; c=relaxed/simple;
	bh=4nckOf4RNI2ajxxc3uP8dvMNmhptpKaplhjkfb33GxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE7s7Cb3Mah2rmjYXfqR2bA7nWkGmAhuXw0nkc1AEbfJIuL0JJE4YjgfJoUAqR6j/iPDDxD4djAMmYCZN/ZKmhw1XcXL7rTk8KiWVd38Pq5d+axuJis8+D49PJ+wY8VtHEBYR4UtINerP43c4hjrGndNyvQ5XNQ/IyHqxxElHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TPm6dtZm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TPm6dtZm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so498564b3a.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785294203; x=1785899003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uq6noV/oW5JGEATDVNzmnWeKswxAlbs+zKFWfUv2e7k=;
        b=TPm6dtZmZn3+OXKqfSrfv+RqkZcRYJskoRXGhjDqeVDGcn+cXqy6SGGbR9Uwe6DKTf
         aGAQ1LdHM+mLBDOm47xlcUI/gdAHWoSm3vSbWsiWrkGpLGXdX7Ku6gP9V/fjXzv3nrlX
         M7XoIiDBHEDxP6Isju/rjnnXxzCYjduERAGT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294203; x=1785899003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uq6noV/oW5JGEATDVNzmnWeKswxAlbs+zKFWfUv2e7k=;
        b=fzuBKXZw5VaJXkpgVVF8f7MyVVansFhC1IdBB36o8evMTB3B3nex3hxVmQ2W5Mu3U4
         p3TkOE6MadetAamtiMVTF3ne+yFtgX4TeJDidAcheXDKvlIilXPd+7YX7cZpdh5opmhE
         OMcj4Kraqq/sADgKA+/xY9kl+/FAI0oUyDC9iby4BlEbwJ2/k1EF7XaiWto3jHLiev9W
         C7IazuS2E5nKr4rB9792/I6Egxz5TBGBYee86vxf2FPHf9KRQuzlsKm+Dp1Ylq8pIHQF
         qt0XPAmteXKt816VQd+6CeiXKB6NPiHcf+wr0HB4lVQXTBUt2v030xnxW6TqKtbnSzrA
         GGbA==
X-Forwarded-Encrypted: i=1; AHgh+RqWANxH7fP16r49AKvES8w1qJyyF9yxpuXcvBdGG0tSNqqgWOLL2Mmb4Ity80o/3Mv1Mri3KYjGiuaqmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW0JPkOIBQh7bYAWRzyT3TJrVPJoq+GuYbzFzHSs+fgB2+uFd
	1PyYKIpZCH+NLSpPNswIgNrY0E3eDvvZRTPBUxXzHlyxa+T6bsxRZgtmtIC3jYoNlw==
X-Gm-Gg: AR+sD13eNc8djXuXEX//BO5wxxgSsLiUoH50obAl48djdC9o/zCtv3Rt/RhOKu29bLh
	pnk0vUwrkNlONrGf0NMudzJ9Bjh/DMlmiqK2PEhp5SKu/VyeRk69ICcZWBRY8jtjmCh4lSNQAEF
	sO+LIRIb656cDyO/T7WSzqXRe98SojGcmMraQk7/ekcXQsGT/giMrnQNiOHyLgTVB8bjgBVPUEj
	p2yOMSahLg7JeSbXtO9iC7Hmr50kfoTYkbW3UMvfXQpoqJGbSd3QWQrWS/QCvbbHhOeiiZlN8cr
	djuUck/enfBfmA5cb80CexFD2yZvyozUogI5t4BexWYD/kdHHW4DlEEksiCNTw0oPcr6VZY0BjF
	zByuad+sz1EqSR11LgNDxJDlL519Mbmo8198f9QU+4hZ5cEqdVfoQpMzV02+7UtykEzpOGNn5Dv
	uG2FHWoGR7wDvzu/AkDKT8SR6WEjhIrcX9+adR+KTePKQ5PuhhuLIdu/KT9lS5OMEw8lopUwuzr
	vOucd2ygHhqwS4GFryZEP14Bb1m
X-Received: by 2002:a05:6a00:3e24:b0:84e:9257:d0bc with SMTP id d2e1a72fcca58-84e9337e974mr5357538b3a.76.1785294202945;
        Tue, 28 Jul 2026 20:03:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa4d4sm637476b3a.38.2026.07.28.20.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:03:22 -0700 (PDT)
Date: Wed, 29 Jul 2026 12:03:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
Message-ID: <amltU9PgLGZYCD-1@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-3-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092935.31139-3-haoqinhuang7@gmail.com>

On (26/07/28 17:29), Haoqin Huang wrote:
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
> index 6ab8be6532ef..06565e064456 100644
> --- a/lib/zstd/compress/clevels.h
> +++ b/lib/zstd/compress/clevels.h
> @@ -17,8 +17,6 @@
>  
>  /*-=====  Pre-defined compression levels  =====-*/
>  
> -#define ZSTD_MAX_CLEVEL     22
> -
>  __attribute__((__unused__))

Sashiko made a good point.  Can we use zstd_max_clevel() instead?
