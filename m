Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49838F932
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135263; cv=pass; b=b/+7XSfInrXFUR+f0qsK4YkyAx1g5flDeFwyyp8UZ6eWnOrj8UhrXWZZQsmbkbRonYgTm8FlOe1xqYGOvrnkfp6KUbIFZq5rPsWpcrgi/aeN8+AssKOXjKPvKHQ/HHAK9v//h539XACyqXRbtTNczuLQKKk1TObKJq2ozFsPYoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135263; c=relaxed/simple;
	bh=DLfVwWmIZXvKt617bPuognmQV6SbJTrSuZiDs9BZ7E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFa3pxmHRlT2n8TWboeGd9B6BDGmElqlBmVRTdGbvGD1v8PhrodNKJvozx+AblkdGrPLB4ibX45RnIxCG1ubFhNZwWWzg4HnuGEO5+pbl7ScebFUXwQ3bE4T/WdxEt2lJgE0Zxb+yopJnu5Bb66o9jUB4p7ueTpEh9DZew43UNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M2PkKnAy; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M2PkKnAy"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46a0741a09bso158419f8f.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 06:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782135260; cv=none;
        d=google.com; s=arc-20240605;
        b=fZwGTB92mEFk0nge3MtJpjqxO47boyDQwXeLcJExZP/X5b0ELlU8CMfA2N9iUmsmKG
         QCV75zqM7TgJ1rbp+oYcr5Eln6bRoFE2EvfqicMh/eVUN0X52bRtk+erfGYxoAybE9km
         ytpCXUUvXzNYiHoouVXHHoDWTAPuoJF8uxv9X2FesFEDfWWC8FWKSWZ5gdywD1Bq66at
         S0hIb8URFXZIR1uKK3qFTNT8U7nwG8pDD9kAqYHPvKY28VNmfGYfkkn2SRhIVaLGbf/5
         Aihd6HxTeG8Q+5qWwPY/APJo3+49Ck4+FGIc4KeU91IjATkQyGyJoi/hDiGyz0nHd2+2
         EgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhSIFBWju+7dfdinNTWNr1c4tGF57j9CUo142scZtjQ=;
        fh=OtS4n7VU/ns2RkrTwVAzYfAdxk7wSBN1dJF/muxY11A=;
        b=EbuB2d0fV6+32r08e1GO8LDVsCWcmchd9t3Pns/81vj+0KW46HpkN6gSWkdj80Dufj
         gyh3WXOs24ENdTAj/qOfxpdZiOcAme325bebGzE2Yux0s9wocWlR5flN3qK5z9NVq9Qk
         c12lRaFVZI6w582rM5r+XDpTZNEJw/0j9FCFW9utFfrgmBSfgvUMi5UXeUiSqnuRDFF3
         pghdI23cJjYAWGDGCJd1N+s/bd19GKv2ZxZ/om/PuTuxg1fSGcqCIcSqLh+X7IaZrefg
         F/Vrw/N/M0t0ItHww5nHGXzn7MesSxQgIs6EZkSha0fmSy5G1XyGW23QXntGuZFwX6SC
         JiCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782135260; x=1782740060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhSIFBWju+7dfdinNTWNr1c4tGF57j9CUo142scZtjQ=;
        b=M2PkKnAyeQPe/8mLt2X02Y/9provdB9qucEXDNJuHPQzYYMGFbJH1Dx9lc4PT9ZRlT
         Cizx8ZBqGlHdKwnBvbROKvUHPIsC0ol36F/LVoMaUlh0wz7FjiLThtCarduVQUQGugu0
         3XkUeXj3anUJQ2ZQ+khCsYrxooReKuVar+AEGVGMHTviaVT1RpIUmSxZkNLF/oRt5pW7
         sjZcixtwGB5H/gmX3VggITrxuZEupkrAACA7Q/Rhc/sG36Qu49y8S9yq7Hlrl4Hwywvo
         I6kUdV4LLUPwNwD5RXSLAOfn26leElqn2wn47XWjIMO2kE5HhF/dC6OJfckzDVqn4yv4
         CmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135260; x=1782740060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BhSIFBWju+7dfdinNTWNr1c4tGF57j9CUo142scZtjQ=;
        b=iPcjpM9W8RNu1iGNtrAeaZTSxxUrGkOhlaQA0v/U49QRvsZtfUTQxkL/k11l6iKonE
         RQXBqJMbDLSezG4ZIt3Cmq/3wIkdG8NMTTG/e/h1pIUGWLePMjFGhQk+VEO6+6tF0ilc
         T1rM34gMtAFnCvkm0LySDq9+aeK/xn7bXTAao2ljQkeSezP2H0f46Jxd81SLlN4Ld0MD
         x0h02xp9pdAbrVcx6Qakgqtr44fSOTjuJ0TDH7LYVihwlXcimXlMi5VjEkaFUBO5ly46
         MrauwaD1Ye76AItNtV4MNffWJeQPOBd+986+dci3OLGddtBDtugPfUuMGmo6kNEGxJWU
         AMqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLze6HmMi4RApwaM438y2CsstVYEry9FSNp/iighOUKfif+q8ADEV0sdm//Y1/h3skWXDHQ+xEyutZZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DpRJ/gz2Cs8pSwS5QlDoziz2pQdD163919pyEvU5H1VhRNTB
	4+GA3CGNleKCFAIoubIafIYTvF2URBxw6FRcwxJr9yM5ijVg4BFuO+XNlQBTUCZbUpBJ7pL8zRg
	wnG4OTp8yT8P6PsVH4XlMz3d+5omPUQCSTRuicFQS+A==
