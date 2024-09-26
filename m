Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BC2F5B
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325695; cv=none; b=JYGkiujr8T8VDokQtTy8+edyhLCp6tAKa6CE0bhdnP2SC6mUBVXwV537W3kBW4rSN/GE3tKWnuBJn9KKnowHuOMj4jXXCjF7Z1NuOAOtigT/K2NPjrCBOE20efmmoQh1eJalJKNncQQKIuDGup+hv1t0eTbKKKTIRxqTYeMNZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325695; c=relaxed/simple;
	bh=tWHyjY9HXACvx+Bs69UkAw2f+LmrsvPg2gVTucv/eoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4zUX42Kvr7+cPUHMcy4EzQ8Rf9Xi7M4gbpkTD9LjJmw/IQTzN70VGpfIMWDDkKqRV0uSxuRGIb88viqDaL1MIrmweHCbCNZ2C3qnzD9gjTOLCotlgfbshtB8+OjL9JhMFxcg1jbuKSazGxgmGns2BjqtP4F3QycQLfiqpcvBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RmcdBckm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RmcdBckm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b0722f221so451995b3a.3
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727325694; x=1727930494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IK77nxbBZEPITpwoYAt/gwthd7nkAtPQWQqMMDw4Ls=;
        b=RmcdBckmPA2o+i1BJkyHIfl+b6bwMYscOe72t2pPEtKtmu6AwI5Te9v3cTQtBcN7nY
         FMv+l0FBzrP3gONQd35Zij7Xi3yybP4xJS2SsuVemqWZqEfMSL/ytb0cKfVVoznAkJ6H
         6b1pCDZbYxCxdjiYNpLXbIN2TgLANSgx3lD+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727325694; x=1727930494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IK77nxbBZEPITpwoYAt/gwthd7nkAtPQWQqMMDw4Ls=;
        b=WULI1P3/D09DCuiVDzS0mq2yVa4wUpDHUq81Rp1HAVvv4Vr9gdAGKwHV1r+goIv+y4
         7V/ciQiS7XrKD256Nm/DkR/DWmzgB2ybbKggm5rPj8ikx0Gpc3E8YMiezPBtWQXDxP2L
         9EjoUWFVvoX0LKliDQBWy+gsBmIGiLLFRqGUoArSHSVrYeAhfPOyd0V3uhquNTDtm4Q8
         kN2dqxrZYMmf6eOsZdMjzFfgL+xOSVyWLghVMx2Pq6ZF4+OGqbeguuMyCYrYJr2dLRq2
         Rs5OwQnKaEyXqn4BJF4I+cNxa+7Gf+Pf7eiKWQQ2+sTOA6FkUVKWAYzJgtkFgjv7refR
         8cEw==
X-Forwarded-Encrypted: i=1; AJvYcCVB6W2bXZVG0uDHgDkMTAErJHv1YMX773A7/lppNiXYO6mYIr8sFdnwWF0BRC94kfhQgLDc2B8uNQr1Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgTVuMO4W8ZX3erx3r36c5IkfJWmdVUdNrKoTXWd/MBR5b9wI
	lYLLq8a8uhzgrAYYCMI9tED2MGfUOxb5nmnqqXIakP1jJ6k/X1WXMlDhcuvx7w==
X-Google-Smtp-Source: AGHT+IEOD9BvUk8bvWmM8arHd+awbM4tS4muPPp5om+HbilxjplSMNBHUU3yJEROXfLfGcQzr2phbw==
X-Received: by 2002:a05:6a00:8a81:b0:717:9754:4ade with SMTP id d2e1a72fcca58-71b0ac43ebamr4852805b3a.22.1727325693745;
        Wed, 25 Sep 2024 21:41:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1560:84f:e0c8:d5d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c6b96sm3476773b3a.191.2024.09.25.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 21:41:33 -0700 (PDT)
Date: Thu, 26 Sep 2024 13:41:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, p.raghav@samsung.com,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Message-ID: <20240926044129.GE11458@google.com>
References: <20230911133430.1824564-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911133430.1824564-1-kernel@pankajraghav.com>

On (23/09/11 15:34), Pankaj Raghav wrote:
> Batching reduces the time of writeback of 4G data to a nvme backing device
> from 68 secs to 15 secs (more than **4x improvement**).

I don't think anyone does that on practice.  Excessive writeback wears
out flash storage, so on practice no one writebacks gigabytes of data
all at once, but instead people put daily writeback limits and try to
be flash storage "friendly", which is especially important if your device
has to a lifespan of 7 or 10 years.  IOW usually writeback is put under
such constraints that writeback speed is hardly noticeable.  So I'm not
sure that the complexity that this patch introduces is justified, to be
honest.
