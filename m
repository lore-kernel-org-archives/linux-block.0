Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48AE1EB5F8
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455711; cv=pass; b=uQfmP1kE6P07xjc3BxD5MKsPorTiqh+qzeSDyM9gllGq+zC75r+f8I+6G7bNJqRiyfD5HJosEGlDjkgmMuvx5OE1CceGhSgBoeqS4/bsdPiwruEMq/AJiSx0bF8Dhn0G4RETcko3VJV7ovqQ0gZLQAOLRznF+/w0ukqKX63i+A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455711; c=relaxed/simple;
	bh=Y/TGuNutVYXpBAEqRrrQnqHgQDmm6YU5GAa+3jsTu70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8a+5TeJL9TAoA4kE63IQfTuoMQqVDxU1vDv+Yf1xwiaNz40L3gIj/5BFTYpQhrMbguGtX8yFuo42unZFPo6xFCWmjD5+NtgWHOQtea5YQbnP4H/Ppxuwc28a5PvzmaX3iPkt+/qjhp2dVMKV9PJWiekb0kDgXAO+uaIPZhVJ5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=LLKpiZuM; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="LLKpiZuM"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a884815606so8317687e87.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 06:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779455708; cv=none;
        d=google.com; s=arc-20240605;
        b=MAHputFduG0e/8q8gCZ6D8a2tqOiwT+hk/RHckZQ6SUjBN/q/8yxSLsTkl9XXK0r6d
         iPUMP0Ot8Wvnitr/a4kwEREYzlt99T7N2LDL9ZBwwk8cLlJyyQBlD6uTKa12tHgSp4tT
         Tup4TwGqC4tIrVtqgtYTAwcJmGIZX1w4oI0T+m45jyhfm4MmX3HO3/LSpEA4YIGvDDKf
         K1VHcE7wvgJLdJiI7hZDMampoK15vc0s3k2EcSYC8YfwEtYHOaKJWvoCISKT1en0CYJF
         mrKF0AIh7pMyofLXy1yfIcDKtxBBfcPHeh1v1oHqVqgWgBA8kxmxvK4opEw8k5016o5f
         5zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y/TGuNutVYXpBAEqRrrQnqHgQDmm6YU5GAa+3jsTu70=;
        fh=4UuI8/ButfpsdKML8OFacNjNh0JnNP4trMkTVnwYbvk=;
        b=IELdYlJqAIeMsA2rPIRDVPk1agqHOpnyT6OVXfzXrfJScnyfUStisS56lEWlrSioxk
         ys5PlOJjyHgoUYn0agtKqtwu/hTxdBkN/cdbwnS7Hjp3VKCl1NuvOTLqbahut1fJ8f1u
         mpC9B3bhbyBB5dU6DZHg1CUa/KT0k6WLVl1o3t7EEc5e3xc/OC2eOYNiXX/uIhUMFLWX
         FUAAw9u+6d2Y+FrHyYvZfGGewr5RPRkhDa6xlen2NJBd9DDxoHMpux6fdnhKWMJconh6
         8yabpFEXMhPiICBy7ToxUT+NeXaXnYXFlRMP1HBD8b5LmmgRfnkyfqTBrMi1UzKvj+09
         5VcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1779455708; x=1780060508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/TGuNutVYXpBAEqRrrQnqHgQDmm6YU5GAa+3jsTu70=;
        b=LLKpiZuM30NHJevfyWrM++xREguuEkcccobyrCcFBbCah1pYRDPn2tEOqEfNd7VrOq
         l/pSxsiIqo8fUTnHDng0aCYIn2SwFzZv/IUkkpS0TdKF719SludNZTjNJaUuQprZBIi/
         hAmxUScZ9gbgCGpHk/XQxateYGGhNl5uO0uez3qAZCmBXoNMMwsHvLbTVGc+7E2z/HV8
         iXLFcFr6YdU9CO4Z9PhxQ7daaeq6hlx2m9GsKh5s0tRb1ifCi3nCG16i8XUK1hyV19ZD
         +8vFKuvHoF90FSfiyC2PN2iwUiWrYr9aDt9IyV2SrMzotkVLYg0C4adOO04nDCzzNnpU
         CQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455708; x=1780060508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/TGuNutVYXpBAEqRrrQnqHgQDmm6YU5GAa+3jsTu70=;
        b=aB6lg5dw5ZTP31LH4JIaTjfbfQxM4bnDi38AVKlSXKC9yMeRNa7sWmqfTjKkD2vmj4
         G14Yk656nYSSXqxz7oMe3XnlZ2qLSyrx7HgKcXaicJdiX2rRD1vUf80BYOOrca5c8ee/
         7SAZc8mwfrdRVEG97uF3Y+1etKb2G0YT8JfXfEDbkcOov1IeSgaJSGSqa+rmOvpo9CeM
         Wp+p05RmF/hM4KlonsQr8eN+rPFL0NdorQgcbf0C2GwvzA1jLUJOzWDBuKl5MuY9l7O8
         wNnSYOAc55QKblvUiGOC0FBf9Xxn77RV5d8NJBhhWmFxV4c89ZLzzqL1HTvdLP71UkYc
         s+OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1rtxfL+34QFYvCtf1yx2XokRwkQHUXLOalO2P4tUc/d6nYvYK91991kn2zvGrYbR7UcoP3m1NoKZz7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIlr3OdtiuFIhegvtzz9M5ZBotaGrN03gxVYppUNfPkgs8ij8
	bernzi3k/gN7AhoWvws1YZ7djg1Q5R51BlZp6WsMdzwWCyGnoMSrqKmz+sjid1zrK0O1PmJcyb3
	FmLzRu534RV1ZAHNWxXjlHWPj1exJvxOr6JUZyM9W+Q==
X-Gm-Gg: Acq92OH2HDryEDugfrNAAfcJh7RcfitDuHq5qfn6SfbSFnjmGJnz09oCwYY1HvH1z16
	Wvup3lq6hNnQeLnnY1+TM7GZZcqVMqQpNs8CeTF472bHCivi7Z8AyZVsQb6jsLsO/9BuCR0im/S
	Av0zATkFzUPr4SlEbbqV8++bOB084ALMZ+HPyju4Vy7zd5c8qzaTcRTWGi+MrEa19Lp6ZH0+CTI
	aOesxkfO6DxvWt9+6iBYw7IgKM+5SZa300bQzBzOMycrhsOjf89ybwG51qQmcfKcoBNBF1S1jOZ
	5a2CPIhBijxw3AjI
X-Received: by 2002:ac2:44cf:0:b0:5aa:b6b:a3f1 with SMTP id
 2adb3069b0e04-5aa323d97f8mr702123e87.45.1779455708099; Fri, 22 May 2026
 06:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522123437.214058-1-yizhou.tang@shopee.com> <20260522130157.GA25237@lst.de>
In-Reply-To: <20260522130157.GA25237@lst.de>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Fri, 22 May 2026 21:14:56 +0800
X-Gm-Features: AVHnY4K853kRvr_VL_AS1H0bWBCqNuo485idzKFybGVtIov8w7-0f7b5vzDCvrE
Message-ID: <CACuPKxk=oLxYhyR3ZCVLK1fWqT1AkgQJb5AF8CR-LtSV=K3z-Q@mail.gmail.com>
Subject: Re: [PATCH v2] block: propagate in_flight to whole disk on partition I/O
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, yukuai@fnnas.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"

Sorry I sent this before reading your email. Please refer to patch v3.

Best regards,
Yi
