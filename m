Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46437363C66
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976208; cv=none; b=u5Jsan7TKKmCPOu70wQb0x4vzqblOlxyxLR7n/eDaFr2I+5/cNBmEvNxkPbRwaflcjUyxtL4M+TNzozIF5lX3zIPanx73XSVWM6h4815WBC9uJd+C1Ef7//6EIOXkakYo9X9VKJj9Dl5SnSGBVCA6wSEsqXS7cstxiguiET4m+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976208; c=relaxed/simple;
	bh=vgkUjsN8ExHKHTx9/7nY4I/nt63eZszotViQ9gfru3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXYwhbjXkEIX123IfJyw417/1Lrdt4AaSrkfmk0NsuUTu4aoeZh9f05+bLWEAd+Hp4gG6JSm9ZDzEeuEG3RL/uNWjyd4xzqtOaSTjBscPbWnbI+t4by67Bo2fwWyyDKiakI0JqwshSQVZQzeXF3DABJzbCJDgwMLGZwMg7dGGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SVB/xHP1; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SVB/xHP1"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11f42e9733fso189260c88.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767976206; x=1768581006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVBFdMZSv4hBYIJD/c7yM+WiKJpV4k9ufsep5DEEPrk=;
        b=SVB/xHP1ukRq+6FzH50AYOWELC4diVbIX7wYMrx3j/t1HsdQ9Vi0le+4uvKr3PfMK4
         oLXuflPzlnDqoJmQCeRGBdABPE/GflGl47BnINskPelWhEpXv5wOtA4X1osdM/TmXlEo
         kfN3yUjvatbmAX0EGo49eTU9W/B4kBO2tmw5Z9ojZJh7+9/ur8Bog1Fq6gTGy6m2f6Gg
         lkbZFr5jTWMBCPFEoT/bZjcQSY2nVoCZQKZHtCLhXinzevYm7X3PPBW+SScneuGx/DGN
         We7KbUIuQ3lOcagmacgCGNKBH15U33ZLzxD9cRUdBicFBk8+5pgaMtk6MSGiHBqroU9F
         Kj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976206; x=1768581006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wVBFdMZSv4hBYIJD/c7yM+WiKJpV4k9ufsep5DEEPrk=;
        b=UIWbjg2/CrWSTtM7rhTp32BRO9BTOe5IIMDo4+shZ7hD/z5DC7XV9s240j3los9d4l
         pGy3kjKOuqa1fGG5yLOepwinbqByvbWgcbqrjRcrq+wLypIRjpnJJXGV8K/Wf63kXbzP
         BHz9xfE2ZdQU40KZGh37SoJ5/9HD8dQgGGX1mrqlJ20YiRmamuCKaRVBjtxmUoBiBCqq
         7ZyeDdXcV71MKJ+v3DYebJZg8/wp+J1ou7e6/FJVBV+wRpEgjSDY5BDFH3p3cTXzYg4b
         0NHvPnMRp4CFwuXRCdad3lklsAvl05eO/tWxXtd6crQnjhBNnIAFYu2+npGIejG21tmv
         VKzQ==
X-Gm-Message-State: AOJu0YxwqyMKM51T7nS1oqnyv+NZC1FZe2dhoaXrUx1eWRF23RqTs+Rb
	J04doKTgMgm1Yrm4+2OaXtcK3fbnJupUmFLMysrjOURsZT/29ga+igiLzDqqXJHu8S6erNeJ/wM
	g2xGNL2FJ3W9lVeABvIciqI5QEvwKTmTDwG88c36bAQ==
X-Gm-Gg: AY/fxX4Jyb+32M/w8gd/Q+9QdlSqBLt1L/YA0yUPgjjK8hfnZckuj3mZunQNFFPg4a1
	6eLy41QeEjmgjkGWoY9rD+t3woqglOqtTkzsQH2Lwl2H0YBH3P+e12B2CBWQh6JVwUrn5F/8+/0
	+XwoYr4Ae2lwrkqtGRd7MMSM3hgwh54J6MMlkUj23DlvKA1uatPpiXuCzQvN5tFsmzOQ4A9WgLv
	6i0VA0te771cl9nnVSuuMTVeU3lBNzS8q84Xgycd28LOtzyTfJpVCSt/KFS2H1D5KlEReWy
X-Google-Smtp-Source: AGHT+IFhp4yt2AQ1ZP1QdiJqmZMwnXirdCCvBrrqz+9ao7l4CoEYukmyuVM+PcZqaieMafkTE41rb+J/punHUo7hR0I=
X-Received: by 2002:a05:7022:238b:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-121f8b923f9mr5084248c88.6.1767976205771; Fri, 09 Jan 2026
 08:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108172212.1402119-1-csander@purestorage.com> <176796707483.352942.3630670392140403614.b4-ty@kernel.dk>
In-Reply-To: <176796707483.352942.3630670392140403614.b4-ty@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 9 Jan 2026 08:29:53 -0800
X-Gm-Features: AQt7F2q9WSHtQNGsZy_6XPje6YYdBvRDgZ-kNB4PteJPUfnXLMLT-u1F2wwS0LM
Message-ID: <CADUfDZoacSnJz5FOZQov50k4_nP0sxqxDHYOvDqp1_7KKD8z1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity buffer
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:57=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Thu, 08 Jan 2026 10:22:09 -0700, Caleb Sander Mateos wrote:
> > For block devices capable of storing "opaque" metadata in addition to
> > protection information, ensure the opaque bytes are initialized by the
> > block layer's auto integrity generation. Otherwise, the contents of
> > kernel memory can be leaked via the storage device.
> > Two follow-on patches simplify the bio_integrity_prep() code a bit.
> >
> > v2:
> > - Clarify commit message (Christoph)
> > - Split gfp_t cleanup into separate patch (Christoph)
> > - Add patch simplifying bi_offload_capable()
> > - Add Reviewed-by tag
> >
> > [...]
>
> Applied, thanks!
>
> [1/3] block: zero non-PI portion of auto integrity buffer
>       commit: eaa33937d509197cd53bfbcd14247d46492297a3

Hi Jens,
I see the patches were applied to for-7.0/block. But I would argue the
first patch makes sense for 6.19, as being able to leak the contents
of kernel heap memory is pretty concerning. Block devices that support
metadata_size > pi_tuple_size aren't super widespread, but they do
exist (looking at a Samsung NVMe device that supports 64-byte metadata
right now).

Thanks,
Caleb

> [2/3] block: replace gfp_t with bool in bio_integrity_prep()
>       commit: fd902c117e49eabbbbe70b1bde8978763c6d3fc0
> [3/3] block: use pi_tuple_size in bi_offload_capable()
>       commit: 0357a764b5f8f2f503c1bb1f100d74feb67a599a
>
> Best regards,
> --
> Jens Axboe
>
>
>
