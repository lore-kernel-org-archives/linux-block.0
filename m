Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6F27602C;
	Wed, 20 Aug 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679770; cv=none; b=O4mBz/7BBDtQjxq3ObalN7clVJCrZxhJhwqNqhFrDL9XmbcJ1UTFYFSAmfcKX34TG/vPBOp/fvusFlaMFFX7CUOVUti8uH4jYPz/d7UbdQIgQcB7pN/09GmX3TDcomNjLMaFkQznJ4ug4IfFwBSHDY52WsHihQCr+/JvccASBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679770; c=relaxed/simple;
	bh=NYRbscHxPN3FzZjV78pk3jOfDJEM29MRGZ3sctUFmVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwJ/oXFfbwfTsbeW6rCNolm+YMpCaujdFWg9rIG7B1i9oBbEOuuxjqC/9s+GukmL3Z4/MkqIxpkOn0tZm5EqtFJ9oxejMjOK8ynm+5Ef1NPusYoRiEDge/x841csvSNTzZt8VR8TzquBfw1U2IXcFt5DluAEfWgZT2FZg3lIsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KErA532W; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KErA532W"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-50f8bd52e06so1978661137.3;
        Wed, 20 Aug 2025 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755679767; x=1756284567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYRbscHxPN3FzZjV78pk3jOfDJEM29MRGZ3sctUFmVs=;
        b=KErA532W+9QQb8RrjIEMDbwmVf+mNT5iGkGGT3B93/qy2O3oKcAymeGn2nVXCZpqV6
         ErQ9r0xmE4YAlrNruJTf5AnbHUjSa9m8Fyfxe9ThM4d/0+sItVPzuZJFo33BCkjPP0hu
         qGvb2IQEir/PxMk2KGULmlGYLGZLstcsaUV/9yoyXmOUYxRtWXNcqZjYrWPTUmd5hKXf
         6jShql2z1M0rpC8eVJ06pvej33bT0wXUBQBJVvkzYrAwIpZ7Tx9DjbGBlKyrhztYw+YV
         lRIgmwDtxk0OdNo2iAGFOIg60cZ7Fe30aEaRYmTqQahGf9REjVgDZNlmxFZzULfB1qgK
         Pc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679767; x=1756284567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYRbscHxPN3FzZjV78pk3jOfDJEM29MRGZ3sctUFmVs=;
        b=Mhhb5SPNgbxnv/47zx/8JKBuOLcvjh485KQlGzWyjI2ysKxoEwLyF8YSMJlwAivF/i
         jr6IUGimKycOQrT/vXjMd+MStXLAjBjP8UmBzQA5nVXRTfKbAvhYYvenNob6wPRsthNv
         5Txs5y8IFQoxRHdcJpjhy4WtK8aXu/RCIAc/CjQZbeOijRYN1+AgeZfEqudxw76UZmIZ
         rW35qELARahpFGdIm9AbZ1s6u9Q8/UFxED/rzLN0QnbMAoY3bO8NoULzGp+d7lYCTcOM
         wQ5KltTks5W79CtyTMWR63hJcdZtYzSQ4qyz2rflJ8NZIhZiaFEzXOzKW6oC+s1JcHU6
         pUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JDiA+i20BYPWJwwkWFX3AiH9CBuGKmAk8344XPD22T+19EjyFutA4KV7eibM9YEAeb6Af9RAqEi+TzU1@vger.kernel.org, AJvYcCVUOJ71J8EAKMXceYz6H84cAqTN1x0LpDOAKgCpGsts9pmPNTLoYqlrA9+vJDYjsnMmjiuuuGvdNRNqRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPKrgYBI03L1sZaqSMSiRumQY8x6QBkRo42ZZPNwY6dBuMMis
	6prNCvm8s2Ou4tawDoha6CIjYDCyhiu3ehsNfyMSXj/e2BPafhMZcEQga6jOTaBr2SL0I9mngE/
	EAfxdMmkiewdgXF/KJUAS5mCVLSaQCk0=
