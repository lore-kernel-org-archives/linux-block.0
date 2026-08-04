Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD5330B0B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822532; cv=none; b=OSQkqL6P17BXG7bECP77JlTKF5VeHzONHTs42jOg3Y6LnvPRrzlWMJJEe/cOpGaQjdHUIX2A4OA5ebHXKkf/TQRsc/iuDbd2s9RQ+k2vLYHM0HaPXu/4NUqldbST2sNYZr88wskdkLTWL1bUH8TOB/rAry6mUsxAnkgM2eWbsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822532; c=relaxed/simple;
	bh=sxFoyKksCsg3HT1PlhW8h6Lfy/Q/jixcDgP0/OOYbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkcfZP8eWkbeGft1XmnePFVOcg0TbItiW7kIWQVc4zHQyyNA54C5k2Ou414VR2PG52igNPigEFtDtrnPc2aZQsttuTH9PYC2EoY4cC0emcePTtqZemd2FgYXklwWqrktTum8biBe8bPaCo9/bYu1rKyWp9GSKMnR2nB/5uOxr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CzSSG5ya; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzSSG5ya"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso644553a91.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785822531; x=1786427331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cKx66oI5obDqMQbX+S9eMb08Q3adMK8gfdU4AgEOKOQ=;
        b=CzSSG5yamTM053ltu9h4NCb0xGXBXOVBbR61yrT4uYNyjRtQfoSka4MVenTcafa6xf
         k8yEkWRrz/+zBbZQuR+ed5ncyCa1OsnOXGnb1AaDUIuWlDP5fpHoTcfjpslfidETEP6b
         Nx+rMshpnFMm5xowYSNDk3bAji0W9hZaJxX3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822531; x=1786427331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKx66oI5obDqMQbX+S9eMb08Q3adMK8gfdU4AgEOKOQ=;
        b=fQFdyIn9B2HUBdIo+fdvSZ1B1X1GOkUvHSOUELsyV7lbigfpsLkhb0RTwoGQY34K9n
         spdRZ4gMI1pnAJUhlzsFAIeKVumU0WOQAAOHHEWp7pmSOhgpoVAnzD+2rTMeEhrAGSA9
         eCRItmGsdBIb9kUEz4qS/hfFQR0ScqyMdkSCtLZ8Aidj1UWT/FX1Y1wimsFEaRFVjHnT
         mEDCrgmvCzZRC9ta4FRDrp/q5FsRhvUxtGN8Za/7c6gci0sYlXyWcMIXtw0byyq38lDC
         61EQE96H1kf2SllcIGS56rvvx+oSoOfNxSaem4unsWsgKYdwKRwbKR2HoXdntOIFfkxz
         JuHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBejakxdsQb50fyhTO9O74r/4pgg2pkjKlAvBF82PU9IwgkXfFHU8lTYlMEsvsN6YnJJvWbOYmQS+djw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygrXqmRNXpO0jX3WKz6KvQ1SUSQJ5NOw/5TkUFxl6UFClzs5j6
	rFg/MEYNSZwFESmcEfC6Nchpt5ODyivIBUYNGpBjQT+mPlWOaky3ka83OpkfYDjeoYRVwqRI0FT
	53OU=
X-Gm-Gg: AR+sD13SERehibzy+ialuXKhdPuVM4Oe1sQ23QSLzkWlMqbOtmY+9789CLgwJF7Laom
	5u7nWCEZ18XoWL9AuQo8XgtgVVXemkiVy21KaKIQWWsJkt52Fo+4D+gxQbmKdiC798esL/0G90N
	DVEDImgbQ8BYcCZfXdM8VCB7OBAYRAWfxrSsWlk7kzRmnK8hEgzPEcmLrkmoGFaGvF1M64nZM8r
	oLrSh7WyNgonw/0Mdi5W9UT0lm22RN1N8TnHuaDB1zqLQvYCtRQ5JYMWScjQy3hwkDzHkS2DXCQ
	xKqE8MIujf7B1lS1aETM3IMzsNcGl2VfojcGsk0i9xXY2cuLwZqgnEORFmW43eYTXbQLVkqyCA9
	lElb4GlehJKlTDPDKc61cRfROxq0yNBrXk9jB0ToG+NmE3l3cqYyFLuB37m3AFxz7gOuEMfhp7J
	3wp3Pv1Sc1MPm+AfqBm+/wpeMalamrbQ8NHagB+uU64CuWFpjqRb4D7Y7Ve/4Hv+CGMD0CEhkii
	uAANiuYkSFMFZKEzo3+2PuyrFv3
X-Received: by 2002:a17:90b:4a4d:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-38febfcab02mr1689590a91.1.1785822530693;
        Mon, 03 Aug 2026 22:48:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fcb5:533d:198b:8d48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm710924a91.14.2026.08.03.22.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:48:50 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:48:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anF8tcbifysw7v9_@google.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-4-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803141256.60599-4-haoqinhuang7@gmail.com>

On (26/08/03 22:12), Haoqin Huang wrote:
[..]
>  static int setup_params_842(struct zcomp_params *params)
>  {
> +	if (params->dict_sz) {
> +		pr_err("842: dictionary is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	if (params->level != ZCOMP_PARAM_NOT_SET) {
> +		pr_err("842: compression level is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
>  	return 0;
>  }
[..]
>  static int deflate_setup_params(struct zcomp_params *params)
>  {
> +	if (params->dict_sz) {
> +		pr_err("deflate: dictionary is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = Z_DEFAULT_COMPRESSION;
> +	else if (params->level < Z_DEFAULT_COMPRESSION ||
> +		 params->level > Z_BEST_COMPRESSION) {
> +		pr_err("deflate: invalid compression level %d\n", params->level);
> +		return -EINVAL;
> +	}

This is purely optional, if you add per-backend pr_fmt() with backend
name e.g. "zstd:","lz4:" and so on (in a separate patch) then you don't
need to explicitly prefix every pr_err().
