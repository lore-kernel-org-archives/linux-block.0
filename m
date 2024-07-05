Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8AA48
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168933; cv=none; b=f21nbw/MVRgOeHO/ilhgEx8EgtkmU0BEN5BmYvbfdFHWPJTFf5+tyQ+o7HkjFK7yyXiVLoIiXw6k+wSkzKg5jVz560k7x8oOGbc2GUx3LvsXBD4XDBlfDCXaiAkBkHfjlVJok8rbfnDZ+AqmutbdXnyqqcJx8l31t+dx3h6Y9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168933; c=relaxed/simple;
	bh=MdoD1uQx97BWhsq7cxMfuLw5Tx+Ae9TieFeMHspDm5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGqq1UpbiTw1PFyfkU/Q/ODaI7ITWN+cDijp+4u9FKY3cN9QSueCVdgUubLkcT1ZgVa8E5Wj7HDYF5bzGTASEsTmymH3hgtAT3jtFdUzaPIdjjQeKcp9kr/4zkaO1L6PhsjeFljj5P1i8pkaTT/QPTYFercMNy0vS9V/LoCHOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6325b04c275so12906467b3.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168930; x=1720773730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb3nvPpoeDCMYNDscdzi/DI3phzoUDDiLMAUKJgL9UA=;
        b=JIQdXGIK0hFsLxts9aKTR6T/ngyWsz6Knul3+sL3X6eDKW9URj0wRupg1gEoF4qCEM
         W2D1Cp5e4a3ipFgikEyZeE3BBRKiiKAzJ5pSnKo7lJYTCFduQascSBiAtUpMt/MisL9s
         1c7fPWsTrzM0WnOrgUrfUYVI7eGIBqlEjMuMNSbd0Svsf6vIEGo0vUQwVKPUXjTz/8xQ
         NPsSL9h7ktLHqDNKcpWAUVkyoV1+PWO6HwGYidfoCCoZUbPigmg/1xg55AO6EfVjNkxs
         9RXwO34uauEzZ8LSMbWU88b5Bnu3jSlcKwblZLkk14jJiL/uMZasuVYJe2yfl0vwfWbx
         KonQ==
X-Forwarded-Encrypted: i=1; AJvYcCVri/L914hR7uOggbySNTvMCTjxiA82TAJLEhqGKP6WuBjukF/n2McBi9sehdOm1EW/royqbHj0thv/cD1+aNUCpQeBPfnnNa7hpuU=
X-Gm-Message-State: AOJu0Yx/QdD4JlGMqFuPm7y+6FV1DiaN0BO0Bg6jF4Hoj+wmLHo6J4bH
	gZnDyhfAzv8xp14YRC1eSI0F51xnF+/okuIhRJyeHe4U1lpUFjdTehfAW85W
X-Google-Smtp-Source: AGHT+IGtbxVVWaaNBHFrDORGf7KdMsxK71w6R7LsS/4ZXzRTvA8EQHN6udhTWzeeNsBZtVPpk5mZ5w==
X-Received: by 2002:a05:690c:986:b0:632:58ba:cbad with SMTP id 00721157ae682-652d522632bmr35862897b3.10.1720168930449;
        Fri, 05 Jul 2024 01:42:10 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9bb4f299sm28055757b3.84.2024.07.05.01.42.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:42:10 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6325b04c275so12906397b3.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 01:42:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE3jXIwImAwt1rCTBqFZ+/HK37Itqxqhz9ba4PEO6chKgtw9DVVlgYSky8nY8SG/q92olg7ADW9+koZv5cp05Xc7umx3eFg5khakk=
X-Received: by 2002:a81:9253:0:b0:647:eaea:f4de with SMTP id
 00721157ae682-652d823ea66mr38523167b3.47.1720168929990; Fri, 05 Jul 2024
 01:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705081508.2110169-1-hch@lst.de> <20240705081508.2110169-2-hch@lst.de>
In-Reply-To: <20240705081508.2110169-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:41:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCHRtRVQ4Vp40OmhwVz=KXgD3pdF6jkX4-UwQrQ_XtQw@mail.gmail.com>
Message-ID: <CAMuHMdUCHRtRVQ4Vp40OmhwVz=KXgD3pdF6jkX4-UwQrQ_XtQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: pass a phys_addr_t to get_max_segment_size
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, Jul 5, 2024 at 10:15=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Work on a single address to simplify the logic, and prepare the callers
> from using better helpers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -207,25 +207,22 @@ static inline unsigned get_max_io_size(struct bio *=
bio,
>  }
>
>  /**
> - * get_max_segment_size() - maximum number of bytes to add as a single s=
egment
> + * get_max_segment_size() - maximum number of bytes to add to a single s=
egment
>   * @lim: Request queue limits.
> - * @start_page: See below.
> - * @offset: Offset from @start_page where to add a segment.
> + * @paddr: address of the range to add
>   *
> - * Returns the maximum number of bytes that can be added as a single seg=
ment.
> + * Returns the maximum number of bytes of the range starting at @addr th=
at can

@paddr

> + * be added to a single request.
>   */

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
