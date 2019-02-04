Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A1C282CB
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DBC2175B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="tf3s9lJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfBDVHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:07:44 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46609 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfBDVHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 16:07:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so444053uap.13
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 13:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iS2DS0EreyOW923rGTwRLJoF4/Y7vjF2KlO4voKmpYk=;
        b=tf3s9lJbDBaGD9GdeJyLywErJrzLLK6DAge2hzfpBSYkMFId+6VFL5XmB2CGP+syYw
         bAX330VvYG+RdQypCxIRg4I5fWC9nndyF6huDHYq7hAQr79tq3jz5/RSnw/zVRbTvI7F
         JZpc1EElv7bQBhViorKibOsa26snaO2Qq/YSndon82XBNE2wFVZLP7rj2gllc6djluYl
         CvZHIxdoP/nLK+T5LhR4kO6COH6ZpUqeqggu3NJgj6MPZ7shKSuGqenuQYBELT74i2lU
         m/1VtUNq+/sSs+ERBj23MZkKLnHyJ9y9ui6zseDSqs88i0PPsALlM022Yi2Hg4R0N9Dp
         GLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iS2DS0EreyOW923rGTwRLJoF4/Y7vjF2KlO4voKmpYk=;
        b=pTBPyhDHolj8LzHka3AKlEnOzWXrVURb4qqLOuDxUY1ks1+6VEvG8j+JAAkdeaE/9q
         Jrh6yviw3tjWc0021t07jG5e8DuwId1jzQ18/qxCsjg8uPrHN4UKLoNxlsRYI2/JIrhW
         c16LKOcRsOvs8a1LQANMfXkHdVQQpgAgP/odfj57aio8b07xgVi0UH6TWJP69MILfMm3
         MZ3TYkXgqK1/XtCKWImxZ8XwSRdRO/tnu2JVLs0tHxnB89VQoG12gVO0kpH2Rpq53QQM
         HX/kjmw0c/dMm/EY1HzD2WAwxQwv7+eTnR/bxsTazdDRQKouRBMjOpe8fyxz8iacrFEB
         aKZg==
X-Gm-Message-State: AHQUAub/3vMkJ3rC72z9yS7v7mKoRFhmWkoQSOktNdyYhxIOnxh/KRwt
        sRYx4q+M4U3VVDbwsy8lrqiNe/Ewxglazb+18m9rog==
X-Google-Smtp-Source: AHgI3IbeYzmWbVCyaSvZB3y/fm/4bDxteX02+nmxDHze5W/MLRajy+yZ0rjl78yOkk5ylIqrc1Cc7YFRzQAZB2nWs48=
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr548107uad.29.1549314462969;
 Mon, 04 Feb 2019 13:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20190130102604.14496-1-javier@javigon.com> <CANr-nt27moc9eLMgXkoXQGR7GA=uRpg2u+v7aJxzNB_AGbw5hQ@mail.gmail.com>
 <E4DF0FFC-5A45-405D-A942-DD8572CC1BD1@javigon.com> <CANr-nt0FWrzsCmv=X8oqCSOBYTO7nZi5gtKJN13setFQ8MFjRg@mail.gmail.com>
 <3E3CC5BE-585A-4F0A-8EC7-7FE5F855E888@javigon.com>
In-Reply-To: <3E3CC5BE-585A-4F0A-8EC7-7FE5F855E888@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Feb 2019 22:07:32 +0100
Message-ID: <CANr-nt3_xLgZ3fY60jNyYEVY828ZAdi6KTMcw7MKFKg+u6CUXA@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 4, 2019 at 9:14 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
>
> > On 31 Jan 2019, at 21.10, Hans Holmberg <hans@owltronix.com> wrote:
> >
> > On Thu, Jan 31, 2019 at 5:33 PM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
> >>> On 31 Jan 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
> >>>
> >>> Hi Javier!
> >>>
> >>> How did you test this? I'm trying to add a test case to our testing f=
ramework.
> >>>
> >>> This is what i ran in qemu, and I got a hang (with this version of th=
e patch)
> >>>
> >>> nvme lnvm create -d nvme0n1 -t pblk -n pblk0 -f -b 0 -e 0
> >>
> >> I run several low configurations without problem. Can you share the qe=
mu configuration and version?
> >
> > Of course!
> >
> > qemu remote: https://github.com/CNEX-Labs/qemu-nvme.git
> > branch: master (cb200e3ccf9c1ff21f6275c6cb68b2801135a640)
> >
> > My geometry:
> > parallel units: 8, secs per chk: 768, meta size 16, ws min 12, ws opt
> > 24, cunits=3D0
>
> You are right, lmw_cunits=3D0 gives the problem.
>
> What about the following? If it goes through cijoe, I'll send a V3.

