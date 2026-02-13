Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AD3590B6
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770985510; cv=pass; b=iRkRKOf1iBo1CoqeUpJK3+VKJpCEy9tHgegUgeM2lzueP/oVuayC7+t8AuDh8F7N/1cMF2ljHaXr7439WiG35IS0csa5Gns5D/W/0/XA+r4tpFp5cPdI2XllDec0oPQEW/m0fyyqGnRM4axrzvQIVA1qDU856lrpCwzYMfbca6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770985510; c=relaxed/simple;
	bh=h/iqHExUT2GB2jR3341fJVC2UQlEXZpsnLLjjyXYUQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6gKkS18qj3O31rSRGomdYFGVEdeFJAH/BniQlyPS6RrxnbKBh8CNOky+DrBjcX1nc6MzhVdAFooUzM/Xuw+EsTHH3rnJslLi8FVGh0wr74jm92oMtZSfcx2mItbCMytaKYlrU/5DpMLdLVLHWFgxDaGvFxQGhS3xEyNz3MzsAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epNLT0zQ; arc=pass smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epNLT0zQ"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8f97c626aaso120591766b.2
        for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 04:25:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770985508; cv=none;
        d=google.com; s=arc-20240605;
        b=jVy+eTkBE3HcL2YrAPopvKTBaECb/LHKAyH12LMLb6wlafT4JT7jVRO7CGivTobxNy
         o9RdNBZjZT0Ak1IM6rXUmV8HHOCZbDQOq/J/c3QMsidBqSj0UA1I9DSXgRgMOd6J1wCO
         jE/E0clR4U/ZVl2jO0QLl7qd19q1mTDCVAiXDdQ/dQLCl8rc5+7PsVbD5lOW7QEPYIt4
         uGKzyDevDTRFexnslcpiKaLYuE68P/K4zSavMEdzdJiuJKQ6+KTtLDj3Bxz85oGUh2F9
         MMBW11UipSyXGxY6k/ptDFDvewg/VoHC7xi48UnrJQAZDFPqINei+QIzXVT+kYQfymeV
         nQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IpcRNYho/r9fRckd/Z5o01Z82cEBweePuEbrYmrG4w=;
        fh=lmZ/4WhuZpq6K/j2qGPBBOnMvp4nbqivfqj2UFs/dng=;
        b=Sx0MqCjbEDUI1f1+m6r9oYl1htE18zDCG606YI7OFGQ+K5qMernByyJ/jvf1UGXD8A
         0BmVIkhvi4ByrCYQ319gVrkmdTgRF/2P3x488QBVX0eTgiVHbF9ruETLOupmiI96zSCv
         v2arLYQqIZPQFej1aRfLexpTkvv79PnEQ7ensRRRFtTwtVcmhKrJjH6QbsUyXApToCOd
         7zBbdrZTr/nddxI3aLkmx8JHK006zHpkyFqG9pCkr/Wk3sb6vtPzz4ZwmjczX99VvZL1
         7gagLTMLYz63A3vZqNmBsGLWeLAECnD44X9nzpojOlliw+uQsgZGUX985O4wU4maIkuI
         31tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770985508; x=1771590308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IpcRNYho/r9fRckd/Z5o01Z82cEBweePuEbrYmrG4w=;
        b=epNLT0zQbSvp8K5WY8WR/1BnBFqpHImZ3HL2xC2jBSdDLMsUZlVln29yxWmED/nBPU
         7tiwmK6rN0Axs24iXVnZn5vJsbtTntnLQ+/HXyGGmFCnQNXR5gJvaplPDnBpUvta2Js/
         N11pZ+raFg7cOfp3YMZfQwQCAkf/5BUoe4z0Jyzs/hJU8S2/bh7ui2lYpCkWcqY1XWx0
         M+O8QOIc5zo1r8mInwyYwPIGJNRGYmvbS9d6xQ6eyG6He5WHv9n4ONfS50apNp+n6ZGL
         Y1OF1e4/5FC4x1FiVvachxmX0hP0IbUwXotHEi5fvl51PMfcWYA+2jYmhWA+HUoYveXz
         2eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770985508; x=1771590308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4IpcRNYho/r9fRckd/Z5o01Z82cEBweePuEbrYmrG4w=;
        b=Vck5+1ypptZwB4HIFO/6tLJxpK1GUGXIRxWtB4cNGOcQu8iHu8FKCndmVBl40n7R9m
         PanLFtWcPbSeObqVEgCGFFSiGN5f47e9aq4JjkiiZl/wV2uqB9e34dHwQeXC0GGvB9P7
         ILbjxUFmC8i1TwYoPOnbGoblH9LFgwGBw/FD1OGv0eNaQxcIKd9aIWc0TE2i5MJmYB1o
         Vs5dfLGDcGgrwVvQvCkaXYU2bzCIAezi8Cz4Vpr45DeWbZqT8Q7KWHhMbFLxWy1Gq+2I
         iPkjxpK7qc7GQhpEDqrPvrEiNiLrAc0viv6B9BW0wK+XfLbaQJ18X3e9pY3M0WncnH10
         z6pA==
