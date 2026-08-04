Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57672F549F
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821828; cv=none; b=PhFbROyLvJDtOha6XmQl+qoAd3ugVOCbcHUZNU5oVzCUCleZsiYBnTAYothy9Uzkgbue/42EukocoVa/0GdxbsgqOHkBbFfXCqztIxjRqdbVKRkkX9hKxOwTmm62HYGI3lXLjTWDGohDvj7cJmJbwu5ww+Y6vRk2q6J3jRaiJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821828; c=relaxed/simple;
	bh=yD3cgIiagIgqlzaUUHpVETjAxdNWdFZWkRrPnWKa1mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Nv+uOzQekCQ2V0PNBfLwDW4tb+XznviGJ5XRa7s3/Qa87w6rKd8PgRn5ddyP76x3/rDj49RoQ5EdtVySZfQ7gy9To2VhN4akkT+gjqu3HIZ9AVpdBT1TVwnwLY+6CLTpCbp4AKI5rkynrrezpA9hfllvVvu8Q4TDLSwHGpuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jM1mpY59; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jM1mpY59"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf27856f9cso41895965ad.2
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785821826; x=1786426626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1i0D2KmfuookTim9/62kIxo50WcIEe/kK0FsOm7UkM=;
        b=jM1mpY59KaPZQ7yl2oY8emNk3BSQTIG+yYKIuRZxw1PtmufivHQ40Pq8QtIn7rn6Ov
         fixPgpO0MB3/g7lNe8obKlmYpyZM0dz/OfS+7kSjS73PEIQD2vfS69S9xNGupD/XgxZx
         LmFdE2fE3mTthdK79Lgv83iZWl24e4roapT6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821826; x=1786426626;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1i0D2KmfuookTim9/62kIxo50WcIEe/kK0FsOm7UkM=;
        b=JlLLPLFjL9uMasJrlevh11Om6GCSPJWVJnOIWrROPd6VLpSJyOjmn0IAxlZHQGBZ3P
         74GQnl7M0Mg7q+h4lA66aJZufCuuzflLXZI8xmwdTcuY52stn2Hjc8UVy0wUdZSlBY7L
         FS+eh95CL4Nk2hOVBT5ACWJcokWxNkLAEcb63RIBL2+zS37eR03lVW9LEGr7BZPZQ8i8
         EV56ItBJFAOXwd/3HAoxqgG0q7Zspu2EQPeJGMd8fAcP9+pZLVd/1aGWo2Uf4JJAUbSE
         x/53EwK9FTpqJp9nOlKRGixWtSHKsYnmQrY6FIrKfKOqKfQdRV/kHX9auaTW19ugB7lM
         dO2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoXS/4iaXFqZMZZMqjFzaNSo5Y6Ers1RAlcdfO1A3fGGl6uImoCQFPpFAP2rGop9UWXEqe8/Xxf1ASDGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgh0hwoXItFuNY3GQPlmyfH616gKfvfMCbBpYRVbWpEV8q/wdN
	iqhmt35BrN3IzHGzIII3kB0+UUnIQdpLxz6Zfa/aBCaBwpPFCnK6oL5g7tewEK2eDfFhtxIr10A
	mRyo=
X-Gm-Gg: AR+sD12bOWVg5Buz9KmKDZopapVednm+dMX4fjmkFx4QLKzHK+OdgMd2xCZ0iTCgk8D
	dYycP823mjHHlPe6kmZ+W49G2vzKULxeWL0IIO8pR/bJkWbNkWmenWBHUfPftFNJi6au9Srk9mk
	SytgInsBFfqWKFpX+GUbcoUC7vG3P8WT6kz8GjRftc4sWbzcoyuiva2VbPRQ1GtU8ByWWL6JVnd
	tFLN4zz4ycui7y2yupotVo4gP1h5j/hOzJ1uOgUlej0h4OkfjvJVTU2r5RtIFbyMIk6oIN7tQL9
	UnsTQneFxyhRFNex2n3ei6j+90D6CLkyS2YE6YcdSqfut7/DIbZP9Of8yGpJKgppGRzYnD3DXx4
	3xg2p/ive8H0970C7/cC67CzNN0NgQG0C7d9Htt1jAtHhfrkQ5JonLM34/lLbJJgIBCGaTqOAa4
	8Qkomfp52lrMwQLtJ9mN5vRVsb+t97Pf7CbFguP2lVRc3u29iJ+FdepStYpsnq4bu73aft//oAY
	ykjLbKBHebfYSelFFFNThDW0aTH
X-Received: by 2002:a17:902:fd8b:b0:2cf:b68a:8b5 with SMTP id d9443c01a7336-2d05222b928mr128876165ad.14.1785821826166;
        Mon, 03 Aug 2026 22:37:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fcb5:533d:198b:8d48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1216bdsm47129115ad.69.2026.08.03.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:37:05 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:36:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anF5ZikFOgS1hp6I@google.com>
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
>  static int deflate_setup_params(struct zcomp_params *params)
>  {
> +	if (params->dict_sz) {
> +		pr_err("deflate: dictionary is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (params->level == ZCOMP_PARAM_NOT_SET)
>  		params->level = Z_DEFAULT_COMPRESSION;

If we want to be pedantic, then {} should also be added to the "if"
in this case.  And in other similar cases.

> +	else if (params->level < Z_DEFAULT_COMPRESSION ||
> +		 params->level > Z_BEST_COMPRESSION) {
> +		pr_err("deflate: invalid compression level %d\n", params->level);
> +		return -EINVAL;
> +	}
> +

[..]
> +	else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
> +		pr_err("lz4hc: invalid compression level %d\n", params->level);
> +		return -EINVAL;
> +	}

Let's add a small comment justifying/explaining that "1" constant?
