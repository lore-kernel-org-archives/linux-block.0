Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2D2F8E98
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461418; cv=pass; b=NUbC+P/p+VPVyuNwqwuSKYxYUH2uH+QSc35FzgqMb2+SdyHPVib55rYVu+zCpEayt6Zbtb7nAJfafOo8wYeAHCiveJs4uEea0J76oyvrjCYNg7x/Ll54KjB2o3nAK4pIdDhU8NQhosXJ9qfq3A+OIHAZCu1u6s27JnvrwS2uY84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461418; c=relaxed/simple;
	bh=5DEVwwHAOLpWNZ1ox1VOPmnxOO6JKolLkj534+peCT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trUPd2zC57+9/xN6meSg82ZnlOMcvlhZ2XieSTtB0kOwX3bHOyDDXww1uUxVdfV2zyTTrApTSluNpX49xwVrlh9LghEgAnmliEDhRGZhExVkvPlNSnbIBJt9tz2NzxXHSUJoQTaHauUAe+/du6Iut9aLF1LCOcUdhY1CP0fDCSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ+2Ovqe; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ+2Ovqe"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97ea7f0d417so108065241.2
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 11:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788461415; cv=none;
        d=google.com; s=arc-20260327;
        b=mQMhrQzJKGIZcW9+1FOFgnSAmwdjGB3oUKuTciFPB8hOaUeCJDOnGiyWrqTgAPmoaE
         U6B7QQqv8ITJ1Pxz9uuGQih+pwcrT9Ef7LeVLBFntg2WcNA5nLWOQx4tTLVUnwPJx0bG
         pdh7QcEQba67x8baU5hbNF3GuV4YdG/e9Y1lEmm+rfcXbZthvmcsg38qL1MBsaZQf/6/
         wq+qSVzaju8sWvyzQG5KfwdS5EO8f4YAv2vdkFqXv9aNhkRiuSQeD4qsqFk+cw1jPxUi
         d7DSIr2Z6bYrUtI/J05lA6tIgp6Hd3yTOopFIYanYUssHf2brQSwFOAN5tAXx2ShHKpo
         Dysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vm8uYb3ipAldE+m1Om2F6z1pphoIFWqb5yzRqhMcwSE=;
        fh=QC2mKUFr9BKFI0Os6sO3dw5R4llfkaNZWVImuvItMYo=;
        b=H5wN0OdNkEHl7J5F9xNON+z8MTRNIHrf2bSryMgRC8bkD0CHMN3S3sCAIZbEoXM5Hs
         awyUH7Dn9PhLTJFVHIrKbBTc4BEymg8fhN/dTeXKhnc5K2aQU66FYMmfUoW+6IBqts1k
         oYFiVXzAHxm30OVStRJxe1V6DasMo4dNTb3TUEtiOCQ2vT/T8h5hiVp3KEeIg93+B5Ng
         FQBkAb7iC72c+HNJ2YD5+E+SNIYFn+6gCHz2kGYjbzrQGNDcHiNFws3EG/hEyLV+M1ul
         uoTeMkJToxHWrot+i8BbDBCbjPo0+LAejacHOex8sOldKw5hDtxgDD0C/qkyz1FBu/Hy
         UU1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788461415; x=1789066215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vm8uYb3ipAldE+m1Om2F6z1pphoIFWqb5yzRqhMcwSE=;
        b=eQ+2Ovqe7Wy1cwBr25YChWS7BSr1eOpztLBcl3b59OB0Lyzma7TOYohF/HjhFucZvB
         nZ4KeESnOrrrnw8zvbfvaOJQWQRFHNhF78UTGhXMy8lBenXoyxJ0ycceFcdpq4s5FPOj
         Zv1q2RSLXZveVTSxiY2AKPXoz81yZsIm8j2ODAO13D6PF8H95f4Ko4eoXR9rqpHvbDTe
         c4fmjqftmSoxLQw6aUMEnJ6xWFGxFm7xUzgFSBKCkTL9G6TjE/9TiloDg157MQ5bAgep
         ORuDnqA/Zh7AUwCqFoqSVomzHiW0G68/vV/D63KBfooNG0WT4SLRoPz6OAZCOU3Oc5yn
         EQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461415; x=1789066215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vm8uYb3ipAldE+m1Om2F6z1pphoIFWqb5yzRqhMcwSE=;
        b=MNYZV8AYl92vA04QWwNt7ZbwVEY5SvZviaW9I9plgQJZ7TKEHJ0mdfnjrNUJRggTSI
         tiKVP3FSQ416xnlZniZRqsivB4d6VwcHEJA/gY27mIceCXGaR3Z7s7wHyiRG5+JLwv8K
         PIsHwsn9UDVgqkQZF+TZCwgLbdYGgYpsSqY7WJfzxgWwewY/8Wqxt71kMMRPxBU99d28
         QORr5Vfu/FN1aa4OQIQr9RpfCMY3Nrur2krRfnyJNGtDyqSEQoC6x+DDNe+FDQ+ZzmPi
         LNOueBdSJCilr3UZvHQhYSW0bd49AaL0S/jBARmh+OqvQYPu/hn4LPmWHurMkNHxLUmW
         BMNg==
