Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3D2EEE63
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863603; cv=none; b=WvcbnYcDP1TCCK/+az+b0eWWzKXW2TItt+yh2QNffeN66C1cWUQslUGoCTDQmf7aRlz87qgRjU++MTdW/ab8XEkPHN33roAJ/6cPkCbjVCi1WO+AKwUiedBr88cWMra/kRZ3Q4lJtUM+amao2mAgAlpS5LuhdpWcXinGd+dAdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863603; c=relaxed/simple;
	bh=JZEj18Pbbp9v5QcQrebynYI8dHLearldCtxTpU/+hx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvRqthp0LS7p5f0ZCLBJVQMvhflh/B4DdFvI/D8s+oHSpxtj5fo3W4jyflU3cNYOOPBi2FQCzVlwmIW42wU08Ie9gToFn/i6q+Xsd5f4bTHMCYMk9yk4CmdafXF6ZCn51K5IlVBHr+4wBGgqkErs3YBiOoB1bHwUPbhBjlUf21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jzFD2OgK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzFD2OgK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceb096e675so13065ad.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784863601; x=1785468401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bDSV9ZIH2XXXU7d0GkQ3pAFMxusv1lFhr254wzjBK2o=;
        b=jzFD2OgKdnW+r+ZG0fxSzgW4/BeCldFUEkvGIGdnB0F0PC9dMxRni9WoiWCZhHRtKZ
         3StASHsGFbWEY8frC8LEakPmAr93NkrSl3dJIKQ0SOSiQ1TeA5U7JwLtgMEYFC+Md24B
         YgPupoU4o4kACVFZDbADlA6w4g0VbyTnVeeH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863601; x=1785468401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDSV9ZIH2XXXU7d0GkQ3pAFMxusv1lFhr254wzjBK2o=;
        b=qNGGkw/XWQXcQXuaHbTpDzTk56zrAZP0fFYMRjyz8SO44igI6pev/ZCsBjYnl8c9Rt
         OYysTNuJLVmGpjGCbKSUn5gx9d/Vx+ABmLXiicakH3GZIHgN6ECNGKGuR3FCihhSaZ9o
         0xSolWl+WM6E3sM/L7q8TJmys8eMEAcjnDsb7A2gLCNEA09wj2Swpj4zQHuxT4dycXnh
         joZhJZcik/cIXQFP/5BckI2MTvE/cnqbGQdEj1fT0vCNAHVxdjXLTjQONKiqGKsZwwlV
         ExXLEkJwswPfZlsDNsb+xaFVuSAgPe4gRSJR0qPXBDuDxo7D1F//CMq7L7qvFXJR0E49
         UYQg==
X-Forwarded-Encrypted: i=1; AHgh+RocrLZdGIz6mp4CYjftSEWGznpEtDMvZzJNJiAA8gLsWBlfaz+QEs214W+wrrXU8KjMmr1l1L+PjRLOng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMCxVWoMs2Rlit8EFWdSe2MbBsA1gRJdvfwtI6RLUyNWHBFgN
	dk5Ty0uxD+cnLSasIoaIMtkRyK4G5E8oST4m1RN67aTrLi+ZAY4vs3nmc/tTlt1ADw==
X-Gm-Gg: AR+sD12LTjlqKJfloA4Qt7mwp+jHyX++U7gh9Qr5e4ZBf9rXC4X4ofu5Sfpw4Cbovji
	bjuZ5Tb+Xu7+s1A3cP5H8siHJM1lyAPq7R/Jc820grsepcNl4rVMCbIum/6GngKhjxIlkQ7WYYt
	skcSVBaPL+B3gYi0SeU0eB6bqdyGuijsQLFF45qDyWRmIqEPwPe22HQxgNPOzeaalJD1h+RF8i7
	TdprHJ8Dtt7Of3QD6+mEx+uVnhOAEylsFZAdhN3ZNmGWwL42OlHEJDnY56baPDuF682fbxeElGm
	wHPEu5soMzZ9vbDB4Bs1KzlWhiXB8DPTUrdiYHlHy6TqgQKo6OE4yoOlrSW0PFjtTLb+xrTqYGh
	vAEmGPyXrBvPbs36NWnM2bw/aPiH59l9U9qfURcF+k8Ye55g2EzMpSjDygksEybIrHGyJzXyL9u
	2Uc+X1q8OwSrbeRQVE2zDjL5BLcvmczmzIIa1rzjvh53aVrZ5Det1w
X-Received: by 2002:a17:903:320d:b0:2cc:c9cb:371c with SMTP id d9443c01a7336-2cfa6c87609mr67525645ad.40.1784863601314;
        Thu, 23 Jul 2026 20:26:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e6252sm43583705ad.52.2026.07.23.20.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:26:40 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:26:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] zram: lockmap tweaks
Message-ID: <amLbHzqNbPEGlSaf@google.com>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714141300.3945672-1-bigeasy@linutronix.de>

On (26/07/14 16:12), Sebastian Andrzej Siewior wrote:
> Sergey, this should be a follow up on 
> 	https://lore.kernel.org/all/akza1qtgHm7zbjMW@google.com/
> 
> Could you try if this does what I claimed it does?

Thank you Sebastian!

I tested the patches.  Posted some minor comments for patch 2.
