Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724428643A
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094187; cv=none; b=j+d+Cwl2TJTBEEdUqqSDcLQdOPDLKv4OfGdpshJwwYobwcCsXE4iprzYhYnP9Vyl508JFEMtegw8x5JjgLORRhncXRUm4llTocPvIHJ8fxKAorUOW2lFEXHbvYHW3ROI8eCE24B2wVJ9dMKl+IDQRzHwk3pqKP3Ppw5kzqGzHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094187; c=relaxed/simple;
	bh=TdsVKY15ZAJzW4SN0/xoBAOQBrm2KAGqezwae/tGq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9bV/u8sxc939V1StQNrlhMusA65LIJqA/skoMURGLtTq2gVxoJYkku+f3TFLY3FKAYIrYVxD+Jj0VF/nVipeJegsZk4rf6SbUnq/xf8JL/FY5amc/RqWgY7Bxh86Qhg+LPS9/IvyhXCGTWs7rKIHmoG4IL5tOraeuxIqVwB+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X/iO8X0D; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/iO8X0D"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2adc1d9ec56so3835595ad.0
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 00:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772094185; x=1772698985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CI6vOnCPcq8NxdhstfPz4bziJRg9yD7gjB6Tum9s8Is=;
        b=X/iO8X0DFzwT2XS1MzhWR9gGMSX71D5QIZou6jo7yQAGrJfe1yNtcFQszg5ImBNzir
         rYnH4of0w2dsz3EINIjwJ/0ebi6Xc9uuFszKAvSNSA3RVupZF1Hf1gEOSEYir+ptZmmz
         YZBnh8zdVoeFlIAKB7hRhiTO+xQjwKuiYeGv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094185; x=1772698985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI6vOnCPcq8NxdhstfPz4bziJRg9yD7gjB6Tum9s8Is=;
        b=HA45MprlLgDSgi/lW6WoWFvQNGM6J3Y5Utr6+TtFz0HCbuESEk/xtEtaNFZT1Fy7Q9
         fjT2yDMrNUW/+96wQAlHikNkqDboUtl8ltdj5GcyNssSaE4CxB6ATtBiREaxxC45ss/U
         pQzug3yQ7MQu1DStCNxstXS5qV1FDLV1l6FYfdv5CtuIKvWh18oE6OilOxlMo1wYP1w0
         jaZCWEyiee3McpsmfN4T7wJtlPGr6O4AF07qmXSUhR94FvpDTbYeZAXL5W0oPCcEgopP
         9O4UIbuog8flwSE/dCD9g5zwxtyNCa6U+cCpbz+eMguZXHkjnURi1aCL51pbBnPUvQ5i
         yEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCURsOJYWpfZFsoX+Y4HeG8y4t4du+tgUqDIBXLyFBKtqCPk8IJqrjq2uZeaVnCFEIP/nFMOKYJTzgC8Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4TYax/Z70UjNk3A5QRP4A0zTtB0/Z5KJeKEfKoZQs2y9nqZD
	j0smfy/XS1qxQh+lFQZhrdRUigwBDLRg5janeHh/WupcsJR7+TQroWKUXiwtclw4Xw==
X-Gm-Gg: ATEYQzxnjG2cXpLKp0Emj30+YUhpmHcM7/e/2cisnpoSODNXlxsH+UYerCa65syG+2H
	CwNmCPLMv5eVtwTS4OUVo43tUFE2ehXVqbrJON+Ls38Y+qisuN1rbvvHXP/d9KjBffHwZHBtwBK
	ZYYnUKbbOhu4KU3fHwgvjavK/tHfm9/AAsKGL8yr6Vq71TE7mkfQvH0Vb+qdV6G18XpzP2K9nm/
	WCGLiJ9v/XyY8oxIg54GFh/3C9C9XcZEe71/MjFa1nx9k/xtR+dTGDE+uDGno4ccQ8TDp488lSq
	7ns1cx03ac5SAD2NebkKL49MRtEmLW4IJMo23jCaVZuELVcIDo7aNWq6mU6IZD7mWn32lQGTjgo
	ArTAq45ZTZR55wZnMzs1K2uquU2y4LmlWFCCnH15sMBU/Up6zCLvaw84o98XaaEoH8OaU8aC2uL
	lCpmsOabW42UfipfodoRqNWRNPztMgBHViAGUFEH4HQAwzIFjhZBaL4fHf75C/LFI=
X-Received: by 2002:a17:903:2c5:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2ad74513efemr187264705ad.30.1772094185469;
        Thu, 26 Feb 2026 00:23:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:f7cc:c9c1:b4d7:b50d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b4160sm15442705ad.64.2026.02.26.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:23:04 -0800 (PST)
Date: Thu, 26 Feb 2026 17:23:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: [PATCH] zram: compression algorithms name use static fields
Message-ID: <uizrrkcxvs5dnqn7tosot564gjymgzsuypdtjj4w6wpfxfoxvm@a6quz7px4ssu>
References: <32d733a0719c479f85d06f6fec3cc533@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d733a0719c479f85d06f6fec3cc533@honor.com>

On (26/02/26 07:50), gao xu wrote:
[..]
> @@ -1648,6 +1644,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
>  {
>  	char *compressor;
>  	size_t sz;
> +	const char *alg;
>  
>  	sz = strlen(buf);
>  	if (sz >= ZRAM_MAX_ALGO_NAME_SZ)
> @@ -1661,10 +1658,10 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
>  	if (sz > 0 && compressor[sz - 1] == '\n')
>  		compressor[sz - 1] = 0x00;
>  
> -	if (!zcomp_available_algorithm(compressor)) {
> -		kfree(compressor);
> +	alg = zcomp_lookup_backend_name(compressor);
> +	kfree(compressor);

I guess we don't really need to kstrdup() the compressor name?  Lookup
uses sysfs_streq(), which should take care of terminating \n, so I assume
we can just pass `buf` to zcomp_lookup_backend_name() directly?

I guess we also can get rid of `[sz - 1] == '\n'` thing?
