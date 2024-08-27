Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6431BF54
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778034; cv=none; b=aiSwWpyL2tntufTNUxNnK4ealNGWPuxy5zviAFOyuPVSQ9gWBBXWwsZbVgt3dKP3CdqFAowxMGA/Gbov8NgqY1XG57nZXzN42tGF88ZUFZy3m4HCgx41b9bWWF/zcv7YPq5ZgWTnF2idE64SNfubgAMXIv7tv88/gUiFhXFX5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778034; c=relaxed/simple;
	bh=o/36KuuzkZWjaEASkl/Ljq0NVD2Apf8lC7arMzKvLdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be2OyVyBlX59mJ0fx2QCXsMn+qI5/wu7gGi05mIuJsI2FUnV9FgpJ9KULRmrAI/gBfohCSW3lfU6YGE1DcUOU05LTDEtGhQlSkPClozkO0gNRgCCb31lpsTsmr+R/Ag9yi47/cvJfdDJXsHZt94PNExzDxcHi+ErxHR17I3DIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K82UE5l7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K82UE5l7"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c1ed19b25fso46442567b3.2
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724778031; x=1725382831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fi8ox7pRszODxLsH//F7Js7GnpcRgiT9DScTVMAqaM=;
        b=K82UE5l7iOzQfRIj/a8X5mfQkUgLuRuiakHC8mgINbsnVkPQMLPgyv7ULZ4BR5Y69f
         LQ/7RACJZBLCLBHqKeTEkumz3mzBY9/+SDGrFzy/CY5vjcfduX+5Wm2z+ki37xDC5sQ8
         JZcAreHpfYe8qXZqgL7UdTaCEABFEtpnrE+6PG0VdncqjyU7D2O5K8iBA7ck+ZsXkSci
         1SUb5VIHagw8I5evwffWxifzO7UxnFjnf0se2j3vtIdRiTNxNqA51eblclvHnRAXKmLE
         dqwMX4v9iu8m4zjB0t/bge9I4TVdlM///YdQ6pYs3koI8wWPRxlDpoGlkE2slYMCmug4
         lCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778031; x=1725382831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fi8ox7pRszODxLsH//F7Js7GnpcRgiT9DScTVMAqaM=;
        b=j5WN2ftODlbf9SGinC1phLZhDtv5j4qKx+5pW1afZMOh3YTfRZ6ZNQIytaxw8jrYNW
         JTV4mZ47Z/gb2nv0oIV0NiIscDmz3pe/i6ixGk4NzdrH6r3KeVqU5yBJDwnt6fAj//Ay
         XAReeN1feXtxkBKKVbJzCMU1otO7KvHnwx+kik4hsxV2Hi2Q12j5c8cRookjTaWJeckb
         wjAVpD1sOP8GxMJOrnTXKK9KmNpGHB0FbbbNKjF/i4sqloxGsaPDt8RkAhpDld4XRyDM
         jTivnjlL0di3FqmM25wZwmNrJIG/u5obmS9jHVInqJMCweYjPdgChsgroP6tF2Lva4GF
         +HFA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwG9n+QN86hNwQSF9E28C+Gjb5DqZsprnIgtv2bNrVGhHHuZ8y0bQrHXXLlVFu+2tNKyck8Km88pxQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/N5MrmB5F/qHtANfBgKxoma+TrPEgy2uixsC/Ctu1Fj62q9P0
	dq7wPFr4EoeDni7S8pw58fNp84Wv2XaHNQdPXDFbKH8B+aBb5sWbDkqWPOqBLJPwPdsNPeXDn9U
	5Tb/CN79xjPNh49Ti1f1g1TqXrSYy9l67dSE5yw==
X-Google-Smtp-Source: AGHT+IGmbSYxYyIspbSsfa9hoBtIp7ns0PaGV0NrZpzLhufVXheexcEWJMYHo0i/aJn3LcDf04Blwkm+zF5thUq4N8k=
X-Received: by 2002:a05:690c:fd1:b0:6be:28ab:d874 with SMTP id
 00721157ae682-6c6249dd326mr160767197b3.2.1724778031329; Tue, 27 Aug 2024
 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
 <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com> <CAPLW+4=NcjOFRd14ecYd8sMsiJXH9c+ZXse7BVMCWe5ZbMmKMQ@mail.gmail.com>
 <bd334314-25f7-4e87-bcab-e3baed9a7ab5@app.fastmail.com>
In-Reply-To: <bd334314-25f7-4e87-bcab-e3baed9a7ab5@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 27 Aug 2024 12:00:20 -0500
Message-ID: <CAPLW+4=EJ4qw4u34bvJ2KPhkEObodB5y-YjnsQmLwHhKpfPvsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "jh80.chung" <jh80.chung@samsung.com>, Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, 
	Will Newton <will.newton@gmail.com>, Matt Fleming <matt@console-pimps.org>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, Aug 27, 2024 at 2:27=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Aug 27, 2024, at 03:28, Sam Protsenko wrote:
> > On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
>
> >>
> >> The change looks good to me.
> >>
> >> I see that the host->ring_size depends on PAGE_SIZE as well:
> >>
> >> #define DESC_RING_BUF_SZ        PAGE_SIZE
> >> host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr=
);
> >> host->sg_cpu =3D dmam_alloc_coherent(host->dev,
> >>                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
> >>
> >> I don't see any reason for the ring buffer size to be tied to
> >> PAGE_SIZE at all, it was probably picked as a reasonable
> >> default in the initial driver but isn't necessarily ideal.
> >>
> >> From what I can see, the number of 4KB elements in the
> >> ring can be as small as 128 (4KB pages, 64-bit addresses)
> >> or as big as 4096 (64KB pages, 32-bit addresses), which is
> >> quite a difference. If you are still motivated to drill
> >> down into this, could you try changing DESC_RING_BUF_SZ
> >> to a fixed size of either 4KB or 64KB and test again
> >> with the opposite page size, to see if that changes the
> >> throughput?
> >>
> >
> > Sorry for the huge delay. Just ran the tests:
> >
> > - 4K pages, DESC_RING_BUF_SZ =3D 4K: 97 MB/s
> > - 4K pages, DESC_RING_BUF_SZ =3D 16K: 98 MB/s
> > - 4K pages, DESC_RING_BUF_SZ =3D 64K: 97 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 4K: 123 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 16K: 125 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 64K: 124 MB/s
> > - 64K pages, DESC_RING_BUF_SZ =3D 4K: 137 MB/s
> > - 64K pages, DESC_RING_BUF_SZ =3D 16K: 135 MB/s
> > - 64K pages, DESC_RING_BUF_SZE =3D 64K: 138 MB/s
>
> Thanks!
>
> > From what you said, it looks like it may make a sense to reduce
> > DESC_RING_BUF_SZ down to 4 KiB? If so, I'd suggest we do that in a
> > separate patch, as this one actually fixes kernel panic when 16k/64k
> > pages are enabled. Please let me know what you think.
>
> Agreed, sounds good to me.
>

Can you please take this patch? It should apply fine without the need
to rebase it. It fixes a kernel panic when big pages are enabled, so
it's an important fix for us. As discussed with Arnd, the
DESC_RING_BUF_SZ change can be made later as a separate patch.

Thanks!
