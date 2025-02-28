Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4126E17D
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751732; cv=none; b=s0U+CgtZJOA8oYeo6rlWwyx4mm66IiNtJrPX5CoBJyNetqdB7d5Qsl48yKQDvP2kieZVks5Jb+SECTJC9x1ct1cptQh8wuQzJ92LXQOnkMwVyh/i9iGUSs05wApHWRrDX6retOt/Xt1HXa7fnMPqKVRmOggw+mgT83QhSil6jwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751732; c=relaxed/simple;
	bh=7DWNdt/2v2uJzfa9a4Lu3gm3NbTQQQo0EG0KhdAX1p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlTM2+CVZ/WNj5JpAHG2AN7O8n4Zj+jc8ahBkz4so7fp6qkTPXWsWXaTcoKWhDu15vGpxJklUhNPvi9zM9/6izggXqpW80emvwg5TOalJmv+FnTbu8+kIwMLKvV4hNYj++m2v9LauVk2MFpmsGOZ04ZjkU4M14z/CqNPFQMO8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZGDpCYWp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZGDpCYWp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223785beedfso6715365ad.1
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740751729; x=1741356529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CILUScLE0hBWAgWre2/oKndCrDoF+/2Wtd3L87a/bg=;
        b=ZGDpCYWpL7tz64mCYW/e91XqrjAuRkdLotJw4zbLKr9JP0BdkdBedK3Idj2RUYIOlT
         CG8SsJU6cGFHk1sQrQhaL4U+pdTdEWyrRl+vx4A9ZG3B/sxyRdoSZSeAAZ/IT2/aFmwu
         JU/BOUOQ7QpJ56r82F9Wl34ou9gQEL8rQ6uKJyhQ9tBIE0ni7OBsGJBXu4+wemJyDaLy
         ednGAbFImLVa12q2gIgOj0l0XEVQUMYpztk7q4NHihRecluv/jyfACvCijKcmBSdZ364
         CBX8AinS1XaLLfi2A0oTZNWNNhwpV55ekc20NDS06uudAS9p9rN+lKkOe0ChSw2wfQKu
         G9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751729; x=1741356529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CILUScLE0hBWAgWre2/oKndCrDoF+/2Wtd3L87a/bg=;
        b=Hao2RdpMZQ2l8AY6+uLl9OP6g2/YEzi7w6KrLDojrpVh5sbV6ixFoMRQ9Q9z0FPMtt
         FAFNSG6S4LOOPMWJjMRrl0nmcXWRj/cKXxkD1keJ6M20Y/cG5IoJyRtNmSeoBin2Sca7
         gC0Wt80+NjZGs6LQxvkkghEX42HDTu2vPirfbol3enDj+RtjTKJVMYEEE+/Hyd/oIju1
         dxBV2eguskfuy1hTieKiSfA/is8Rzc+0cGwPGiQKp9TmlVe9iqJF+JGNGTBdMVdGSdxG
         EyhjoK77nShrexFKd47v+XpQ87fT93RLk2jHRFoAdsuduKu5CedqlBvT/Ax/1GLJP4ng
         4/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVG7Nl9pCRgjyaZHcusMpY/quVwSILU+FGdfhr93X+uUeQCgGrt3K0IklqlyvqfIyZnQnr8nXQBg05VVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvV0IyARMAqPyaNQAQI9RNk0HSpfSP7xFhlVFw9XtdUs3s1sP
	IdEo7ar8sMe53yv8NNbm43e+FlusE9f4xBYxjaLd5yKn+PSHitMarwkY38oHNTZzrKTIBfrL+g3
	3
X-Gm-Gg: ASbGncu2FlPjSRuVEMnCDZnaB76xCDdUDDSqYVH45xqJZmHUWt17hg5IJNVC9FGka9q
	UbK5YSS5iXbl9BvS3mPX0HQU7pfmEbUgGhxTf9Sg5kWeqw7qiFmZL6XpGxDnVj3kD/wba3Opkcv
	VBmcVwUV/gZsX+d3loBd5Ggl6ERyzpdB8Itca0eiJdK/P00EHLqp4cOnRWgXjhPiScoW1W6Cp69
	ufrybB9wbv1acVIZ4M5YovNT03nsXus8ngRLbVo3rKf10S9NTJfJ0RJflFDAdYJB8IUGFFSj1VR
	f1bpoG9NnnLG5Fh6jbw=
X-Google-Smtp-Source: AGHT+IH0RvwNCYwa6/BYzvW095Ti4mOLDCGElcS+QZXC85+fl4rOlbbZ3z3pilQKgJLmbSgtB5MatA==
X-Received: by 2002:a17:902:da91:b0:223:5c33:56a2 with SMTP id d9443c01a7336-223690e1aafmr59671725ad.28.1740751729331;
        Fri, 28 Feb 2025 06:08:49 -0800 (PST)
Received: from [172.16.2.60] ([4.96.84.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050b123sm33495085ad.197.2025.02.28.06.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:08:48 -0800 (PST)
Message-ID: <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
Date: Fri, 28 Feb 2025 07:08:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, regressions@lists.linux.dev
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 4:59 AM, Ondrej Kozina wrote:
> Hi Jens,
> 
> this patch introduced regression to locked SED OPAL2 devices. The locked region no longer returns -EIO upon IO. On read the caller receives block of zeroes, on write it does not report any error either. In both cases, previous to this patch, the caller would get IO error (expected) with locked device.
> 
> It was discovered by cryptsetup testsuite specifically https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/tests/compat-test-opal
> 
> I've attached a simple patch that changes the ioerror condition and it fixed the problem with SED OPAL2 devices for me.
> 
> #regzbot introduced: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833

Oops thanks - does someone want to send a "real" patch with commit message
etc, or do you just want me to queue something up?

-- 
Jens Axboe

