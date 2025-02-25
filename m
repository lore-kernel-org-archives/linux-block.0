Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148E2054F1;
	Tue, 25 Feb 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487106; cv=none; b=atjvyyf1Pl2EL5Q5onzBgzYOolF2joeQO04wOMfojLR4lSCeHhCkLR1nRBKhoP1f37mHrO8eD9bCVxhFvWb5G2DGhHMBkyfGcN31a7yhypSOGtRRqW05EXrvf1fhXgqonbI30U6y7+3lC+sPTXAkg+hZbOaEd7AKI0cyKqJU/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487106; c=relaxed/simple;
	bh=fc/p/9RNI3/Af5GeNDbes7M/X1PE6vKq5GnAqJPC+Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0lUZOsmm9uCGsBALx3VwoseBDI8IV+uImgNf5X9OZjqGUX70NoQmmrQrKutqyOzMm1xUYMQudHWFPrsKl4dY3lCJAUgU2KvCr6sc/lOntSVQ3HP+JK3ydgmTsCHlmm4LLWMou6HaU0ZGdnRjLauUVdeC08beQAsabqevrwR8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdcUPBRe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdcUPBRe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ec47991aso75741285ad.1;
        Tue, 25 Feb 2025 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740487105; x=1741091905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7n6Zf3s7m/cLD7DjADw4Wy8FbLBTsdu69sH+3LCZ0=;
        b=LdcUPBRewxebfxfV/Jajp1mCPuRAp6RvArHmT4BHqxFDISh32ZMMUK8nSRLrvehXfB
         lJpZIV2IUKfXzJIj2aRDgd0F87RL3EPAyMr+E3UtOxmzvnc/mRJx2abnLFgsWfUpKEfW
         rS5768gvISZ0mwHcYtiw024bXn1vjOTqjqPcqUwvNrYUhoR2SsjFXL6rwwg6YNN9JJAI
         YG3oBf5Ps2mYTBTbnMt4bcMLvr+GqxWvmYqSqqWuqSyEZfEk2ljodFjV62UkPYKt0H8Y
         6C+MyCiHhB6GW3s6TJIBMDI6yks/0lwvpLHpuhrlQtYcGzYNrCqPlRmGCSyAVpy61IiY
         9f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487105; x=1741091905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR7n6Zf3s7m/cLD7DjADw4Wy8FbLBTsdu69sH+3LCZ0=;
        b=g+FMEsHrhb2Lug11CAI/oqzwbhlYl6zcyXn7so8GQt0nfXBcD+zvxaDWaLQAkQoJcN
         6oO+xxLRpARqMMMMdUjOfTku5CFG66R7cp6uZJ2OU2zN1B58R9lzf3MypCbXoq+REoyp
         C3BSFrCf2xkBG2vzDW9QSE/aGFA+uQSihAY2t+cB+7a+d/jBdfEf7MQ4nlnEVuy74eCq
         XOpXsoXN8diDeiZghwarpVfXjcVA8EMK5DkfA/q490oeARBTLe8QYUWIkCgBMa9FMKhn
         gNFt6CbKqYM2gR9xSesuak3A2a1CDN5sHP76GKa7OdUFlydv3nn6u6mgOegfKMb+08pC
         rE8w==
X-Forwarded-Encrypted: i=1; AJvYcCXNh+2E+mKmNNcy1uWvx8dJis9qaKA3TYQyrS6RNm1xDZcd0PntjE5BxswhXQfJY5NRaBzmHmKLeGVFfcLj@vger.kernel.org, AJvYcCXqQ3e/wGXZtyGRL2WksB2Ngwqioc+LNUhOpTJs0rvaj+4JLr0hjf9RbhSJivJcazLqMa6DR0LFeE/zjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdRSIcJdyWQchCY3Zd/a6TEY2ur3Fwpoe3AGgdcZ4LiVE4WHe
	Mz8l7pIFI4bg/PMWVEFA3FL9Gh4wHhM9oehdE6yulGqBXRQU0ugRrHWgcb0Zbtd2ddvbU1s1Nho
	8JpjBLMl8V7Bhhb0XHN/gMTX2UZE=
X-Gm-Gg: ASbGncskW89OFIsTWIHRmFbnJ6YPQMRKeHlUhwLGC/8Bz1MvbkUoOiP3issYs6JFUPP
	h/fuaKiPH++lqW9VGC2xXFMxY4y+KDRjEZdoGIKF/odp2AbTUIdKIJ/gPQT1A9iGmNtysfKal+E
	gGoE5Cgd5I
X-Google-Smtp-Source: AGHT+IEfHGSXK3Q+q0bHfxxALYebbSoZ4QVhEvjRliYDGu/KD1GkFIhtsmTkRosagZ9TMvXV+cnObA1uVeERYxcLVIw=
X-Received: by 2002:a17:903:32cb:b0:21f:37ea:47c9 with SMTP id
 d9443c01a7336-2219ff30ba5mr346486735ad.4.1740487104573; Tue, 25 Feb 2025
 04:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
 <20250213100611.209997-2-yizhou.tang@shopee.com> <76cd73b1-52f5-1f19-ae37-c856a765ebc4@huaweicloud.com>
In-Reply-To: <76cd73b1-52f5-1f19-ae37-c856a765ebc4@huaweicloud.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Tue, 25 Feb 2025 20:38:13 +0800
X-Gm-Features: AWEUYZlhrM0xZVwMN5pnVnHq74CJH6dZtxu_WvLIVVxuizaIcGmBFx0avdqYzLk
Message-ID: <CAOB9oOYvSOeTTvF9nsWH4Fbqx0DKSG0kh8m5Fc0XYoKnPBBpYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blk-wbt: Fix some comments
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/02/13 18:06, Tang Yizhou =E5=86=99=E9=81=93:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > wbt_wait() no longer uses a spinlock as a parameter. Update the functio=
n
> > comments accordingly.
> >
> > RWB_UNKNOWN_BUMP is used when we gradually adjust scale_steps toward th=
e
> > center state, which is a value of 0.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > ---
> >   block/blk-wbt.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> >
>
> LGTM
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Hi Jens, could you kindly review and consider merging this patch?

Yi.

>
> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index 6dfc659d22e2..8b73c0c11aec 100644
> > --- a/block/blk-wbt.c
> > +++ b/block/blk-wbt.c
> > @@ -136,8 +136,9 @@ enum {
> >       RWB_MIN_WRITE_SAMPLES   =3D 3,
> >
> >       /*
> > -      * If we have this number of consecutive windows with not enough
> > -      * information to scale up or down, scale up.
> > +      * If we have this number of consecutive windows without enough
> > +      * information to scale up or down, slowly return to center state
> > +      * (step =3D=3D 0).
> >        */
> >       RWB_UNKNOWN_BUMP        =3D 5,
> >   };
> > @@ -638,11 +639,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struc=
t bio *bio)
> >       __wbt_done(rqos, flags);
> >   }
> >
> > -/*
> > - * May sleep, if we have exceeded the writeback limits. Caller can pas=
s
> > - * in an irq held spinlock, if it holds one when calling this function=
.
> > - * If we do sleep, we'll release and re-grab it.
> > - */
> > +/* May sleep, if we have exceeded the writeback limits. */
> >   static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
> >   {
> >       struct rq_wb *rwb =3D RQWB(rqos);
> >
>
>
