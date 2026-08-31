Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779743C5855
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161929; cv=none; b=skh/EzOUIpYMoan1iqXY94fBdBBn5e/PSNAPMb9dZWKrpUWCaClmoA18FlyuFcKosxKJ8/1JCaHwiStPqdJjg0pDEmigkHrWYDfrND/NTdZCha0sJ5W2uiiezugMDdv14Drk/s/UkuPZYrRlSt6T/koGVjzd+NOD9NZKajMYn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161929; c=relaxed/simple;
	bh=n+bm+oD3kn40fyS7L0liJo1kS7q5/LI+20B3up/88HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaw44AzUlgR1g1ztJZ8rQraBP96tY/pxcKAPGEjwGmOIKdB0diQisibMfuIaJJQNMUq1dtmxF5++pHyIcyRwsJ82/IRM1VInAQxmq+oTF/seh4OSEXgzWesy0BhCiQJEOysqKeo/JjwmY05U9E+MfguS6j0XugdAjDxfOF1mw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7466771f1caso690874137.0
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 00:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161926; x=1788766726;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1+Wb6c4hy/mllkEGw9UkJDy4J8V6hEIxHDRjaIVv61Q=;
        b=p2t2r303wiLHrDf2NaNi8tDMmE4V6mOuxhWu4epPw+mLBg12y6Psk/xO1AVyJ7gzh4
         k455gIvAJZnZJnMuC+1Al9wou2fI6i89hykysZUiA0vWGpm9kJ8oW1UDQDUB+TkpW9C8
         Xz7hzr/FqV7E1Jtkl+gU3Hsjg9W1NsZ90wf8MeJR//LW2zwmEJ1KTJ3DuW+GdgfpaoTh
         5yueakFBp10p77b7WMj/j9yze/oAs4UlJDodYCDDZwsVfpFy1LUQaoRXJr1waWQJxoRr
         IuzGlftDTY0/Gg4OIPSZjtiSkLdFRRkb8l7SJjZWwVkezYHLJz3siarv0re6235Spmvv
         qFOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDol/fo57OFJBHQ8pm3ur/JX3vQKgT31YYSsE2P7HNXOKME+/4vNbh5plx0ZrSQqdF5IbNG4x6E4gaaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nISDevevulFfRw3NDynNhFqesW8fXFxFGWBVtd7iX5x8GUQ36e
	7A/uP8q2WCYtSXza1Gf44DQigzArP2KbFbFKgdu/d6pI4uwWGAE7wXq9HRGLWrLg
X-Gm-Gg: AR+sD101m0ON4yC31jqGLt+wmanJgQ2dkLWEX4N6YFFjIO3chNA9LsPto2mV1ljn83W
	0vlm/Xd+ExCcIA1Kain4FYMxYJLxCe7oYT96f/RBVGQY625SUvHpU7cpY5ygQb+t1QSFYp52r7t
	sYijaV1q7Lrs1UtkGjH1JF99rLyM6sKFM32z+G2AJI7jq48RUqqp9aBCryCK8YzWIuTOp00PL2n
	hEAOztnlnOOaR4rGqY3XYfozDeNLWFci/cZ0UbfpwAAZi8kmcmkkOSYNC0/In1h2Bdc1AIeW29N
	3zWavjCKeCxQiXUKvYi6FU/b5fPMoQ6QlBAE87L1rRjPLLKZ0JPDNvEjekfQD3XxjLLF5JX/iXQ
	a/ib9uYsUoexo2e9yXdh/FsCsIdg1PXzUOc+wtFTRMbesLwoM7aqGwOqSd+7rnFsJBgnxbo5qX7
	9eOjitwJKIGOYwo3S6hPmnxVyIdt0y3iWfGPNNV1cW/+zwcFbCPD6oDT5n6P6P3J5JR7k1WyH3e
	LQzYSnIUd3KSfuvBdTS3flgKon/SC1B/fkf
