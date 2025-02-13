Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A281FDA76;
	Thu, 13 Feb 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415840; cv=none; b=TgjRhMPPqXBLE+4i0cV9TLBdoAj+0j3eYAAAYZ66USWwY32hrHqmkNpNBI5a4plvORHzguOnK0OiBDdbV2ijGOB23ZTj4GrWAexrSHnDg6CojtIu/XrbiRTR08CpD9uEGHVgTAFKyEl1EuITaIcwPQaFY2rZa76AWlTKgO7SJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415840; c=relaxed/simple;
	bh=mSad1hkwmEAsAZOzR2l1cljwAyHO7zbd2n4TbREAdkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAn8BEoy9r4PFV9SpYCM1J/49w7qyD/6D2CEaguPCmDWik3QzFeJJouxaGLd+8fPgmwG/N5xLfIIZwwGdAFqwTaTscqFLEY9dFQi1mlq6R0ugTDVhh5znt98Rsvsd5azfroVyM5RGvlWqI+IBLkPNdgHUjy2pQbnc7mqtLrBc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu/X3FPv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu/X3FPv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f62cc4088so5705255ad.3;
        Wed, 12 Feb 2025 19:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739415838; x=1740020638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHp4alut19oloxCzjxoPjvEruLOotLPpNPsPCt3aeZg=;
        b=Tu/X3FPvJqepHlqMpMgIFzN3cTyCO2XD9DAuxVrAaOeE5KRHbHGZ+qPpr1OCol6q4i
         Sq6/2Liy7C5PtTjOdSxqS6BW3zHeXBVPngc1ELIOiF/qqCL53JrWd2HMlSI5kL9wenNc
         NXnGRtW39DyHTnIIo9FvkI1KCq3Zv2aFq0Dl//22WKzEN6xGPcDcKJDWEXPK9zJ4Rc3j
         hTgQycmoc2/9R5hdfgPhRI576DQtSFsKhWMWxK89EAUaBA92/Tumhc7M57Qgq2dJeB3k
         EtoC7gG4hj/hnkJCLCUbQt33Cks9EosTLqhopHfuC//IzbVoUFBBn5fQ46m+4BcBZoDG
         ouhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739415838; x=1740020638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHp4alut19oloxCzjxoPjvEruLOotLPpNPsPCt3aeZg=;
        b=j+mnxCT9fT6mdSCz4fm5Qn3S+x1iPaGoHw6KKwFlWvLCZBrsVY03yxX97erwsIjd8J
         38Hvdw7R4LR2WoW/AwrGBPii8E1HPfzcuFyXtw6FYmZLGTGQxGpq6OfnWX1eaqz1obiV
         yYak9k+UsgIaI6/qcMS6KH220c8WFAMGyZVP4coQj3zCpsyoQSk+XA5vr9y0Updk7ZCD
         tKD2/9qASypy0Xh5jkeb3EKAF/punOPWFhe8jWzlbLoC5/5SBECYnAXqGpf6hAmfGLHv
         OQXKFvcsnkTz75cj9DlcjIgDyFO5bpSgQGV8vScDf+EtCtzC31w8Y1uEGMvWj03TxvXS
         QAhA==
X-Forwarded-Encrypted: i=1; AJvYcCUCwRYQJEb0POyoK9JpaBU8Fb6CY114SSl0AVTWBVQKvvAR9gmXbQREXWgDG+E/oOa/a5Y9qi8gFa6sTuZf@vger.kernel.org, AJvYcCWtJ9P73jCGzQ5CJq20wun2SAebQ9lNC3wqWWvIMWBcBIwcAMco03Zv8tP6r9FEXGWlb4mYJXnTr4qHQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziYBmpAaf+vQ2AU9JDFpR0xU7Y3PoPsL6WAG5pJYjsEzuzipT6
	Z/HndC7TNaM3DSmSrlK3igdjJuJpnFJc3RbvR++TfnNiJVBwqAWuppV0kiKKWkGzJtWRd0dgYlg
	zsJ5RAdnqwac7yIdQyPv/+nh3AdHRDqMB4Wo=
X-Gm-Gg: ASbGnctIhAsjxVYHhH2VVYBGC/QYMCmedtjXsDSb0NILxvc9jsdRjI//TDKvrwCBlng
	sdCx9tzFIr3+6Yrzac8E1QG6pQ1tCJzCrQXVn0gwfxsnFR8clQdhF07PZtLNfXhPw2pfyVws=
X-Google-Smtp-Source: AGHT+IGMD0q0aHtEH7IDH336JcRX6ZajiRUxtwyklpdMns7TMq3ADF8lBM1QgO3aok/6y0f51VjtOGjbKvYs+tR/OXE=
X-Received: by 2002:a17:902:d549:b0:216:6901:d588 with SMTP id
 d9443c01a7336-220d1ed1f92mr29416855ad.15.1739415838106; Wed, 12 Feb 2025
 19:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212030055.407090-1-yizhou.tang@shopee.com> <e8de697b-e098-97cd-fe3c-800b59b2c7cf@huaweicloud.com>
In-Reply-To: <e8de697b-e098-97cd-fe3c-800b59b2c7cf@huaweicloud.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Thu, 13 Feb 2025 11:03:45 +0800
X-Gm-Features: AWEUYZmxkVDEYB0FDPASTKzoHC4PHeYsG13C0CnTyBZshm_HoVg1FXcFA3s7kLE
Message-ID: <CAOB9oObJ6O374EnThRs4FSchTZeJ3v_153mVHCgXK8EOOGpCnQ@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: Cleanup some comments
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:56=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2025/02/12 11:00, Tang Yizhou =E5=86=99=E9=81=93:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > wbt_wait() no longer uses a spinlock as a parameter. Update the
> > function comments accordingly.
> >
> > Additionally, revise other comments to ensure they align with the
> > actual implementation.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > ---
> >   block/blk-wbt.c | 17 +++++++----------
> >   1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index 6dfc659d22e2..f1754d07f7e0 100644
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
> > @@ -446,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *c=
b)
> >               break;
> >       case LAT_UNKNOWN_WRITES:
> >               /*
> > -              * We started a the center step, but don't have a valid
> > -              * read/write sample, but we do have writes going on.
> > -              * Allow step to go negative, to increase write perf.
> > +              * We don't have a valid read/write sample, but we do hav=
e
> > +              * writes going on. Allow step to go negative, to increas=
e
> > +              * write performance.
>
> Other than this clean up, the others are actually fix. Can you remove
> this one and change the title to "Fix some comments"?
>
> Thanks,
> Kuai
>

Will do.

Thanks
Yi

> >                */
> >               scale_up(rwb);
> >               break;
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
