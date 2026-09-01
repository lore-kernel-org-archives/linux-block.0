Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF78459AE1
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253834; cv=none; b=rGBUGh55UD+KpQQxnUbvmQFkGz/AxveEuCYHIE6Ou/nDZKfQ88KOSobfaPQk717HkxjBUKpTZ0Eq9MDicOX7/U0sINdE91zP5R+7AW8aNRdSqF4MfURtU1yWYTeFnU5e7ufX6UEtv0flcB9hVvlxpJnoFl5om6w5UI1PHEwIQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253834; c=relaxed/simple;
	bh=MbIyWVV1fDEvUhmmiJrRl8bgUScodrVy2todr24b9xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWQTj1huhx59ecr894NebEVbRLx7QPVqCbqqbgiVmeRYPgpO11q9HhpX6AHY1apiSr3MNdINHlB9j5WHyoeIwamZ05WcAIf7kxMX2yUEzg6NhkpTy+ipnQ7FN3laxhD1eCt4jx92gZUUoF4BFD4z/yyWsZKiJFcqu41hE4eL0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ea365dd68so877343241.1
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 02:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253826; x=1788858626;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAHBVIqCMd7JP6CfhiZjkc1474N3IhXqUrk37KgzKlc=;
        b=Hm67WGzSnnvmpcRdTEQxE9+Jjf0soZcNG1nCtHrOE9hlPJWSJM9VGubENOyUJ8oVlv
         lF230yON24ij5ZL69HOcVWZALuRYLafScS/hRxa2N5UrYWRxyYJ2Jq5kbBf8kx6vb23W
         kKg78iXgXdzSipK8iyk5WSZaYLWYAAn3GVm7rcNzazlATCheYwVfCRxCd2lhQi4Fn12R
         rFiQW7jNfcVEcy6kMHTSEiP1/gC4BTHQufAliV+Rix3qaVMIhxl1t/9Ydta0oMThXqf1
         bIm0kv4HARCfANZv5//ublDCR/P5q0OnZs1RNKeUaLuLCqH554KGBQ64CZCAY58HRF7P
         OkZA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+HXgZjuUf9K2BPr6Gg721ubWZseyT4N2rQvFXFycxOVZbQ60ofZuEdUDpwfZYdJ6F+/vq85lxvFtJ/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lDOmgFY28Z8kvMSbJkIg9EraGPjqSFmoR3dXcxwcVNKflYDMNs
	INpHpBu2LsQK0VYOuwj0A3SxYY3WQO+7hXPDHuU4XTGnN4HlLa4hsKQT5MEMnDXZ
X-Gm-Gg: AR+sD12jvXAyUSnOLNG5RGYVQdUZQul/dV2v/T4259m4XPO7vM4/4kXG++1H7LAIK+a
	cRQRK7+eqyutRlR6G+xk1jSmUie2bOnofogzIxku4+RESOjS2tfbUi8eDF2HTY8wvB4huORPofD
	NHKcVdvXSQe3eciwFO4SC+C3WMrM4RbW/T857psZR0yfKVeoJH2W0vc6TPcCcEFI7YiUxAcYtfy
	0rDQhOrRmnm+zM+X0C3FA8nSmyB8DDdSMmgFoMU3tBmaeDosEO/lxKuF2hsNRfOiMrfh2v2s6Y2
	igednYHf9GNEGX0gxKEsbfvMmHABcgl/AmOGg+4MFPKibuUhaVoJ1ohmLOB/KHONXZYJBu/M9BS
	/PiLWfOgPNvLZgI8msUiXWJUxm43FUEqgMfzoeLeke36X8D34bmJXcQ0Ct+kyqJpi65ytwRbgcK
	7QCrGzqV4YJB00w0POyvOQO3a+QBfsgdRjsoZgy3yi7Bkw7oEvZoEC9eZwKGUyxnUyoWX+P/Vpc
	/Hl8KmpiC1Gg95ytlSD4m1vqIJtkg==
X-Received: by 2002:a05:6102:4188:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-78597d071b0mr13077029137.5.1788253825844;
        Tue, 01 Sep 2026 02:10:25 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7893f43666esm5374270137.9.2026.09.01.02.10.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 02:10:25 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c65093556aso3267765e0c.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 02:10:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsBJrGTYz7aPBqCfvrFiGjw5pxAALDzculKqPaMbCG8Egpi8poWPZOwF6i8q2uqpBV8HRbWgw2QpJ5IA==@vger.kernel.org
X-Received: by 2002:a05:6102:3e83:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-7859956a1cdmr13463869137.10.1788253824841; Tue, 01 Sep 2026
 02:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786929430.git.fthain@linux-m68k.org> <1e349506a7cc6aa574aacbd4c69c240b5a1e3eb8.1786929430.git.fthain@linux-m68k.org>
 <CAMuHMdXgtstGtcbRkrtKtQ+d1c=mCe5zgYZCx4dyUQ_YnVhbbw@mail.gmail.com> <b0f20a10-78d4-e8e6-4001-99f076b99a8a@linux-m68k.org>
