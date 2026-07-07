Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1D3E1231
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441450; cv=pass; b=VPrgw1xSV5eWbZBatREg6XZnHve1nEWCSiXklpfre9uY2MqbkJudwJapv77L3mPW+FPtV5W9Hty/iHrrvCqpEjRSlPJ7OE5u/jaKLiyS6qOOM20/N2uzDqNhjo35hyEPB239sdME9qKCCVyO7qDWLoSR3Qwu9RtVlYrI6+juc7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441450; c=relaxed/simple;
	bh=s3QP/N/T2OffADMUwQaui/gH0aS5YV9Re+9pNlEWuJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE4yjCRv/j6LH4NuRK5oEJrm2+F629gdNH3S6bQr4vY0E9IUx/QsIACo5aQrM9d6xKyckyKo8HaYgLSdXPik9gnGqd+hfzu9mujehA3VGNPa1SoH4/47ihzjq6JE1Xwm5gRsXibfoA9OCyDCPRz5fuXDqC+bjcZMFuz5lpI+IQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1+Dh1Wf; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1+Dh1Wf"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44cd237446cso2768335fac.1
        for <linux-block@vger.kernel.org>; Tue, 07 Jul 2026 09:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783441448; cv=none;
        d=google.com; s=arc-20260327;
        b=VUC8VTQJCzP6UVahAQb029IdOPIew/C1igobrea5f2jy5sqQDLRr9nZfvvuHKMM0Ci
         03rm9QQhHBfa/It6yqcp++e2n6U9aQCe2bl+44/zEyr4sPzJb/y+SFkX9lQRAY9zKPzB
         LncWuJohU8OChx8uPKQDE5g7ONopVzgAdVqCugvWps0ju+K+N5n2FKgG02ifPd4L2qsu
         vy5pUNTRiT67coBr1EU4GSSHVtc07fLOIyP0YGdxghoXArWKlKFPJEEiYowVg8qUpIIc
         fnLs1VoLd5pSk579ZJN8AHZ2PqtdmLl0OpDPC68rgpp+V/1BwMzlNrQlMSP64zE+dSR9
         Gx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTupGlZ2+IgKZ+7JTyORUZxRUn13aVYLWMx6bL2puSQ=;
        fh=WTPzBDSEzYEOm5UAP3L7S/0Wew0ZJx/+aDA7L8jZEY0=;
        b=fVQID+do2ee1394lB1iDSXTvU5KGMC345E8szNeVPTISRktvWZ3cTwbpV2t5WSo760
         pQIZt95yylqTn7RDiIQ20MKPZGTFYHzYweRP0dIHAK8WEhnHLBzgk5eB2IzkamlENfrC
         WTxo1Ul/QDcde/a11hv2bxilhMl38OI1x8rck9kPBlAeiXzEkA7Fxq2bePdO25BS9Hzk
         mEFvPTWRgtnA2spdN0o9JlbFPQinbepdwi8yUhGGDZ9uxm8AC5MKpxJUjBfK7vgwgksy
         QJjMBRv436mFZIIlbm9puCM2XA6rQ5WRSM/0BEvGT99j9SVto4omcrBg9Pc5tKnek1LK
         wLDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783441448; x=1784046248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTupGlZ2+IgKZ+7JTyORUZxRUn13aVYLWMx6bL2puSQ=;
        b=U1+Dh1WfSNwRmmSy0Ru/Z3J8JRPNAR8q8TikMuOw//3E1jH9h4jau6jxnEuCx7CrS0
         yVKt/gh2NFbmy4nLBz7PZMYm0EI8ikVo2nXJL5aMuATEzA3LAOTR547QngY5Eq04uH/2
         6Zrk1mBMjfIgJJNIIR6ep59ZVvWCjYYnWNbxWfLLcYhGguPbhHSx76NMt/0f65qSWUm0
         Y7Dvc2dyITGdvB10oYw2b7yRl5BHAmKggWDCHk45Ali9rhY0aVbHesXWAuBTlR4UvvzX
         D2RTCVhLt3c6KrrvlbDroyW3bQLqD9GD605lUNUMcNVLmXBDxwwlEYiFtgluPlWWszRb
         iINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441448; x=1784046248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTupGlZ2+IgKZ+7JTyORUZxRUn13aVYLWMx6bL2puSQ=;
        b=U0Fg9jezF2mokG/eHdoPg+xW80fqjDfkDleTIQvpDJ0R6+1KOp74+Ss0c7du+QfcG4
         c3NjpbTqWd3lnTciNV/44NANZ7kCeO8kXyotaaU117eNX5xI+sIP+RxsOtvkDPpSb1Iu
         Nuhe5fxxH5OHUkz/vA7nB0hJ1ztxzxU5kOkslhbZ073ko69rRIJ4ro0j/VNZSq6iOiWh
         k38R/KlLBbsZRZ+YC5+qPY5WAgY5v4Gv/EsZ+RKVX8IPI+jCpnuauwgjjtqWrFlbbC0R
         FO026+eBhaHnKOwjy8QUkY88y3TmQYUyckBOxOsIkegieOH0KRJ5Mu0XpAgilCiarxEF
         1Qzw==
