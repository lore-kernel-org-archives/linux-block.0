Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDA3D76
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795577; cv=none; b=TlF5tU1eKXI6bkwTFZ7SBfkp6EGZ50CgEmt8zwDHryS/9eZxiUqNVl4S9XLLgwtLO/lf6mANKUpAfKu7s8DPdrqVrK0dmgY2Io/DeHU4tD40RRh4AiKguxa/nVcz029+QaDgBz2os4n2lRE5Vacbmvqhwv2dQOrincS6XlS6oBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795577; c=relaxed/simple;
	bh=pI0/d6VWhb3rHB70TMDWtb5UFpEepPzY4oFcPVKsnh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TROVpuHOIVukG/gdW4LSMpaWhrRCQs5qLRlfwwhQNQQ8A+7Rq4OYAezp9px0zILgmP8fMMiJSabxXb2jPNf6O1082a/w4xbvE7gfnb+UczRdeU+WEhcdfwI7l+tdBu+/u/cF+UA03EsGM6AtgFOXgQRnG2rQmeN0czO2RzRyGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PInQDyQ4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PInQDyQ4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47666573242so349901cf.0
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741795574; x=1742400374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrwYv4hV0FSY3G0vHHh7TMbzsgf3mwWBIi9HSSg420o=;
        b=PInQDyQ4dIr1GHpBncgGK5/XRGNFnPfFQtC2uexqDz9zyoUoT7JHfgt4Zps+a1IoLZ
         9F1mzQnt6W5doUKmDd3e20dkC7Ys8+W3pzRK4cJbI8G2/r8cs/ybZ6Q0mDW6zPbMVesT
         EyCx8FWWfKeM7vvve82uFHtXGJvcDuIh0VeFi0QEWbuKFoRFM9iGdcsX3nGslKBZw9lS
         fZz+OjsDV6ah/px1rP0ONs8U4a0EeBrqaExqrHCnXPzyp7kZCESYxC/grSM4my1k2BMR
         j6NSyspAxJ408QBxd9RHOsVIY90ZWqwdxqFzGSBV6sRYp1wczk6ERHOUo0JkLLHFR0IZ
         ZdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795574; x=1742400374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrwYv4hV0FSY3G0vHHh7TMbzsgf3mwWBIi9HSSg420o=;
        b=PFveDNN9nnRrKyr8S/Z9Is84L/K/oiPTBkzEPgjWeYSQVpeGhjAZeK6jFl+LdtqAiq
         hVaMWBlpzBKbEXnv13wimLjS+NRNkX/ALOwtFBxd1FpxCwE8uyqfxp2EPRMFd4rHmbYe
         meYJdm1aWOjAcu6vHvudpgSrA0yduKHYZJeoObZE5MiXIdWuIpRoXOQfzhS5YvU5Enwc
         2ZsnTEfyec2CGmjU2UPCVOZhB1UEc2HncTIbW94v2gBZbzBunyiLxDHvHYWRalH3rpTa
         0JsIeU3Rb7Fz6KqO3ssRrZf/WHtv9+mJJmR90IYN0I8PLCKJt5kY41XMYV+6Tl73pOXS
         GD3w==
X-Forwarded-Encrypted: i=1; AJvYcCXMYh+zp2cTmyr/FoOGuML5HP15abo32qVeSlFrR4H3LYpaXIAPto2KqnZ/GuLhNS/5cKJjshcJM1gH0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUW7wlQlGoy1v+ZPHFKeoeeScp7Y71IRSe3rkfo0x84OTkZ2V
	Ej9hjoBIn/odhE0BpDfUOZmnSH2H/j1FhSHLbow25In0pJMAZ6GBspnZ5yZ/QwzE/wU3bU6fI+Q
	zccH3nw6BajZ+B2i/56JHvdkDHaPTCRkwebMu
X-Gm-Gg: ASbGnctz7rkSlcGyBNxpLdXysVXmYA8fXEO1guPLwdC4XgmBtBYP6J6ar9R7P69t8eV
	DKJUVooNuIkJpqg3EFM7xSIuVzABqCLXX6xAtK4uBpROwAglBcM+x2MESKHmginHiGj/w87rktf
	XaxJbiygsH3w8uMEOwxkX+1D0mMYBxTtHSqoLTda6//eklrm9xwAcC5CoD
X-Google-Smtp-Source: AGHT+IFGXoN107iRcKAaMfh5q54qUSWhsZqDVFmtSnv/zuzK/6+/d0yI2gmYWt4umU7mYkJ4NKdYWUinvN1PCsVQ9g4=
X-Received: by 2002:ac8:5846:0:b0:467:8416:d99e with SMTP id
 d75a77b69052e-476b7ade14dmr390451cf.21.1741795573844; Wed, 12 Mar 2025
 09:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com> <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org> <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org> <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
 <Z9Gty3Ax-2RslqDX@infradead.org>
In-Reply-To: <Z9Gty3Ax-2RslqDX@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 09:06:02 -0700
X-Gm-Features: AQ5f1Joz69JkjpPsTbZTRmJZtQx_aT9cYAZCenCDm6y3j32d7IR3YQveqxicKU4
Message-ID: <CAJuCfpHG9EWAC9p7hcOH6oPMWMMSDr91HDt7ZuX2M7=j6bxuGw@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:52=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Mar 12, 2025 at 08:38:07AM -0700, Suren Baghdasaryan wrote:
> > I might be wrong but my understanding is that we should try to
> > allocate from CMA when the allocation is movable (not pinned), so that
> > CMA can move those pages if necessary. I understand that in some cases
> > a movable allocation can be pinned and we don't know beforehand
> > whether it will be pinned or not. But in this case we know it will
> > happen and could avoid this situation.
>
> Any file or anonymous folio can be temporarily pinned for I/O and only
> moved once that completes.  Direct I/O is one use case for that but there
> are plenty others.  I'm not sure how you define "beforehand", but the
> pinning is visible in the _pincount field.

Well, by "beforehand" I mean that when allocating for Direct I/O
operation we know this memory will be pinned, so we could tell the
allocator to avoid CMA. However I agree that FOLL_LONGTERM is a wrong
way to accomplish that.

>
> > Yeah, low latency usecases for CMA are problematic and I think the
> > only current alternative (apart from solutions involving HW change) is
> > to use a memory carveouts. Device vendors hate that since carved-out
> > memory ends up poorly utilized. I'm working on a GCMA proposal which
> > hopefully can address that.
>
> I'd still like to understand what the use case is.  Who does CMA
> allocation at a time where heavy direct I/O is in progress?

I'll let Samsung folks clarify their usecase.

>
