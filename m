Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6C1632DD
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782535086; cv=pass; b=q0+IMKMgeNmk5qp2f0AJqpjwB0inWBd+8WsU2ET+Ffrr/Ylr3RFGCivK4TYaEZHNuzuVJQggNBgdQkYUg8qJcsea2O3kcGQfOZ8GC9fFA8XXPfRQStKn8UV7DWagqnm1uW1daD46ZeEwIdRN25Ar3/94TblshyDGzlpq+Ax9/74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782535086; c=relaxed/simple;
	bh=WjcNysgJ1cmO85TM5aS9Urfw5hQC2DHrRyxP1v+DX1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSDHOi76ij0f/lrNuw/ykJUw84ZLpe7+KTXEddllslYUiwfdpZHn6dutuAQ+Vq5SAwvLzeC6C8RpkU5S8rf0xp22c0+OChW65F8d9+jrgiLJa7tsI3EnAr1A90zENjWBVY1P7OWtIuVOwcaiF6ETyvLMQlnAxrvwqmlh2SCz1sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMbTEULM; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMbTEULM"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so2719544a12.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 21:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782535083; cv=none;
        d=google.com; s=arc-20260327;
        b=PKmC7/+avfthQV/wr4J4syCluRI3Jk5XsfAfLhZqIqoxJKz5BEuRpavM0UAW9Z5J72
         94JU+ZXBQsJnUgsjGetPD4GL/GJpauo9jNyfSstMoSFV62FYdJ45/bF5txDuWGJxTm4o
         tIP9Q1dA4HrVgjO9/hBNb0b2/F+UpY/3Ssx7Jxs/8nzVNxQlamlBIxCFBOtPBWqO/cBS
         Gs2lVmZfBkhoVX32DXAQb+JaYBMhucvGRgHscXBVpcyrb1I8MtttvDnZVOMp+04kEPJX
         bZRTYDwtsHSVD1ixH1Tt9FnHDgApxJVR3DO+TI+A69WdJ/TskVE7e3MvwxQNP5uDAjc5
         RdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YMnFoAkMSB8x3pEfoOBV+xpCcydJt5zrj489HlTpRmo=;
        fh=P/MfEgDehikrLT5744YkIOhNnS5Pwhrca7H2wSp9IIA=;
        b=G/r6Pefa51aNtk/GzpsbBbSvV+S57mnORxtWDUjII0dI79W9+31IBi1A2CFg2yfVBN
         rz/9MBFGmKDSkDpPB443NsIQkmqbpSK+lrcONzr4QWGxlGhN0yuSaOTNqUHbl5bJUG1G
         yyqg1etH75O5EhuL/L2jqsi3JbKvnLfl7isJzi9AG+MlXysTb19dswWaebQQBYBw3Enf
         sH4OMwGOmrqE+F+wX5OfxPKQbbRPwUqPPdJodJ56azqyp8dB/cAkqt3baAhs4PE2RzNS
         P1JTptwTfmTV+VH6R/YxiJbpyipsk9Gui/6xMTGeK/vuudWQ3ePFSZAplr2MJBrGZpG8
         VMig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782535083; x=1783139883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMnFoAkMSB8x3pEfoOBV+xpCcydJt5zrj489HlTpRmo=;
        b=tMbTEULM3C6ZCVkMw8kScUFfV4Q2KufapNU48twqLls8gYl0dbcct0VRjGMCOxZzkc
         fVEoRYoFlv7cLxqvfZl3FIGnY3RqEW1q9PDfg8D9ZxXkImbfEinfHYpPy8Qqj9+ORga8
         xlcSiFPgROLt2Ep6E/t5T+7lGuPTWIHBwbKv8oFnLnw2gP4k2AMxEhTreDa0Luy8TH/e
         Cbv5BohjFwljVCXRWuo7/5ylzqZDqJY3pvrESHBVs4DB+j36Kd39lnHxKLaVIQyjoesH
         9b+l+MWzht/tMQP37aSltRT5p7923owyCM40ZFXZ35sfAgvuKQuvYoFWqfBcbrq9tAq4
         dWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782535083; x=1783139883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YMnFoAkMSB8x3pEfoOBV+xpCcydJt5zrj489HlTpRmo=;
        b=ZlHe35EXWm24HKWNqdsCkvMvMphWzCHaQvoRj8Ejwe51BQxlx03ZQq50IOXzAZDJz7
         lEZzXQSqIUHcOxFqdlKTwSH7VTKBlMczFKOevnoZMFn4waFA18llEQ1VWP+COIltCq8d
         kJ5kWczrnAZQnUvRVUbZ7gAtfEUJOECYRdXTX9TrZdeLh2kUhnA9i9e5rUWpVy88zlgI
         nq1bDZ5oAd3K1d37k6OBswD5QF9gTyzY6dVovVBe1wv2ELn2beCtDBB8pA/8X5MRptka
         ET/CgeW8q64mjNUVsEvsOckZrcmAdNyYKqIskDMsqawp2+RgALPCtk0HK7WB20UnoLMo
         jkDQ==