Please do send a V3 if it passes your testing.

Thanks!
Hans

>
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index d4ca8c64ee0f..a6133b50ed9c 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
>  /*
>   * pblk_rb_calculate_size -- calculate the size of the write buffer
>   */
> -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
> +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
> +                                          unsigned int threshold)
>  {
> -       /* Alloc a write buffer that can at least fit 128 entries */
> -       return (1 << max(get_count_order(nr_entries), 7));
> +       unsigned int thr_sz =3D 1 << (get_count_order(threshold + NVM_MAX=
_VLBA));
> +       unsigned int max_sz =3D max(thr_sz, nr_entries);
> +       unsigned int max_io;
> +
> +       /* Alloc a write buffer that can (i) fit at least two split bios
> +        * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee tha=
t the
> +        * threshold will be respected
> +        */
> +       max_io =3D (1 << max((int)(get_count_order(max_sz)),
> +                               (int)(get_count_order(NVM_MAX_VLBA << 1))=
));
> +       if ((threshold + NVM_MAX_VLBA) >=3D max_io)
> +               max_io <<=3D 1;
> +
> +       return max_io;
>  }
>
>  /*
> @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int siz=
e, unsigned int threshold,
>         unsigned int alloc_order, order, iter;
>         unsigned int nr_entries;
>
> -       nr_entries =3D pblk_rb_calculate_size(size);
> +       nr_entries =3D pblk_rb_calculate_size(size, threshold);
>         entries =3D vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_=
entry)));
>         if (!entries)
>                 return -ENOMEM;
>
> -       power_size =3D get_count_order(size);
> +       power_size =3D get_count_order(nr_entries);
>         power_seg_sz =3D get_count_order(seg_size);
>
>         down_write(&pblk_rb_lock);
> @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int siz=
e, unsigned int threshold,
>          * Initialize rate-limiter, which controls access to the write bu=
ffer
>          * by user and GC I/O
>          */
> -       pblk_rl_init(&pblk->rl, rb->nr_entries);
> +       pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
>
>         return 0;
>  }
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 76116d5f78e4..b014957dde0b 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
>         del_timer(&rl->u_timer);
>  }
>
> -void pblk_rl_init(struct pblk_rl *rl, int budget)
> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>  {
>         struct pblk *pblk =3D container_of(rl, struct pblk, rl);
>         struct nvm_tgt_dev *dev =3D pblk->dev;
> @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>         int sec_meta, blk_meta;
>         unsigned int rb_windows;
>
> -
>         /* Consider sectors used for metadata */
>         sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_l=
ines;
>         blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
> @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>         /* To start with, all buffer is available to user I/O writers */
>         rl->rb_budget =3D budget;
>         rl->rb_user_max =3D budget;
> -       rl->rb_max_io =3D budget >> 1;
> +       rl->rb_max_io =3D threshold ? (budget - threshold) : (budget - 1)=
;
>         rl->rb_gc_max =3D 0;
>         rl->rb_state =3D PBLK_RL_HIGH;
>
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 72ae8755764e..a6386d5acd73 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int force)=
;
>  /*
>   * pblk rate limiter
>   */
> -void pblk_rl_init(struct pblk_rl *rl, int budget);
> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
>  void pblk_rl_free(struct pblk_rl *rl);
>  void pblk_rl_update_rates(struct pblk_rl *rl);
>  int pblk_rl_high_thrs(struct pblk_rl *rl);
> --
> 2.17.1
>