X-Forwarded-Encrypted: i=1; AJvYcCWFSo25qn8nQIaIOIdtBbPRxjX7UbRvdVxnZHpasa3zt8yMKz0aeu6wybR0Es0CS06wbMzjjPhbUsi2HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytYI+lJkhDFnZlSppAU2PiNao5c/mNDHL7+/b8LQipmUGxKkPD
	womHXp3JVFS9laad1uOS5sXz6HhYTEDpmveFmikyX/ewOKxVKSNQUPoNRK3uhaNuypWNrm1xV/D
	LTecgvkySlF6x0T82rD+tZjLb5Snr1CA=
X-Gm-Gg: AZuq6aL6crsl9RDwcG+ytQx1iDUkKuz+LncLvxEcHw9o95IZeW8VOYcAqvu/mNpjhsb
	tVJibabB/i74sc39smm7WHcCbFt1kvPP+9Vu7n1cvjtfyD5VjqyPF3ebnnmGwMcN7VdrlHIofhg
	K38eP8UV2u/NcIOr0OXLjI+ev/yJ07WMsPy8BluvffEWQBl3jANmY/epXpqCQiX3FxgQoIiredA
	m0D2dlrpXwgFE4W4cjg9Bx+PHUFR0hpATOX+zI4NyXYE3KNspy//1KTr+JQZE6agjUZqRquGGEG
	UZouwYP1
X-Received: by 2002:a17:907:7255:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b8fb4167f99mr82011866b.9.1770985507288; Fri, 13 Feb 2026
 04:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213073829.182168-1-wjl.linux@gmail.com> <890f2571-fb46-4ff2-b7ea-7cfa10bc8797@fnnas.com>
In-Reply-To: <890f2571-fb46-4ff2-b7ea-7cfa10bc8797@fnnas.com>
From: Jialin Wang <wjl.linux@gmail.com>
Date: Fri, 13 Feb 2026 20:24:41 +0800
X-Gm-Features: AZwV_Qhv4kDPYOaKtg_fIpi53hu2WdEStY0qq8lL2eMmGnu1Y9LX5_oA7bdlld0
Message-ID: <CAG18Jnyvs9Ob2WKQV0LQYGrq3F+czrRukhxW5JCza0iZQvbh-g@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for
 cloud disk
To: yukuai@fnnas.com
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, lianux.mm@gmail.com, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 8:14=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/2/13 15:38, Jialin Wang =E5=86=99=E9=81=93:
> > In public cloud environments, block devices usually enforce performance
> > limits based on two independent token buckets: IOPS and BPS. The device
> > is throttled when either the IOPS limit or the BPS limit is reached.
> >
> > To effectively manage "noisy neighbor" problems, we configure iocost
> > model parameters (or vrate max) to approximately 95% of the cloud
> > provider's provisioned limits. The goal is to strictly avoid hitting
> > the storage backend's hard BPS/IOPS limits. By saturating the virtual
> > budget before the physical limit, iocost engages throttling first.
> > Unlike the indiscriminate throttling applied by cloud storage backends,
> > iocost selectively penalizes low-weight cgroups or heavy-traffic
> > perpetrators. Consequently, IO-latency-sensitive critical workloads
> > remain entirely unaffected by the congestion. Extensive testing has
> > verified that this approach yields excellent isolation results.
> >
> > However, the existing 'linear' cost model leads to significant
> > performance loss in this specific configuration due to its additive
> > nature.
> >
> > Using tools/cgroup/iocost_coef_gen.py, we measured the following
> > performance data on a typical cloud disk:
> >
> > 8:16 rbps=3D173471131 rseqiops=3D3566 rrandiops=3D3566 wbps=3D173333269=
 wseqiops=3D3566 wrandiops=3D3559
>
> Feels like a model similar to blk-throttle will work fine with your IO wo=
rkload,
> what you really want is blk-throttle absolute threshold and blk-iocost re=
lative
> throttling, correct?

Yes, that is exactly what I am trying to achieve. In cloud environments, we
need the absolute limits to avoid hitting the cloud provider's throttling w=
all,
while still benefiting from iocost's proportional sharing and weight donati=
on.

Do you have any specific thoughts or suggestions on the best way to combine
these two mechanisms? I would really value your advice on the implementatio=
n
direction.

