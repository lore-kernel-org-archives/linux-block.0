Received: from mail-ed2-f2.google.com (mail-ed2-f2.google.com [74.125.228.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52783A8384
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826950; cv=pass; b=ip89yBYMEiweWT4oPTzK4vrcHYWFxum39X1MY/yKVuCR6zvqhxYxSeVKFtS9Nz4xmlOiYWgKPjW359c3vP25zj8fTzuAT34kxuUk/LHUig3FXlQhH8AjSgAg1mNMfEVi2Ev60DGyU+xErHx7vY15UEjXvk4bGImaA16zCcLdlAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826950; c=relaxed/simple;
	bh=SGlzrTMsjcbXfdXzf/1HbN0kBYLdL/vbXgaWkiX7k7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL4PuHQnZKPZSv/oRXhEyGY8fiVNpUm8QqCn/PRtWyBmKxZEas0PvS/qAwmUqums+k5fvqBRjexoVHa9b6TwdCCoLReyPaWXEgy3RKrFbT9/1KRK9OxVqSyxbhIPxRaDrtCNSe9lEj6EB28esdIQDvk6sMAh5KA4ztEhiXl7D4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5+do0ve; arc=pass smtp.client-ip=74.125.228.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5+do0ve"
Received: by mail-ed2-f2.google.com with SMTP id 4fb4d7f45d1cf-69af1cf65bdso1865956a12.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 00:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785826947; cv=none;
        d=google.com; s=arc-20260327;
        b=pzt29MrfO6ehCkepsoonNZ2lyF15Dw5JCOR+7Hr/wyEbBfPw0UP/bTVZviX3BtUfbV
         gdUvW7Fn8BtmgJLSEo9nckScanesbXauF5U+vIKJHMrZrHxdGeUU17IPMgOcQ38fPCTr
         uoSOc5bYIachz4MCZARsJQkuK08osebpSkNJBPXivlXMXHOk9mlBbfcxDiauLTMr+6Kx
         FqVSwU0SGpYuaCY9d3SCd1/pn0BSvIaiHdX146fqIhFycBnYP1JaV/46LC8hKkzB+aYM
         +CUfEOs9Ap7cNDyYAR5Nbyq7V8vlNQa7pbZ3A8kIZeCk3zox3syeoGaK1DRo3FPaXU8P
         YDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJZspb3NNzf6LgCOIB2oLgQisf3iW3/huLC5rogu2V8=;
        fh=qeaUkbbn0l8k4y8C9hdcVIHvYQQIAGU4PWA6rO51qt4=;
        b=qIkrcimkOKlNsfbs+lr1Rs7nMriC8fjXpUTCdllQ5U3CRw54Hc4OGGX+Bj45Wpvx/u
         TvXQftVM6Sdi66Gp9l4I2ptOW4RVvPQXX3d97F5cuo25Oed+nuTz4mvEEsMYU29uwZL6
         gybkSqYypzGHInneBLyaGNUU0SrJOC6BqRNpRqppwkJtvW7nqm2R1DFn+Ek63FRioZiB
         hoaYRG3LG8N4S5K6xOIHUfBnyfVExWfr0OrQURKBiny3X6zE2fTXx/Xm5e5bb+YVY21F
         K4BqrOZferaFfTgOUjhAaNbsyPvnsaCDRrnhatu6Vhmu/9iSoe3r0O9L3jycR8IFz5EZ
         qBeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826947; x=1786431747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJZspb3NNzf6LgCOIB2oLgQisf3iW3/huLC5rogu2V8=;
        b=b5+do0ve4QbOFw7rl38xlSebzHCni/xjOVAM9x1gPqM5pTLgrTc4SkD4yo33FVY41x
         lijaA5/IYJSVPqZ7Q22XPkD/5RLiMFjVqiGx8fguuMLLbUuoWBmo7dPsLGxpISKyzL8N
         isPfZaW6y5c9U9JY0ZB7nO6qTjr2AvBtCQZwAz61NqeDLIkDgd2bn6+v5WE7SSvJ/FOx
         GdbZJ9yzRAjkrmnHDqh01ef88PeRVpURTRRWMhzBdkzCC9eEp0WV0aiWREkEtaWGVFjm
         XqgmtN8iXw+Gu4LmnvaRPRsXoZmJdzN+F5bhslttByKLT/1YwIyTHBLLRV6Jta5ehP+3
         karg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826947; x=1786431747;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJZspb3NNzf6LgCOIB2oLgQisf3iW3/huLC5rogu2V8=;
        b=ZAS7rAAC+luW2bIr3l2rwpb4GjX2TKWHycignIA9cUq5nn/RG1xBrbyhZGf+PvbzR/
         R5yiZvy+/7K52l5neUYL2pglZhNOXjOeDXpXp++HcJxDiKzYyq0Y/Yr174c5d1MpaYJD
         ktupasfsmmWhqzp06EUsY3iITGYvgnA37zIehOiMw8F3oiuW1lS6GiD+aGrHXar2mHGC
         ucxqBA3FyqKz8g7IT0Ua2VkA0g/hiII095Rqa97OdsV/Ybu7bpogeKL4228LrTuRZydA
         n6IF72VkJCirCLpS0lAfnHKy8Z/ROeOpxftDVWb4MmwVbxFH8O/bPbyAvEKbk4b2Bns2
         4h9A==
X-Forwarded-Encrypted: i=1; AHgh+RqJtqetxJ3Mb7OIA4X2+rbWSAPepKrmf/93M4+3ahX3/eOBJqB4tOorhnvaTsse05u60GlEdSTrZ+xjrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB06O+LZRuJWFAvEQdCvUxosGb7MaB2DdBfp1LzQAcT5Rzpo4U
	gDwgq7QnN5BCNGVFHigx+GxDRPdd33WUpxQe9y7EamZqB+nCaup6rG/mvh3xE/pBvHoBaS/FYs6
	M2KWo3EXsvav8TAyM+yyxuVvXa+ck5fw=
X-Gm-Gg: AR+sD10tqnTMnLsCtXmP/gZKDt7UTek0GTkOKp2Z0vHkmehB2I9jaNCifPSuzC5AcHr
	qf1qoGrtGvCFJvA5BMGyf/PGN0XTzUxvCqi1P7Nv3ry8otPpGnaU/8WcfnZrn77UXjw7uOxNJTM
	YkCwV2gMWZ9zw7ZZp3KvyzCEZn+eyuwTPs1S59/FlNCcQcdVTK0HE2W/0dRsdBKcnVE2GlA/+JM
	9/bAq7ztVUjbcDzzqSgEVlaHNmRFt1NSWqRaBmDQjHtTgsW5jS2w6Y2DgtjU3BBcIui8RVh3HKg
	vjsEDm3Rel94HY8+gIRgZVyW1WN2ExBRCyhGDM36d1dhYg==
X-Received: by 2002:a17:907:b042:10b0:c1f:8145:820c with SMTP id
 a640c23a62f3a-c1fe80ba52bmr764193466b.2.1785826946935; Tue, 04 Aug 2026
 00:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com> <20260803141256.60599-4-haoqinhuang7@gmail.com>
 <anF5ZikFOgS1hp6I@google.com>
In-Reply-To: <anF5ZikFOgS1hp6I@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 4 Aug 2026 15:02:15 +0800
X-Gm-Features: AUfX_mxgb2sjniuo-JeC2MxxgJgI3JLh-uDKuhbu-g1DTsOecbqI8_MwS00u-OQ
Message-ID: <CAEjiKSnECdUd9oZNbhJLiD5NTpOY+fx=mKNnccCXtBLyEC7KCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's setup_params
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:37=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/08/03 22:12), Haoqin Huang wrote:
> >  static int deflate_setup_params(struct zcomp_params *params)
> >  {
> > +     if (params->dict_sz) {
> > +             pr_err("deflate: dictionary is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D Z_DEFAULT_COMPRESSION;
>
> If we want to be pedantic, then {} should also be added to the "if"
> in this case.  And in other similar cases.
>

Okay, thanks for the reminder. I will add {} to the if-branch for consisten=
cy.

> > +     else if (params->level < Z_DEFAULT_COMPRESSION ||
> > +              params->level > Z_BEST_COMPRESSION) {
> > +             pr_err("deflate: invalid compression level %d\n", params-=
>level);
> > +             return -EINVAL;
> > +     }
> > +
>
> [..]
> > +     else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
> > +             pr_err("lz4hc: invalid compression level %d\n", params->l=
evel);
> > +             return -EINVAL;
> > +     }
>
> Let's add a small comment justifying/explaining that "1" constant?

For the lz4hc comment, how about:
        /*
         * LZ4HC_compress_generic() clamps levels below 1 to
         * LZ4HC_DEFAULT_CLEVEL, so < 1 is the real lower bound.
         */
Does that look reasonable?