X-Gm-Gg: ASbGncvozGfn0VKEGA8V+KcKGDyLS8ddgOZ+JqYmL68gAvJZk7ZO2l13nxD0foQh/Bv
	5dvV33/HUzZLbUXoNWBg4qGZ3Dc/BKrKChFK4+nurjykPXSAv7WPKcGm12xUvZ3szS9+7Aew3Pz
	HQDfDzLajJrRbJ9ElzNzK5ZlSFe2GfXEJgW2sFMnJp6J/mnSNtJkeklHouVIYN/QZHX8bMXwObD
	wvCrfc=
X-Google-Smtp-Source: AGHT+IE8bsBxsWMm2/GpnHV43YJt2UC3wGe86Mo+Xv6m4XVzWaSAxlE8ISrTVWGCLm+sqp02QH3/iG9/F7/aDGOk2yQ=
X-Received: by 2002:a05:6102:2b85:b0:519:534a:6c28 with SMTP id
 ada2fe7eead31-51a51dbecd0mr547102137.30.1755679766883; Wed, 20 Aug 2025
 01:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>
In-Reply-To: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Aug 2025 16:49:15 +0800
X-Gm-Features: Ac12FXxtjx0Q-hWa85CUYE_gYYDTs1okjco5AnEoadYbOublUq8TKGxYiKJFYyQ
Message-ID: <CAGsJ_4zWHtdYdmDx2NBJVOLkfXEFPtsMmLQL_S5HG4ZC=hRidg@mail.gmail.com>
Subject: Re: [PATCH/RFC] Zram: Improved Compression with PID/VMA-aware Grouping
To: =?UTF-8?B?54mb5rW356iL?= <2023302111378@whu.edu.cn>
Cc: minchan@kernel.org, ngupta@vflare.org, sergey.senozhatsky.work@gmail.com, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:44=E2=80=AFPM =E7=89=9B=E6=B5=B7=E7=A8=8B <202330=
2111378@whu.edu.cn> wrote:
>
> Dear Linux Kernel Zram Maintainers,
>
> I am an open-source developer and have been working on some potential imp=
rovements to the Zram module, focusing on optimizing compression rates.My w=
ork is based on the Linux kernel version 5.10.240.
>
> My recent work introduces the following changes:
>
> 1.PID and Virtual Address Tracking: During page swap-in operations at the=
 swap layer, I've implemented a mechanism to record the Process ID (PID) an=
d the corresponding virtual address of the page.
> 2.PID-aware Grouping and VMA Merging in Zram: Within the Zram layer, page=
s are now grouped based on their recorded PIDs. Following this grouping, pa=
ges with similar or contiguous virtual addresses within each PID group are =
merged before compression. The rationale behind this is that pages belongin=
g to the same process and located adjacently in virtual memory are likely t=
o contain related data, which could lead to better compression ratios when =
processed together.

This seems unnecessarily complex. How does it differ from the mTHP-based
compression we=E2=80=99ve been experimenting with?

https://lore.kernel.org/linux-mm/20241121222521.83458-1-21cnbao@gmail.com/

In that case, you don't need PID-aware or VMA merging etc.

>
> Preliminary experiments using this approach have shown promising results:
>
> With the LZ4 compression algorithm, we observed an approximate 3% increas=
e in the overall compression rate.
> With the ZSTD compression algorithm, the improvement was even more signif=
icant, reaching an approximate 4% increase in the overall compression rate.
>
> I am writing to inquire if you believe this approach and its observed ben=
efits are significant enough to warrant further consideration for upstreami=
ng into the main Linux kernel. I would greatly appreciate your thoughts on =
the utility and potential implications of these changes, as well as any gui=
dance on how to proceed with further development or formal submission.
>
> Thank you for your time and consideration.
> Best regards,
> Haicheng Niu

Thanks
Barry
