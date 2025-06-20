Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302121C18E
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399011; cv=none; b=BYmND9/n4ylrmi5oIT/F/fpgS1dtAYQe7ADKokk19+3sjp7ydJumY/SCoPIphZAJnnH3DeqyijCP5Fxc2kJ6Sh6MMd/5sijoaAeWESmPJReDfjIIUMK/KElzfvf1mPz3h87TzOVGiGBvr9D9ShMxpPl1aN8XiIa6b4JpH4r/a54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399011; c=relaxed/simple;
	bh=QmxzrQ1XE5dR6+/jxjBGLJSVr0bsJPDR+Gf4o5oyzoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZAFlNk1gACV1GG3q2n511DmsDOnhZVUtd9uz0U5w2f5bfpym+pSO6u5NglOTM4BuLEWNJuG/QB7raiFWxpXu1nadsKRKoz2XtFvWlIQjyj+ReIdmtGQhWt2oDLS/vS3ITmhIQU7MFyGteNlIgx7mqst1gqwl8f5dCIY14/BJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYhEyOZS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYhEyOZS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so238995ad.1
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750399009; x=1751003809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxpxNicPnor4y8vQEH+jSbLfvejhtfEVW8wIzxz3DXI=;
        b=ZYhEyOZSkM1OUIRV4egrcN+wiFY1kKxeXSBoAnahtJoOZ07prhAQj9UmurMrycnBd+
         EuS45OAO8HyD3YaobKxzQxo1fyVLYVqjoxaGc5zHuveyK9s8FMbZ5W8MZWsEOVxAoWtk
         9B0KdTjebBjdTVCln3nGBpEIzjR7Ajh6WJh5SSfGU4HT9fsNwEnylLlKLmIi7uQG1Pg1
         AKUbac8PGGKT0xLeFMCim5GuYMLV9wDgTPjWb7GIn3122/wOJalUvVH/07lck9nYlEWv
         XAKA6K/VHpL3XMWd6HvDH3dp0Xs+hmFqbEtC/xdERunKqSSnna61paH6EzmMvWYZwM0v
         zH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750399009; x=1751003809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxpxNicPnor4y8vQEH+jSbLfvejhtfEVW8wIzxz3DXI=;
        b=FuPuG28+x5F44Kw9Fdl2MLETAYcMaTQ9D2ycE9vUt6ciUf+PQB34sUiFfSNJFUyDgD
         dPPAvIeNuZW9IX4THWV4v58NyQpmY+zdV6OANwOhddNXKnea9/CPjDxLupMiaLuk+wN6
         X5smMhlJ/3WpQllMAaLtWFqa83o4T0ghmsBVfAit5mv3oWVFRXWCRpVTGHMk9TvezsOI
         /1Rc2fOYv4BNbjRfhMMyTfTSeN6J4+7GVMxzg3krgCpEsIwUrmX+41+1kBi5LTS3IhEo
         fvzP7uL6AcTrjs3tBD9bjtr4hkBvQn1/I4ohxT7cWZOMFg+KeXgeXlcKasCGAUmpwBZ+
         Oa3w==
X-Forwarded-Encrypted: i=1; AJvYcCWaOyNFyo+GuaUQuCw6oB7xm/jwAhmwSgQaVh3cV7wL87DYYcS1H3VTMe0Tn+PWj1d3gyNNGO/3m0GHZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9OjMyz0vLk03aNnY/6hA17OJ/pxMXdVHa25k8CXn9LKNWbZI
	yRJxltyLhOROWSfC4N1GQF/SLOEBXYLM6rTfBlU95xQjinsKr6QeZoKlmsUjS8JSOY5EYJKFhuY
	gZeLwjhcbH8cAdF8rer65BEzzvstdyrSQ3MbewG2TGpD25WGO8EixpwVq2Ad8
X-Gm-Gg: ASbGncv5a7kfQRmV4eFflyVODmy6ijfCHs1L1I1LJRroVI/eyc0ryBSH2/6Q0jkkllu
	iP4+ALux6HqyOm+V9jKwhkX72kQuqjEPR28hiwhVYhBeBfCHrEbV82bcy/3A9SXfDdq64MZEDIo
	O7ryCr54AHfyK/48geRCMV0CaGSnEmOgyh4B3Q1M2+
X-Google-Smtp-Source: AGHT+IE0fbJcpE3a5EWlRlBwzmwzf74XJIWhUKbxVW9udfBkda1c7D5doedK1kwFwVY18nvlCbeXmzQvOHd9GK/23H8=
X-Received: by 2002:a17:902:ce11:b0:236:9402:a610 with SMTP id
 d9443c01a7336-237cca9ac6dmr4107045ad.22.1750399008899; Thu, 19 Jun 2025
 22:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618132622.3730219-1-richardycc@google.com>
 <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
 <CALC_0q8-98y0v_jV6QOFTKRAGhJ4nCXZ=q9wutLZPCE0KnKymw@mail.gmail.com> <x54netqswex6fpv46nlmeea3ebnm32xnwask4zxw7nmcn7tqdz@4mu4hwsa7hsb>
In-Reply-To: <x54netqswex6fpv46nlmeea3ebnm32xnwask4zxw7nmcn7tqdz@4mu4hwsa7hsb>
From: Richard Chang <richardycc@google.com>
Date: Fri, 20 Jun 2025 13:56:36 +0800
X-Gm-Features: AX0GCFs5Hupz_gafVprFl7uNHbD4US3FsNSuhKS2U7_w7YEQD3JEd08YVfAk1SA
Message-ID: <CALC_0q-aRtNS8c00nCD0key27UH9-_2kW=PoXQKrLQ5bg6MU_A@mail.gmail.com>
Subject: Re: [PATCH] zram: support asynchronous writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,
I copied three linux-6.16-rc2.tar.gz tarball files as the data set.

Test Flow:
- mkfs on the zram device, mount it
- cp tarball files
- do idle writeback
- check bd_stat writes 185072 pages

On Fri, Jun 20, 2025 at 12:15=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> On (25/06/20 12:09), Richard Chang wrote:
> > Hi Sergey,
> > The main idea is to replace submit_bio_wait() to submit_bio(), remove
> > the one-by-one IO, and rely on the underlying backing device to handle
> > the asynchronous IO requests.
> > From my testing results on Android, the idle writeback speed increased =
27%.
> >
> > idle writeback for 185072 4k-pages (~723 MiB)
> > $ echo all > /sys/block/zram0/idle
> > $ time echo idle > /sys/block/zram0/writeback
> >
> > Async writeback:
> > 0m02.49s real     0m00.00s user     0m01.19s system
> > 0m02.32s real     0m00.00s user     0m00.89s system
> > 0m02.35s real     0m00.00s user     0m00.93s system
> > 0m02.29s real     0m00.00s user     0m00.88s system
> >
> > Sync writeback:
> > 0m03.09s real     0m00.00s user     0m01.07s system
> > 0m03.18s real     0m00.00s user     0m01.12s system
> > 0m03.47s real     0m00.00s user     0m01.16s system
> > 0m03.36s real     0m00.00s user     0m01.27s system
>
> Has this been tested on exactly same data sets? page-to-page comparable?
> We decompress before writeback, so if the data had different compression
> ratios, different number of incompressible objects, etc. then the results
> are not directly comparable.
