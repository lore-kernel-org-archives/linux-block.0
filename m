Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD474267
	for <linux-block@vger.kernel.org>; Sun,  2 Jun 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363349; cv=none; b=VHFsoQ95pMP9r494k2hYJ4RhWg19UHWva+mi5anHIiZdItaPIb1eT09aTT32o/ckP73yUQLq6FbNdrRLsMq8wHeTlD1sLUnAXjpGbvqFe2K/Tcc3izYwqxA4DRFf1rlEgkNpMXQ7TOgoB3nt1o8BUvZ2qaCdXDlrP6VJfCsLXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363349; c=relaxed/simple;
	bh=ZrNyGJ+1xAe5OlHj8yXX8XgZ1dYWuG7ARxdqnuQDI3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6JuFMiB652DCWX2/xEJXdGn5Dmubfk5W/y7jFmRpI9TJPfniV1QMW5DCxcl2fyLqIIacyDJjv7WC+EWM44d71FbAwSMrFqIX3FH1MXLLhd9sbTr2eb82qGWwAPre/j6tycHY72GxkHFvyUhZdSgF81/KIMe4ZtFuYFguMS0n2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TlVo/Sfi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TlVo/Sfi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c036a14583so448012a91.1
        for <linux-block@vger.kernel.org>; Sun, 02 Jun 2024 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717363346; x=1717968146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0T9kNJzBuWYHBbnU6xMqOu3ufXMD03KlUaYrvHQkAU=;
        b=TlVo/SfiWbSKqZD1akdsjZDTMFkmYyAqz2emHIHu+Yz52xnjZnthNaHFtiVy4XBbs0
         e4sHy9UkB/+KJ0YmU1YAKX28CbTBP9CI8OFaOYHD/ySJ2MdF9UhRET5RnN2wGsWRi0xK
         xMHbf46V7ajqfk2dHqZ+ChGcQM0TbJvN/Ufp+3XRvfv56as5uMOsEUcqUYLjgLFT+5Yo
         rhPU1Ls3QGemXCU0bot98+5zmevcaBu6plej4Y2RDAZfXiVVpOnEfYobvdrGBNgHGf8v
         +PxEZNPoS5bTBWHq84RVumE8nJPypYZ36fDqQmGuRb5VJUvGMcwK4nAHZQs7AqORHgw8
         LG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717363346; x=1717968146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0T9kNJzBuWYHBbnU6xMqOu3ufXMD03KlUaYrvHQkAU=;
        b=XGYygMgDfykw6SHf5zVRD593Aidy8czAPlPVuNbQyGg2TVInFoSDrcn4Z5J3+fY3qn
         /pUQQvPgdMcBJTvLtPuZKTI6U3r9QO/R5+pIdLJzEHm21GqlmRme1sPTW0q+XwX6NFOH
         xXm/9eLMWV6DE6ibSiWk7nmpC3Seg0bGEqimWJjwNp2szbrJBS5U5+p57Ak3SrdEuWxg
         UFBYQa84GqtzuCxrONiXsZTdsUp71DC7NB6Mt/mLy+NY7CEjYrWmakRsQHvCZr+Caz2Y
         rRUf8JzJMP+rgSIxw4Lp1QdWsikiiXeSfOOPSQSun5PtmTca/Mm3XqCKakNTXFh0/MnU
         WB1g==
X-Gm-Message-State: AOJu0Yza8UYKFZ7H5pJnzhqlkajstbenWXvA7G/ou2pQqkSP9RJhc9wN
	ACBLwx/cwV7ZtcUF9VXP1GKOJQoNDaoMHLo+KfkyPX8WWkgvvLB6KDRK8eiXe8FV6qSbw2vgRen
	8
X-Google-Smtp-Source: AGHT+IFcawuLyffyqPbp6ygRQeRiVrutoJtZBQnLQMaTtQTwhGzO1Vm9z0I/3d+tAwC510L3hdeZAA==
X-Received: by 2002:a17:903:1c9:b0:1f6:226f:cc50 with SMTP id d9443c01a7336-1f63710095bmr86792725ad.6.1717363345634;
        Sun, 02 Jun 2024 14:22:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f6541sm51480225ad.219.2024.06.02.14.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 14:22:24 -0700 (PDT)
Message-ID: <c912347a-71ce-4dde-9e57-f9068d50f797@kernel.dk>
Date: Sun, 2 Jun 2024 15:22:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix some typo
To: Fabio Fantoni <fantonifabio@tiscali.it>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240602183603.18799-1-fantonifabio@tiscali.it>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240602183603.18799-1-fantonifabio@tiscali.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 12:36 PM, Fabio Fantoni wrote:
> During some blksnap patch checks I noticed that the codespell one
> detected other errors outside of patch changes, so I created this patch
> to fix those detected for the block folder.

Honestly I don't like doing patches like this, because they only end up
causing trouble for backports. I don't mind taking typo or spelling
fixes with a real fix, but I'd rather not do a sweeping change like
this one.

-- 
Jens Axboe


