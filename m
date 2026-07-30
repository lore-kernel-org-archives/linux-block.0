Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D8372ED6
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391076; cv=pass; b=Q8ENcKiO7LQYEVpnHGM6wOticijuvRjy10hu5kHN20kzaEGdEiMbrU1I27MkeKa8UH1V4v8kvBwiVv19DBnhQyt4fSxhkEf2fxOGzivwvIwpVdo7Tyo0GoogdwPfLisPd65YDl/OA4Klp59Edh41HO4atkK93BkNEIOwBKf1pGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391076; c=relaxed/simple;
	bh=oYFfriLfuyoK+ROapFu5cHnHDlTGwTliP5WSVu5C83U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX7J20OxRMEpPwYkw+MhJNeMWPxZmvtOi+mSg5T0YmJuE2eccHoo7yW/U1TWeNpdvZWH11xwG828dK7ybZNu+iB+ynPXGGk6DXQZBe0DbibIducczxq/2mNHP/CC2HRboMtK8j8d9dA3zIrXz2q0sqVuLt1j29SSkBMOyfCp2f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATpOoN52; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpOoN52"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c1c5cb0f9f1so69750966b.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 22:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785391070; cv=none;
        d=google.com; s=arc-20260327;
        b=UhHFzTFbNzJza1YK2TsHG4ds/2RKYCJ8A2LYD4Vbp1VbSdeCD5YR+L3XNDNcJ8PiXI
         x1yth5ue8rGxO52jrAlxAZYfelFO7kZB+B4T0LQNu/l8DYFKOgy3LtOlNpzDpHdeXI41
         7pKGdTdOwu8G58KsW6vK4KdJnUT6iq1O0IECa/YwmNhoVuNNbh+N0KvyZ+jpzyHTjwGJ
         r34eQrlipDtcxNa54QqTMNnUFZseIIqxPEPPWhbBN5ieQnVauThNncxULeqXm82Ih9xj
         MQqAxSPgILxipAm5oos+ME/+hpOK9IjuNISay7ijw1tZGAZ/P1PE83zUZbA+nMlC/3UQ
         qaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6OLw97VGJFhAg3DPpLMylYS1Rqp00aQWPntGBMsHGtE=;
        fh=hnF4sYsUeAMrn84d/G5gRitkXZIegOKRjWP4vPAVIkQ=;
        b=kExziS9nSJ/14iWuyyFwP14oJ6Aci+WLYzjzYucTWnihDATrdVy39hnJn8K4NFLiS2
         VLfGTxpjIGNT8CWgTIAD8NWRXe2wE6Po3CpsqVEC5igJF7gENQIA0ivq9d2ZSGy3mu7Y
         tqBN6brY+Ja5+EnyTQqAD2nRH8HT4PeyYsI1B6CwStd6UnVB03NLfx74IO2XJ13FzQCl
         iaOA0nResyjGZS5+2DMwpFWTnJcrSxqQfNcXf+V8I2w0247JrGXxS9EX+nC7KKBq+VBZ
         A/KuYzqgoZtkyYEQ5yCXbz4fMdEncMLhGQ4J5ZuXAM6HIZwpPih8+wOVNeaBr1XNuDE0
         D9Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391070; x=1785995870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6OLw97VGJFhAg3DPpLMylYS1Rqp00aQWPntGBMsHGtE=;
        b=ATpOoN52KgjzfOizLlqVw4nKEmRBUABqs88BVHhNn7/dzdQywTqLXo7Z1JCK/u1aj0
         VHjSNpTkh0TjVA3e7tvkoImB/O98oF6eFPJsa85yDb4+yEHRwUiCBNgc7z8aa6iu2j0V
         0vcepQ1Jzqb5SL1S36H/GdSFTOCIWl28QczSU+GdOXbg9aaf8YPp2LkpQE1MT0vqgcYl
         kdl45q2HwWmPGuAKN56HSashvycRLeWMpLisKyS+eE7lVhGVubETkOoV+II7zppjZXf+
         /7K9Syf16EGKAOSz7+irNX5BiP2oA9S7HGcni9Aj3qsKYietTLM1EDUkmwpbd2Z+q7Rk
         bntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391070; x=1785995870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OLw97VGJFhAg3DPpLMylYS1Rqp00aQWPntGBMsHGtE=;
        b=MllVQ4NdmWkubHAtZB3w6jOFx/b3CBhOXEk+jXvEz/EwPbOpHkwJd2tFQUo0P3bcju
         WeLxbKRore8ZaSeO9icUWibarJeAvIhL19FP9VrTL0FJiHBplGmhYhsI5xM17obnOBfC
         HXm1VJoDGD5Jf04DdyUXeJS+5tzOlfOodusstW3plftqVKWuLMVEf5f/uA+RfLzKstsB
         iCXcHRRPeSiPC2bkjsWnnNz19rkWgKEZBqFxysyUVof+a+iOPDCOhtbVdSiIUPnKmqWG
         rx4hXQsJn4dl8HHya+oq+mqCrdfPSPJara5Y8xi3+q4tq/M6tky99wzk6z/Lw20X8DPb
         ygNg==
