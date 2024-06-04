Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3C13D501
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471545; cv=none; b=Gx+QzIIZloW1sKLzRdoVEGOGw84PlZEW1FLOKvLVYXo2t3TkARe5CvFsYVE5A/8h78euxCRHcPunU1dvPCHZe82ZSYcX3pIr5ttv+77j6eS5JOU4dZOdzf9nirJfTli5RW/Tnk5cmVpft90M6kGEoRI95bgZj+ymDDzovu9EGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471545; c=relaxed/simple;
	bh=NjrI4lHVFyH79QzE/OE3lhpa4QHszBqtLMquvt/lk1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFe/yG8hyIGAoCRaljT9Pjdn8oejzJFj9Bx4Z0I8zVceoOO54bAT8TfP/yI7hyJod3xBgYOnD0+EWEPja2aBxIE2726sVbPUp82m2wA1kRXhT780s2veMB8DDOQB+WN6uy928+3u6L15u97rtCkvkIYiL69c9jVnfM7b+OBC/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNToNuRD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNToNuRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717471542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEUAhiXSNeBDF6NeU6DEm0KF3UmpeqhO8TfskOx9nww=;
	b=cNToNuRDvFvizomTVk76tdQoSMNLsT6dg/WYxQzLiEn52wkPKeblpRBk4O0bjTN7OEQkod
	EOLwauKTEakoQ3C9a34SpFXR1WnFtt1QhTYuBP+2VDUv2jxqIPSgT9yArq28rHUKoJuzdu
	Z9oOZS7aTksyn/Kuj+5OgPWuoorUUQo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-1Vxa9YS0MlOb3nCYTOrTAA-1; Mon, 03 Jun 2024 23:25:35 -0400
X-MC-Unique: 1Vxa9YS0MlOb3nCYTOrTAA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-48bbd01f2e8so77028137.3
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 20:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717471535; x=1718076335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEUAhiXSNeBDF6NeU6DEm0KF3UmpeqhO8TfskOx9nww=;
        b=U45D/9HYdboDWr8L57PD06tW/KyBBGbPLHY+QVtc76Cab2GELJpDU5bZq0NVmge14N
         sqOPRo5VGgyA9F7iuEH20Plk+Et4S1IiOS5HioYnBhY/9EB2DHgRe8vgx7JfBrNdYX60
         JfBHCX2zX8Rw+uJBuP3961MgeS1fx7kYubFiDw/CTgR5MiwiPHTJ/78NNe/Oot10rDxJ
         ASQPl0CbuydS1TwpXYQk6u0yaLfxZibROZ3Eioq93W08ZXv0rtxdMIInM++IziWUNePK
         IEyBf8yQzFGrAL4kwmbBbC3vzrK83nTXF87OX0tL8VC+G9moknTUa1sb3wXNmXLH8Bj5
         6Y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgy06PxcAqNFwoeplZikv+JxFZcqWC6OiDHr5bUb0Ovc6eh0t67YDcXAvwol92HReEAlS58B6dAd86zB3nBKvdGYUf17zQgvaQfJ0=
X-Gm-Message-State: AOJu0YwUydvBbtZBnlri6WW88JO/614zulqnO3dENOP3YtRimdQe1HAB
	7U2IVlu7G3bFYy0dZKna6LLdlFac7kB5y7ADcVlnYjgJOaPym+PArDTE9dqI/fnGsZ3DpJm0piB
	yMJIhgAl+cDn4mH0sn0XQct/8CfXEZRiX5z+REhPqJmk+tlwSP1OHHaFPIxxtO/GT+1mFXOmq6W
	CcqOEsVIwRrfYSU/bHa6JsQd76xnwEZztymZ0=
X-Received: by 2002:a05:6102:2413:b0:47e:d83:3baa with SMTP id ada2fe7eead31-48bc20d61c5mr9946006137.1.1717471535497;
        Mon, 03 Jun 2024 20:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7DXnSSwrPGvQPNJKTJH9Cjm0AElH/f5m6QlOX8pDSYFZHyQ4s0E3aFQSu7Exbjezn8E4sDHKpToxRMkZtOOg=
X-Received: by 2002:a05:6102:2413:b0:47e:d83:3baa with SMTP id
 ada2fe7eead31-48bc20d61c5mr9945993137.1.1717471535155; Mon, 03 Jun 2024
 20:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604031124.2261-1-yang.yang@vivo.com>
In-Reply-To: <20240604031124.2261-1-yang.yang@vivo.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 4 Jun 2024 11:25:24 +0800
Message-ID: <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:12=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wrot=
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
> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> remove swap_lock"), which causes this issue.

I'd suggest to add the following words in commit log:

Check on ->cleared and update on both ->cleared and ->word need to be
done atomically, and using spinlock could be the simplest solution.

Otherwise, the patch looks fine for me.

Thanks,

