Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2821B9E1
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910060; cv=none; b=js7yq1JwLbhIFb4f056Yj9TY4/jKoI0EQ7yItB8h+u0Enqcl6mn4sbk2gvQwjgNChsRL4YkTKls/37gQ1MJvK+f/HruMQhh/T/8DgZlKQK362y70Y9zRAlg+TIFYk8UNsJ/OiXvGsxWYUibk7dHQkWkyNIv2PgWlEkLSDQpcdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910060; c=relaxed/simple;
	bh=idQR6FMP0hjSHldh+8eNgRaRntbDdUsf2KfANjgGpZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv4H/ltSR/WDHxliGTO89ZZdHgCuPDFktvIBFVRLIeyCMNdkTMMhk9WJ1XwEd9Frt8eGxGS0jmvbUfeGwzK3VCS9KvaXY+w4KHaDNFR5A6W1sHSkYA4KilWC1cRn6zNnvxW9bJ8H4cKj/2IDKFU8CxzmSAc/HyOcjlT80lgXa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XgH0y1qs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XgH0y1qs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc288da33eso1034877a91.0
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739910058; x=1740514858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDL5ENmYEobOBOGopXLnOpJxyEOQbkaeafJSwgvXG9c=;
        b=XgH0y1qsmDPH4+mLUGINeUVHRIrZq0QXqUROBMsdK8TZB2Tsdu0XsvxfHK1FOF02lQ
         tQVmLhfpj/my6mUds/l4RhLN0eisw6G5GfSItfwVHqYA2Pu+k/9blzrO6tI7n1r6QkDo
         L8SWcqPIwQDYF9gMFkiCQa8IoKAVSNRjS6L/5nFmNbKEWwB6QKxeIK8H6h2Gr18T0k57
         ZXCbHLxw9/eTRfDVnOvJvbkkUUvcaJcPBaPQm8Wt4WcnD9DOxLZNlfHRy8PuNZYPVpvS
         pvOtAEJ9uUS1Qf8+aIogZf/O4mN3BjLxxuR+Htyp5hSePoFTXt/iFWAFI9aD2oqbDMxK
         Crdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739910058; x=1740514858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDL5ENmYEobOBOGopXLnOpJxyEOQbkaeafJSwgvXG9c=;
        b=MszKrt0i6Z1scEwm49wHarCVF512F6N+93Fr3URF/EDcToqJ9OsdLM5+CVlQIIkWlL
         j9gLGI+32k8rPfgx9ZzW6h6CRETkQYcCiOc6DOwhi0qyEfYJvHzHNpC8GETYkAqCm7rf
         klfcstph4fA2CUkU6A/LKLKTjFFjeyPPcBnX/o3a959EKr+6ARSaz4herjJOgmPADIVG
         4Ox/FU+CSgQB1iC+iBnhpWKhXG3n9zkmb1G7lH7rQPbAmDpg6WWjtjefu9agZ2QqiRKG
         ZrI5GzALeeWtvvuUaB9qiEdp53whZ7CxXCvvx1UmDcRPGLXcg+Nh/5A8S4DZBZRtS+zs
         kB4g==
X-Forwarded-Encrypted: i=1; AJvYcCVWmIluLAd4FOV7CNoo9Ztn1xItqRqoG0OAYphJms0E4xJvWvG5tJzhp2O22Hqpsupmp0aLUkbMpHYmQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoQHUVjuNtLNUHTqVDWypQtYZM3ISaJtFgiZMqiQihw4T4vFv
	8uq4nwSVTZDjwPyniq51LTFlNDtNF6p9ljOo+os4fyLagN6Nrbx0c7BpLdIoGopNlnQVvSDz0Na
	L2NknLeg3B0PZu5SvuuuWoFP7HJMUwIDf+PS7kg==
X-Gm-Gg: ASbGncuXX/dAOnXnzyUqJwmXhMlwQGLv0XzPnKVdQ+Qfa6BroHd3lN5hEGZxizhqK1C
	Tk7m8RgbXDVJD9RikRb6rw5wPJsXLpT3k93uFtAJJIg5HNlxs25hrLB9XIEvZf5E8roXcOxw=
X-Google-Smtp-Source: AGHT+IFzRM9dWI1Dt58bvoJ1SBUSqteELCYJZmXQVmxaJVUkNCmh+yI5Ky9C4ckh4BV7j2wfD7QAXk6K064Fw2GTSEE=
X-Received: by 2002:a17:90b:33c6:b0:2f4:465d:5c91 with SMTP id
 98e67ed59e1d1-2fc41174806mr9071194a91.8.1739910057970; Tue, 18 Feb 2025
 12:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214154348.2952692-1-kbusch@meta.com> <20250214154348.2952692-3-kbusch@meta.com>
 <CADUfDZpbb0mtGSRSqcepXnM9sijP6-3WAZnzUJrDGbC0AuXTrg@mail.gmail.com> <Z7TmrB4_aBnZdFbo@kbusch-mbp>
In-Reply-To: <Z7TmrB4_aBnZdFbo@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Feb 2025 12:20:46 -0800
X-Gm-Features: AWEUYZlQ5seoUzPfhkm2G3v0L4jrKcOJ-d0Fq30l0zSfFPjJJDR9eBYRJ3c3ezY
Message-ID: <CADUfDZorM+T+-Pk4hbsFk_+kJFYMAEaAkLompYdM2UWFucOWsA@mail.gmail.com>
Subject: Re: [PATCHv3 2/5] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, asml.silence@gmail.com, 
	axboe@kernel.dk, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:59=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Feb 14, 2025 at 12:38:54PM -0800, Caleb Sander Mateos wrote:
> > On Fri, Feb 14, 2025 at 7:45=E2=80=AFAM Keith Busch <kbusch@meta.com> w=
rote:
> > > +
> > > +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> >
> > Is this guaranteed to match the number of bvecs in the request?
>
> Yes.
>
> > Wouldn't the number of physical segments depend on how the block
> > device splits the bvecs?
>
> Also yes.
>
> >lo_rw_aio() uses rq_for_each_bvec() to count
> > the number of bvecs, for example.
>
> Hm, that seems unnecessary. The request's nr_phys_segments is
> initialized to the number of bvecs rather than page segments, so it can
> be used instead of recounting them from a given struct request.
>
> The initial number of physical segments for a request is set in
> bio_split_rw_at(), which uses bio_for_each_bvec(). That's what
> rq_for_each_bvec would use, too. The same is used for any bio's that get
> merged into the bio.

Okay, thanks for verifying!

Best,
Caleb