X-Forwarded-Encrypted: i=1; AHgh+Rqd4Y79W+6cQbPIXKFq5uBFaiCKVc2csCB7FsS0FsTouN5MNDprpZVt1iZfFU0aeclchyXb3R6CwGamJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrG0dmbtGSJnVYS1J8oofYI201Xlsy5FKDsAOsrllCfbHO2GNp
	krB1IGNADkhGmIKV4OPJKEKjwCappU6gHv9jVmSPh3e8EywmRWuuZOLKE0KgHSc4iene3N8F3i6
	mup461fWwNiV52BKsIn9TyEf8SsnkIgY=
X-Gm-Gg: AR+sD116ILMHeA7LKBxIzXoVb7GTIkqM2uCeaVoCrz9E6AoB5GtHgbpOOiaMSBSk6Is
	P3OuCajalzLc4FpELHaYOyufyUFlFj5A3UVKuGYvnY0hhoGRySpkc2lu1tBTszfUz8lNR8WIFsW
	kJdRObQjjFEcBmEVYIlCulSp7/dVPrSMd8lf9U97jrE5fGHOSftfI0g5g/rS47z0OwXfQ+onG86
	6JpEg3BwIC+DZmz72KYNGD5+IJq/C/HfnKrzo2hyZn5Y3hYGmzYI0Gms79gxSZ/zb1xl1/xzcuC
	y7wr4DkotCO7hk9/r18l5tyepaSxyPLDudLOSeU8yCuFJxOIqOq8X/U=
X-Received: by 2002:a17:907:db16:b0:c12:764e:326 with SMTP id
 a640c23a62f3a-c1fa547d775mr58436666b.27.1785391069615; Wed, 29 Jul 2026
 22:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com> <20260730025240.17724-5-haoqinhuang7@gmail.com>
 <amrAyfqsKY2JH4zk@google.com>
In-Reply-To: <amrAyfqsKY2JH4zk@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Thu, 30 Jul 2026 13:57:38 +0800
X-Gm-Features: AUfX_mzWqXziPqyic2bt6K7w9ylhcEp3D5LTid7H8KSn2JUQ7Gi0BzQXYLd1uVY
Message-ID: <CAEjiKSmgvA+6PzRA-u3by99bP7mJrkRb+=Er1Qt1j=mAsBRzGg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] zram: add per-backend caps and validate parameters early
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 11:14=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/30 10:52), Haoqin Huang wrote:
> [..]
> > +int zcomp_validate_params(const char *comp, s32 level, const char *dic=
t_path)
> > +{
> > +     const struct zcomp_ops *backend =3D lookup_backend_ops(comp);
> > +
> > +     if (!backend)
> > +             return -EINVAL;
> > +
> > +     if (dict_path && !(backend->caps & ZCOMP_CAP_DICT)) {
> > +             pr_err("zram: %s does not support dictionary\n", comp);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (level !=3D ZCOMP_PARAM_NOT_SET) {
> > +             if (!(backend->caps & ZCOMP_CAP_LEVEL)) {
> > +                     pr_err("zram: %s does not support level\n", comp)=
;
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             /* level_max =3D=3D -1 means validate in .setup_params() =
*/
> > +             if (backend->level_max >=3D 0 &&
> > +                 (level < backend->level_min || level > backend->level=
_max)) {
> > +                     pr_err("zram: invalid level %d for %s\n", level, =
comp);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> I was thinking that you'd move all params validation to backend's
> .setup_params(), not just zstd, but for every backend.  Sorry if
> my message was not clear.  Can we move all validation to backends?

Sorry, I misunderstood. I thought you meant only the zstd-level check.
Done in v4: all validation (dict and level) now lives in each backend's
.setup_params(), no caps or zcomp_validate_params() needed.
