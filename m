Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87853101AB
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501570; cv=none; b=aY+6GP3EQQxnVEDoGpY4bH722aI5mwihbcY+XWvSgV3cIwzMSijr1/MmxR0rkslIQzcFCyV/6IdpsCxZ12k3I/1L1+05kuX9LaRVofnU1U7waiK4hJwLKfrmmwx5NijcpzxAnOR+/kQPXVr1YxsAsY8DXU6AVRuiWLp+gY/Yoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501570; c=relaxed/simple;
	bh=Pu5n7af86vGvH823/Yp61O2TfCCCjb3TRVHLgzzO1Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hx6m3+zrD2XljN21VwEzzrVzB29uAXFWhEiB2ru24v7toDWEI+X5gI0c1+AHqmSAIXbBtjNno3CtH8mW0jIN4p0oF686s/lny/CdzdZVd0gfhUDfjtQZItLe1ofJGVYws7k5HeYj4O7Tg+ful5SNhuS3luQbY2642fcTVegXIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KJncWa/O; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KJncWa/O"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-321289dee84so2187931fac.1
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757501568; x=1758106368; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT1ofiuSVoWseJh7MYOF/nr4mco48PliIphnXMl83A4=;
        b=KJncWa/OqYf9t5cElYrZgAfTqO7MLyjDhC+j5/UwdittfzKekaQDyG1svHG+WcL+qe
         CVLEsgclWew7bw3I3K11AXcDlhco7vAJNjIyP7BB8E05ZR4Fj/TfusWLrdMn82NTATln
         xEeCvnZij1vLVVzakj/PVcRSazTwAioBiU9X74VzRRg8LjEIHxJNQagk77kkNE+cCZo/
         VmZckB7jS1mGlVqC54mDB4H7i3dzxD6EpSweyqep2wp7pwM22fxxLTpMzkjg+zLZ1203
         6h33C9WVtnceyrDXMKHTntd/LZEy59tdFKfe1IqLecAIhSioviUnjmgjdoRfi9rZIIOd
         WtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501568; x=1758106368;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT1ofiuSVoWseJh7MYOF/nr4mco48PliIphnXMl83A4=;
        b=P7eP4f+p+F8Z7/TE3g+oBLoXtFpgNXEjxqaW5dJw8lx3gmAFY/DCSgVtiRt4pHobim
         dhGyC+SwXdHiIChDq6x2IV5A86kVzTs9ORK8kL1mr/MsI/Aw/zi/EtVOgTz734Op6Ru/
         6fj7OjRv+RdzBu6mLtBL7b4QBW21exMsE2CIhBMcIyyxP6MgIURcwyfsvTx73x4w/qrS
         kgKAbCdbJBAH7jdV5vpGUPeODgawkJti8aHDz7v+0Hy+FK3cdU6/sYhHxM4s1Znhf5Ha
         Lvv2lMmHPqgoQrxSftHO4IeXflAD9OIoR/e6PcVzi+OAQVIrVTih0AATdL1QTMzgVQhs
         oceQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3GUqzT8KLc00wN3IZm8PBrOza2aARCsOsYhS7Ty2g8ZLQl6Nf+PzgYVXEAsn/5svK1qr6zkm7CSu1WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNDa8uudhT4G+ZFuNTANfyKA+HDzT04Db60VjGOY53xj1uiDh
	4cx2wleJst8jT93uGdqlEs6Wdys1jaHj/2b5WhIasInptag0qUa48nyIUWgR7wT/u4PkfI8xaEP
	wIWKn7zyyTBIUIbLAAtCO5acuLhKiVV5q9VmHNsq02g==
X-Gm-Gg: ASbGncvWHq3vMK3/UbMKf8sOLJEz1pSe1/5ca0IcT/7Dc4SdLuUCPYupgR/Qbs/+V59
	50FCoR1h1m2npQqrxrC7a7kjPsM3gGgPOdvFBkkVFmz7vxi1E6B7M0AlOx5+DE2dX8esJPDGgq5
	bvy+7bhMH+nLqqEXpwqeB8BhKE+pPyj4hkPIOVtPU1JnjNFw8/D8lIAhBwReJthefrkxVHZ8ef8
	eFjOOMxOGpU33Dh67S4bJ3PzeMY/PeDcAHbkCcTJg==
X-Google-Smtp-Source: AGHT+IFpMNnWy1Mpff3ONFTLVx27KeGSsvIhY8w+2YZiYG2szzBQUCGr6b1FcWDN3xQZW1C3esWefEhe++/4nWObHfE=
X-Received: by 2002:a05:6870:f706:b0:31e:1def:1e0e with SMTP id
 586e51a60fabf-32264e1f191mr7168001fac.25.1757501567607; Wed, 10 Sep 2025
 03:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com>
 <CAPFOzZtaKcaSsvUfjiJL2TOwMy-jUkMdboEmp++-USvoUoqjYA@mail.gmail.com> <879fb17c-e6d6-4b1b-bee5-9087ba24a4f2@gmail.com>
In-Reply-To: <879fb17c-e6d6-4b1b-bee5-9087ba24a4f2@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Wed, 10 Sep 2025 18:52:36 +0800
X-Gm-Features: Ac12FXxaXjFDhXYjy8vJN-rkpO3OKcRZyUBgBZDXgkSaBebRrBGN4SGFHpxr1DQ
Message-ID: <CAPFOzZu5e1AgjHZbKLbCQVn-We6jc-J7h5v1A0SJ9_KM8cPSjA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pavel Begunkov <asml.silence@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=B8=89 18:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/8/25 13:55, Fengnan Chang wrote:
> > Pavel Begunkov <asml.silence@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=B8=89 17:52=E5=86=99=E9=81=93=EF=BC=9A
> ...>>> Now that per-cpu bio cache is being used by io-uring rw requests f=
or
> >>> both polled and non-polled I/O. Does that mean, we can kill
> >>> IOCB_ALLOC_CACHE check from iomap dio path completely and use per-cpu
> >>> bio cache unconditionally by passing REQ_ALLOC_CACHE flag?  That mean=
s
> >>> all DIO requests via iomap can now use this per-cpu bio cache and not
> >>> just the one initiated via io-uring path.
> >>>
> >>> Or are there still restrictions in using this per-cpu bio cache, whic=
h
> >>> limits it to be only used via io-uring path? If yes, what are they? A=
nd
> >>> can this be documented somewhere?
> >>
> >> It should be safe to use for task context allocations (struct
> >> bio_alloc_cache::free_list is [soft]irq unsafe)
>
> Why messaging privately? All that is public information people
> might be interested in. I'd encourage you to forward this
> discussion back to the mailing list.

Sorry, It's a mistake.
>
> > So bio_alloc_bioset is safe for task context, but unsafe for [soft]irq,=
 but
> > bio_put is safe for task and  [soft]irq context ?
>
> right
>
> >> IOCB_ALLOC_CACHE shouldn't be needed, but IIRC I played it
> >> conservatively to not impact paths I didn't specifically benchmark.
> >
> > What's your suggestion? Be conservative or aggressive?
>
> At this point in time I'd enable it by default. If you do,
> just benchmark the worst case to avoid regressions and
> attach the result to the patch.

Thanks for your suggestion, I'll do this, It's already in testing.


>
> --
> Pavel Begunkov
>
