Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E493BED42
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954122; cv=pass; b=Gja0XgjXRovbVGbtwnzY6N6Bcbf5g0lWH2p1Bv2bgPPVxxhyYFDi+m3UQbTE6qiCEW/ps9kc/mSgEZdzN8DqlZve4Cqqm8Y1HXE0Z8Hula9UZiDUFCcypgaHBSqQ2Kjc+0Cib4cDtJS3M3TuvyxxX5LoIqeIp0qDM+wLaGxlvpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954122; c=relaxed/simple;
	bh=jlHk602IzD49KATS7pfkgJoqej7MicT5d5fLp7NdNRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/8u3yjnzy3EcRKWZE8oQZT1qlE4dWjoxvVLdoLvgCUy5rL6DKKUW3zwUeO9yNRTEnw07hrPEHNrb887wWoDUa+lT6j6VWNkheIxACq7Y0V/HsJJY9RKc111+nRFI2qByUrDhgY3nbTRSMJoiyZk/YSFSvp+Iy5VLGG+WS0MDkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRd4CDL7; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRd4CDL7"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b01cb18515so2886778e87.2
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 01:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954119; cv=none;
        d=google.com; s=arc-20260327;
        b=os/aG0emplsRhYnjxaXyKR23oQWQdAtu+dyODNbueTTEXCJZNEsu+10tygGhhV1Mvr
         lMAatFqUvC36m0W85ber68eZ5rIiaoSgfuHDrjIBQrJ5BuSFNtrL2B5Yv9quJy4nfrLS
         uKe9b3AM5P6U29C2vrEZ0C5wKP9h0eTxeB5Nm4YpkB8KkXiFF8lwTxHb/uAUKJnZwz9D
         ftT2cG6vosOu+o8ETkoHfFBRt5ALQqSuP9ZnHW0vQJ/WtAbAHMDnVZCubY1FIneYTSi4
         vzZdQR4ReBzdjocib5MMWMTrTQlbtMkSfi4hLXVV9BTxh+HnJ83FlAC7NbulhkygRMEe
         j+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        fh=nhogTvKzeZI2v5sfnD6boh1RczNN4V41QfM/YUuL9rA=;
        b=jWgwC3eVWSXYILiHuEdHi2l+5UnMWRXOfboMEFAajflE1wNoH59a5Ym50PKnPaOKys
         mJpyVls3mluh8yr+NITaytiaI3QuM2290kebJjgZIXA0JfHytdEpvOQIH24qOBRypGSv
         uzY6oDPWBoLS8CfxH8ULHz9RkGugTFmLRUx6Hdxg4olyMQIC0vzSMrvVqcZ3TLkp27bU
         R7xEwr0yp7xaMJ/X2nRmh3GIGKPP37tgrEXB26XqhaG8urXpW5OX2bNeVInQhCj3MTiH
         GiTlkjxtQ9Bjt1ANXNAIXYQzPDPGH7wPHnuWOT/4gS7zDi1CLEJ4U5KnIytggOVofTVD
         Nigw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786954119; x=1787558919; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        b=NRd4CDL7GTkjfVinRhtpFex5x9NrgS2zsKv1FxPI0G4JFrqLskeqvSji8rPrkGE6Y0
         wlqtzrhkcJecEw9b8LU9nZ42RYYzY1kjSgLz4gV8DBTW1uEhcIruOWJ1/JeEGLFN1v9s
         Kvs8vVL0XhXKIoayn9y1dSq7vDf0pEY8sAXkT/VMruKAR6W5yyNzs9HSyMnBNeXF0DHP
         bK0TZV9HUyrlZw/3lPDrXPlUA2j+wI9XeMRt14VrO4d6W0IYf9ma3TzgsjCXxgJ0ZHsf
         m7tI9nI2uTDS5k14daLg6hRU1beAjMR5CsnCXslMnk/AYSvrP/Y7N6TsUmFeAxGJ60a3
         NTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954119; x=1787558919;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zq5NcBW4r+uAp2cc7Gehb73xyshGtyDG5pRXGUBZHc4=;
        b=S6AeMMXcy7E5LqWtP5pyJZCoWargCZfArb8+CujjwWsfoXSJBwB+YUVQTC6WQxCoI4
         UD6aQZ1g1IKqzR3WPsoj83L9jVJL6qqLIVqP11pVLtJ8pbHdBuxbwGt4Lv95tl0HpLuK
         ehAs/shBxOpYLaJf/UN+36Do++pAhwdC7bHyXwi0NR+G2dASKpA+p2jBJrpjFKrhCN6O
         aLeowA3rLd/A/i9ogjguEwGLSFm4m6h3L+zFtk0nwdPb8mlHNbRgkOWJqbbhTigmbb0Z
         HKIf4MqQbYDH1dDr92yTBpciBwOUq9/t+aMx4kakTgZuSVfZQuthcbuoOdJfrR0Cczm9
         Ekig==
