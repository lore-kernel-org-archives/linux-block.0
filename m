Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05A391E59
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257163; cv=pass; b=PJHyo4cEnF+FvunvVlwDXkcTmY8BcVsawf4yP4AyWzF/BcxiTgWX1s5a4NN1kfnvrbnnaIaBCfydPTFm3lo1eZmYLPU14eQuhSC+1D9OpatQWepCNIM6o3MtDC7mI6sRKIVmiClyHgZXWRgE9cXnUVaXFIObLeKJ5Plquiilvcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257163; c=relaxed/simple;
	bh=CnU9qBZiI2d9l8PWlewTxxURPQrkvvHbexVentScxhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIPzqfbYkzmNpw3rsGOzzcHuIp889NWkFWZaQcXw0WRW3LhNBW2oMNIZneik8j8oWlk00snPhjPR3qo5BRTfU+GfoVD4ViuyFPrNsbW4RCRUczB4SiFamNXyevuX8ZOUSilEavgv5T6znxOCb+gu5bJ39wOfQyN/Eat9yJzOApM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EIs556J2; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EIs556J2"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967738c801so6407941fa.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 02:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781257158; cv=none;
        d=google.com; s=arc-20240605;
        b=WKvcXEORV8rqd2TThl5AaQpdjHwlt/ey0VEHJogdVhCNUyoSiNofZplS14pQxLN86q
         /x8I++s8BFq5a1pJhn9+sDDRktv+bNvUCcwqOX3ZFGtzNTsAbhBCnOBrV+jcaru9IltC
         HL3ZNwrG+HHgr36lw/OIJbodiLpOIDbQAiC4X+dXC/DHMMBBX4VY+T3v2NRJ8xVNxG9/
         BBnBMOe+9iRywF6N/0y/fJ701cIAp4WpXJNeersDfLTwqRbw5Wp4Xl2NVBTt/brx5M71
         i2I1EIMceV2TDfHUXWm+gaP80dgFC4VQKsbZQcnE6IFDtMZZTwuev6FhLdIlgG9J2UMl
         Z/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F5QL6jsXXlrsglbd7oQwYpEsY1bNUh4psG4/A5eCDr8=;
        fh=kQT4eZK1pjLv+QoVOxgZhatXuufg4j9l1JTLCC0glqE=;
        b=fphKpFMVeTn5LwG4GV4EIQLaDZLYd4k/LyNRwEG3oX6rNZnLzaE4m947p2YCPWfmAv
         ysZIiTCflHAYC+cqEXUuClWf5PZqI3LIo02GLMMgArd1zEYJoFuESILJtrIsLy8co43T
         VsjnvuLfTSXHmUI3LYynuap5TNK6PUi1HheicF9Dxocbb46E/sWCW987zvrOUsBQwgH2
         pi/KVyilEZ8gif5qtPB1w5BLbshOEnCGOhPou/CrEgJ43pLXK31YQIiCFVjNNio2z6vw
         nI+bDjqqTCOt1s5zmVJKrNvgg1B31+Ou2TvhT1hnB3ZC1bowjLym01Vc/GsHayOoZuHw
         9ODw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781257158; x=1781861958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5QL6jsXXlrsglbd7oQwYpEsY1bNUh4psG4/A5eCDr8=;
        b=EIs556J2m5Lcz5sKDBER3JbuCdLYJielTg6pS3JbmN0RsYEGvV5DSmjL3G3hT4ioxa
         PjJSCp+km9KgOJT5iG84mrFhEur7lIlH2ZwTjMsIpWoXvoRRJYqfyfsGLymX+ZnyIg2r
         8ib8uJFP5aJJvFgczZ9HhbII4dHqCF2NglnvsKAWvRBEk+T4OfDH+cMpetLyHzlsZmQr
         CbaEsMjv6SPsf7w9y3tZ5Zbau0gg3ET3gCDaUtF3NOJmR0lX9iQE9wWJJtDIhmW/cZwZ
         M3jI5W08h8gUEFYRQia81+cO9QD/dnwwCiUaOHxDyTJzl8TZkAY3tG032MYMmfejGNIE
         rUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781257158; x=1781861958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5QL6jsXXlrsglbd7oQwYpEsY1bNUh4psG4/A5eCDr8=;
        b=RTQCL3WWBNtMPeRQWjOmNXazKzxmbPuZZjJWiJyAJbsrVfJobLRjMS8iw+kAqRWcm/
         33xIWucit+/JLioYlfFjw7JeD7S3JyY3k17OYorRfDq2hTezEYF9AWjwxHW1XcLf0an8
         kXIhOYIJZuHAIyg16K5iiODbVInPnHx1HoJ/jW3wjWZBNzO1OnT5lHJ3foR8BBdubZMc
         EmTz31Y7SdqA3VgW9uhI2V1Qipx0QLj/c7jLTqA6E0eyGe5sqwSmQWb4m11xkW5isJ1v
         y8cGClB++Bs69UDVn3Qx7W47zdFyCHIiuGUAfIMaI9nenKUnzvGEjFCd7YxgxuDjsJZ+
         ViAQ==
