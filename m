Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E819
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224446; cv=none; b=bnW4z3QF19BvtVtwaAJacuH8Mji7b2TGukvNb/cOTmvXXhaedcbK1b3q7txA222MaiLq+3j5hQrB1dOb9XXCuVJzcWgUg6qw0cbgbzddOolaaHvylqGTXv2m1WXJ7j4V0m+fp8lqWE4F9Ge3E2V6IRwqnrEoYr38+mij57kUlKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224446; c=relaxed/simple;
	bh=vxfvtIHoiH7P5nvTjP7xIHE6c9GhvRSqK3sGxM2SH/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjS/UxOhFqYwkKI41KYh89mD84gwf3QAYTc2ZDc6HeMPyV57VTrg9dqhevmf67nt40OoCHnZuUEc05XXIPuVPAzK9utByXzigrnBs62b54/zWu48Q0dWNWFN6bmYB68u9/5suRZ+CW+lmKCZRXqqgqSyy2Gs9V6iVbS12g3G2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lp/B6SzL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lp/B6SzL"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so782106a91.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 00:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738224444; x=1738829244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsEYcP1NGDh7kuRB+cYt1IsW+UDamKaWDnpnO8cQSo4=;
        b=Lp/B6SzLcTyPJQwvHGM86H5hvD308e9m2WEQzSCWwoLhyTfP4V7QpSUz1QvHKunkEA
         qGMDqTD2HrecFu7CHmrRkavXGT/xER3H5rEuAAaSlnDVZVZriGKQoq2PMLRRL3yAqcdh
         llFqtI2p+6Mel5JAvVutqbu0YPta9GZYqFeJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738224444; x=1738829244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsEYcP1NGDh7kuRB+cYt1IsW+UDamKaWDnpnO8cQSo4=;
        b=uiJEGZYMUzcilFUyr0Rjs6611o++CfzrpnPh4X3Wp/mg5f+W56snCUOEMZaHmNrxqv
         fbzjOufiI+x35zdy7jINYq6yDhbC/NtGKTomTGf3rxNCKivAty/NJVM7ZXmU6Xc+Ens0
         vrSknABfMSF6JuV+V+D5G1yNMk81zgjtbuMT9qNU3AnGEXteMFEJCrzzFgYyg9qS4yX7
         F14x0HKrlGkEcl/VAv3kk3Nn3LTzqgvACtTkDA1TcFOjr2bm++t6Ba5CqbHbB58v8yi5
         EZHDEXThLvo0Md5hTJdl9e7xt04az5eObq/V3ARYeJXiRMruRyHwTFOwpPf1lf+JDZmD
         QEow==
X-Forwarded-Encrypted: i=1; AJvYcCUpqiE/LD1eH9tciqbn9Qfu5feePcJUZG8uYCrW4bRaaSxJUz1+MGBpABcH6z3ZcLj3sVoEFtvGBQhhzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+381cicDy2vNJlXGVrR65jJlsXMsSJT0O9loDlt+T+i1KPgR
	pL6/sa9q9C0j3iEVnRnG/JxruYynyMHD9r39rBbTPee1fIjIeA7itzatOsijTg==
X-Gm-Gg: ASbGncuQXr51aUoVDs1BFQD2d/l63E3rcxW0CAQGltN68ZMjXxBjBGI9AWUP+7Y9rms
	WUKdzEQsNtbI8jv34p2FPxet/+8KX0FCeYzm5KOvLFdElkfc9P5LN3hRdVmY2sEN/tAjlJbTgmR
	vrc1Arku1wYZcrWzBG3ns/Yv4EHGzPFge03Xb8v+bldsmUeuc7mdDjrN68J6c9c0z7FFVlsSQTq
	T/MgjXKbUEpFfVpzKHSMjkY4DVsLYGqFcfhi2tKFiYOAF8IpoJL/HJmQA9u+PM23TAjdNdTNyG3
	y64b0JXn+QXAH3fUuQ==
X-Google-Smtp-Source: AGHT+IHH5iWlIjO4Eq7Q+EqfVEm7K/OwOAqDScxv/BnOtotmv9zSEti5npxfhQOovsFQCQdLUWPMhA==
X-Received: by 2002:a17:90b:2e8b:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-2f83abd933cmr9991694a91.11.1738224444091;
        Thu, 30 Jan 2025 00:07:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d4ce:e744:f46b:4fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f84897a290sm1019361a91.1.2025.01.30.00.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 00:07:23 -0800 (PST)
Date: Thu, 30 Jan 2025 17:07:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-block@vger.kernel.org
Subject: Re: [bug report] zram: unlock slot during recompression
Message-ID: <kjfjox2rxvsxsbaqobypihcu53cjfoakebdojj7mx66g2agqqr@yuo24tu3gj6f>
References: <7694cba5-d9ea-4f73-9962-ea67637d1f2c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7694cba5-d9ea-4f73-9962-ea67637d1f2c@stanley.mountain>

On (25/01/30 09:08), Dan Carpenter wrote:
> Commit 7ec2cb65ef0d ("zram: unlock slot during recompression") from
> Jan 27, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/block/zram/zram_drv.c:1960 recompress_slot()
> 	warn: passing freed memory 'zstrm' (line 1943)
> 

Hi Dan,
Thank you for the report.

[..]
>     1923         for (; prio < prio_max; prio++) {
>     1924                 if (!zram->comps[prio])
>     1925                         continue;
>     1926 
>     1927                 num_recomps++;
>     1928                 zstrm = zcomp_stream_get(zram->comps[prio]);
>     1929                 src = kmap_local_page(page);
>     1930                 ret = zcomp_compress(zram->comps[prio], zstrm,
>     1931                                      src, &comp_len_new);
>     1932                 kunmap_local(src);
>     1933 
>     1934                 if (ret)
>     1935                         break;
>     1936 
>     1937                 class_index_new = zs_lookup_class_index(zram->mem_pool,
>     1938                                                         comp_len_new);
>     1939 
>     1940                 /* Continue until we make progress */
>     1941                 if (class_index_new >= class_index_old ||
>     1942                     (threshold && comp_len_new >= threshold)) {
>     1943                         zcomp_stream_put(zram->comps[prio], zstrm);
> 
> Imagine we hit this continue path.  The right thing is probably to set
> zstrm = NULL before the continue or it might be to set ret = -EINVAL.

We still need to make sure that ZRAM_INCOMPRESSIBLE is set appropriately,
so zstrm = NULL won't do the trick.  Let me take a look.