X-Gm-Gg: AfdE7cm4ZRfTSD0b9yW3GOcXe1IWgvi1EWVbrweVg9M0Y6mOvuxj+RcMPc9t+bc0wt5
	Q8ooZxwTxuKIAratR0bRe9qjrR/Ob8tQtg0hqIYKOqaFyFjJYKEnEEw2iUWDVkf1YjRf+ruM+Na
	UfodO/jM8RhqKq8qrYbBGlStZ00YSq1LJyShqpimtE8FGiQvz/OJhLSdA8wBWZFwwvgWo7jd27n
	sgZ7Fw1IJSGS+cekFV8V4nMGa9fweVTlnWYyLyk3YvkC75/1rLsNROwL09T0AJ/4wj+1g==
X-Received: by 2002:a05:6000:2611:b0:460:7399:23be with SMTP id
 ffacd0b85a97d-4656dd09441mr20195578f8f.13.1782135260466; Mon, 22 Jun 2026
 06:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617072516.6238-1-sebastian.chlad@suse.com>
 <20260617072516.6238-2-sebastian.chlad@suse.com> <ajSud4Y4PmCu2X_5@shinmob>
In-Reply-To: <ajSud4Y4PmCu2X_5@shinmob>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Mon, 22 Jun 2026 15:34:06 +0200
X-Gm-Features: AVVi8CdJpTvSXvl841_2oD9Lb2-vWBw-jzdoHF9KmtK1UWmgWPVbkTQzg8Smr3o
Message-ID: <CAJR+Y9K=0C+TnKAycdXbeQF98FE=RhaYYvK6SCpLPbdeMH2Xxw@mail.gmail.com>
Subject: Re: [PATCH 1/2 blktests] src/miniublk: switch to ioctl-encoded ublk commands
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shin'ichiro,

On Fri, Jun 19, 2026 at 5:26=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Hi Sebastian,
>
> Thanks for the patches. I agree that this direction is good: it's the bet=
ter
> shift away from the legacy interface.
>
> One point I noticed is that src/miniublk.c can no longer be built with th=
e
> kernel headers of the LTS kernel version v6.1.y, probably (v5.15.y does n=
ot have
> ublk and v6.6.y supports the new interface). This is a rather small windo=
w, and
> may be acceptable but I wonder what you think about it
>
> If we drop the miniublk build with v6.1.y kernel headers, it might be the=
 better
