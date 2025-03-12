Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FC25179D
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792853; cv=none; b=FUrjSqbaZX0/FP3rRAJe/6Xzd+jg6C9dUxw3L/+n993Dmav+OBa8SD3jjB7E9/S/R5Udb8wraJ374Owed9MiJoVK1KyRye1O59F0FSMv+DJFhRPzBhBEfg3493wxJIfc7qQxrbPa5liMc2WCOcsU/rH+g4JcWEGXsDKRD3FdqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792853; c=relaxed/simple;
	bh=vFO5RejfroO3/QCBzMpZapYOLh4Wu0SP4ltEFH9/5V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRmUqMbPWLSji8N67e2DJp9LKomUvr+qZUmZJsTLAxSUP41wIuxmWOjebwubh5dAkZAilJ8aRAzrKcnzLYHNd686I32RPSAbNmsCfmhXHaffPFdEp6rcsS+2F/28jVGkit68RPKFA7+mnTxjAapSvjRST6gFz9OFDhAijSDXW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEG9dvLh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEG9dvLh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso55215e9.0
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741792849; x=1742397649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGxZkF5t/1wrFPJ00FERNaK3N3Q0WGshExeLmGRXwks=;
        b=iEG9dvLhmd0BrnthMwEu0OzD2RHaNIgNqI9g/+nhDui/skVHhKYblZeY0fzLxORBL8
         FrV3UvyNHMzRA7qNTHWAuw1Aq2tCBnTq6lNbE9Xqm+pP3rEGoq3c6TjqBmaQFfJ2CNvO
         aKRrrKiO0Xbv2Z0QYCY5QNzGxQm2ujnD7M++Wwsnpul33P7q/PKgGkT2meQ0SnozOiGg
         M5VrZIm1skS/GXq2cOWPaHqF3R6xxiJUJ7zST7u07RL35DM4ZQXljoTq34KDISozB/oW
         Yd4NpXUg/aPXdPkbt7bCgIAY8GGNJ/gyFEKokmsk8Sz/dpzXy7ihWLhCFyplOYkhaSgU
         Ujyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792849; x=1742397649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGxZkF5t/1wrFPJ00FERNaK3N3Q0WGshExeLmGRXwks=;
        b=k6NQ6bfxVUyTXtuNdR+cBsKy84mlrj4wiITKLoZYdvekYmkNEZcB7Ooj/77b74xkPR
         PvjghdFYqAyTCWKHspvALZD1xZGZ3SM91sMgK+nl0NHlTv8pwDlKNGnRl1hpmpkfI9cW
         uC/QVjQH0uyouJ3HiznEDyjQVe61rqHPhymmdwXMvlSZuq221aPjXYihznWTNDihQzHr
         jLlmN0YbfEKwP9BITOs3usVg6jDx/Rys2hCJFTtIN+8/yhOxlX3jru/8FbruONzLjMWC
         EHMlMccN49lFGWn4A/69YixyHhmdrAundnvCD+mRfs1csNoKmL/+H+hLAaayJJyOzT7Z
         MIOg==
X-Forwarded-Encrypted: i=1; AJvYcCVlr9SbMp6Flj9PaYJckHCVP1qC0q8UFsTsv2O9aDH7ek2tjac22xB30kYlkiYWQCUO3OfAmpaynaf/Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDraZVvDKBmyVR+LBz+Cw/7J4EeDvWMA2l3X7hwWSDEQZHFTqb
	wLR9OF7s3GZ2Y4NckJarsjsANHHUfxN620D1dwUs8B3Alk1VzsRcbyYig3I09dOSpWg2GxOrbwk
	v4xpaCXmPlMcBYnxk191HpIPC+lxpqIlEV9RQIolKzj6/zTkvjw==
X-Gm-Gg: ASbGncuUrxrqLW0DhBU6CnD0bGvx1cM/CpqnjvEQakCMGWkmmWjihXoZY7ASKQAzrJh
	yFHTULV1rDlp/WGnBMYn8z2MErTlBeRuji81JHCnoYF5ZuIIlsT69HPwsBDmfTAHipKx+77181h
	kOuPuSBSTK2LYEoZqWtlK5IHRGtFoeQuG9OZCJmHYcxy9jY7JU/bS+aeDM
X-Google-Smtp-Source: AGHT+IHD2nQKbwusxnJ80KAjLgbQAOF0EvyAvqqHHVna5q1oZeuBFrEiEEKAahgMMiR6eRSYCFMQhm6AYgZVdiouPL0=
X-Received: by 2002:a05:600c:4f49:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-43d15f8df65mr69355e9.1.1741792849400; Wed, 12 Mar 2025 08:20:49
 -0700 (PDT)
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
 <Z9Gld_s3XYic8-dG@infradead.org>
In-Reply-To: <Z9Gld_s3XYic8-dG@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Mar 2025 08:20:36 -0700
X-Gm-Features: AQ5f1JoRE6F00aRF8p4iMy0O_p5G6IwsOeM_xmMCWwyYOphS5VP-BnJT1SNFaJY
Message-ID: <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:17=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Mar 06, 2025 at 06:28:40PM -0800, Suren Baghdasaryan wrote:
> > I think this will help you only when the pages are faulted in but if
> > __get_user_pages() finds an already mapped page which happens to be
> > allocated from CMA, it will not migrate it. So, you might still end up
> > with unmovable pages inside CMA.
>
> Direct I/O pages are not unmovable.  They are temporarily pinned for
> the duration of the direct I/O.

Yes but even temporarily pinned pages can cause CMA allocation
failure. My point is that if we know beforehand that the pages will be
pinned we could avoid using CMA and these failures would go away.

>
> I really don't understand what problem you're trying to fix here.
>
