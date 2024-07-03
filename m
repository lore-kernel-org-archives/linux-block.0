Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEC10A1E
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977474; cv=none; b=HVOTJyBR8Wkeu2cA7m98NfPLipAAsOAo+vEsBmE2wz34rgfuEXWfsuNj2Efm5RC1nfPrXTMpeyY/xeTS3wyIGwRaxtPsK/42txPeFAoc4V8eAFc1UD9Td/3wpNeW5jiRvBlQl2bepENgs4FVe0kTQ5o7+DQkrTAuPLjllN7Gm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977474; c=relaxed/simple;
	bh=Ntgv1RmGQvZEExr5kYNNuFVZ13m+/Y6h9Yh+Z/69C94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRAlhUU6dplt5WjoWwQfoOLN8rYcAkrfPdFVSO+2MVSO+uQj9B6kM3aWqlY2eaBSOMBrpupJPBwXYoUDReJwGLkuVgIrMhIpq9VSiTlg3i/XdltsB6WBCHB9hj+Z/hXbcRwFHbV5HpyE58jXfLdqaUytGTQoh8O5ewx4hbtmxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPSZGguv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPSZGguv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719977471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdbEpW+ka8BV0EfHU5IhEH8Kwx89A+Qt9tjxCITxu5w=;
	b=EPSZGguvBZkS6OmGwUeJLx0hq7/lYdmOkcACR56PEQcJslNbOHn66rLeO3xkJ3GaXYLL2q
	FVbMHiGePDKEGzlzUY7j3j8Fj8ue253mT4jcSojwq5vM3VTT5Us0h1j2xhqytLEAx7djNN
	b7QuadnPUF1/jB79S3KzwJomNGboA1U=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-yVNi5QB9M96y71RneWjZVQ-1; Tue, 02 Jul 2024 23:31:10 -0400
X-MC-Unique: yVNi5QB9M96y71RneWjZVQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48f3c35695eso499471137.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 20:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977470; x=1720582270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdbEpW+ka8BV0EfHU5IhEH8Kwx89A+Qt9tjxCITxu5w=;
        b=TuKIklPM5Q6JUjeQkNmN6P7T2kydbPYl8yCBGygxb3NiTZS2VoC9tDlJOpDQubvEtN
         iSLCR+bSODJtCJYAs7q1A43StSwXjW0OPrNt2H6D0YvjXGxH5CydV/V9aZCvEJ1MhlHQ
         i400HScVdrpOSUxjpVvo3oCRKs716a0tDJjkVGyv/Vx7p9/i3kopD2r0CXExj86wJ+Iu
         gD7nHqs13mXbB3pMKfEdzc0Fba7XXNvVriu/Af1WDSP6vplMr7H4ZtShc7a8qtDknLbw
         bN/DeAt+27nsaDl35VI5fzmLqKXmCIPH64Aheo57g2TyvY1plZTy0Ohz2Q8csSGHkKOW
         tvxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJMNsa27N9/gCskxH0LyeX0SiKaVKnV8Dw2bPuFk0YCvsekUxqTLY+QEcGZgOzO2coTEfgM1fAw2RnnKL+Rflf71DQjtZKggKR+k=
X-Gm-Message-State: AOJu0Yz38/VnZPFhRuZQvkCvAA1627Qh9zNgvMRtGUivpbVHILmsJHLv
	zz4dpAouqbaumYheRABzztUR/u5fonn1Qd4ggUCPhCSECEJ2yPfHcrY1KgmYzoeLAJr0BJNbj73
	s16HG38fQJrve4F9X63OEM3SaamIiwW7nRkbyQw4QKwNzuDgT9EFt4zGwG/tmWoKS4kKAo/cwpY
	bXImZiaYAG1MXfXio+88UFJu2Ebn4dA8pwVcQ=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d58 with SMTP id ada2fe7eead31-48fdf2c7213mr459639137.3.1719977468409;
        Tue, 02 Jul 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq36iZHffY05mQHqGwXuTfgtcDXU9owjtWovlD+KLAjq9PvpntYYFlSgObgHSBSnsI4qjVbXMlcxCuzralhu4=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d58 with SMTP id
 ada2fe7eead31-48fdf2c7213mr459624137.3.1719977468074; Tue, 02 Jul 2024
 20:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703022807.642115-1-yang.yang@vivo.com>
In-Reply-To: <20240703022807.642115-1-yang.yang@vivo.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 3 Jul 2024 11:30:57 +0800
Message-ID: <CAFj5m9KfY+0r8eR-ThS7FF+xTnLaWGVrC4vT01LUChVQMqqzUA@mail.gmail.com>
Subject: Re: [PATCH v5] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:28=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wrot=
e:
>
> Configuration for sbq:
>   depth=3D64, wake_batch=3D6, shift=3D6, map_nr=3D1
>
> 1. There are 64 requests in progress:
>   map->word =3D 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word =3D 0xFFFFFFFFFFFFFFFF, map->cleared =3D 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=3D-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=3D0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=3D-1
>     mask =3D xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=3D0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
>
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
>
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
>
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
>
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

