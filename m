Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED3258EC2
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763947728; cv=none; b=G482V5razsLZmQI38ZKhcoPTnwMuYTZ0ZCDmlJaaVZxpBoudWEsGh8AQp2MU7/uFnZlhziA20oYXgvXbcn8sihF3co79mgrOg2s853ExB+/8ZXcmleZR8egMoEbX/E0lt7P+JQGVlts4ZwhVuwbUB+x9TftMbENtggTFtSrA3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763947728; c=relaxed/simple;
	bh=Tdtix09h6RcCKm+k90F10JITFmAMc7QjiDjFYuJxxsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPaDQFERlmp897e3g5QWquiBiQqyTKJ7jMdVYUtfFn3sUa6UMrlWie8nXWHBowu6+X8r6As8SJVkP95xpAJr3sAnFhWYY59M1311GTQQ4hmSeQrW1YBoXK1SIiSqQrHDb/YPzsxxcJz44xQolQbqLiDosjDfPjqxaiWesI9ys4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey5xmHMS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey5xmHMS"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88056cab4eeso27120196d6.2
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 17:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763947725; x=1764552525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=Ey5xmHMSbpttxXry1ArkU+2c3XF5FWeZC4mfDJPOPZuIMq5q0paG7w/GGZ7fZhwNiF
         meRJdkHSq4tIw2wUT+lyF9W0j2nVnIyzSSgx0MPqAR2TJ4IE6kLllxT/GZy/+VZbPhu3
         hk1onHeMG24fgCQYgt+JMgEDDxKezQLfQJYWQddm2my/vJE6q74I9FToJJBJZUL/Fj60
         beFnszMUtdFuTujkh647UU35tLVHb1EluT+9fGGcL4IKNDF8XTlLNq2gb5pUq5ECFeIl
         0ODfM+yQgc4BW0t+kkKsTesAtOoSfIdIvUEsVwCh1qNUivM5DEKurXWClwTQakFhaiLk
         knvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763947725; x=1764552525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=wycL626Xd+52Be8Gt3xGIdlnskBdG5g/S2EGj7WZurdLQcI36XzoaUR6T//VrkmRq7
         X2mvbs+lmCwDCo+jW8UWatf7l+wuOoUxraXKxYPOCP0YHrrPdkG/Mves8NlZptzJs5mF
         GytLGbsG3tFNEki2FXDaPUCX7C3MDkz4gLmdUCSXIPoDVN8Po5yl6mNcD6mF8WXuR+54
         C6W0xo766Q2K/55cGtK0+iPfkdbXJ5xDO9gMtAw6pJ3LuS+qyxdOLXdJ7qyK3XVCfTwH
         RXUD9KFy5f9UOMcQUR0tmjEj7vttsz4nviXJ8aSQxCAliiRJpb462O0d6S/k4AtgawlM
         NjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVIFRsI2v3e07czVdHFofWUpRpLXShdRFXSdtl52zTMGBMkB/K4ZBy1LtkUzxYj4OuA0x6P2ql1Di/elQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2m0FjbXOghxP7XMqGtcfWPZZKtH1rDLCbcklz7xKG8gWeruX
	HG2P4NbZXyYbrjxX0aSE5fzExWl7tuccWPAAariXq4Gz2KsPidRGKNEcaaSB/E51fErxAf3LWaJ
	a6iBErQhtAaKCQrv9fqPHvfZ5X5la8kU=
X-Gm-Gg: ASbGncuBU0noFOgya/0MU6jHI1z2UsACv87ww6ZHhwXyMBQLUG8cRFh8bxczc5z37SU
	X1T/K8PSzKVrKqwBVj3qBKHOD8EzgWzc1aLIdYynuHQQXNFp+wvlVr+GS+iqaFgaecwcc7Ksgfs
	0Wwez0ozKt9tXFHceWA64FJmWXfxnQIBckh8UebZs/UVd4MPPHObF81oPqQoRu0C71vp5lkbyk1
	n16tYXKackZJ0zezEQq7kQQi2iIFNXisSNH7lVVZAzQjozlPQQmAn/m123Sl2FwMJlVk8q78pLn
	a+HOcQ==
X-Google-Smtp-Source: AGHT+IFHZruP2YBfL7pdTjTDvePbwJad50RtaobjpQ37TLxnePvW54pVHPb5rvzSUyg3BEeJesXp2k7UVUVu8L9oRt8=
X-Received: by 2002:ac8:5d0f:0:b0:4ee:2080:2597 with SMTP id
 d75a77b69052e-4ee589103cfmr127248731cf.38.1763947725292; Sun, 23 Nov 2025
 17:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
 <aSMQyCJrqbIromUd@fedora>
In-Reply-To: <aSMQyCJrqbIromUd@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 24 Nov 2025 09:28:09 +0800
X-Gm-Features: AWmQ_blFIl-YjYfjpEue9I17YWgGWhW3tKNMKvxlJbU5ZD_pYkwFt7d133xm8_0
Message-ID: <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8823=E6=97=A5=
=E5=91=A8=E6=97=A5 21:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > > > static void bio_chain_endio(struct bio *bio)
> > > > {
> > > >         bio_endio(__bio_chain_endio(bio));
> > > > }
> > >
> > > bio_chain_endio() never gets called really, which can be thought as `=
flag`,
> >
> > That's probably where this stops being relevant for the problem
> > reported by Stephen Zhang.
> >
> > > and it should have been defined as `WARN_ON_ONCE(1);` for not confusi=
ng people.
> >
> > But shouldn't bio_chain_endio() still be fixed to do the right thing
> > if called directly, or alternatively, just BUG()? Warning and still
> > doing the wrong thing seems a bit bizarre.
>
> IMO calling ->bi_end_io() directly shouldn't be encouraged.
>
> The only in-tree direct call user could be bcache, so is this reported
> issue triggered on bcache?
>
> If bcache can't call bio_endio(), I think it is fine to fix
> bio_chain_endio().
>
> >
> > I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> > erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> > are at least confusing.
>
> All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involved
> in erofs code base.
>

Okay, will add that.

Thanks,
Shida

>
> Thanks,
> Ming
>