X-Gm-Message-State: AOJu0Yxci5tE0aNMaStWUPDwE7uaIbMg3DH4aBFXVBi2iWg2PEMu+npc
	yfFWz7edp60+V1X6DdtGkqUZw4svmdyPLSpCKB/eEmR75682BTWvuzwaPHicurK0bseVjcBM7n7
	aAfv6Tes8lpo0SWHAVaNWKXPAVyjQs5imV8WBS338RQ==
X-Gm-Gg: Acq92OGfzbOw4Ih7zTcrCZUf/vXH2XVNg6IJo7c32jAPACONBKz8BGlObwTGK5/ZyA0
	pdoR9LCxzqoo8oNnOHgyLBObiQ/XvI0KJCnecGv1YDcjbEPUFDRP0BCLc9z3toK6WdHoq5BWz3E
	3JFYiTNsqvJ0nnPaI5mY1h9ySHyv5Ip3PDYUfsJDMML651/fBZjQfnjYU5OKuuga1xHC5GKXawK
	uweZVDRn/lhYMPVTdelFKy37yS2nT2Bs218kyN87xNn1mltoiRGSXTqJZgE7PXU6GyjKIZQwQMw
	Onidwcu9K8R5REqPR0Wbrf733xbBEJd3F4QKeVGnTCIEc5mKZqRZUc0QCynY4yafdG1B
X-Received: by 2002:a2e:a989:0:b0:399:1ec3:eba7 with SMTP id
 38308e7fff4ca-3992b160959mr7302881fa.20.1781257157667; Fri, 12 Jun 2026
 02:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9f86f0b-331d-4cb1-b8a2-00bc1e857ec7@web.de>
In-Reply-To: <c9f86f0b-331d-4cb1-b8a2-00bc1e857ec7@web.de>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 12 Jun 2026 11:39:05 +0200
X-Gm-Features: AVVi8CdiaXrm1U290JlCGFSnQfH0BBbjtNNWl211mNib7KONSEM1txH-98N6PwY
Message-ID: <CAJpMwygBw3meeMj9mS+0N1p9mM2cOrYo81jf9toBkmD+rREkRQ@mail.gmail.com>
Subject: Re: [PATCH] rnbd-clt: Use common error handling code in rnbd_get_iu()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>, 
	Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:03=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 Jun 2026 20:58:47 +0200
>
> Use an additional label so that a bit of exception handling can be better
> reused at the end of an if branch.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 4d6725a0035e..d8e3f145ee2f 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -329,10 +329,8 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_s=
ession *sess,
>                 return NULL;
>
>         permit =3D rnbd_get_permit(sess, con_type, wait);
> -       if (!permit) {
> -               kfree(iu);
> -               return NULL;
> -       }
> +       if (!permit)
> +               goto free_iu;
>
>         iu->permit =3D permit;
>         /*
> @@ -349,6 +347,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_se=
ssion *sess,
>
>         if (sg_alloc_table(&iu->sgt, 1, GFP_KERNEL)) {
>                 rnbd_put_permit(sess, permit);
> +free_iu:

Thanks for the patch.
It does what it mentioned in the commit description, but maybe we do
not need to do this?

If there was a kfree before the last "return iu;", it would have made
more sense. But jumping to the middle of a conditional block to reuse
the free and return seems forced.

>                 kfree(iu);
>                 return NULL;
>         }
> --
> 2.54.0
>