In-Reply-To: <b0f20a10-78d4-e8e6-4001-99f076b99a8a@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Sep 2026 11:10:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGBT+Xbm+zftBzQEaCgAY2CNUxqE9Swz03se4tVisENg@mail.gmail.com>
X-Gm-Features: AcwNN1Vv8ix3n1nJubUXaePLSvTFNecD0g75FaaL-e1OfJQWQPFwaJuEm50wUr4
Message-ID: <CAMuHMdXGBT+Xbm+zftBzQEaCgAY2CNUxqE9Swz03se4tVisENg@mail.gmail.com>
Subject: Re: [PATCH v2 07/32] swim: Enable clock divider only where appropriate
To: Finn Thain <fthain@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <laurent@vivier.eu>, 
	Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 1 Sept 2026 at 09:56, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 31 Aug 2026, Geert Uytterhoeven wrote:
> > On Mon, 17 Aug 2026 at 03:55, Finn Thain <fthain@linux-m68k.org> wrote:
> > > Some models have a 16 MHz FCLK oscillator and others 32 MHz. Put this
> > > information into the swim device platform_data so that the driver can
> > > correctly enable the clock divider. When this is enabled incorrectly,
> > > nothing can be read and failures from the Error Correction Machine are
> > > flagged in the error register.
> > >
> > > This is chip initialization, so do this in swim_floppy_init() rather
> > > than floppy_open(). Drop the udelay() which was apparently copied and
> > > pasted from swim3.c, where it relates to interrupts (of which this chip
> > > has none).
> >
> > > Cc: Joshua Thompson <funaho@jurai.org>
> > > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > > Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> > > Signed-off-by: Finn Thain <fthain@linux-m68k.org>

> > > --- a/arch/m68k/mac/config.c
> > > +++ b/arch/m68k/mac/config.c
> > > @@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
> > >                         .start = swim_base,
> > >                         .end   = swim_base + 0x1FFF,
> > >                 };
> > > +               unsigned int data = 0;
> >
> > Nit: in the absence of a real platform_data structure, please use a
> > more explanatory name.
> >
> > Perhaps s/data/s_fclk/, and store S_FCLK_DIV2 or zero?
> > Or s/data/setup/, and store the full register value?
>
> I looked again at this but I still can't see any uses for the other bits.
> So perhaps I should change it to:
>
> +               bool fast_fclk = false;

That's another option.

> > > --- a/drivers/block/swim.c
> > > +++ b/drivers/block/swim.c
> >
> > > @@ -807,8 +806,10 @@ static void swim_set_parameters(struct swim __iomem *base)
> > >                 swim_write(base, parameter, mem[i]);
> > >  }
> > >
> > > -static int swim_floppy_init(struct swim_priv *swd)
> > > +static int swim_floppy_init(struct platform_device *pdev)
> > >  {
> > > +       struct swim_priv *swd = platform_get_drvdata(pdev);
> > > +       unsigned int *data = pdev->dev.platform_data;
> >
> > Likewise.
> >
>
> ... and change that to:
>
>         bool *data = pdev->dev.platform_data;
>         bool fast_fclk = data && *data;
>
> I am unsure whether a NULL check is desirable here (?)

In theory it cannot happen on a sane system. But recently people started
hardening drivers against misuse through sysfs' driver_override and
bind attributes, in which case the pointer would be NULL.

> Interestingly, that NULL check itself is sufficient and so we don't really
> need the flag at all. Allocating memory for this bool is a completely
> pointless kmalloc.

Sure, but readability and maintainability also matter.  In the absence
of a proper driver-specific platform data structure, having a boolean
variable with an explanatory name is better than an obscure NULL
pointer check.
And what if you need to add more data later? At least the bool can be
safely replaced by a larger structure with a bool as its first member,
without the need for a single atomic patch.

> > >         struct queue_limits lim = {
> > >                 .features               = BLK_FEAT_ROTATIONAL,
> > >         };
> > > @@ -816,6 +817,8 @@ static int swim_floppy_init(struct swim_priv *swd)
> > >         int drive;
> > >         struct swim __iomem *base = swd->base;
> > >
> > > +       swim_write(base, setup, S_IBM_DRIVE | (*data ? S_FCLK_DIV2 : 0));
> > > +
>
>         swim_write(base, setup, S_IBM_DRIVE | (fast_fclk ? S_FCLK_DIV2 : 0));
>
> Would the bool be more acceptable? TBH, I'm not sure it's an improvement.
>
> Thanks for your review.
>
> > >         swim_set_parameters(base);
> > >
> > >         /* scan floppy drives */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