X-Received: by 2002:a05:6102:4bc2:b0:77f:fb50:8822 with SMTP id ada2fe7eead31-78597f13346mr6418746137.7.1788161924412;
        Mon, 31 Aug 2026 00:38:44 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm6181198137.0.2026.08.31.00.38.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:38:44 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-74ab6c88052so809234137.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 00:38:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8fX3Y4eKuoqBMHHPL6iRM/zMEsB0E2K0gWwxhw0LLJ3qmVRXDLbGpRdNjVWjI51KBSqYVBsrK7JLn4Q==@vger.kernel.org
X-Received: by 2002:a05:6102:418b:b0:778:721:53db with SMTP id
 ada2fe7eead31-7859426191emr7077458137.0.1788161923583; Mon, 31 Aug 2026
 00:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786929430.git.fthain@linux-m68k.org> <1e349506a7cc6aa574aacbd4c69c240b5a1e3eb8.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <1e349506a7cc6aa574aacbd4c69c240b5a1e3eb8.1786929430.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2026 09:38:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXgtstGtcbRkrtKtQ+d1c=mCe5zgYZCx4dyUQ_YnVhbbw@mail.gmail.com>
X-Gm-Features: AcwNN1XVC3wu-2rZS0i2vSr8DmQmHBettg6W2uihbfihhqw2AlLs5EB1RzHcC7M
Message-ID: <CAMuHMdXgtstGtcbRkrtKtQ+d1c=mCe5zgYZCx4dyUQ_YnVhbbw@mail.gmail.com>
Subject: Re: [PATCH v2 07/32] swim: Enable clock divider only where appropriate
To: Finn Thain <fthain@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <laurent@vivier.eu>, 
	Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

Thanks for your patch!

On Mon, 17 Aug 2026 at 03:55, Finn Thain <fthain@linux-m68k.org> wrote:
> Some models have a 16 MHz FCLK oscillator and others 32 MHz. Put this
> information into the swim device platform_data so that the driver can
> correctly enable the clock divider. When this is enabled incorrectly,
> nothing can be read and failures from the Error Correction Machine are
> flagged in the error register.
>
> This is chip initialization, so do this in swim_floppy_init() rather
> than floppy_open(). Drop the udelay() which was apparently copied and
> pasted from swim3.c, where it relates to interrupts (of which this chip
> has none).

This move should be a separate patch.

> Cc: Joshua Thompson <funaho@jurai.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  arch/m68k/mac/config.c | 31 ++++++++++++++++++++++++++++++-

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -984,8 +984,37 @@ static int __init mac_platform_init(void)
>                         .start = swim_base,
>                         .end   = swim_base + 0x1FFF,
>                 };
> +               unsigned int data = 0;

Nit: in the absence of a real platform_data structure, please use a
more explanatory name.

Perhaps s/data/s_fclk/, and store S_FCLK_DIV2 or zero?
Or s/data/setup/, and store the full register value?

> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c

> @@ -807,8 +806,10 @@ static void swim_set_parameters(struct swim __iomem *base)
>                 swim_write(base, parameter, mem[i]);
>  }
>
> -static int swim_floppy_init(struct swim_priv *swd)
> +static int swim_floppy_init(struct platform_device *pdev)
>  {
> +       struct swim_priv *swd = platform_get_drvdata(pdev);
> +       unsigned int *data = pdev->dev.platform_data;

Likewise.

>         struct queue_limits lim = {
>                 .features               = BLK_FEAT_ROTATIONAL,
>         };
> @@ -816,6 +817,8 @@ static int swim_floppy_init(struct swim_priv *swd)
>         int drive;
>         struct swim __iomem *base = swd->base;
>
> +       swim_write(base, setup, S_IBM_DRIVE | (*data ? S_FCLK_DIV2 : 0));
> +
>         swim_set_parameters(base);
>
>         /* scan floppy drives */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