X-Forwarded-Encrypted: i=1; AHgh+RorHyPOfXDS+kctbpoqFJWdG9MQn6IsEjdweonfttCKhNfJs8utWJxo34xFDQ8npYNrAfn28/LW+DgWdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwML7yW5MATowaL5TFXMOyTVOXUOn70Ib9J8DDYctZA0h/wked1
	CELAp6GWo3RbkjUIUzHCSJfEXHMRJJGbfbztL/GFypyt5Or/hPkUND85PAFK5trto4fsmSARhQD
	dR8whSPV38xJ8ASSd6xzgNNZSIFcu9A0=
X-Gm-Gg: AfdE7cmkk6f5IYTodB72KmjB2HuZwW91e9SWFVALR+qMal2TOjWFwlIvhHVm1kbecyg
	mWPq3PbBE04EWek7e94JB0M+hg6sn+969BNUV/rYx2GvhEaF4qrFpFEXYEgozO/WENUI2cfqiUI
	gj+4Fhglab4A3vsjJS1gReltVvVWLKPkM7y0FiXX+GCdj0Rmm6ObBmHXH+HIz5b3Ttjkt6PzWra
	TPRetrjSY/qm7r9T+eM7CZlgZy00wYpadYcfYTnUydt2XEA/3pYpwfkS6dWc1NURwINETWSVPiC
	V2LK
X-Received: by 2002:a17:907:948f:b0:c12:2e52:185f with SMTP id
 a640c23a62f3a-c122e522de1mr208949366b.3.1782535082691; Fri, 26 Jun 2026
 21:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782398104.git.roxy520tt@gmail.com> <6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com>
 <20260626090929.GA4627@frolo.corp.macq.eu>
In-Reply-To: <20260626090929.GA4627@frolo.corp.macq.eu>
From: tt roxy <roxy520tt@gmail.com>
Date: Sat, 27 Jun 2026 12:37:50 +0800
X-Gm-Features: AVVi8CeFak8CulrnxUsJNgYGqYRMax2U6VAL5cz8d6zjhqrc0n7ileM1NzDc87M
Message-ID: <CALMqdkS0arRS5FSsbPBiHAZzU-NeDEBhm01-r5v00GFQN=sx8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: partition: aix: bound LV name formatting
To: Philippe De Muyter <phdm@macqel.be>
Cc: Ren Wei <n05ec@lzu.edu.cn>, linux-block@vger.kernel.org, axboe@kernel.dk, 
	kees@kernel.org, hexlabsecurity@proton.me, objecting@objecting.org, 
	akpm@linux-foundation.org, yuantan098@gmail.com, bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 4:50=E2=80=AFAM Philippe De Muyter <phdm@macqel.be>=
 wrote:
>
> Hello Ren Wei,
>
> On Fri, Jun 26, 2026 at 03:21:22PM +0800, Ren Wei wrote:
> > From: Zhiling Zou <roxy520tt@gmail.com>
> >
> > AIX logical volume names are stored on disk as fixed-size fields.
> > The partition parser reads them into struct lvname, but later formats
> > the fields with %s. If an on-disk name is not NUL-terminated, the strin=
g
> > formatting code can keep reading past the end of the 64-byte name field=
.
> >
> > Limit the formatted string length to the size of the on-disk name field
> > when printing AIX logical volume names.
> >
> > Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  block/partitions/aix.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/partitions/aix.c b/block/partitions/aix.c
> > index f3c4174e003e..de19c19c85b2 100644
> > --- a/block/partitions/aix.c
> > +++ b/block/partitions/aix.c
> > @@ -261,7 +261,8 @@ int aix_partition(struct parsed_partitions *state)
> >                               put_partition(state, lv_ix + 1,
> >                                 (i + 1 - lp_ix) * pp_blocks_size + psn_=
part1,
> >                                 lvip[lv_ix].pps_per_lv * pp_blocks_size=
);
> > -                             seq_buf_printf(&state->pp_buf, " <%s>\n",
> > +                             seq_buf_printf(&state->pp_buf, " <%.*s>\n=
",
> > +                                            (int)sizeof(n[lv_ix].name)=
,
> >                                              n[lv_ix].name);
> >                               lvip[lv_ix].lv_is_contiguous =3D 1;
> >                               ret =3D 1;
> > @@ -273,7 +274,8 @@ int aix_partition(struct parsed_partitions *state)
> >                       if (lvip[i].pps_found && !lvip[i].lv_is_contiguou=
s) {
> >                               char tmp[sizeof(n[i].name) + 1]; // null =
char
> >
> > -                             snprintf(tmp, sizeof(tmp), "%s", n[i].nam=
e);
> > +                             snprintf(tmp, sizeof(tmp), "%.*s",
> > +                                      (int)sizeof(n[i].name), n[i].nam=
e);
>
> Is this change necessary ? snprintf always adds a NULL terminator and
> truncates the input if needed, isn't it ?
>

Yes, snprintf() guarantees that the destination buffer is
NUL-terminated and truncates the output.

However, with %s and no precision, snprintf() still treats n[i].name as
a NUL-terminated source string. If the on-disk fixed-size name field is
not NUL-terminated, snprintf() can keep reading past the end of
n[i].name while looking for the terminator, before truncating the output
into tmp.

So the issue is not an overflow of tmp, but an out-of-bounds read from
the fixed-width source field. The precision is needed to bound that
source read to sizeof(n[i].name).

> >                               pr_warn("partition %s (%u pp's found) is =
"
> >                                       "not contiguous\n",
> >                                       tmp, lvip[i].pps_found);
> > --
> > 2.43.0
>
> Best Regards
>
> Philippe De Muyter