> to check before building miniublk. I quickly created a Makefile change [1=
] for
> that purpose.

You're right, sorry for the omission. I'll incorporate your Makefile
fix into v2 with a Suggested-by tag.

>
> Also, please find a comment in line below.
>
> On Jun 17, 2026 / 09:25, Sebastian Chlad wrote:
> > Kernels built without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES reject the
> > legacy raw UBLK_CMD_* and UBLK_IO_* opcodes. Switch miniublk to use
> > the ioctl-encoded UBLK_U_CMD_* and UBLK_U_IO_* variants defined in
> > linux/ublk_cmd.h instead.
> >
> > For IO commands, the ioctl-encoded opcode is used for submission while
> > _IOC_NR() extracts the raw NR bits for build_user_data(), keeping the
> > user_data tag encoding intact.
> >
> > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > ---
> >  src/miniublk.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/src/miniublk.c b/src/miniublk.c
> > index f98f850..5a35ca7 100644
> > --- a/src/miniublk.c
> > +++ b/src/miniublk.c
> [...]
> > @@ -624,9 +624,9 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
> >               return 0;
> >
> >       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> > -             cmd_op =3D UBLK_IO_COMMIT_AND_FETCH_REQ;
> > -     else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
> > -             cmd_op =3D UBLK_IO_FETCH_REQ;
> > +             cmd_op =3D UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> > +     else
> > +             cmd_op =3D UBLK_U_IO_FETCH_REQ;
>
> The hunk above changes the "else if" part, is this intentional?
>

Yes, this is intentional because we already check things in
    if (!(io->flags &
        (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
which returns early if neither flag is set, so checking the first
condition makes another check redundant as by that
time we know we need UBLK_U_IO_FETCH_REQ.

However if you think it's safer to still check if io->flags &
UBLKSRV_NEED_FETCH_RQ, I can implement it this way in the v2.
Let me know what you prefer.

I will wait with the v2 for your reply and address either the makefile
change exclusively, or both changes depending on your input.

>
> [1]
>
> diff --git a/src/Makefile b/src/Makefile
> index d8833bf..adfe3ef 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -8,6 +8,10 @@ HAVE_C_MACRO =3D $(shell if echo "$(H)include <$(1)>" | =
 \
>                 $(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep $(2) > /dev/nu=
ll 2>&1; \
>                 then echo 1;else echo 0; fi)
>
> +HAVE_C_DEF =3D $(shell if echo -e "$(H)include <$(1)>\n#ifdef $(2)\nHAVE=
_$(2)\n#endif" | \
> +               $(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep HAVE_$(2) > /d=
ev/null 2>&1; \
> +               then echo 1;else echo 0; fi)
> +
>  C_TARGETS :=3D \
>         dio-offsets \
>         loblksize \
> @@ -27,6 +31,7 @@ C_UBLK_TARGETS :=3D miniublk
>
>  HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
>  HAVE_UBLK_HEADER :=3D $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> +HAVE_NEW_UBLK_INTF :=3D $(call HAVE_C_DEF,linux/ublk_cmd.h,UBLK_U_CMD_ST=
ART_DEV)
>
>  CXX_TARGETS :=3D \
>         discontiguous-io
> @@ -37,8 +42,12 @@ SYZKALLER_TARGETS :=3D \
>  TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
>
>  ifeq ($(HAVE_UBLK_HEADER), 1)
> +ifeq ($(HAVE_NEW_UBLK_INTF), 1)
>  C_URING_TARGETS +=3D $(C_UBLK_TARGETS)
>  else
> +$(info Skip $(C_UBLK_TARGETS) build due to missing new ublk interface(v6=
.4+))
> +endif
> +else
>  $(info Skip $(C_UBLK_TARGETS) build due to missing kernel header(v6.0+))
>  endif
>
>