X-Gm-Message-State: AOJu0YwQpQVJuZ5z+ueS11K/iPcaaD3ASjy8F6OUQy3/De61p4ksQD7M
	Q2CXsLJHBqJ+kIhXLSZ/7UzSeOCbTYNu+/8DN2XWnXg8eS71gfFBZohcCKfQft2Gs09YdM+e4+8
	zynmgVVmhZW4PtgfChdSEePuxzjPt/Ppgsg==
X-Gm-Gg: AfdE7ck1qSqyXOgE4wbL8gFIwLOj9g50vdrDQUVz4K5ebqjSdDNnmYvIw8DCK4Wq9A2
	AYu0cUR5v2prLKgyRQLuLa74AX4oGJQ7hwUEgMLmlCuf5Owqd42y1r36WpiXJ2ASNs/YnjyPOJ8
	ZPpl0c0NdkW6QllP/fhWoprHRsXslGCOwTQ/1pKoNyuL3tqjqmkclaW6yynLaATxg5ZwQkyH2/N
	VsJodYXDFPE5D5v7slXZeR+a5Wh7Kz2netBITnPBWBqV3SNJ7kQdkEJJ/R79MmVcLhE1KaksbkZ
	DajfWUBuw40L1P5cWcFoWZIwS//WIrkeih4HhYTdsHPnfPUTesFdaeZpKXS74SyyyaleCkp6
X-Received: by 2002:a05:6870:3272:b0:448:4eb3:b87e with SMTP id
 586e51a60fabf-451062d1cbamr3550705fac.27.1783441447667; Tue, 07 Jul 2026
 09:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akyeX0hlcrnOC0nT@shinmob>
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 7 Jul 2026 11:23:52 -0500
X-Gm-Features: AVVi8CdKOFZERuEPKJaQm29NZ30DdvfGI5fcSaMpqUwZ07vWctLwKP9rC9nU3KE
Message-ID: <CACVXFVMio4pcYVrnd6LzYffymFUOLsSY6Oo3C31Yzb7sEcOGAQ@mail.gmail.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, John Pittman <jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 1:39=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Hello blktests contributors,
>
> Recent discussion unveiled a license inconsistency [1]. Currently, each f=
ile of
> blktests has one of the licenses: GPL-2.0, GPL-2.0+ or GPL-3.0+. Majority=
 of the
> blktests code has GPL-3.0+, so the effective main license is GPL-3.0+ (e.=
g.,
> check, common/rc). However, GPL-2.0 and GPL-3.0 are not compatible with e=
ach
> other [2]. Because the majority of blktests is GPL-3.0+, blktests cannot =
contain
> GPL-2.0 files. All files shall be GPL-2.0+ or GPL-3.0+.
>
>   [1] https://lore.kernel.org/linux-block/20260626045650.GA8752@lst.de/
>   [2] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
>
> As of July 2026, seven files below have GPL-2.0. It is desired to change =
their
> license to GPL-2.0+ (or GPL-3.0+). The list below shows Authors and Contr=
ibutors
> of each file. "Author" means the original file creator who set the licens=
e
> GPL-2.0. "Contributor" means those who made changes to the files later on=
.
>
> 1) block/029
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Yi Zhang <yi.zhang@redhat.com>
>                   Christoph Hellwig <hch@lst.de>
>                   Li Zhijian <lizhijian@fujitsu.com>
>
> 2) block/030
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Christoph Hellwig <hch@lst.de>
>                   Li Zhijian <lizhijian@fujitsu.com>
>                   Akinobu Mita <akinobu.mita@gmail.com>
>
> 3) block/031
>     Author: Bart Van Assche <bvanassche@acm.org>
>     Contributors: Yi Zhang <yi.zhang@redhat.com>
>                   Christoph Hellwig <hch@lst.de>
>                   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
> 4) block/040
>     Author: Ming Lei <ming.lei@redhat.com>

Ack for switching block/040 from GPL-2.0 to GPL-3.0+.


Thanks
Ming Lei
