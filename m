Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA21DF75B
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298020; cv=pass; b=gbd5+Ch8H35hP0G9gPUY2kw/7Ragu+PATJQ/Bc3KoKhFEOB5sD7ynTaqwpbfxObX4F4ihLtWjlB8HiJT2mgOMh/csvPsakK/sBlOH2LgmlST/YRZeGOsRbbCQIIVDea2rpB0UclPOl05AjENfAY6T/L3aXMbnISr2k8l9IpnAJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298020; c=relaxed/simple;
	bh=dgi1aPDpcohtTHR8Nq9/ZMw2SBasWt/au/mvDp/pMaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUgL4GSXwZfSMhu4ruq8EU/hAVdBwXMJkuqqcVjWzjlNPKSSX1ApLH2eey8hZ00AMyoiVimwGqmR5H7G2Sdl43RDNBwPdWnPnFIvxgoTESba9Xg83eRpfZIBLXAmJCOeQhq8JgDKmjy+EQseXbsvBXUBS2PxyckcU+0wvCtP/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEmHxKpE; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEmHxKpE"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15a2e27498so24941266b.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785298016; cv=none;
        d=google.com; s=arc-20260327;
        b=nzie4Ne9mfoE7snvgzu3jRTv/jeYozcSQz1UUbMdS7pnAjKHbqp8BSGf6NIXtFZKiP
         7v39tk7R+GOG9XdYGtAplJ8VsmBieq2Oq9S7xFZDvc1LhN9muGa4rQmu9OhuLq9jgdgf
         0Zn9KClzCeP86jc6DBnyDUhLWWzleRVCDtsKeV4tXCOi6sohOj4jRODNol0z/CMtQOzh
         y7GqnLrGhZ7JaJMkAOUVobLq8B014znw0ig5iAw7PoiiAuPwEcpyGnNVIpcokxS1ejBh
         HfjZL1xFMZDCfTIFbn1OQoapW06j+cNqRrTpw5qog09Pq/klpGky6rW0OyB6W/yW1bjL
         I5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KLEbD7c03F7/KMGhqHrEaRqMGLVcuL5QIITGHykFIg=;
        fh=L/Ols0h5IDOYMeXfWrTCHq7oKJ9N9/V0MwBiURQ5qdw=;
        b=gTSbjXgh25VeYL6qjGJh64TSQkSpstQbQsvl5/iwlkgjr73V18IqgMurZbB/EFNBRJ
         XE7F720M56fmQWsR/mL9pr06tdO4Bj3vwEcbvRl3ZExQ4DdL6NGSTtGZVIJTheuZeqmV
         3HsF4RaU1Hha5OaffHUHF9KebxV4j7w1m+YxNTDTFRq7JN2hDF/NxFbcjMqRbfivBCsz
         zGjJFntsqbeQ/DYDJhUghlaYH+bsCXii30056QIvjOmyEuoKjJ5oD2mGXypGs4MqtEVN
         ibiSGPGSB0c1nixxjW5dNuRv95iUWCMg+0ICosMy9tuu8TZIKvApMF2ftLyBAAF6thsB
         6QQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298016; x=1785902816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9KLEbD7c03F7/KMGhqHrEaRqMGLVcuL5QIITGHykFIg=;
        b=XEmHxKpEEkZ0zrZ2OGQGae4ExGyvj7DxrAZou1+dPuh6hzr1RkchRyOAF5G6GVay67
         sYIEpTkxVL00/2YTjiTDeuhiX3hauOYLxHJxDqiUJJo8w2rCfm4lO74F+HnSql3ohblL
         1NQvlF9VSnASNFTu90VKwk5dBHCNxHKA+ejSLxJHw1UgBoWrVbem6ECfYJdIOkXFfsSf
         GrNA3Tw5+2E0c2Vky7R404NgmSd00ReodH2/45wok5d8Z50DVxzTgVDYh9/3jpLF4hLK
         /FG/1LWrWG+WflcHh+r6ce9MU+zisKPQoSwgO9Lkna4C27aPNWL6lAm3vSkzFkRYiAnT
         eo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298016; x=1785902816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KLEbD7c03F7/KMGhqHrEaRqMGLVcuL5QIITGHykFIg=;
        b=hlQtY4dSJDYNxTQd0ijamtsMAAeXZ4FHxdcBsXlQ+4tsp2fbbE0ylK7IGsqZG6d86V
         xTMrMohBWcdTFMh3aX6NqMzzLFxS2XrvhjcwdtGhfj2PN3gxVFG5oQDVZ/PSBXvGLx13
         7OiaIhHLRFmKLHROiKx/SWajHwDtBmAiASHwedgLfL4vyvisQWU/60GV14sts4YB9nOO
         rpn1WceBWOaTjMfAIKLjVuxhNNmYmr97GccEkHcVoAzxrO5RO4vaBMdEip91x8IvfPR3
         qP0Zy2auw5Iil87nPG4hvXOy7FPpq5utLmP6953xOsasv0uTyCwyHvOm/6I6Q2pOzohj
         h55g==
