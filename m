Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4431C7017
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998746; cv=none; b=WUCF7k18TodNgBizkUD7mRjrbud2ZvTQ4tRogp84KO9VGrJOTAUdToQVv5FRW5vQBMV+DDlQNSwuy0OaTLExHVCJypRDxTq9w4NSu++WSMGFgvZ1dilhyjbOGxF/vaRgWeY5eM7rhY0yUDLqydABe5G+ryg8Ps1ZpFHtOv17dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998746; c=relaxed/simple;
	bh=v+42VstUVNPd2mezC8iuO8gwNNt9a6yuYkzSDlyNOJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNSNE8IN3zchuWXemB/XO4nj07nw3RxsY1HDqRjVb+CRLLc6jivIi9tWgIIn4H3+a5TILsl+8jEaCxsOeYIkeReplgqkv7y2wvU89ArGHZsmbD+4NdhTmFZ4c8C2+hkZMhiYr6z64xSATE7rero79BEAgrp7aK/scpNJnHBHAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RW4L2mvJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RW4L2mvJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1744393b3a.3
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 21:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750998745; x=1751603545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et1vKrANEWd1oLPdiIp7rldoq/gXylaA1yJpyMaOcf8=;
        b=RW4L2mvJNwHOs0eG0IS2BOMXmejQTJNxSRGD7LHHivfRGniaeE7W0eCoegiQ/SlGW+
         sx/j2EGg3nHuo7MIcy4r2tdPYEbEWlaRTGcTBxhOm103W2efBnzcvOjL/Jamj+46hu5C
         32fRo25FztWUMeHAJfLHxw0WuufHI4K/HPRY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750998745; x=1751603545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et1vKrANEWd1oLPdiIp7rldoq/gXylaA1yJpyMaOcf8=;
        b=InrRpD7lywLqRrMwTnB9iRzxEhDcUbLDD7Pm5Cc2DoD1+LJpr6ClEGbJoy2zvaZ2El
         B7JSMx4TDcs4tzxNjFcpm7CaUWvu18Kf3piayfJHn1K7FcM/0ZC6k+0x/TN8khrHhzOD
         hjikt73VoqxhzcyN1NuYAVEGKnjJXUye28wQak+L6s3xliPuit/xuLOTysIpyjs4dMcT
         IGVuGUPlzrFlXFC2NLdT4n20hiDJT7uopgBbTQc0q4PZTxVUIu9bX+RQ0U1zIIHs4nnS
         kq9T+j/nnp9Er1bppxreFyHCQF0WVgyCWGoAwYbYOA2xkYhrzCANTNuj/Gvle6Xb/4IR
         9Yow==
X-Forwarded-Encrypted: i=1; AJvYcCWb9hGL/6OWt4xNCapLjdXj4nJBjiWKpPKHaV16Wqps6caAfqArMT5xnmIFcIBx0ajzMGsDIiD/GmuWIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyifRP1LTErAZGndCrG6mq/6xG2NNEfHBHkyFPHm6WhPVgQ9of8
	mHSDXeq+Oo0Gy8nxmycbSxtVZgpv2B6Zkwv4480LuJQo2fL/2CYartq2IkZ1co3l6w==
X-Gm-Gg: ASbGncvFJTyW6/p6ivIZeeTo4tBC+sWK76FNkJhsOMvTDLXv/PEMfpDd+D2i1Clp4Tv
	5M42iHnbH0V0UXrvN7VMi/MlAA1YCyRGZAjwdhq1lNCt9V8q7ncmxjRhoRec38XAcOGMlW7WcXL
	GCBE9vPPvTdnDj1qtel7n9wJ7qIy83nsPPqwJt1aawXT9PGYqopV2Xys7Ec1BRLI+LUwWSvrFXw
	iFBzEkQirwCbTDqxfuRPCEaTu06dG0i6cVgPEEFcedS67iY8/7s+q2qNM+q1Qf3drXqBjjPG6L2
	Ve5JTbtWFDEqbb62VHL2nMnjfojfR1oEGvQu6860jUpUmLEzAwMOwRx370vkF6bwKQ==
X-Google-Smtp-Source: AGHT+IFsUUHvXLkVnFLLwlY36+r3+Fgx+TFevhxTOC4GjFZoOrSNFaMyU9W5wFF/BGs6YIpTwbjcOg==
X-Received: by 2002:a05:6a00:23cb:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-74af6e60f24mr2433036b3a.6.1750998744783;
        Thu, 26 Jun 2025 21:32:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de1c:e88f:de93:cd95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b37bsm1190315b3a.24.2025.06.26.21.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 21:32:24 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:32:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Rahul Kumar <rk0006818@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] block: zram: replace scnprintf() with sysfs_emit() in
 *_show() functions
Message-ID: <zzscki3fdg75nl4gojsqo7exhwodt6sm66avcwmmhnz5yvc5sm@sld334al6udp>
References: <20250627035256.1120740-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627035256.1120740-1-rk0006818@gmail.com>

On (25/06/27 09:22), Rahul Kumar wrote:
> Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in sysfs
> *_show() functions in zram_drv.c to follow the kernel's guidelines
> from Documentation/filesystems/sysfs.rst.
> 
> This improves consistency, safety, and makes the code easier to
> maintain and update in the future.
> 
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
