Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238E27C84E
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911873; cv=none; b=l04FLsgb2PHQj+4p3Cj3XaVm7K5ohTWSzi77C3W91hMtI7tKmSZIUZ/9qN3DdU9EgLqfsvGhKN1vnw4Viy/ozF8AxjGdE4D66CNEiNs6DNSkWbk4sIrtSABPJm9T0xlYbo1Wsb4LY3NUTSUQ4QDfehs0qO5l0S/uCsziwU4/Llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911873; c=relaxed/simple;
	bh=HGl4RmpFu84gj76U4PQa4Vp95wD0o4Jckxg3KXNlwxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgCmYEmnWOlj28JUsk456UNzq5FpuM3OFbeQZW331iXn1vsKRHi+aRuL+VUIaoF9uDED4gKaB3ldkE8ptbhiYFXlSS+OtlSXYB7yxhbl3zjSppx2LadMHkU+g23utePvP+rPni5Lq+O5A9Dnsk7lWLTY1Ajlv7yRbioletcSo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YVia3w17; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YVia3w17"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso44693a12.0
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762911870; x=1763516670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGl4RmpFu84gj76U4PQa4Vp95wD0o4Jckxg3KXNlwxI=;
        b=YVia3w171u5knPgbighujbP5v9rBubbB2FNrtOBtVV5O47YWrXyc/Pn5Ci56qYqy7C
         wtsq5ItmPRXn/THYU9nemte8nEXv1P7GjvARUNNGn98Ycti1mrsQA08bsc5N95BC8W/4
         3TFfadCa3EH5l0GKBq4hcqXsPsKkBlVGpo6wFb+UgbCczuhwZQsba5Adv+Xq04us3clD
         /I9xYN/3+JyiTDKshSDHkyRxH49LmEEAPHILn6ZfAuDl5xmlh0lYxveQS2degWpS2g/g
         YO+cj/rLUQEE0eK7KYnJ2zi4/ITzTAJYV8wLC3bk4AdnQCWjeePPHwNhiYzZBpwu5Jy+
         vicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762911870; x=1763516670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HGl4RmpFu84gj76U4PQa4Vp95wD0o4Jckxg3KXNlwxI=;
        b=BAngFfJ5Z/zFng9ZTl1Dr6sHwEhDlZQY0itB4HuzeEgCUynsXsabpUdWd0ModmTqjv
         Br+yf5K/1C2I7VJSsZ77uoXW3pDYpWbR7EqSGD+eqnFvOe4RNqNJR7WKKZR4UeV+CQzd
         59yJ+Ikeru1Xya/z4CLnI48BdXWpbMsJCjiWWclAJykN1uxrWjBgAyUeKsnJqStQA2vT
         sh4xIqhvFsv+cbhPqpRIkjrs9L4Di0AyVQ6CG3faPJWZJnPUAWvjT17jTd2o5cfmhSJn
         zsCKSwHzYWTTbe0mYGPvM+O7FZcsdm7BMLDp4d1QYgVonRtaZDCAW5L8QGI8vDgJuWHQ
         wsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu4DRWWqHfrfvrtFfMhtUq4dbIN9QZxVhreHaitoVGloLGez5SBNeXeN0w0dgEs71MktiZ+awAAkAoHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoq+m3M+kyVDU3Hxpjc7Mc8D3DdajW+yKPPz/qzhyajdskpziD
	m0jpeUbxFdIO7j0jP0q2devhAmZIjgb/vqJNUmG84PISJ1+sN6it59xzk2V/yZ5FsL3JUWSnqnT
	asQ07RiUOe0NeszbkMESjt/AcjQnTF82Skaaxyvo0Ug==
X-Gm-Gg: ASbGnctAoAQqqEd0jn+9CWc+dANK3j1Fwb7Nk7Oze5d2pOmp0eFhoKcFNYJ4F0QltUW
	Czq3rBug2wD7pOhrp9L4rDX2HM9an3f4Lszqs1/YHll0BCJznwRgppjDDaka0ywE1hFyPz2lsQM
	2OyAQzRuiVOkxd7XANHoe10bqBeVeqIWKa8NVqMGgqp5M1mcJU1CcLLCtJIQoga5zaDQYpMgTUK
	0cLfi2Oxo0JSMYITjXPF7zFi6EoNl37XiK+hwmds4C7ihTCrqxinT4i/Rmo1GD8p2CUch1u
X-Google-Smtp-Source: AGHT+IGGJzsPUNQafoq4PvUv0D7ILT2uewqou7SB/zBZxjLSeaobS11qhsqkImiirH/dj7vmyyEFOkI6mNDh5iM3Jto=
X-Received: by 2002:a17:902:c951:b0:295:f926:c030 with SMTP id
 d9443c01a7336-2984ed34944mr9164955ad.2.1762911870295; Tue, 11 Nov 2025
 17:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111191530.1268875-1-csander@purestorage.com> <aRPcdmpZoet2fwbu@fedora>
In-Reply-To: <aRPcdmpZoet2fwbu@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 11 Nov 2025 17:44:18 -0800
X-Gm-Features: AWmQ_bn5L0BHdz5rRKs386fOtrXPE9SRJa4pEt-kLJPqzJYTQF4qFEB9j2C4mwg
Message-ID: <CADUfDZovn5fPh_E6GGvGkPYbW12L2z6BS4jPkpQjuEjNd=bRGA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as
 number of bvecs
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 5:01=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Nov 11, 2025 at 12:15:29PM -0700, Caleb Sander Mateos wrote:
> > io_buffer_register_bvec() currently uses blk_rq_nr_phys_segments() as
> > the number of bvecs in the request. However, bvecs may be split into
> > multiple segments depending on the queue limits. Thus, the number of
> > segments may overestimate the number of bvecs. For ublk devices, the
> > only current users of io_buffer_register_bvec(), virt_boundary_mask,
> > seg_boundary_mask, max_segments, and max_segment_size can all be set
> > arbitrarily by the ublk server process.
> > Set imu->nr_bvecs based on the number of bvecs the rq_for_each_bvec()
> > loop actually yields. However, continue using blk_rq_nr_phys_segments()
> > as an upper bound on the number of bvecs when allocating imu to avoid
> > needing to iterate the bvecs a second time.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs=
")
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> BTW, this issue may not be a problem because ->nr_bvecs is only used in
> iov_iter_bvec(), in which 'offset' and 'len' can control how far the
> iterator can reach, so the uninitialized bvecs won't be touched basically=
.

I see your point, but what about iov_iter_extract_bvec_pages()? That
looks like it only uses i->nr_segs to bound the iteration, not
i->count. Hopefully there aren't any other helpers relying on nr_segs.
If you really don't think it's a problem, I'm fine deferring the patch
to 6.19. We haven't encountered any problems caused by this bug, but
we haven't tested with any non-default virt_boundary_mask,
seg_boundary_mask, max_segments, or max_segment_size on the ublk
device.

>
> Otherwise, the issue should have been triggered somewhere.
>
> Also the bvec allocation may be avoided in case of single-bio request,
> which can be one future optimization.

I'm not sure what you're suggesting. The bio_vec array is a flexible
array member of io_mapped_ubuf, so unless we add another pointer
indirection, I don't see how to reuse the bio's bi_io_vec array.
io_mapped_ubuf is also used for user registered buffers, where this
optimization isn't possible, so it may not be a clear win.

Best,
Caleb
