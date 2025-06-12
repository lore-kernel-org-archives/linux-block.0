Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CF22423F
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729192; cv=none; b=Yvl1W/knTRKOOZCIKE7CLqMldDAJlZ7VY5FygBeIghN1mnxLsI6ij1ELmXBnc7p1xqeze6h4l91X+4ev89GdA4fqgDeWMo/C38hMpo8sxL/Xe9GeN+MH0Vp1dckGRVdKbJeCzWgY8L2pKJSZ+6ffwTosmFLWk0STziUvEw/nrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729192; c=relaxed/simple;
	bh=fIizwEmflkg3UUQXY8k/0K+rU2xRQg0yItsdvb2iPWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjGCEYm8l/R2c7LrV+kwFjIh3ZIUw1yq+ZNZzJpAP7GF+C4Ldfp+c9ZgBKD4Sqgx4ENOkMYK/2KOFGWNJAhDys8GtUUpzXZcJzKc2ZWuGcmRUbK4UEOQgXxV00vQElUzp1JvRmCKCfderNqwII5//2uGsgrJXHPTYDA4WcXJ/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2ZozmZCD; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2ZozmZCD"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-875b52a09d1so25312139f.0
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749729188; x=1750333988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBq1OUn0hIrn5Sd0JC6MpZrZIvTHBLTazREmpjS45xw=;
        b=2ZozmZCDcm1PQDiuEhEtlS6b3MBKC20zjafWBe1c5ZKmk1OSQCmEehPJYF9O/A3Uqq
         ZRhjJ/m+a5ZZMmXCKckEwIo9utYQtCtb+5in+ybzF2tfK8moR0Ll/zQ4pFQr9WoNmejx
         rqbAEZek0gvzLA+t8EPjHgaM127x7Jcq4dT0L9bvYjjGIJTLPMlQHc8oaId8cT31pb/c
         3nif/TZNyLkLOwQnNqT8VyduqQaBMquBjb8uQ5EeAjeIk32SxzAn1d9oraWGRj4kASvz
         yfItzstUuUbDtfxubJAqLaAPiw+psEThOWFah/8aH/CWsTVnV8EYpCpNjBDRQDKAvFAU
         gB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749729188; x=1750333988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBq1OUn0hIrn5Sd0JC6MpZrZIvTHBLTazREmpjS45xw=;
        b=QgVMMP+cJReLWgy0w3+uucbIkuiYLewu8yTLPbIZMAN1O3mCxvDExn49THJBmUHDYt
         M723GMWTY9FGX6M2VJLysN2Z1JHtOsB8RqU+WUAjmtsfMnmWx6u+PN5HmtHT20sJmS4o
         4ioMXlRy5ErK9hqjkpL5h985H0p4GpFtGZpJLjUrHufNAB/F2ZRMvkdNmTb25GBsupD3
         A7yGCiegLuqLq1KYZWEDljuGeMkOS8Qk5IiZmeW6YZCPDUTFJYyqh7xHS0j0xxg3CiNc
         UkI1nJDMxVZSGviyHICta/2jWYSWVexxMmFKJXELhgKqvWen88/th3sOv7gx/KpIun5K
         4+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUBCG2RsxtAJ4yGvtHDz9oanEn8aXmY6gkF1eHAmuH61tbU25WcijWAXYB1Omq7Yc88QMl2YaY1+gC2Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61nfCyzrmz8L7xhEuhUcvBcwrvnfcTXT8xgXNl3UUzY7Pta5n
	2rOaIvv3A0Vc1m9/AMZ+M54Z61kw8yutVAAlrl2shbhVIYGnnwY2CoZfO3BZ4jknsNM=
X-Gm-Gg: ASbGncsv+p29bFq7KP638jQjna5Gab+B8rF5kcHXad3iV3UPMJGf9p7f/FnjowrgxTL
	nfcTVS45ObfWZW29xrE2P9hodLCGtIhQDY0ShsrcN5Tdn292rk7POzZSLiAiM1QrjUH5Te4rjbt
	R7agCPsWoHhCmIhK+CduGbTUUiWeb4eZOerCaUsBYeKe7R1r61aHAskWNrwjd4j+bv/S4K6EoCj
	J33zeClxmnkzQa0qwXG+ojhlib8Vz+qTlHQtjicq9oZSVhZu7Y6W3yvITl0UWSJVhyIkXdBtNDW
	qd/GGZeLmo8RtUq4jBhyCPvHBoUJ6q1DjCyuA6IlEdlZ4ucBbGp1iasmBAI=
X-Google-Smtp-Source: AGHT+IFJgA38ImH+vSy+7vuk0UQScCcE2MUYyhqqJE/sFKOFT19SRN5sU5pRhkYZ1mpeOJ9AgyaSHQ==
X-Received: by 2002:a05:6602:7504:b0:875:bc7e:26ce with SMTP id ca18e2360f4ac-875c798acd6mr266415039f.0.1749729188183;
        Thu, 12 Jun 2025 04:53:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5013b79657asm265335173.50.2025.06.12.04.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:53:07 -0700 (PDT)
Message-ID: <ab5bd614-a873-4228-968f-e9086ad1ba38@kernel.dk>
Date: Thu, 12 Jun 2025 05:53:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, RFC] block: always use a list_head for requests
To: Christoph Hellwig <hch@lst.de>
Cc: abuehaze@amazon.com, linux-block@vger.kernel.org, ming.lei@redhat.com
References: <20250612074245.2718371-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250612074245.2718371-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 1:42 AM, Christoph Hellwig wrote:
> Turn the remaining lists of requests into the standard doubly linked
> list.  This removes a lot of hairy list manipulation code and allows
> east reverse walking of the lists, which will be needed to improve
> merging.
> 
> XXX: the ublk queue_rqs code is pretty much broken here, because
> it's so different from the other drivers and I don't understand it.

First of all, we're definitely not doing this for 6.16-rc, and secondly
it'd need to be properly tested in terms of performance implications as
well.

I'm somewhat annoyed that ordered plug lists turned into this, which I
already strongly suspected would be the case back then. And doubly so
that a really basic performance regression was also caused by that, and
then the proposed "fix" is to go further into the "let's slow down the
fast path" of code. Yes deleting some code is nice, but let's not
pretend that it's free.

-- 
Jens Axboe
