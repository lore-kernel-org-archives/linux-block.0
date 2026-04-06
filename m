Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAF1367
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775446655; cv=none; b=qdbU5TuMZnOwwDxUN12yq4z7hA//fGshOcCytpMqVQaz2bVQdiMYaQIBX4YDNxcLBG3YhLdS91mCOTowVM9R9HS5c9D3fMjRbb5YW9xzCTkGCQkYR/9SqYJ0RmwgUXMGmSjXDRK5aa3/cRywlILt7scuWUwLdaxztgmR/a8xUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775446655; c=relaxed/simple;
	bh=23vKraEQA9+Xs0hus4h8jHXPVRTYv6DHGeXNeuMkdgQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=omLmRK4NWM3J2AQtzz7O+WV9J6BC4XVS3WFE2/Xd2LURXouGhfZxDsT04PcxRWSNr++OeI+UOBrYN3/Ct0JqnFPaVRvfqW21EqU8ZG8tTKpoeregbgK4OIqrYim5oPefq5nN4z1bmUxIRhuU9lfiHltlIfy+WcB/ZFVzE7fJXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVXqiqz1; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVXqiqz1"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82ce49785a0so1409016b3a.2
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775446654; x=1776051454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23vKraEQA9+Xs0hus4h8jHXPVRTYv6DHGeXNeuMkdgQ=;
        b=DVXqiqz1bugRosGJt/kBSQdAGhlzE6cSfG36O+W2rVsicUz/RtbRZ9UMuV7kxIz0CW
         6egKRXa+iAbBuMkxf1SwAv0+5tMAybz0iSkz8dolOUcmJW+Y9A9Xgxr2RmQaS67YA39/
         OGO+IFUhVtEw9Kh5NgTLipv1HY+I5oyPUPu0gS0x94Maq75uRWEkHbo+DMzIp3gRRMmr
         KpACHBE6I/XkswtJzF4Uv759q/hxp6EWk07t+dlXFQFn9SOQvsk2AeZvE2YZyQM+/Num
         TV6vyV5WAizcaRTbGeUygP5NaRyx2gG4dIIoNr+bPjLFFvBnmCn6ZLL+CaKSdBgr6JJW
         kGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775446654; x=1776051454;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23vKraEQA9+Xs0hus4h8jHXPVRTYv6DHGeXNeuMkdgQ=;
        b=PK+hD5Vk77fCjrE0UqwQuNH4sT8aYRWP8IIAyLS2DlPPlUFirNfYiw8ievGBi8Kz1x
         8OUAfLONzmiQQAC/Jgb4Oi1YHI1eIougBBBA3wGKThkvN0/wrUMthXxhUGdgXS+m0U91
         JpNHCECGPMS2qlTvqc/lJL+pPFJBNBZ34qK58zyaV0vB9BAzO5XhoqhCMSaonHIOofQR
         EGsfeM4ZGNaRNFZXyz1/4wIDV1PvqXF1eMBVLHtZ7btSyOtQh9EhtTslKZXnr8aBthXq
         FYY1Dzw/CCQ3ZodwnNRCDX+mm2sNFWTMpTlgJ+I/AwdKOX5QLrGnUp3Mr5mYnp2o9nQz
         GhAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/rz9Dbz6+tmXmUaRLX8tNSnBSyMNnJtaxaEuUwUE1rXuFe8OHQPnlXBKjba/pXCNIsZDOkdTwdA5bKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCUO8KFgezHf2w145dDo7WQnlk48cqcHjl8VEu2u9DlCsFWuJ
	9x5eF5r6tUORiQ94lJM7s4BrzWNitv8e+PGt8httRYmpnzJReVTcLXvn
X-Gm-Gg: AeBDiev1rut38wdNL4hzVcPyl7v5lF142oiu36EOUKG9SYOtQFN7Lj5L1RaIUyd7qFW
	TC9wGsWYx4Jhj/Ye/pdc/N+6I0vYeUsr6r6REajB5ru9nRdz5OnsEx1m9yugT33PLLSBWJ/DpV5
	OZ+7s3w++LZqDBGlf/7t6i4+61TKGX7Um8FGlGY4VYPTzeDR5mAdTDM7wdS3hzp2xbnXjgoq5Cj
	5Q/WnjMvYMQuuVk5og5QoMjBmNhU/DAzE5Ern3rjy453STI5tD5yvM6AH4qC5fwQpDaf5JVjZtB
	FDSnIjG8GmpVYf86X3owtMLr88ppZSWkwYrhbsjeyoI9TgwMK3Y72NJIWFnCN1NgoN4mFDX1CXV
	8pjkDae/ssM/ddxHDVM0FvsiGiz7mDgNaF7ZD6/I67ZIMOQzsLxHnXW6bF5WcYM8M7K1hWVGTGS
	p1aujI7kYp7nBt+ncbfw/MUU8=
X-Received: by 2002:a05:6a00:4b50:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-82d0db53786mr11441160b3a.30.1775446653568;
        Sun, 05 Apr 2026 20:37:33 -0700 (PDT)
Received: from [127.0.0.1] ([142.91.102.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm13049098b3a.12.2026.04.05.20.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 20:37:33 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:37:22 +0800
From: zhang <zhangweize9@gmail.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, csander@purestorage.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org, ushankar@purestorage.com, zhangweize9@gmail.com
Message-ID: <27d823e3-6a37-4ed0-9681-17dd04f9f816@gmail.com>
In-Reply-To: <adMlcc0EkqUNpMbu@fedora>
Subject: Re: [PATCH 1/2] ublk: reset per-IO canceled flag on each fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <27d823e3-6a37-4ed0-9681-17dd04f9f816@gmail.com>

Hi Ming,

Thanks for your clarification. I see, as long as `->cancel_fn()` ensures forward progress, the potential repetition from userspace won't compromise the kernel stability. That makes perfect sense.

Also, thanks for pointing out the tag format. I will use my full name and email address for formal reviews in the future.

Best regards,
zhang, the-essence-of-life <zhangweize9@gmail.com>
