Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168831F4282
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296217; cv=none; b=LHVk4DcpH7Tg27GsTtzZDV/uk0V83q1VdpvlxTlyFwufAJLytGIp0fNrob5hZETqHTA88jy1ejWS29aZ3+OYeiz8jgW+mjk+0NPRA8GckceWthUUrTGLcT28oVsR6lqp+rAWHsKTfBmhqXArTV8hK3pQZnQ7k+BwQTkotd37ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296217; c=relaxed/simple;
	bh=jqZVc0A+513de4ynStQpRG3bSF21D3VZFq76oC+IFv8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iJOEILiQmNTv7qQCgJvE3g10mg2ZJz/Rz3BIeImuBz5yyX+EfSbrJwUdF4oJEbEX7KBHBKAmRfqusK9GlFcR9/8IspPqxrpp69cGcCGILwh1HKjtlOlhyi08wKSGiT4FEuN1InlAC2iMu5KYvyaECx6bHDpf7BI2A8Vn1x++xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vZP1RRIb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vZP1RRIb"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83a9ca86049so251642239f.0
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296214; x=1730901014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=;
        b=vZP1RRIbZWJSRJn//Nl4KR/DHjZZwwHIWHVOFZ+d6ZBlTjWboUNBwKjBU18l+KQlZs
         mU924mK9Tyw7ixA3XML5LP/7ShppBNDhdKmsYsGCLFp89K1gCa+LM+zh5InM/ayU6lmw
         efwjJd7DeqrWRIm52IB5YX+XNfacha3BwVJLS5akb38xnH8eYoagWz2t2vGhT2yOzzOw
         6/zmauUfCNzpKdMvEPuUxg3iMQL5qvaEQhgOl5WPYh0tEQHPz4EykpRrwjMntZRUk0sq
         7FcJrqfpL+gBLLP/52XcCQj8U6jBvZAJvGv74NFGP7FIqboa0BfnALq3dxYOdAT9xER6
         JWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296214; x=1730901014;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcLMgJLbqvOSfHGThREfZnNbXvQVO2LcvPlc9fGCaS4=;
        b=Uy1nOjsHioZDSpjiNqXPridRcx2vlcAp89C3KaBzyIwSFRg8cxF3mAptZIxoojc24u
         lE/Lfc5pTsSo+qrY+l6iPqP3K+5ZZiyCZ4hh0EgHJYMu+2vCigSxOJ1Dq8pAcxOduxnW
         2/0a2D4WuGAB+IdeUtQwaBqiuuE8AzCEP8Qcf0Z0kNEc3qnFDygfaVIDm3emC0fjELvw
         a5yj7blXG8JjszgxpC1bY7IaQJUHpdGa7TBAZHyTHhgGI02DitxdfzQvk8pIJomTie9d
         E8cwMu1DIHRjtDoqCDmi0JdrSPZM7mc7SEltskVZNEgJ6Yf0MCvduSGLJcXU8qoYcXGS
         x6SA==
X-Forwarded-Encrypted: i=1; AJvYcCVaAddX6QWqyD1KwDrgJJeghCPLFu3EgL6b5cByOIbgYPwkJyYKx/jwIAc9P5SkfbTVOZxIZ7bEOQ773w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvI9VMilMeEtPhx1kC3A90ohBR7sBHXByIOhZq7dHKCrKG7+iD
	u7m7kygfjqMNW+NP/Runb1XxdKLXdX8ZNlyomyevNu4UDXM2UJCsoocXEaFtqX0=
X-Google-Smtp-Source: AGHT+IFv8nLJb1rfbeFNnAcRwDciARx886dwuGgEoPRb3VHS1G5E9Sb7txw7Pj8IXgcazvLW80HH+A==
X-Received: by 2002:a05:6602:340a:b0:82a:a8af:626f with SMTP id ca18e2360f4ac-83b1c3b88e3mr1355346639f.2.1730296214052;
        Wed, 30 Oct 2024 06:50:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72781d02sm2831576173.135.2024.10.30.06.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:50:13 -0700 (PDT)
Message-ID: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
Date: Wed, 30 Oct 2024 07:50:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
 hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
 <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Content-Language: en-US
In-Reply-To: <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 7:47 AM, Jens Axboe wrote:
> On 10/30/24 7:38 AM, Kanchan Joshi wrote:
>> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
>>
>> Jens,
>> Please see if this can be picked.
>> Helps to reduce a dependency for io_uring metadata series.
> 
> Keith, is this queued in the nvme tree?

Doesn't look like it is, picked it up.

-- 
Jens Axboe

