Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662D2D9EDC
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151385; cv=pass; b=RzKgfO2tIHxBkK8rhC5t0BvHDlb2/H5OthDEGQm9MbOxLGYsLuTUom7QsbKKEP1aWB4QdJuaIFLuluhJ8INM+ns4S/P0HPJcoyifVyb/8rg5PykvQleZio43ydBABJepIrv9B55B+LBAwM7WK2/qv2YbhRAt5F3DHmcuJVi2CWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151385; c=relaxed/simple;
	bh=t8Uqc0fYYKsuzOBE55YHlxelJFfvA3Jskj7e0Dhpho8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2gN212ILpacKuW/RHmBTls+rKfcQiAPI3AsSdbo/w7F3zMGkz9Y1HIv0KOKwPAs5k9lTyFUl3YchXmNQ8uMXuXiCB6ZSkUmgyGD4ERRyj6ttqTZCpNa8tSEQdzOVnL/j4ffeZBsC9L9vAQJmnuWHciy5HsfRYR0kG3kLSYa19o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVMnzGf3; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVMnzGf3"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509069a7a7fso564501cf.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 07:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151383; cv=none;
        d=google.com; s=arc-20240605;
        b=M2vOcBYKbGGUJPpm4Uit8P2Bw73nRzLgldTuevBoHIH/UAEL5wR4Mf3yyT0rmCdC1c
         s5bhCuuwQig93Ldqv1An5fcXl0pGCfaazaoffAVYUM4+dg4gxor8v3WcfuVBFxtRYu6J
         t7f36/umJ3tNg+aE7YdMLuAhvmjA7rMRUojp/843VdLGlwqKt+kVdj8aLt59XEQ9Fkia
         GjH02RPrnGeAZ1Z3BDnlulH0HEEpb+GboxSXAtqkSv0jVHopnzhyh1Zi3v2gquzi2L1k
         xChxfmIMlmvMN3cBW3D6Ku3KReJdh5dBN74vUMjed98Gq0XiR/ohkZaxfh4mc0MBn5/u
         P9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIavvIBtTtHaasvUFabIuv5jcPdC5cBsH9MQOa5Z8Ag=;
        fh=Viz7MHGtG4Jbs/ZGz7yjZzMS1HeDNXP2eZVJv0kh/gc=;
        b=BtsaaEBsWNhqJbfHdRcHfJSF7k2Jp43UdNc/cHmAdqhnDBpIc+HjNGet/+T3D1xqPH
         mCmKBTTsq7kWqR6YZaU5k+9tIm71JEgDDt9wmZR9Pd+m8RnvFEiZc50dyMXDR9L7bP6R
         m1mV24inJ/NcyVoiU1Bs3EFp2bovDGLHQMVqqBiPz1K4gzm7EJfC7Bm1MOM5BNmqNyEt
         9Ju/y6v9S8JgVjfG17qU6NWdKMXksO/TBnFc2d0KpDnJJamCmZKYlx1dSbdalDroBH3A
         7tb4FJa/WskWdtYHC+drJgGGXtjibzKgUsUuL5vTTW12HH2mWyb/iuf8SD714AshfQc5
         bmFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773151383; x=1773756183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIavvIBtTtHaasvUFabIuv5jcPdC5cBsH9MQOa5Z8Ag=;
        b=iVMnzGf3wWF7BB8Egl6m0pR8gqZrxRdp4tXwUbA7Hy8JbrUBlYnA3O1ymAnWOO0CYw
         uXGuHPOcbHGQu16ViZJBfmZSK/0/SoZlr0RTz/E+9JAMaqpQStCCL7O1Yi+7+OIa4Ad7
         XtZdMPpTE0wFZWEnlDp+3BCoyFcVUALMwzAJ5ZXBFFnstkb0lod11M5A8kAtAr29UTWu
         TRly+gBv3Fo5dgsvf4NCI0lLlyNV5UmeAloJ1Us2ObKYP0Dd9Kkw88stj+Nt47U5EBJ8
         OpkBaW15Vc+KJ+5FDoWvh17RTU+3ayDcX8xUnHYLO2j9ERgci4e7stBpb3xSj98NBuGY
         iA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151383; x=1773756183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIavvIBtTtHaasvUFabIuv5jcPdC5cBsH9MQOa5Z8Ag=;
        b=fU9fjajQMrVTsWBB1EhrX59Iq741Fo/CHliw6aa6ifbG0tmgGStkMrtTjLVE48FTXU
         +V5C/ymhWWNSSnDOeOos20qbGgWeFqI3RRaMWd9hoMjvvDs589awYjFg7vjOTgg7TogP
         rBS1pc/MceqFbqX+x2KUhF4ZlEhacGt4JgHJUdBJF6PeQnRyJYGQmlKIwjC6SyRzeJWK
         rCKSEovPgLb88emH97+S54PMh1Jcc5mkFT+VabdjUmU1Frcj3RTuVtIzsY2BbLCGeSQT
         PAGram3+ozVC+aWMbOWbLHsA1bvRhCW6sEVGa7uPdwmq9nI4qI5ybwNrobX0dajl9FKI
         RneA==
