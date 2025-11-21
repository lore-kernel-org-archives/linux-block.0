Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8228F948
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741618; cv=none; b=f4kgXbvfR5tFM7p/SO5eD6t5oaPzTK35zAy1wdYbpAUl1oj8XcQ7Lpa+H/bsK5VlBTJd7G+sOAMhRV3tt8QERIqkOcZAuhhHonY2xu7V8GmcfhedmVORosalDBA9mahCsiVlFCo6guRvgn1rcB9B2C0J+fRUXSfbZ538OoHMvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741618; c=relaxed/simple;
	bh=dMK0oCGPkhBORnYflGD+Nd/wtsiqo9P9q5j0HWkQypo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwm/A+ZnV9mloJM84aKIegSYeTiikaN1g1Bp6q8VSOTk/3ik/DpLFvaa9x0w3QvuJ3zIObc9qTWhTJp6pj8kLN92kRQLqdSkPjeXFgcW3eFDSDft5vMf8PRjw3qiaRZKiRPkQPhhqefMkMgepfE6rsv/QxxOzdX75Y4i83tZWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcNQhhhh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M70S74UA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcNQhhhh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M70S74UA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
	b=LcNQhhhhpJ9wRd7zseKWpTJ3jS4xzTdefbyazCyQs6KiM94uuKs5frKIxOWAOiyiQVTRl5
	FpwZDTgFDVXCxw2WRUxWRkZShZSpeqkihAI/XF1Y49UN16KSOoxRo7x9rYkpuLLoPj1BeB
	CbyfCBjqxyvVVqsEpfXvtMqk4aivARs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-yKJDMmo-OyChKNKSE1MBQg-1; Fri, 21 Nov 2025 11:13:32 -0500
X-MC-Unique: yKJDMmo-OyChKNKSE1MBQg-1
X-Mimecast-MFC-AGG-ID: yKJDMmo-OyChKNKSE1MBQg_1763741612
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787ee7b3ddfso31748917b3.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763741612; x=1764346412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
        b=M70S74UAnBIG9N5oZ9Rp2ATpXZS8B6FvPCAAaLGqm5/qTsp/1gFY8X5SPmDoPjcspL
         Y4EUL5PYHLbLPWLtiTOoxs72iavnvlIrB4VAHjhIS7ZRBpfxRr3R3oFexj6B0eTNUuR3
         z77yVc9iiGZsAW5e8NLmHF+n4YmVxPvC31PV8MtambFu3uABQ5pc3a4VvqI+gt9gSxaW
         SHnQT3XhDb6HOHIsuzkkyl9Z/qIr3JFbxv67XKmxg+5hrKsPTKO3PM7ABTz/qwarBeFp
         BiThZo7VqoDugCS8t8GaCyRE6FTX1BlnQBilUIpxOetJe0EtpscTXAnK3xjlfQVz8z1H
         nRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741612; x=1764346412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
        b=pz4J0oZ0Vzlho61qsfTdsGPFdykQcBLO6XKiQmwSSCRprVglCsEiSRN0iReqRBO7Q5
         5tWmTcoS/alQH4tYif24k/kcXZl+IA5xxezjOsWfqHmnuSv81R/khoKAkrcRc0RahQb4
         TRv93Uv8HiG7G/2U/9Rn9X+Ylg/4aMYisoWcRYMjhw3jWz4duKX43h6EOudvNaiAizRT
         /ueklKHJsm1k8ON2u7k3/JaSDOZMkUjGpxUSQOjJRMPESHmIOwGK9TleUa1SNmCufH+C
         wks+VeNNEo58o4b68LrW52BXV/UmCvhuzdVc7p4rN8uEW9MOYpSOLKgCPIx9cubW9ggP
         eAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrO5oBoklmmnEUTDkiqySk+Px2ATbubrx0//nwXNqCmBEqmmsjb7icbb6BUMTl5+m+aH9wG77Ok+jS3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18wBRY85pzzvYGNmFfFquSRfZtuSj52dJExb7eGjGETJFlXTM
	yi7354k12tUE98yS/8qvPiW5yuEw5DvRYPPTX4On2e/gVb/8Y2TFf07o+wwzXZ/P51dpSVAlONL
	Fgyw0ZYihMORnymD7Nm98SA0Bo+iSkA1RcqrlPUdcErjAQduBzzRITSZC+8jynWN4vCYycaA8xY
	rIk39lnQiDHDPQ9SimA4gCOBegxSSuSZikzVq8Xug=
X-Gm-Gg: ASbGncus4msGMYV6oIhPusIJ24e/Kn4cuoaT+QKwAiLTPUer1SDpZHfxj2c56KGapvc
	tCHI/MByuI56IqZYO/lswO/O8i3404Ayb7MLwyiOlsDy+kqBU6Ko6Y+AsU2dme7X21rj76TFvOI
	EODJFhM/WUdOiqp69nwR7q+Vv4NjGZQB1pDAYXOHVYd0tbOoLlXbyEl+MIPnd2T5Tj
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id 956f58d0204a3-64302b122d9mr1963774d50.85.1763741612191;
        Fri, 21 Nov 2025 08:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHJg27kBmo+3qPSDwMS0FzdloscgwgQdqDmCn0XCLoSgo3nmRsjJwwBETY525KvvMg6grxlgTavlZWQ/uK4U=
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id
 956f58d0204a3-64302b122d9mr1963750d50.85.1763741611792; Fri, 21 Nov 2025
 08:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
In-Reply-To: <aSA_dTktkC85K39o@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 17:13:20 +0100
X-Gm-Features: AWmQ_bmosC4btoZ-wa-ksr6NsYAdeqQOhz6k6QYvia4F3jK6NJjmea5Iy6uFTHo
Message-ID: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Christoph Hellwig <hch@infradead.org>
Cc: zhangshida <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:38=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..55c2c1a0020 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > -     bio_endio(__bio_chain_endio(bio));
> > +     bio_endio(bio);
>
> I don't see how this can work.  bio_chain_endio is called literally
> as the result of calling bio_endio, so you recurse into that.

Hmm, I don't actually see where: bio_endio() only calls
__bio_chain_endio(), which is fine.

Once bio_chain_endio() only calls bio_endio(), it can probably be
removed in a follow-up patch.

Also, loosely related, what I find slightly odd is this code in
__bio_chain_endio():

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;

I don't think it really matters whether or not parent->bi_status is
already set here?

Also, multiple completions can race setting bi_status, so shouldn't we
at least have a WRITE_ONCE() here and in the other places that set
bi_status?

Thanks,
Andreas

