Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B41881E
	for <linux-block@vger.kernel.org>; Sun,  8 Jun 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749412547; cv=none; b=TWr3AYYPYXDiNsflseCak/Y44zEyIA0eSk2vby3ULINvk1NIKamBozZc1fU3zJyA1/Y2RweST29pK0kDUn0WWC7GzW/0i02Do2/p5UVr+LQw3kEYyvU9eN5Nk5aW+ZIOohaAsIelV0KLzg1m2Ayb89cWEA6sfPMW7nBLGb0++rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749412547; c=relaxed/simple;
	bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY0fc697RfTqdUsOFFkPcgpKM0GHo2x8nJo6ggQBv/lTiJOmV3AWwRSHVb2DQYl3ujvmU3GaEC4Q+lqkj0HVJVVA4RKDk9cQCnu/Tl3R8tzcnmX9WLvIrN8oQ8MPqKgLA3oVI5G4Ymvnjzi+a3hEdA8FEyB3nYuOlQZqqTn9OPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8ra7o4y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8ra7o4y"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-addfe17ec0bso867885766b.1
        for <linux-block@vger.kernel.org>; Sun, 08 Jun 2025 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749412543; x=1750017343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=;
        b=J8ra7o4yoY3HGpw9N+aB7QPCP4WxDv7qdDzQ+MXTS6sAz1KWyf9bKHuBrLG0kdCnAl
         kNt/sIO6NgmRh1UxgsGAb9E2wKsKAIkif/bQaqabYudvMh3NZWG2EBN6i3MliTf8BPHm
         UnkHkMJ+zP88/MRyVbwLbiJFBWbQ9TlrxVIcvcKPMrigFGk5XDxGyAnivh6txLSbHWu8
         zVs42dEuMjWQkZ9kdT0BLD7EcAsf57loqY87kXGUv3MvbogHa+yFcIQwveAXB72zeDPv
         U92yPISkbxUlnjGnl10Gyv0oaS5L+MGf6aWEa9FVazYoT+PrGlIInjpYgRheGlFZHuLd
         tkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749412543; x=1750017343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=;
        b=vtWczyrtULKU8kT7NtCAApPVrShCgZSB8x97x94vNOR0+Fn7YOB0+6moHwzcWHO4SS
         l9kysp5gUZcpEAtfqqx2pTBkB3leJXs97iXhSNbVK9Yr8tSGeieSnZTkpiJhyDH/42+W
         bwHsD2QNZec0crXNfIOlMvpyjp9TC2IkdLbL4186u5lAPhsV+SwT1HIQ59ktL1XgqZFs
         QNUOjd3/0KVYQhLS6+bEaJohinfW6S6lEd2igEbuYtVZzX9xweCOQuwrq0CY/u5ZJt6c
         nZKcriM/h0TSH18fyvDx6TIhr1U9VkCfVRU0N+eSiWiy/x+JQrsKhQY6GMaO5uhPfTvt
         /WMw==
X-Forwarded-Encrypted: i=1; AJvYcCUxC/RPzOla27+3LytgSeoAQonUyUzFSPb0jfZOlOxwidk0EwGqB2f0u9qw1bYR8HGniTjsxTyANT74Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtzL/4csvyCDdYHSQXEbxRV74DjURIFc5TxlW8i0Nd4xMmHu4
	1vxy4bE39tnZGKn3xlE88vegUFL+L4zSBybSGaWoECkTY0SB8NH/d6xdSZvGmYNYc2iMSy3kMw8
	4qoPtDWbAmJir/zQMqYa1Ma2xQYegRQ==
X-Gm-Gg: ASbGncvXpFGxY+DpU78OUrwwdfwb1TJwBImurO4Ow0Uw64UtObL1kpPMT7jfFtsWuQs
	GQeQnLYyZJOcwULmQtBFQnCd8UsdkdBn+Co9Sgp7/5KobK/Z+ldsoHSPnW/5TXDIQSIqOhER2f+
	tMaOjuMs6GnjCWIIRncsLBeDdcVc1Dqj/lnelpi95QN2p6SvMjWejaP0omJw9Lx/ohnRqjhH5BW
	Q==
X-Google-Smtp-Source: AGHT+IGNh7UzWlxJ4Gt73kTF0hEBq6eRb2XddjaPurUJ15JVrSn+IjasAht+wTEijx0Se0nOuyBuYfDZAXewiZcd18k=
X-Received: by 2002:a17:907:7f29:b0:ad8:5595:ce07 with SMTP id
 a640c23a62f3a-ade1aa8c109mr952954466b.19.1749412542764; Sun, 08 Jun 2025
 12:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606003015.3203624-1-kbusch@meta.com> <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
In-Reply-To: <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 01:25:05 +0530
X-Gm-Features: AX0GCFs9xe5ni6Am2N_20PzQkxb_CdjA_46QNUL-7LzyYRW0ZMOxdf7ydcfl8xU
Message-ID: <CACzX3AsFG-aORqNM0oV8TCqotCvnR3fdQD9QvzLHpWFWeYVo_Q@mail.gmail.com>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 6:25=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jun 05, 2025 / 17:30, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Get more coverage on nvme metadata passthrough. Specifically in this
> > test, read-only metadata is targeted as this had been a gap in previous
> > test coveraged.
>
> Thanks for the patch. I ran the test case on the kernel v6.15, and it pas=
sed.
> Is this pass result expected? I guess this test case intends to extend te=
st
> coverage, and does not intend to recreate the failure reported in the Lin=
k.
> So, I'm guessing the test case should pass with v6.15 kernel.

As Keith mentioned in that thread [1], this test can catch the issue
only in the more unusual or corner-case configurations.

Additionally, if your NVMe device is not formatted with protection
information, the test will exit early and report success, as the
integrity path won't be exercised in that case.

[1] https://lore.kernel.org/linux-block/aD-J9mzq_bJe26rD@kbusch-mbp/
