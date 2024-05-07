Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3C3FB2F
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053857; cv=none; b=LIL/L/NOWH6fPeYZFChLMIZvoZysHq6Or71xsrNAOyaUX9hjFXIoLeWaSOvyFAneW+rzIdu+MgJ8FwyxeR169K2ly5JNKMFjIQhMNQWt5Eo+9pZ4s8SNKKJ5zm/aSMvatddXBuFacF2kYD1Cqc5JcS1F7vN4ejy4vmXFi1psndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053857; c=relaxed/simple;
	bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI7hwkTzcoDFxvdEfSNIS9nyLcVvugpFeN8yRAr3W+EQtgAj5z0UCffbWDKnP2VaPT/Lio090Jxeg+5CuaFlUe7uZghJ4MXitOw0i/VwQE5/1a5o+p7r8raRDkqdA85WKTOFJxXj47FlXGrv790ovIjoAJRzOv2CtQDswJX2WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptdX8RKN; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptdX8RKN"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7f82c932858so10831241.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 20:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715053855; x=1715658655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
        b=ptdX8RKNsIEtA2+LJdEg4nHx0cwyCZYK+cmEbhfm0FtlT70eXHBH2twdTrjV5sI+7O
         UB0fP0lHQ5yJzo0DAa1vp2aQOKwGQXH+PftaSUicSChyTBeoJV4HPgrAC1TqpPcx6PAP
         VAUkaneqcQB39U0eQV1BykayNazyFYa0tz9rkfDLI2fihdi1N6wVwR0wmdo9blF4LSUk
         XpBO0YtUVJSOx13ulYV+dGghUoXfQczugh/corf+KVurVTQqF+JAKGSf/Z5BR0vQe8K5
         jbjyqD0Q+1FLtPcr9OhYjheK4bdqX8kTjyfm9gtHUY3G1YyyTFzpSO7PRx35fV+AitQG
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053855; x=1715658655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBh2sNvnxivKaTg/6xMQ1vH+J1//OY69+3MunvpWfkA=;
        b=ve+312JHoYW/OusZbN/qQ+79Y/O68MqbtiMORhKj/wy/35IUZUdeCmW0Dxmyijcymm
         hFvKc2Geek+tHEO6SqCQ9GgE2kK52piA4P+ChnkD5QpmbvSBOujFYLVZRCzzaLkgiEJF
         n9vXkNiwiaOb+tW9lpQTMDRW6uKPnADxI9wuj1RB4XKENXGf0lFqQqc0a4E0irYCi+Kz
         PaUdvhKgIP8PqrI00J7aG/Slo0lNfKJlkBwWvvd5EwWOznEhxV+gPQaAbb05rlpupmMv
         Km1x0Atmh5JcNW5xZHtSyMOFNNDjg5W/9ShS0ThEND8Mb4UsXa4ea+0H3+BZoiUgONHr
         hl3A==
X-Gm-Message-State: AOJu0YwRFA0kxhrPthQCt5wV0kGa9uAwdkhhJTA3CN7EDifBY6f6k4+D
	PV/KjiAjXCQfATGQoRPDtBB2kgSNgoHL9VPSAStOvNKsSmrOKsp161eHXc07gl3cc4xuzcvFKeo
	ZpBGD0p9EsVZ9NQ9HnA7SFJuO2Mhce6mm9yKv
X-Google-Smtp-Source: AGHT+IFb85IXhA5rUrJO0F2AvjpnYaPXIbrqw6PUpjJNLcgK3c9NShQZyPtn7iG7PO0YAoBSgrPP6/195qfMiOM9fxA=
X-Received: by 2002:a05:6102:244e:b0:47f:1f49:45d1 with SMTP id
 g14-20020a056102244e00b0047f1f4945d1mr4094840vss.17.1715053855075; Mon, 06
 May 2024 20:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
In-Reply-To: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 6 May 2024 20:50:43 -0700
Message-ID: <CAFhGd8oUjT3G7hvweWTtd3RLdQMBSjjVS6iHModQPf5VqU039w@mail.gmail.com>
Subject: Re: [PATCH] block/ioctl: use overflow helper for blkpg_partition fields
To: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:10=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
...
>
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang; It being re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
>
> Let's use check_add_overflow to check for overflow between p.start and
> p.length, as this method won't trigger a UBSAN splat.

Whoops, I got this wrong. The third argument is where the result of
the summation is stored. In an effort not to use a throwaway variable
during testing I just used the address of p.start, this is clearly
wrong. I've changed my approach in [v2].

[v2]: https://lore.kernel.org/all/20240507-b4-sio-block-ioctl-v2-1-e11113ae=
b10f@google.com/


Thanks
Justin
