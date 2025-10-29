Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5945478D
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749868; cv=none; b=mPU6VKzDiuzAEzHR877Pw9T60ahDteNUcymV4oWpYf7QOGZMUuGvY11Q8IsxZt8Fu3EoSLKDiHaN6osoQWPd6ejUziGVVjdbBNc27F3Z27TRHqEbXBZNPo14wQxR8GPJ+R9a5Wim/ZcmNYUl48WJzP7C/ObNeI2wS79Av6qTVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749868; c=relaxed/simple;
	bh=sW0fcO523ng4pGFY9aQJooiGcb2xLELRhF6pvb9Out4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZn2ig1cU1VFwxEuDG41aYELizkea3W4vOxFpqxzuFYMVT7anMB+VOe4zy7Kpx4lW06IYFMfGAYopRf34NP00/torGD04Rwh1C1SCINuc2Cj1Rh9pXDUBsAyqfHAf81zc+oGWYarVj7bB2Kjn7dFlED3E5cCtJhcF0EuzG2baBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8pSUfFi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8pSUfFi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso383081cf.0
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761749866; x=1762354666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=P8pSUfFiXDPDvWHmEXuinZOCNdErarnp4POZ0SOm+Nft/ANiXqnl82D1ltOuvaxP2s
         RH0K4kWiEOjHoyP3J6XC7Vv3EFYLm+P9ul8yKQuoRy8/xTCUNl6MSBeb+CmCWHSPd3Sb
         JcTJlOBlIgMdppqp1oVg9pEjoUbvzy6XrklLosfX6s5Kb0Cu56C8gBleV0aVVFRKDPe4
         sJZU483KkhPOrqeiIjJFnj4l5NNwWSxVfdReZGU7PYWWlG3Kzti3eXuhCBOq86OLRrlz
         7wCz5egdwKvC6zV5PHkrbqNTTZPrHe55bfZvOf9W1rE+KJAu9Rm6qI+EOx5Ke3jEFoDT
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749866; x=1762354666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=R1nXY190jYG9k6suHnLA7OPntNIORPrLeTQ779RePzE/kNlV65Y324jfp6BSibOIrv
         XooBtnLpLTk2BqCro+S12ZsIRuYEa5NAQxv7zsQ61W18Fy06yszRFy5GMKxAHxZS3hhy
         jZ2rlYIoU0vKoTQIOfEQZnw8sJ+TMyk1XKjFytVywn7WZLBzxb8jvbPrKVbmppKfqOdP
         1tLedU7NdO0TJYOeBrOC800PtMcWDgBCSmQWFdaTle7F3GUdFV8jWHlp/d8bfatnEcuG
         Dllwj5ynRETq47Ourqvya/YWJyMX9YObmt7ley2u2lLpHD62UtEM9xSkSuRDpaEpUnCi
         xqgw==
X-Forwarded-Encrypted: i=1; AJvYcCVfKrmEhqg5LsNNCjxGIdKIXrrnROnKEDzOMliDpoQ2RsK6MUynz7O/Qg7107onD/ST4H/IIIBUErWMlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMRTmzw5P2ckkaf08t1MazDI9qQKtPYB0IZfq/LUpiaDuTP6i
	10YI52n7wyN6bbBZwSqhN1LmMZpxFrk6qu1Kwhd3QxgeIvmoqXOJAfbbxyZ4Mbrap4NeIUgJCSQ
	zfUbt3YO57uTvbVw+Cv/Cz94L3eCDZYQf6oqDYBrH
X-Gm-Gg: ASbGncvOR8tbJmbypwszNZPk2PT1M7ohR/AxW/dVqEMePFor4DglAdicb5NB800+odI
	wZhExK4VefFcZIq6sfsc9usSnif+MNXGkkM6dOVblogSDgHvGxrx9i8qIU/iBluxgZmRbqzDftX
	8lYDFIZ7O1L3FdgFWeW0bNzs6sP42G8Ov109gSsddt0XmzyM1t5OaRRET7NH3/2t7RjGLDiiEwg
	k7XTvuYg71zmzQo3T3cItXv3pkrlX+SvCg80QawYz+mPD1F6+odAZzO+rye8O2uEckTouNEEyvI
	PVvhQ65uEaSbLahp8Bj8ZXMyhQ==
X-Google-Smtp-Source: AGHT+IHJk1Z4xsEEl6nhEK364d+WNrqkglBzi78RQdt59uckdBYZ7htllhsIgZwt9bC5EN7/2oXDuEWCE2gLHAXeC4U=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr6994811cf.13.1761749865638; Wed, 29 Oct 2025
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com> <aQHdG_4yk0-o0iEY@infradead.org>
In-Reply-To: <aQHdG_4yk0-o0iEY@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 07:57:34 -0700
X-Gm-Features: AWmQ_blGYfe_lFn4eY8RCcDjRQso5Ijs05VisPx1zbBZudE9r4ISvY1EtlCdvh4
Message-ID: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:23=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > I'm guessing you missed my reply to your comment in the previous
> > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3De=
ukTuS2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
> > Please check it out and follow up here or on the original thread.
>
> I didn't feel to comment on it.  Please don't just build abstractions
> on top of abstractions for no reason.  If you later have to introduce
> them add them when they are actually needed.

Ok, if it makes it easier to review the code, I'll do it. So, I can:
1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
way all the logic will be together.
2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
as incremental additions to GCMA, sysfs interface (patch 4) and
cleancache documentation (


>