X-Gm-Message-State: AFuF++kSOfwm4F87+7bXPg4etcGanCSIKbMF57SId682SvyTSAAdu6e2
	250s8mOc+xzs25/nZy1eP0LCk/QD9bdzX1lVR2BOXiy7GfKBgsRA5IJcqoV/p2qgkN9pgdbpCVD
	uGLGFOHqJFc7V5Gq7bob+8htquDn6pl4l4uVuLXNc4trM
X-Gm-Gg: AYBFou2nVijRkDokii9mTwVe0hwfiUoR2TPgP17bow6F9N50KCgvlOhioBcL1h6LKsy
	4gtXcFbFEq+OSndVRlbwd4AysuGHuWBFuRaVGe6AZJlnma/OhTpkHlL2TfOuwQspsIwB9HOwkmc
	h4YR9f9P9XG1slBqOwMObtnRjSHBRdM1eCA89FQUGL034NYkeAAs13RQeYstysgfapaY5mYaEDd
	9GDXBItroCfZANPRg2paOh3xZn2HN1ct6jyRxo9k7Yrxe16qvNlXyHffiwfKIWwrhyVYUlzGbQb
	y9Rv3t/FP1Cd7tPGtNx8M3vl4rc6I2mecU/0sZrqU5uxZw==
X-Received: by 2002:a05:6102:3a06:b0:781:9922:78f8 with SMTP id
 ada2fe7eead31-78a1f34dd1dmr5115116137.13.1788461414539; Thu, 03 Sep 2026
 11:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903174124.51009-1-mi9992828@gmail.com> <apm0q8sNDooT53jU@kbusch-mbp>
In-Reply-To: <apm0q8sNDooT53jU@kbusch-mbp>
From: Maksim Ivanov <mi9992828@gmail.com>
Date: Thu, 3 Sep 2026 21:50:02 +0300
X-Gm-Features: AcwNN1UTvMxWrpvy0N1bJOoVjIRErtSoVKG-8v1liJCSKik6KNgfWHa6wVBrEck
Message-ID: <CAHmptyB7i3YHOhDdDekAo0hBWu7C39eWOApx3Q84yHosO4H-=A@mail.gmail.com>
Subject: Re: block: zero logical block size leads to infinite loop in set_init_blocksize()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Is your driver writing over the limits outside the API's update path?

Yes, it does update the queue limits directly:

    volume->queue->limits =3D limits;

There is no blk_validate_limits() call on this path, so this bypasses the
normal queue limits validation.


=D1=87=D1=82, 3 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 20:55=
, Keith Busch <kbusch@kernel.org>:
>
> On Thu, Sep 03, 2026 at 08:41:24PM +0300, Maks wrote:
> > Hi,
> >
> > I hit a soft lockup in set_init_blocksize() with a block device whose
> > logical_block_size was zero.
> >
> > I understand that logical_block_size =3D=3D 0 violates the block layer
> > contract and that the driver which allowed this value needs to be fixed=
.
> >
> > However, the generic block code currently turns this invariant violatio=
n
> > into a non-terminating loop:
> >
> > while (bsize < PAGE_SIZE) {
> >     if (size & bsize)
> >         break;
> >     bsize <<=3D 1;
> > }
> >
> > With bsize =3D=3D 0, the value never changes.
>
> How did you manage to get a block_device created, but bypassed the check
> and override for a zero logical block size in blk_validate_limits()? Is
> your driver writing over the limits outside the API's update path?