X-Forwarded-Encrypted: i=1; AHgh+RpPFEqF0wLxID9qHujjnAHBs38XH40puGdIR1HQkFNoYfCHkWe64ftQmPrCn+5y42OBdQYWCYcHZ9IBug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6btAVs7v+UlyK7LTztk1pXYmOSMdXbk01aLTctl8ySHP07yxh
	psxDDX84Apj++lJuA1ETPWKM5k0s4I7m3hRnmHV07YLyVSmsT3wEKIopmj15UJZ7mMy/hUrA9zl
	iTCdlRIMqtSMQL34k9Y2XVh73RWzl/JfG3H9WIrxtK1ikbug=
X-Gm-Gg: AR+sD11krCF7fVOJfSXa8ruWX8jNfKTpt7G3KWRNiJ9VgU2zk/EZSxwGY+7XqfB0fcs
	iztJ3AlO9BxbH1n2iWL/JX2Ez8HCsFxLYf4dcFEgHTaJwW5IiZrGEb5U78q4SeXFscKVvMcKFn8
	WHy3+Pkm10k8E1tgTAE6kxrJ5i8uejDea4aUBOAJBdPB8gmJdWYAN7Sm01PtpLqhHDo0b2mv/Lm
	is1/t7JiLxItQoxn6nLj780Im3p34juQN3lEZDP046SJZo7o52R9eKqyQKeq9Xy49do6EKplRwn
	OQ9SBFI7d5bjbp0tnkgj2PsE7E8yy1vif0GLQPgtkA331Q==
X-Received: by 2002:a17:907:6b0a:b0:c12:6d26:1ca with SMTP id
 a640c23a62f3a-c1f7219e1bfmr272801866b.61.1785298015583; Tue, 28 Jul 2026
 21:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-2-haoqinhuang7@gmail.com>
 <amlk3lqSbtfEOkbs@google.com>
In-Reply-To: <amlk3lqSbtfEOkbs@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 12:06:44 +0800
X-Gm-Features: AUfX_mzbsP3KB3Xo8zp_qY4Z92LgJcG4IJOF3CnG0Wz-SJYvYAQqWCRwDcjm9DQ
Message-ID: <CAEjiKSm_q1X4O9H44raKYYo8WQRxNRBUN4VFi7+-JW_JkWkbVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] zram: make dict update in comp_params_store() atomic
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:30=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/28 17:29), Haoqin Huang wrote:
> > comp_params_store() resets old parameters before reading a new dict,
> > so if kernel_read_file_from_path() fails the params are left broken
> > and the actual error is swallowed. Fix by reading into a temporary
> > buffer first, swapping only on success. Use sz <=3D 0 to also reject
> > zero-size dicts.
> >
> > Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
> > Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index ace65c586072..9ea7ba9d1ed0 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1699,21 +1699,23 @@ static int comp_params_store(struct zram *zram,=
 u32 prio, s32 level,
> >                            const char *dict_path,
> >                            struct deflate_params *deflate_params)
> >  {
> > +     void *new_dict =3D NULL;
> >       ssize_t sz =3D 0;
> >
> > -     comp_params_reset(zram, prio);
>
> I don't see why is that a problem.  All you wanted to do here is to
> handle zero i_size.  Why do we need dict setting to be atomic?
>

comp_params_reset() calls vfree() on the old dict and resets level/
winbits to NOT_SET before reading the new dict.  If
kernel_read_file_from_path() then fails for any reason, not just
zero-size, but also ENOENT, ENOMEM, etc. the old dict is already
freed and unrecoverable, and the params are left in a broken,
half-reset state.

The "atomic" in the subject is about all-or-nothing semantics: don't
destroy valid state until the replacement is confirmed good.  Reading
into a temp buffer first, then swapping only on success, is the natural
way to do that.  The sz <=3D 0 check falls out naturally.

That said, if you prefer a more minimal fix, I can drop the temp-buffer
approach and just change sz < 0 to sz <=3D 0.  But since reading into
a temp buffer first protects against all failure paths, not just zero-size,
it seemed worth doing in one step.

> >       if (dict_path) {
> > -             sz =3D kernel_read_file_from_path(dict_path, 0,
> > -                                             &zram->params[prio].dict,
> > -                                             INT_MAX,
> > -                                             NULL,
> > -                                             READING_POLICY);
> > -             if (sz < 0)
> > -                     return -EINVAL;
> > +             sz =3D kernel_read_file_from_path(dict_path, 0, &new_dict=
,
> > +                                             INT_MAX, NULL, READING_PO=
LICY);
> > +             if (sz <=3D 0) {
> > +                     vfree(new_dict);
> > +                     if (sz =3D=3D 0)
> > +                             return -EINVAL;
> > +                     return sz;
> > +             }
> >       }
> >
> > +     comp_params_reset(zram, prio);
> >       zram->params[prio].dict_sz =3D sz;
> > +     zram->params[prio].dict =3D new_dict;
> >       zram->params[prio].level =3D level;
> >       zram->params[prio].deflate.winbits =3D deflate_params->winbits;