X-Forwarded-Encrypted: i=1; AHgh+Rpo0B+Gy7R+PWBrFARBEdCuZJkONlg5/YsrCsBCWEqRoHxnOhVGeBcTnJv/um0B+aQcKcLLix3Ta5z3dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLy9nm2TPc07jT0Z96/dQwrwPUEXtkKUsJTENPJgHdJ9gVl7FP
	9mlj3xO1HsrCaPzS4UVFj8Zie+wqBJabMKRouoCYWT7IzcBtz+HMnrDJbkkri82wk4Xk0wbFX/T
	Hy9q3yb/cReQ/ftGgQsv78HMRind284Vps6tYHqnO
X-Gm-Gg: AR+sD10fNnT64hsHziwhrgtLrBCdyLwlzkJTLdbyGvmpnIi0j9YVP9M3F3JItgtlosY
	QhIKnq7UiL4ulPSYnnOzlo7RClVNRqH1tKm5dcr0jeSYNKpO3qRFwwMW7Wr8nAzMg22rXvjV9OF
	3DnAQ3jl1+QjIjFXPYs4DE1BdL+gxfLoKuk/vGOyszIzyOdKON2S38ief360eaCjnUJ9Ubmxb6d
	tFGlVp2TMLatZF1kQHODMghvJTFipD8PJs0JCf+CYfL/pL0oUWnTig8Zw6BgyUfrQw4BMiww9gR
	HDeMvv3NW8x88W7nKrc75xaYcochAQhdWo/1UzHa8CLVDnmq6COqhE9MMVvrvM5p0LPQQHPlwXI
	=
X-Received: by 2002:ac2:4f12:0:b0:5b2:f211:130e with SMTP id
 2adb3069b0e04-5b45916acaamr2877358e87.37.1786954118585; Mon, 17 Aug 2026
 01:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814105954.4060627-1-sergiiushakov@google.com> <aoK8fF27_nu1ux9s@infradead.org>
In-Reply-To: <aoK8fF27_nu1ux9s@infradead.org>
From: Sergii Ushakov <sergiiushakov@google.com>
Date: Mon, 17 Aug 2026 10:08:21 +0200
X-Gm-Features: AcwNN1XAoP3oHuAeEAegVjZNw955sF8O13C8o6CZZQS_gl28GbEoZXh-QgGOtlA
Message-ID: <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 09:47, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 14, 2026 at 12:59:54PM +0200, Sergii Ushakov wrote:
> > When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> > scatter-gather segment in a request must consume a physical slot in
> > the virtqueue ring.
> >
> > If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> > virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> > defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> > compound bio arrives from the page cache, virtqueue_add_split() rejects
> > the request with -ENOSPC and triggers:
> >
> >   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
> >   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> >
> > This permanently wedges the blk-mq queue and blocks all subsequent disk
> > I/O in uninterruptible sleep (D state).
> >
> > Add a virtio_blk.max_segments module parameter to allow runtime cmdline
> > overrides, and automatically clamp sg_elems to
> > (virtqueue_get_vring_size - 2) when indirect descriptors are disabled.
>
> What is the reason for the override?

The module parameter was intended for two main reasons:
1. A safety fallback for non-compliant/buggy hypervisors that may have
   internal segment limits lower than the advertised ring size without
   advertising VIRTIO_BLK_F_SEG_MAX.
2. Debugging and performance benchmarking of smaller scatter-gather lists
   without needing kernel rebuilds.
That said, the automatic clamping to (vring_size - 2) resolves the
hang and panic out-of-the-box. If the preference is to avoid adding a new
module parameter, we may drop it and keep only the automatic
clamping.