> >
> > Dividing BPS by IOPS (173471131 / 3566) yields approximately 48607
> > bytes. When running fio with bs=3D48607, we observed a 50% drop in
> > throughput compared to running without iocost enabled.
> >
> > The reason is that the current 'linear' model calculates cost as:
> >
> >    Cost =3D BaseCost + (Pages * PerPageCost)
> >
> > Expanding the internal variables relative to IOPS and BPS, this is
> > effectively:
> >
> >    Cost =3D VTIME_PER_SEC * ((1 / IOPS - 4096 / BPS) + size / BPS)
> >
> > When the I/O size is such that the IOPS cost component roughly equals
> > the BPS cost component (as in the bs=3D48607 case above), the linear
> > model sums them up. Since cloud disks throttle based on *either* IOPS
> > *or* BPS (whichever is exhausted first), summing them effectively
> > doubles the calculated cost. This causes iocost to drain virtual time
> > twice as fast as necessary, throttling the device to 50% utilization.
> >
> > To solve this, this patch introduces a new 'linear-max' cost model.
> > Instead of adding the components, it takes the maximum:
> >
> >    Cost =3D VTIME_PER_SEC * max(1 / IOPS, size / BPS)
> >
> > Which translates to:
> >
> >    Cost =3D max(BaseCost + PerPageCost, Pages * PerPageCost)
> >
> > This formula correctly models the dual-bucket behavior of cloud disks.
> > It ensures that for any block size, the calculated cost aligns with the
> > actual bottleneck (IOPS or BPS). This allows the system to reach close
> > to the provisioned BPS/IOPS limits without premature throttling, while
> > still maintaining the latency protection benefits of iocost.
> >
> > Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
> > ---
> >   block/blk-iocost.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> > index ef543d163d46..ead478d8e5bc 100644
> > --- a/block/blk-iocost.c
> > +++ b/block/blk-iocost.c
> > @@ -445,6 +445,7 @@ struct ioc {
> >       int                             autop_idx;
> >       bool                            user_qos_params:1;
> >       bool                            user_cost_model:1;
> > +     bool                            cost_model_linear_max:1;
> >   };
> >
> >   struct iocg_pcpu_stat {
> > @@ -2565,7 +2566,12 @@ static void calc_vtime_cost_builtin(struct bio *=
bio, struct ioc_gq *iocg,
> >                       cost +=3D coef_seqio;
> >               }
> >       }
> > -     cost +=3D pages * coef_page;
> > +
> > +     if (ioc->cost_model_linear_max)
> > +             cost =3D max(cost + coef_page, pages * coef_page);
> > +     else
> > +             cost +=3D pages * coef_page;
> > +
> >   out:
> >       *costp =3D cost;
> >   }
> > @@ -3368,10 +3374,11 @@ static u64 ioc_cost_model_prfill(struct seq_fil=
e *sf,
> >               return 0;
> >
> >       spin_lock(&ioc->lock);
> > -     seq_printf(sf, "%s ctrl=3D%s model=3Dlinear "
> > +     seq_printf(sf, "%s ctrl=3D%s model=3D%s "
> >                  "rbps=3D%llu rseqiops=3D%llu rrandiops=3D%llu "
> >                  "wbps=3D%llu wseqiops=3D%llu wrandiops=3D%llu\n",
> >                  dname, ioc->user_cost_model ? "user" : "auto",
> > +                ioc->cost_model_linear_max ? "linear-max" : "linear",
> >                  u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDI=
OPS],
> >                  u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDI=
OPS]);
> >       spin_unlock(&ioc->lock);
> > @@ -3412,6 +3419,7 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
> >       struct ioc *ioc;
> >       u64 u[NR_I_LCOEFS];
> >       bool user;
> > +     bool linear_max;
> >       char *body, *p;
> >       int ret;
> >
> > @@ -3442,6 +3450,7 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
> >       spin_lock_irq(&ioc->lock);
> >       memcpy(u, ioc->params.i_lcoefs, sizeof(u));
> >       user =3D ioc->user_cost_model;
> > +     linear_max =3D ioc->cost_model_linear_max;
> >
> >       while ((p =3D strsep(&body, " \t\n"))) {
> >               substring_t args[MAX_OPT_ARGS];
> > @@ -3464,7 +3473,11 @@ static ssize_t ioc_cost_model_write(struct kernf=
s_open_file *of, char *input,
> >                       continue;
> >               case COST_MODEL:
> >                       match_strlcpy(buf, &args[0], sizeof(buf));
> > -                     if (strcmp(buf, "linear"))
> > +                     if (!strcmp(buf, "linear"))
> > +                             linear_max =3D false;
> > +                     else if (!strcmp(buf, "linear-max"))
> > +                             linear_max =3D true;
> > +                     else
> >                               goto einval;
> >                       continue;
> >               }
> > @@ -3481,8 +3494,10 @@ static ssize_t ioc_cost_model_write(struct kernf=
s_open_file *of, char *input,
> >       if (user) {
> >               memcpy(ioc->params.i_lcoefs, u, sizeof(u));
> >               ioc->user_cost_model =3D true;
> > +             ioc->cost_model_linear_max =3D linear_max;
> >       } else {
> >               ioc->user_cost_model =3D false;
> > +             ioc->cost_model_linear_max =3D false;
> >       }
> >       ioc_refresh_params(ioc, true);
> >       spin_unlock_irq(&ioc->lock);
>
> --
> Thansk,
> Kuai
