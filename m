Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC25364959
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381271; cv=none; b=G7OAZ2ybiU0YuZytpVFbP3N1Z2QLGuaRDLuDfTqiwgHiY1SjpYXigmCnIdNC8snx+8g/p/Oy9SJjMuKsYML7NBlXtuSfCffzCjFr/K+0nKZTZkv6IsFy5EIQNS2ZNsxkAiEoiH8D5lt2+12+4j2R/SGXciNlwzav+3dW+cUalP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381271; c=relaxed/simple;
	bh=AurNsHsMSUVlPvub8ynGvkrdYbslVOdpo2108EGST9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2gjy2nacm81N9FzCzVP70O0en1xkf8rGubRVcvuFcCGaPaXTpxeRCmiP7KbpZHpT6k7w16vjJFSKlk58hbOx42lQmJT06WU3S5RqQaPYUZY+gJ//qEDWkJWKLNd5T/XvjuNXkhIqxSEkYAoSErpU737KgOTcI8rm2Qyla8yaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ALuBn8ca; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ALuBn8ca"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so17628635ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785381270; x=1785986070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F/XeoUnm6rgQUsPZD3FHsPIgt1M7s1BOWYimjFGH3CA=;
        b=ALuBn8ca1smEELrbUus8+vrUFI6UxWJe8rcytFzBYmYDDbLGeG5xdOisN4yfhs4vtQ
         IKW2gFaQM2OShKR4APhemEqnrhSPkOKZn6D8KRCXKZoD6WMzBrDMU67XWJHcpfbytXJn
         6tpy36Pf+rB8QUvoDK2OFWIR0oMtWOxBjYrMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785381270; x=1785986070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/XeoUnm6rgQUsPZD3FHsPIgt1M7s1BOWYimjFGH3CA=;
        b=LcQrd4yrIVhYmFZgvZNmrRbPHXL8pW7xaaClDkw11QA79dt02eXFr7d8B3SxvmIaAQ
         VdOWPm5skCCKG9pxvXC8UypSqW2zHzvS3E/75BmeqU0g4HRsTVRsWGGMnWfIlSlpSzAG
         9pNe8SnTMJep8sJ2HBJbzQcofhN7jnYv8Qm/7nlIzNwll62mxFHl4JiZlvFpiNBu9e9D
         XREpVd+LHYz93eATKQXMtRh+KIzZjCPa0SWXxV1q88VgBCuZTi4I4XWot5/pz7sKHAyZ
         nJXX7sBONz+Ydl7qJHiEOa3SwFFpAYoZw3aJNtlehSzlMiQoa8yjVIr5T8R132dCk20P
         2a6g==
X-Forwarded-Encrypted: i=1; AHgh+RrKt9IsNkUmGTTuTwfHNMVw4xqHh9WLyGHdOHFbbr0klKa2RkvLddPWvcBlMPbDG14SxpF56vaMckf//g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVVAi1cxpn0/8JF+OMZw/yXlLYFJRH+gqwUerhnsS9p875ISN
	mtvEBkCNuqNLT8jfULkcwqGt4M64g7Bap/sSZ5ulBaw+HniZe88z5Qne3lqiauHsTw==
X-Gm-Gg: AR+sD11B9mOayifjEEsiXmumz11Lk/XzYI2wr2MipZuX9TE+NM6IIwSBYwRFcKy2O16
	iS8aPbUHe19R39YKncGWDe3f5w//FWmCZKmjDp8jfjWJXykmZ/msytVKAY2fG8KWrhg78iV17BV
	/HOgHtlyr9g+cW8TYLyMh9mL1R/Db8COSf0X7ammmWl+mKQFrmpaE84bOCCWBCnFmL2OuNqsPLG
	/pbv06DFJ5SaYIq7VAhNq0SM0x3+O9w7aEgVG6xp/jhL3e6EaftZes21q7f7AHqup57D73+0pJs
	LMnPa/d+qZfx6dGb4fAhiFyfVRTREwMOxu/9mUOyGKrEDANYu+2UMIDYqLFSf8Y8M3I+hmWTwOR
	cOFDR6g24+nT3s0Dw1NriQ0J8aQvO5axPC1aD61+5VzUsaJec/VN3RJ76/N2ZUplUWvcw52K8W7
	AmgIVfwA2Ia6KwmqUuiGJSp3p8Vt8eNrmmyablF6bPS0v7C6TYsDcx/IZOi0TH4x+woxK/Ci/yn
	S4Q0/zaP6REfIPFvSRgW3lhHHNW
X-Received: by 2002:a17:902:ce8c:b0:2ca:1594:451e with SMTP id d9443c01a7336-2d035c918a5mr9857305ad.31.1785381269735;
        Wed, 29 Jul 2026 20:14:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46270sm18748885ad.26.2026.07.29.20.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 20:14:29 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:14:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v3 4/5] zram: add per-backend caps and validate
 parameters early
Message-ID: <amrAyfqsKY2JH4zk@google.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-5-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730025240.17724-5-haoqinhuang7@gmail.com>

On (26/07/30 10:52), Haoqin Huang wrote:
[..]
> +int zcomp_validate_params(const char *comp, s32 level, const char *dict_path)
> +{
> +	const struct zcomp_ops *backend = lookup_backend_ops(comp);
> +
> +	if (!backend)
> +		return -EINVAL;
> +
> +	if (dict_path && !(backend->caps & ZCOMP_CAP_DICT)) {
> +		pr_err("zram: %s does not support dictionary\n", comp);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (level != ZCOMP_PARAM_NOT_SET) {
> +		if (!(backend->caps & ZCOMP_CAP_LEVEL)) {
> +			pr_err("zram: %s does not support level\n", comp);
> +			return -EOPNOTSUPP;
> +		}
> +		/* level_max == -1 means validate in .setup_params() */
> +		if (backend->level_max >= 0 &&
> +		    (level < backend->level_min || level > backend->level_max)) {
> +			pr_err("zram: invalid level %d for %s\n", level, comp);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

I was thinking that you'd move all params validation to backend's
.setup_params(), not just zstd, but for every backend.  Sorry if
my message was not clear.  Can we move all validation to backends?
