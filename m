Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED040DB3F
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229761; cv=pass; b=Zguv4O6IrTJj45a4pWqXy1ofIKMe0ZWmFPN3GnJhAfmQhT/2Z8d3IRZfeLlMryfl7zjJFujV9bjmwoK9Wvna9JGZ5O95V10MdBT+F6VpZQyFs8l7XPg8IAKzB2R0JIVQp9Rt+3g8glzMxmtXCLFAgL62WcQFRg8H7iTGcm003oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229761; c=relaxed/simple;
	bh=7u0w9JMgfd9pCEcqnNs9Zp3pgDXhxuyxNH/nd1QEvdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEq+n8619DgY/++XpaWvK/JRC2Uqfp9ZTO4VioSgM1vLX0HFvQfdcp7iHlwWkzXDabaonzHH5EMa96/uZ5K3cP42wGOrsPK0qqCG2BO2RFhaICrL3NhgKz8lqqbizN7KeRw+qXpZM7xbefVDgLLoCsQQgKC5XrR72EtIRUBvqVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bCVjC6; arc=pass smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bCVjC6"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c166aef4f02so225381966b.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785229758; cv=none;
        d=google.com; s=arc-20260327;
        b=rDwLXSkkB82qCdA2W9hPkaLHd2KMEJd5KjzYnRnoK3nTNju1M+dEQ1gRzUQ4j/W/5w
         wcKMxQWGtZ7sTiJhOO2Wv2IH8jbNZeqy2UfI1O5IjNHrN8rdsJtplcRsmF39S3zbbNbS
         7/NgChhDhoj9RnQVRClnWJCn296rIDCnh6x8ei2a3/wSXUN4qJgVdGtSNd+fOdn88m0L
         XBi4BZnVvqHMAra/lUMoGH25WdHRMbpfXRvXx8inp+Rkw04IbjICgD89PfeG28RlPRal
         jYc0WV/y8odLuRkuWiY97B2E1oWxdKt513B2tswV0XS6J0oZ6sqdnwFvYsyTuFgVHz42
         ySIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AAhm5OULc+8iEzNqpaSE/brnzZbvAo50kBAobxfR7Mw=;
        fh=rQ9yW9hQmWyMNpWKPtMN5sYEDBNv6StfpXfjrLZC5NA=;
        b=rIQq85pyAQXiyqM9uZN51mkQUy5XwSSxttWNfxzVvVK6aREKu1+RpyvdWJlZcaFDiD
         WvrBhlNGFn/Hd6Vc64WbM6izsgPktWDfSiGBLDkAxGGSmZFGjuP5pPxiB1YsfgdIYFPR
         ygNpovbJA6iDcNwb0I1CG3IOa2aGtZy7Ducoag8OoqTUXGDR9XqiUQVJaSg0PYVAua9B
         UJH4QRY1Ll/XhtSUTbZvZzHdcKwPyNhwHTV5cJYjcQUW6VbZNwXExNDOtf9qCg5WRZ3/
         KX8yr0ofO3sZcComRsYH7n5ASofUwfnPJgKHbNYpd2r1mXH0mXaQuCe7fkpYC4/31lyQ
         ryqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785229758; x=1785834558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AAhm5OULc+8iEzNqpaSE/brnzZbvAo50kBAobxfR7Mw=;
        b=Z5bCVjC6HQAJBQ9dt7WkKe7gLa+nAr5SNUrHoomD8ScMiVdE/2bCOaktT8how7YQyk
         TZLwQbWqj3KWgdycel8MvNSkeiUsUZ7oUtyRPyEsQyg335c98XYU9O8q88X30v4eV9Fd
         iFjpupGZda1A/c2b/gkWoTIZ9qf9oU6rzMXeiNxXiIHpacIVo5czh6SmcfbsiN27OBpQ
         //xBKLegiKvlJRa4f43NxDEykcTMgHY0xqt6AZ/uBdUyuxzMoNLpgwxNQG7X4PuGMOmV
         yv76yuuOeW3mtyd0el3MzFCashXQHal4Y+wTE4ftYI4cwFOPSVGw3YZI7zCn4wJC8WRZ
         xmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785229758; x=1785834558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AAhm5OULc+8iEzNqpaSE/brnzZbvAo50kBAobxfR7Mw=;
        b=JChhPS1lVfhPhEYtNild/3j8eFaF+LcxWVnXtHYoWSjVt1KYuMP03jtwCoA0aZXnNo
         neBLRz3F183zcLfy0+HV9J8cKACon9aIlBuChJQD2gWhqwVbmWEY3yFITtlMQBBoIypO
         ZBue9S8wRYxcZDYIEBXq5Eg2a7TatuceD4d/fZispe9FFgfWaOfUyqBweTaqLch+CH1b
         mnFft54LbOCedT+dksfAhMxHfpwfGzNvozDi7+EeMmahhNXC4se9+RlpjACL5JSNNYWy
         EjtKKplCxVJjV7u4uhk2Os7SjO2OLwsM8fcp+Lc711K7selNAUDiy4Q0IVGxHzPqjt/H
         bi4w==
