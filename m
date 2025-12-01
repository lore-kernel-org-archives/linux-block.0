Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B90301472
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581699; cv=none; b=hthIqWhoEdFt8+d4CUXC5LNRq0uJ3TSBNd7+S6NP+kuIHG3gHKOu3uYrilBH6gKFdPWLrxX7g6NCQAZKt/64tkJFkiOrJ45AgR5zK9d/oWspSfDaleGPa33gIQqoWXJUykgls9DvSSBWbbmOBV2Ubl0mwDXTsdDUXaDfRqV4KNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581699; c=relaxed/simple;
	bh=T52AtHPElaPUhvMaiSySl1nDPtYlKqOJljlXi1j8qDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWOXiaEW4ergbu+rGI/6WKHM5OW93cXkfFuIg9yIPUpU2bski/c5jIQK7WTBkqfuchnqWY8WIfebGX4HcfUCxmEPKVeEE3vIGqsYX0hWHJAsnBpShfKIOw543Ly6slB1yN6CopzNTU/OQ6KCwvacbiv7IQ4Tu9zT9Q4XmNpQav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALEMn52L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kgnj2fEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALEMn52L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kgnj2fEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764581695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YnXOTrBkDWFfUknE1oxAp7HDSV9l35AiIkERLzX4GY=;
	b=ALEMn52LkVGMdVZw1cOdZkrogcPm3olbB4eJIMoTFdNRSkr6sbY+kAEjRNwA7qSXQjDQAp
	pvo3u/28/aeiq+oDsgNGMfMzIoM/tI9dQJY9Y3v1GfpX55klag5Yakw/WQJWYWK/rc9SmD
	9sQQz5yox3TCajC+45HNHAnMQhvxwRE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-iYWnQ0LZMq2Go_L4mrf11A-1; Mon, 01 Dec 2025 04:34:53 -0500
X-MC-Unique: iYWnQ0LZMq2Go_L4mrf11A-1
X-Mimecast-MFC-AGG-ID: iYWnQ0LZMq2Go_L4mrf11A_1764581693
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7868561eb2dso48181937b3.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764581693; x=1765186493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YnXOTrBkDWFfUknE1oxAp7HDSV9l35AiIkERLzX4GY=;
        b=kgnj2fEKyuJ6SrAFR9hQ+Z0PhkkELMpCJhItlNnTYxDRqDZf1Y/ZnZPXaxsue3IUSm
         2xCowS2Hnz6IdyCBUd7At94+M80Jeyvj45r3Lit8Bc3G+2N1CYkv01DwDRgR0uPCCXx9
         JhhJdT9ARMyV18LfrwU/Ep+V3vlv0dTNHGhB/UBhabH9zTpxJrUrC6tzBIwBVvP9Colg
         P1sqvp6R2PUlyN77eR4a2Y9Ezwt3lrA7d1GmpGqN461SZHOV+4HCnh5h0WVLp5hNWBJX
         HBOd9H6HFQJGwa+5SHIHNBLl9M4h2j8/2Euea8hYkUBJ/iOmqV004Ny9oVaxn468bRN4
         1UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764581693; x=1765186493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YnXOTrBkDWFfUknE1oxAp7HDSV9l35AiIkERLzX4GY=;
        b=aWorQMvh+HtQ60hGUECDEWIEAl495fT3m5ZSt4vegsHtc8fHo0dr3ECXDyQJob2m9P
         Da0DSXRfx6ufolcIrrdwX4PWGWyZ14VLaWSGgrun4NZsWgEicwg+douUep5XDKGjiQuT
         wcqsj0dsd7Pwt//ch8CqONSskaSdt0HbdrPOez/UWkcYFN+/nOVieupNmhHdIv/fdAuB
         mVJaFOJ8Y7oMhV6csd9+zvy251lmewP/qjHubcwvyDaI698wurYzNTH4IRX49M4DP5J6
         XDpQ5KaLf1yFmhU4sHTF7Xq1awG+DaDiPWjLrV0Wh5SMXMlPh12PusQIMb6xDeCb7oSu
         GbEw==
X-Forwarded-Encrypted: i=1; AJvYcCX115asosOTdqba3lK2fhTMnN78sA9iqeuIoTYKKMCF3ASDuDfFL3W2yLfPrMkXFh7+wWNmX4yRQPWlRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOTI3dGbnz1sKA/JdPKB5R5C5d5bKEntrxPKIjLc71+kSTAp/
	3iqv/vFlFR/m61uISU1JRSOWdMQoMlDN64l6qNZj2+qKC/fLuTotg55GBhYbRwTQQce3t9X+kYm
	XsfpZ1mU9qy/z5twhxMksnD8HhV7AV9LeCrPXUNrXjLMpXStrNZEvV7dR2Cxw8AiERA62pKYeUq
	Alnvi63SO32D117/z4RWlfCbIWZKd4Rsfgd/GXJk4=
X-Gm-Gg: ASbGncvnDJFtlQ5Ts7EVsP+FiBVqWPiY2fYGRThPWrbJgSvkS9hb+ZaLsm25RfP9Q7K
	EO04Il625e1EHfsj/yx4J5rLVjF4O7YKGR2DOGKEZqs3R3TyI5fV6cn6wIuzZZB0rY1X4eCNYOQ
	R/ljHpSYWPeowpdZ8Btukzd1Z6ja91ndpGHBZA5ehGY1OtKuwJCo4OuueF4RZLKI68
X-Received: by 2002:a05:690c:4b89:b0:789:6c45:5ee with SMTP id 00721157ae682-78a8b529321mr327732237b3.42.1764581693225;
        Mon, 01 Dec 2025 01:34:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE+ydvQLXLWR4PLDlpL5sDe/7ms/CBFUiYi8OzSrRwSjG/eFnKOHmSMbzUo+6JiXvQr8GsLl9rt2B5meQ6+yY=
X-Received: by 2002:a05:690c:4b89:b0:789:6c45:5ee with SMTP id
 00721157ae682-78a8b529321mr327732007b3.42.1764581692913; Mon, 01 Dec 2025
 01:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201090442.2707362-1-zhangshida@kylinos.cn> <20251201090442.2707362-3-zhangshida@kylinos.cn>
In-Reply-To: <20251201090442.2707362-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 1 Dec 2025 10:34:42 +0100
X-Gm-Features: AWmQ_bkx-ahSOMJme7sYbH0k3cAGQiXM2JSUj318w4dIuYwRxb1qdF2fgZVmzjo
Message-ID: <CAHc6FU53qroW6nj_ToKrSJoMZG4xrucq=jMJhc2qMr22UAWMCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] block: prohibit calls to bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 10:05=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Now that all potential callers of bio_chain_endio have been
> eliminated, completely prohibit any future calls to this function.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c27..1b5e4577f4c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio=
)
>         return parent;
>  }
>
> +/**
> + * This function should only be used as a flag and must never be called.
> + * If execution reaches here, it indicates a serious programming error.
> + */
>  static void bio_chain_endio(struct bio *bio)
>  {
> -       bio_endio(__bio_chain_endio(bio));
> +       BUG_ON(1);

Just 'BUG()'.

>  }
>
>  /**

> --
> 2.34.1
>

Andreas

