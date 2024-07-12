Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5710E3
	for <linux-block@vger.kernel.org>; Fri, 12 Jul 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746086; cv=none; b=qD6NN7J4IfY+nS5105YJBJfANRlEn0S10fyeg6/scTcEbPDPERum4H46MNE84uHPj1/Nfj5ZBYxUu/qLE5HOIlp8tKE9cRTfxLxLZ32NEhlzb8ada5LC45qjgmIKYn7nvBhgg+7ICu65CfB0jaYKyxdtgnOh4FPZbUuOm/z/Eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746086; c=relaxed/simple;
	bh=0lzGgMccgOsb1N/R6m8AEmk1oMrFdCaXnfbBbMXMHRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7NTrwnPMhDKp6Tdu7Bv1Vz0W3gZ/Ga5UkPT6IHK9vx///9AM0BXPyKv6TlXv/4PANQEj8ZYHqr7ib7tSH28Vmr194mVtq2RyqhBRFj7HypSQAf9GrklJc60TXK+3xqWUWAPLmtutwM4JUZ/6gqhoZyxI3KP+EbeleF1qP3ix5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxCvCc5t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxCvCc5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720746083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9wm45KJYHSR6EG4gUE0pW1MnhXS5B56DsrXLuti6lY=;
	b=KxCvCc5tmkfejammXW90LAybYP+YdFtQGLN2w8vUs5enIdSfd4Ii9rqhPe65AMRSjEosiR
	IgZNju8gtno6FPIiVN+DZUVak+CM5kTHv2HlZJwG7mRTVcdxMRmSuwVkG6DDFxDMW/GbHF
	EbiYgXgtIfDY3b8QE+7G1gtWSvO4tBo=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Lbj7StPGMzy60FQ-ivPiNA-1; Thu, 11 Jul 2024 21:01:21 -0400
X-MC-Unique: Lbj7StPGMzy60FQ-ivPiNA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-81016668febso123358241.3
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746080; x=1721350880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9wm45KJYHSR6EG4gUE0pW1MnhXS5B56DsrXLuti6lY=;
        b=QlKo/BSWjoFRxFJ/qgMcGZURooC9693G9RwOHLeOfGOGAWFqYxU9MaEV/52R4YVx7v
         OWnYt+wLrQGMJFacwK1ujrI2wzWo8XU4y0VaORC64m4TY15yw9f99nQAIXQMnw07DqZu
         TwQ5DPXnOycIUogRQuHCTMOVMuFeA9Gef+oiIo93AVEeBGDAc9fjO/XePKE+ATaHVBHi
         9Gb+54eindw7/VnYQZsKPfq8iS/zsj/WI8/hzAfRv2DrTWr0iSzNxx5u7Rjblzizdq5B
         7VcS/jRSekG1S3vWHpOvdfLd5x3dCmDR8OnJ3Fm+lF0bY/G2qq4mh6/s0dbzqTSw9Sh0
         eCag==
X-Forwarded-Encrypted: i=1; AJvYcCVCWgevn/6raDRPvg2rMmxFr5GE4q0JELvjwcdJyo9IzQ6CX1UULo3P5/YcfWTc8bjUSie1uOk4nPpsoKwFOern9Bm55L2qTXPz2yQ=
X-Gm-Message-State: AOJu0YxpLQ1g+cjz1UcRXzfieC0HLk+4Gn5xgCti+07U728h7wzSxjUF
	+LecZwfqgHiU6my+oGXfnWEKcW/wpSb8GgJs30AtkauK4X5grjSmGOBrqeB0vtayMnwRUrxjeVx
	ZN6/nfLpUWtrmEghJOi4NDWInT+4el9sZ9gG0PvGiPbp6WRirFpPtPwvB3GFi5R3KPLgYjjbvqL
	b8dOmyH8N/mW1jWmCJLC4Gwpr3+E96yGO4Azo=
X-Received: by 2002:a05:6122:3c8d:b0:4f2:aa91:34eb with SMTP id 71dfb90a1353d-4f485296ad9mr4395852e0c.1.1720746080271;
        Thu, 11 Jul 2024 18:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9qAJCd/UDkXooJxLP3polnc0tAxXfY/AZlFlnhbfWI+/TnM9trFyVB+qIUz+wEKL7J4r0h72VhTW6a3A80Wk=
X-Received: by 2002:a05:6122:3c8d:b0:4f2:aa91:34eb with SMTP id
 71dfb90a1353d-4f485296ad9mr4395840e0c.1.1720746079952; Thu, 11 Jul 2024
 18:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710065616.1060803-1-yang.yang@vivo.com> <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
 <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com> <Zo/gevNqftePGvic@fedora> <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
In-Reply-To: <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 12 Jul 2024 09:01:08 +0800
Message-ID: <CAFj5m9L2qin-h1qfPbhotSr-2Xh+mnQbsWhpzeK3dA_YTQ=JpA@mail.gmail.com>
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Bart Van Assche <bvanassche@acm.org>
Cc: YangYang <yang.yang@vivo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:33=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 7/11/24 6:39 AM, Ming Lei wrote:
> > There are only two WRITE on 'cleared':
> >
> > - xchg(&map->cleared, 0) in sbitmap_deferred_clear()
> >
> > - set_bit() in sbitmap_deferred_clear_bit()
> >
> > xchg() supposes to provide such protection already.
>
> Hi Ming,
>
> The comment above 'swap_lock' in this patch is as follows:
>
>         /**
>          * @swap_lock: Held while swapping word <-> cleared
>          */
>
> In other words, 'swap_lock' is used to serialize *code*. Using
> synchronization objects to serialize code is known as an anti-pattern,
> something that shouldn't be done.

> Synchronization objects should be used
> to serialize access to data.

It can be thought of serializing UPDATE on both ->word and ->cleared,
instead of code.

> Hence my question whether it would be
> appropriate to protect all 'cleared' changes with the newly introduced
> spinlock.

Wrt. ->cleared only update, xchag() is enough.

Thanks,
Ming