X-Forwarded-Encrypted: i=1; AJvYcCVXWiVXJg2blnKswzFuujPW/+m72KJTgXfd/AqcKisr2k76gY5ErJ+CRIM8A2aPFF8mauGhvdjuKKc+rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YKQFsB7Q9JWtGpk+cD41P5e8sAf3jmi0vmYEFCOPmejRurMe
	enQtAIdjMxSRmGNmh1IWUhNOJs6fkYdLNMCmy/9H8Rkb6u3zkymZmInzBONXHqRzkTVBTiMp0kr
	hDWG9Hy/FwmNAjsw0IZdHtU3kRANodXahSQX0OwYu
X-Gm-Gg: ATEYQzzok7b4KnFdEF3SCOdDpaJ+b8mHU48saQE7rIM4eWfEhLurVcAsTJphph7n75P
	JdlXBTTyMrppoXR87dCgWOaTIBp7Na7TP6jpflWQRwxxdSq8qAEj35htZP5li0MpxeDUwO1gVgM
	tu1Umttv4SKB49BthLUb4tRwkXpE8ezgN2xLTrxau/4pZXnA2N+PvX/NwK4TfXwmPAz99Dt5mWL
	cx3r9SWRGoc1Wg2vfyHOM0mUfGF0NKUa7s9gPTWSHdqRY9M9cg22zxIR3S46v5Cfrs4nGjnuCpn
	HGFPriUD1gfWDRevUBA1Yyz/+rPu/S6Cr2jeo/H9DL3Qdc/WFFQrbIsgZD8J907okGIAUz4yTyg
	n7MKfaQzQvTt0aomUUXD59BwDiCzK7L5D1Hg=
X-Received: by 2002:ac8:5e4f:0:b0:509:105c:74a9 with SMTP id
 d75a77b69052e-50926f1e3aamr13927151cf.18.1773151382478; Tue, 10 Mar 2026
 07:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310060407.1133800-1-senozhatsky@chromium.org> <CADyq12zF3cwzSFcKYiGAdJ_G-NVnydBRQn+x0fgNq1kVgof4Vg@mail.gmail.com>
In-Reply-To: <CADyq12zF3cwzSFcKYiGAdJ_G-NVnydBRQn+x0fgNq1kVgof4Vg@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 10 Mar 2026 10:02:25 -0400
X-Gm-Features: AaiRm505DSdRTNRL1G8h-GZEtlrvi5UA2vbcMF3uI1SjdIgSiG4KGr1my05BvOM
Message-ID: <CADyq12wpJVSvWDzWb8Y7ZQAN940qPKRdHbmu-UCN1L2GkyH5Ww@mail.gmail.com>
Subject: Re: [PATCH] zram: do not permit params change after init
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gao xu <gaoxu2@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:01=E2=80=AFAM Brian Geffon <bgeffon@google.com> =
wrote:
>
> On Tue, Mar 10, 2026 at 2:04=E2=80=AFAM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > First, algorithm_params_store(), like any sysfs handler,
> > should grab device init lock.
> >
> > Second, like any write() sysfs handler, it should grab
> > device init lock in exclusive mode.
>
> comp_algorithm_store() and recomp_algorithm_store()?

disregard, that happens in __comp_algorithm_store().

>
> >
> > Third, it should not permit change of algos' parameters
> > after device init, as this doesn't make sense - we cannot
> > compress with one C/D dict and then just change C/D dict
> > to a different one, for example.
> >
> > Fixes: 4eac932103a5d ("zram: introduce algorithm_params device attribut=
e")
> > Cc: gao xu <gaoxu2@honor.com>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> Acked-by: Brian Geffon <bgeffon@google.com>
>
> > ---
> >  drivers/block/zram/zram_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index c41e1257243f..7551c5e664a9 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1769,6 +1769,10 @@ static ssize_t algorithm_params_store(struct dev=
ice *dev,
> >         if (prio < ZRAM_PRIMARY_COMP || prio >=3D ZRAM_MAX_COMPS)
> >                 return -EINVAL;
> >
> > +       guard(rwsem_write)(&zram->dev_lock);
> > +       if (init_done(zram))
> > +               return -EBUSY;
> > +
> >         ret =3D comp_params_store(zram, prio, level, dict_path, &deflat=
e_params);
> >         return ret ? ret : len;
> >  }
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
