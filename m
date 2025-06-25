Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DA2877F5
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848073; cv=none; b=LYikdb4rv6UZZQC0jOc4AT15WiY8+T1jcP286SN6w0YiENiS8q+8HOGEYGvEnzbeAP4Cf8OrNID/TbXjPwBXeu4YHuWl2/7qyPnV4+/C0SqrJY41ME37XPcLY4rFg9H4MvQisVeSJyuht7I+unKWVlFIRZ4mN+E/Nn2cipd3ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848073; c=relaxed/simple;
	bh=AIVz62DuTVWDixko6X2LPuwXhOwmi4DqwR/TSjDPY3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMWPac1MKpSqDupNVnGevORgY/KeB2WRG5gSw98Z5NLb8aNnVdjzBMcHr0yasgXlEi7pN4TMaJDFtPeb5qnPLAez6pV1ycTCoZChSN/kdk+9hdH6SMZF8T+FvwuHoZmB7q/37dEit3v/ZeHbZ5dLoJ7phEfzqbTsQXUMWwI+l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaB+qOtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaB+qOtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKr+DQBtFyizAsw1988hOJcgz/t/EULmqa75FsXdoB8=;
	b=SaB+qOtMuuvj0kM2pUKYH2skTBGcQ826VIyaRBSFOWcRSLTBSOnWIAfbYzF8ipoPrDoon3
	orODjmr/AJRtjpY1nQvQQc5f/UJqgwN6UqEuFSIDrmhtA2oq7C5BH7el0W8XExV7v/+lZQ
	g22EsoZ8HmQMbmSEukodNtrn8TTIC3E=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-mHoi5CaaNKyVXp8DViHGpw-1; Wed, 25 Jun 2025 06:41:09 -0400
X-MC-Unique: mHoi5CaaNKyVXp8DViHGpw-1
X-Mimecast-MFC-AGG-ID: mHoi5CaaNKyVXp8DViHGpw_1750848069
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5314dd44553so378244e0c.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 03:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848069; x=1751452869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKr+DQBtFyizAsw1988hOJcgz/t/EULmqa75FsXdoB8=;
        b=UE36lX80NHgbObrQYfEAdzlDoPi1s0uFDVAfL+f3FJqXvfT+iIy02yoXD7ip8WGO52
         332SgUDUga8qQy2Sc0oBun9ZvgqSYKpBZBnQXamSTsPskFqrH9QRn4o+xXYcdMjPGnPx
         /WSdwaBQa2BrRtKdIalGrzxaMLTfWshBDsbnZyNz1RfYsX5iE3rBD9CrcGHF9hnqfHor
         BbOk73VZ464Xjm95seNuJmRxrLniC1Obu5wSh1DGYjat3uTip2vPiOYoKds9vHVr3HG6
         bZO4jbMO+8j5P8Hnm7BZvCzNpMsPom+0O0OcF81hAo77N42Wd/Hf/CrZTvINOkXzV3Do
         MuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRCsdapBS//z8M4oZ7Ys5A4xKX47p/afoIu8HKdR7Rav2b46CzV9dQEWth7tQK/K0bNQMrheSl03Uhmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHFqLGFhB+eBHTqPD1Q1aUqFMREe8zKLmHnzX6NRGcqBC17cf
	uY047SbHIQqQg3Fv3N6WS1BP6bH2pZ5A2/CJr+3HJoHVp+1qEr3RFDYd3dH3+bVB9XVOLtUxhbH
	QGxmhSZq1/EDW3uOcQliJfCFRxa438RlpPy1mFWfIFiub7PHeiyAuT+irnb+syrdB6TYTN6zSCS
	bNpXqTsQKI/jecfSTmrIn0hKMZmSrD2y3Iz2qXJng=
X-Gm-Gg: ASbGnctw4RUw1JTSJyEBjskIQv6kbEGOuPH7plPQYA5g2BfD7fH/G8KzreOm7ojBG6v
	YGNDi4XX10XYhXC1wo4jK1K3zba5HYoul1laeE1EWywzWZDj+RinZfB+S9SDTkiIpEGnQGU9uBB
	Ck
X-Received: by 2002:a05:6122:1314:b0:531:312c:a715 with SMTP id 71dfb90a1353d-532ef36d88bmr1312852e0c.2.1750848069182;
        Wed, 25 Jun 2025 03:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKSrlq1vbTvn3Juc6W5KhrcexBGZURwwZbo6o+xxVCTx25vGfBDJ/xWAUugd4sgcE788El/lgs5X0WkOKHVaQ=
X-Received: by 2002:a05:6122:1314:b0:531:312c:a715 with SMTP id
 71dfb90a1353d-532ef36d88bmr1312845e0c.2.1750848068518; Wed, 25 Jun 2025
 03:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-2-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-2-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:40:57 +0300
X-Gm-Features: Ac12FXyp1o1FcravfvrXONE97kHRXN5UStXCBn6AB_JACNodeZdJ-QuOTaMpRIc
Message-ID: <CAO8a2ShgtKP-_V=YZ1NUvSUeoS8_mX7de20nP=P=RfdH5n=XTA@mail.gmail.com>
Subject: Re: [PATCH 1/5] bio: Use memzero_page() in bio_truncate()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> memzero_page() is the new name for zero_user().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 3c0a558c90f5..ce16c34ec6de 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -653,13 +653,13 @@ static void bio_truncate(struct bio *bio, unsigned =
new_size)
>
>         bio_for_each_segment(bv, bio, iter) {
>                 if (done + bv.bv_len > new_size) {
> -                       unsigned offset;
> +                       size_t offset;
>
>                         if (!truncated)
>                                 offset =3D new_size - done;
>                         else
>                                 offset =3D 0;
> -                       zero_user(bv.bv_page, bv.bv_offset + offset,
> +                       memzero_page(bv.bv_page, bv.bv_offset + offset,
>                                   bv.bv_len - offset);
>                         truncated =3D true;
>                 }
> --
> 2.47.2
>
>