X-Forwarded-Encrypted: i=1; AHgh+Rrttkx6AXsaeVpNX49MXfGozkfkeagOWY+qF6LlIv7N7LCFiMnRyRpQLgrGen8pVhMi+rHX6a5i9b83YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKRCOns8/W6lxr9G9IyvEjp4Bk/aouFlXpuDLbAgz/ojfq4PI
	L2CImLG/Kkw588jSpLwnd6g8zgCQAz+BPUr+EYRfmU2/VLYwGPUwuYgDLtusSsQUprmyJIpx/vr
	wei3gNiLJL8lH5ek02eVKG55LGBCSH1k=
X-Gm-Gg: AR+sD11NYKV1/04dijNikZ/NXqP+mCYoh6DizlQj/ufCujmDTA6QWd8YXqkAgCNTFfh
	fwHevq6lKOkyhRRyANuQxUUthCALr1GGHU9oJUPpQfLYhrQCgB6K62979ug6XGmLLkYR62Za7nT
	DGE9ciSjaCQQwayeKgYn7OqbVVV2MCBZDMAhlheTZ0sd/KXtsC9ZyV4XhpGsX7GEe4l4oTPfWQw
	SRsbOjh6NNORwEm1wzPS/EYKDc3FLwylG7nbYGePflLGptqC+HMlP6Z9LWkcaQ=
X-Received: by 2002:a17:907:1b1f:b0:c16:8404:4631 with SMTP id
 a640c23a62f3a-c1f720fddbbmr76680966b.26.1785229758194; Tue, 28 Jul 2026
 02:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com> <amgE5z5QEYa5258-@google.com>
In-Reply-To: <amgE5z5QEYa5258-@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 28 Jul 2026 17:09:06 +0800
X-Gm-Features: AUfX_myDyieNySLdz0XlujHur2PjroAeYZyBEI3F3bupTTh5ZGiK3shMAfIo11U
Message-ID: <CAEjiKS=SOTQFC4PrsV2VHkP9z3NxceuhUQavtvd7ZaZytWGDPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:27=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/06/27 15:02), Haoqin Huang wrote:
> [..]
>
> > diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> > index e295d4125dde..f4b26844e53a 100644
> > --- a/include/linux/zstd_lib.h
> > +++ b/include/linux/zstd_lib.h
> > @@ -1241,6 +1241,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_D=
Dict* ddict);
> >  #define ZSTD_SEARCHLOG_MIN        1
> >  #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other str=
ategies are limited to 6 */
> >  #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster =
strategies are limited to 4 */
> > +#define ZSTD_MAX_CLEVEL              22
> >  #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
> >  #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constan=
t to an unsigned results in a tautological test */
> >  #define ZSTD_STRATEGY_MIN        ZSTD_fast
> > diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
> > index 6ab8be6532ef..db3b275b502e 100644
> > --- a/lib/zstd/compress/clevels.h
> > +++ b/lib/zstd/compress/clevels.h
> > @@ -17,7 +17,6 @@
> >
> >  /*-=3D=3D=3D=3D=3D  Pre-defined compression levels  =3D=3D=3D=3D=3D-*/
> >
> > -#define ZSTD_MAX_CLEVEL     22
> >
> >  __attribute__((__unused__))
>
> I think the zstd part wants to be a separate patch as well.

Agreed, I've split it into a standalone patch in v2:
  [3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
