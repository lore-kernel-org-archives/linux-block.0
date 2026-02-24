Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4D288AD
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891998; cv=pass; b=YIU+7CEjmJ0fu3r9BxeKujoKQoRt3ly4eehNJ+uaXR31al6ztSLnL6o1RJ/3E7R03xp4XzjoRKkeNRzRa0C6TvOA6MNoYgji3NFi12wQ9SI9UXrOM3x1crzR6rebQLcxUqVGrhPP8Uz01oJrQhlopt0zMnuZLO9eHj47YWPOP6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891998; c=relaxed/simple;
	bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HozHr6MI9aq8fSjh2bdTFAdqAjvMtly8bp1yZTpNo9jtdoKbUGAuQim0sYTQDAS8evH0OKvFxT30FzEpGa8h6zM5yQkPcNzGBeRlpq/mmWjsAi871Oa1qLw+Pq7erZCEEKyr2c6nlhWfGQrMOaq8assEBK070OORONo4Zvms/so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9p5Hu4A; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9p5Hu4A"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so31205e9.0
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:13:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771891995; cv=none;
        d=google.com; s=arc-20240605;
        b=XKe8eoxALE1wX90VyDfuXImbNkLYNVIjbUqnI/CrtlnW1pq8gKbqvwbps9SwtP0bwj
         mZhWiGMiOesNwM/RwtR826k7SjTOxPoJz3DCsUssSjfQzuifWn1hY0dL8YHfixvMIzuN
         MNnFUM8NwJmAKLQIg8liVP5a5qI9yjDYiX4cx/k7pYN6UnTDaISj3Do1hm2KFS8RgZJk
         1RvZ1h3ecTJ34rXnjBQ+xra6eQDUO3D13Qay6CSLM4wDqopJ5/V2J2Bgs6Vc46tCQJ86
         StyextVyAPiO07/SdTMEGz0AQ9WedCvlEb40gpRuI+RyRvxJzj6ciT8DlE/Yc+1Av96+
         ZcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        fh=+OLUg8gqJYcHyJFrTHKg4aNlHijIupT9E0Q+2+MKnVQ=;
        b=iGjl92R3imsBvXrdEr34qXpD6wkMnK/L+ySI1ytTxXOSPttTXn4Trs9LU4i8ND/nOc
         DCIhIHlZBiKsMvl+l0qNxkG63G1Kyz0QHfFHvFwKgTzrAjL4OUKPJrTf7IJSxhyIVA1i
         E2EA1QdRIFxeqCmsYoICGnJxsC2P0ToScxEKb2DtBNqPqT4simtBTTmd1HUXv6sAr21E
         5kmrAod+6FlOWIvoNVeW3vYUiOqnJGWdVdcEG/1F+nmecpn33qLdmokBhVSr9Zg1ix8V
         QOpFY9Ze8IoEOUQHVUYbneM+5Qm900dWJlN5mj59k1UWrVY98htjeTkAqy7vr9YPbAYZ
         /a+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771891995; x=1772496795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        b=h9p5Hu4AebmpuXWbGnMMcptNbZmMfVpVrr9UFRCQUpHyy63x1nEdboaPIC8dcOZIaV
         79reG78+XTH/eCsHYoIM+vaPGVNH5TPdudnGKqAUShaVfzHMy9kLFncutZ3jpgOCD2/7
         6cBk8+rv9FPHTsXCFiNkp4xnaYHG4TGA7CzGu9HBsmq/IW7f2gNHi4iK5z0qsSxwN+XE
         kJWGCnHbjXfBbm03lPzQdiZHM1l7dLvye6mwuVDGs6iZF/D5t3sQuFaiCyugsnaYE2b5
         ini5rLcGKYyJE5GR7oTi8t04rYPdoBTp++f5n+fSAe2SccIjnv6s5fYPqd4VhXVYz3zB
         xhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771891995; x=1772496795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        b=LLw9hjoleaG7CO5YWD/7rqvrz4bZUulckGWAZdz4WHNAD2hEWTo75alcwOOiFRCPc4
         aW8Jj8mimPiAZvS9hRzLBfYkM3QiCf0vuB/L1nopKpRqIv8x7XyVQG8tpeAUmmDRyVAm
         pS8ZQqdKclnSq263VHiv+he00uU3xJ6BRoywLJLfWFxRJQNEIf9L8b6pmo9UvmoU2hXG
         dSrItcO6Z6stFP9BEcOASAHkrRvtE7YGa+WXeDmlAPMv3rCM+PsyI8DL9a6XbpOmIFl9
         yl/o2zhEr2X34MW7ObVLbPtmBNeXVPix6vTxiSR+SLAHZPQJhxgPf1bpPRSgtezuR8CG
         CpoQ==
X-Gm-Message-State: AOJu0Ywiv/kyTeyb2zo4YVOVw4gL569rFF3OxsUy7HEfomxuS9Ufl00l
	Fxk1FVyC3Aw2xwm1FZTKZi+gCH7YqSrZ0UHwSyK1D3ycMkvN1k09FpH0yS/6/4arTsUA1EcHaPT
	SBkCf4HhruArh493yOsS1jEBJwVm0S5xmfYkQxm1N
X-Gm-Gg: AZuq6aKfw/9uVr/YzNeYX2zFKqGRAFLAMfdCGaXn5Mal/NWvK8mTscs7PD64SgiBjdJ
	/Vo9LqYAOA66nw2CIjH8AjD/LI8ijWvfmE30NU3bG+HhS098nOynmgIBw/Ru6r1yOSFLrFI2Fh5
	sBuJTwHrjxmHmBqqiUuJl3ny0brSSRYYr95clAOdQVN0iXPPr9+dE3DI/IF5MoW8pe7gBfe41/T
	GZ/KI1/+G96stv+ttPEzexhIdOyGUQhbxmI4qX4wm8y9XTW60LkEI9Mee72PCn4ASowTOEba4Yh
	Cp8vkMOnidrwzKiKHw+y9l0aNp2VC1cCuHvC3Q==
X-Received: by 2002:a05:600c:3011:b0:47e:de1d:ce99 with SMTP id
 5b1f17b1804b1-483b876e3ccmr255025e9.12.1771891995111; Mon, 23 Feb 2026
 16:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 23 Feb 2026 16:13:03 -0800
X-Gm-Features: AaiRm53fe0m1UF9UR81dGOPUcovFTRZhHstytiajG9W0XdK3GHymEz_MxNhuT1c
Message-ID: <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Gohad, Tushar" <tushar.gohad@intel.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:29=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> Good day everyone,
>
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
>
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
>
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
>
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
>
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
>
> - STRICT: before =3D 570 KIOPS, after =3D 5.01 MIOPS
> - LAZY: before =3D 1.93 MIOPS, after =3D 5.01 MIOPS
> - PASSTHROUGH: before =3D 5.01 MIOPS, after =3D 5.01 MIOPS
>
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gm=
ail.com/
> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.c=
om/
> --
> Pavel Begunkov
>

Hi, I'm interested in this topic. I'm guessing this will be in the FS track=
?

Thanks,
T.J.
