Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B38154BEB
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746992; cv=none; b=Y47uQdqZMW873J9S9kEw1A1B4qXN1yLREnk13WlO3IfyFl6dczJMO548UjBIs4EQELBVTlrZpdXSCi8n5jwbDoL1fp9RBBrqxQXSyInoL6VhcZqXGauBVXJJncJyvr9eTuHS9q/x24WeGyNwRDfxcx9hmJtlEc9WsGlgrwTX5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746992; c=relaxed/simple;
	bh=eLMLx9zeEFexg2iguwEaoSY69Hs5LeFsam4VLUFdPjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuLovS42fqp0fVZtZttDNKfjHfoqt3K3L74rN9VB52TJ6lNdrGN6bhZ6bR9aB4Wu1qKPx127wri0xbAOQWM31gydpnPWxcXMQ22ihD0ANbeleGaO0WvHgaMykNpZIwUbReahg+Q+PdOjvIvzaUCMrrq3bD0lD1PEdI15yxOexWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf/htNo0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf/htNo0"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f401b2347dso44524251fa.1
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724746989; x=1725351789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmhpdEL3F+GMt+Wv+wb1lPtczLRnUwEG+h2xbbf4XYE=;
        b=bf/htNo0e47lCZDbcTLkiFuGRyjpjjNseW9u+/sSnd3KiGJO24ZFXDBI4x8ZURxtNd
         K2SBeALdu1hDuXOBL56MxwqWhYrkgvmBL/3mq7b4VeXqZvSjmGwdfkp7Qt6F01jHfXue
         cEXoQ5+Bdbte2sFcVZAtk0Af5yudhnY5PjiachQ6TQUBq6hg+gQU4yA1iW8qMF2cTsHy
         x7vGmzreXqXGt9pNRCqIBtEu+aDL6jRBSVrH0JBGyNRFQgyFhez+TBKRtyuaeZ/XXsUe
         TX2xUjSAUnOYupofIsSH/6BVsKBeaHEfCz/VDEFAymmqsPCJbPFe2MZWTBOEtd53fLnk
         gyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746989; x=1725351789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmhpdEL3F+GMt+Wv+wb1lPtczLRnUwEG+h2xbbf4XYE=;
        b=HXXWFG3GlWiyxKI9yRcRy0BMUJ8tjHzefcfloA1hziogwtNY50/UoY7IS2EhGc/gnt
         VOjaqDxJuaTltG7zmKD3X7uGFv82B6KUZsDAdNuREJlCc0In6kzPo5sspXJ+SoaxDKKc
         Y2I8mToEes8lGbXWUGeTuprcEbc4KEt8/Fj5ybLRU0YxxobbVHhD2N1ZmPBpYzf7jYuE
         +40UDFAYoqy+8Nz5Y5evKN2+wtrgIMZkJnFIg3ZMaCcaPVxug6lQgLMc07Dhd+sAJAAz
         5AxB8C9mVebZNLSJuux7xo1H8xfMJKp0izUA1GwAxv2u0uPp9oERFH+76HJhwU1C1KwD
         RQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXmqzFTSC6V1oWgWRcVWYYz2zsWmMbz55qGefLftoUAyR/OxiuX2fv/G9lmtfDYj13fLmw7iZiwanWxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4loRllK2BZ9C2oYCz5zBXpbnTDmKY+yJGTSC9QJ7NWv7Ec1r
	MtTg0JJ4dXwlZ6tDTZVTo7hRDQkvssSGWE58BUBXPMLVp6xBjrXSNm7KF1TY6iPZfRCZrtatMgu
	echIC0bNBy96aW677DIv4qGJK+dw=
X-Google-Smtp-Source: AGHT+IHGHaRhwApgvHq8e/+12jq143K69Y94GVmGO8moBtr3RugpxJkjmH67saZr991JxDRV3FALUbmvyjlb1vuRxk8=
X-Received: by 2002:a2e:a555:0:b0:2f1:6108:3f00 with SMTP id
 38308e7fff4ca-2f5149b1d6cmr8619031fa.0.1724746988673; Tue, 27 Aug 2024
 01:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
 <CGME20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6@epcas5p1.samsung.com>
 <20240711050750.17792-2-kundan.kumar@samsung.com> <ZsAlsjZeNmsBI6J0@casper.infradead.org>
 <20240820074321.i5budzkt4efcqodd@green245>
In-Reply-To: <20240820074321.i5budzkt4efcqodd@green245>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Tue, 27 Aug 2024 13:52:54 +0530
Message-ID: <CALYkqXor5Lg_SJi77CHh+kvxsEkEmms8ccaFrWtfivBG66g1kQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] block: Added folio-ized version of bvec_try_merge_hw_page()
To: Kundan Kumar <kundan.kumar@samsung.com>, Matthew Wilcox <willy@infradead.org>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org, 
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:28=E2=80=AFPM Kundan Kumar <kundan.kumar@samsung.=
com> wrote:
>
> On 17/08/24 05:23AM, Matthew Wilcox wrote:
> >On Thu, Jul 11, 2024 at 10:37:46AM +0530, Kundan Kumar wrote:
> >> -bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *=
bv,
> >> -            struct page *page, unsigned len, unsigned offset,
> >> +bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec =
*bv,
> >> +            struct folio *folio, size_t len, size_t offset,
> >>              bool *same_page)
> >>  {
> >> +    struct page *page =3D folio_page(folio, 0);
> >>      unsigned long mask =3D queue_segment_boundary(q);
> >>      phys_addr_t addr1 =3D bvec_phys(bv);
> >>      phys_addr_t addr2 =3D page_to_phys(page) + offset + len - 1;
> >[...]
> >> +bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *=
bv,
> >> +            struct page *page, unsigned int len, unsigned int offset,
> >> +            bool *same_page)
> >> +{
> >> +    struct folio *folio =3D page_folio(page);
> >> +
> >> +    return bvec_try_merge_hw_folio(q, bv, folio, len,
> >> +                    ((size_t)folio_page_idx(folio, page) << PAGE_SHIF=
T) +
> >> +                    offset, same_page);
> >> +}
> >
> >This is the wrong way to do it.  bio_add_folio() does it correctly
> >by being a wrapper around bio_add_page().
> >
> >The reason is that in the future, not all pages will belong to folios.
> >For those pages, page_folio() will return NULL, and this will crash.
> >
>
> I can change in this fashion. page_folio is getting used at many other
> places in kernel and currently there are no NULL checks. Will every place
> need a change?
> In this series we use page_folio to fetch folio for pages returned by
> iov_iter_extract_pages. Then we iterate on the folios instead of pages.
> We were progressing to change all the page related functions to accept
> struct folio.
> If page_folio may return NULL in future, it will require us to maintain
> both page and folio versions. Do you see it differently ?
>

Gentle ping. Any feedback on this ?
