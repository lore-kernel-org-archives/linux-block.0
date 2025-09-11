Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FA2D0610
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579577; cv=none; b=dp4bayB3FFRZ6qqdTpcKvU5PnOc2WVGzJlZgclB1DfQ4ZI3wklUfninbi9ivUkmJ+1rXC9+W3xy8L1u43zu4mdTf56429A8hHDLUTALEYkeZVQBIQ4XG51lCLBc7q5iOPrldQqhzzQIdWbqpoNGps6mQRuLpif0EyjhH1JRP3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579577; c=relaxed/simple;
	bh=7DXzBkYfqzdjQm+DmIuYQj51CR1NgQMJr3Gl5XBSCjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URqmDGSba+oNzHlIJeVMSVyoVI7VAn4eyV3Ll4DnIR6mV1JCvjGwFf7hRmSJDBCCimzLb/M+miccMRXMuKA5sIgsW3Bonqcx0GVHEdX//TTqDJCgXemq/IFukcgoPKD7tzo4g/+7vjjv50fbj6X7iv0sCKaCqXEvztiQmqvajDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6wajZSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6wajZSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757579574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU0ePF4d16jInmmLBuNmFr5MEDXTsnd2GYHiQ58mMXs=;
	b=F6wajZSgnG6UmGRq5dHOtKVeArIE8j0pKh4u3NjLKd2H3qe0PzMr8CtKwrcvDCwf4L7xTH
	/8a/scjhNFH0Eg7rVj+EAGq+ORAs6/1dS3MPzT3JzP8RlY+liNtPHp9kHoJGrjcSjP2OwB
	/rmeEKhiAPET7+0AqLyA/hlP/7IZlGQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-vyARuW8eOc6Dc87gAu9-IQ-1; Thu, 11 Sep 2025 04:32:50 -0400
X-MC-Unique: vyARuW8eOc6Dc87gAu9-IQ-1
X-Mimecast-MFC-AGG-ID: vyARuW8eOc6Dc87gAu9-IQ_1757579570
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5351d7189faso220188137.3
        for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 01:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579570; x=1758184370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QU0ePF4d16jInmmLBuNmFr5MEDXTsnd2GYHiQ58mMXs=;
        b=XPEXH96Wm/bc7LoVi7eXxi5u7KuOnRu1MfX7WgG0ALvo6Frk451/GzUZ1ZVchnaRBp
         NXK9dIaW+Q7m/LZR3I72/gYaGo8N59b/KMQikCqvtcwaEm40yi/7e1MpxqOn1dqNm3FD
         BHaG8sP044bY035eV170r3wavBAzlAccnZuR4HS3UaE0O4/NeaIWjIeBSxjT4Z8YF5pQ
         GmSQeHT9Vufdbu5H+N20QE5gkdisroK5YOSFenVyMbLyOutajITw0T1XK8dvk6jS4SAi
         YlvTWhDpCZ95xpDki88gTKEc70iyBfwrlJKPGS7PVS8qsQSueOLRIzlUKm2LaQMr6m33
         C39Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQeY3UdRovu2WQhPBZZ+mJ99MV0+rhX/Q6npsvUoRkSo14LvujQJxYQNqj0E66SEKxTXoXtO+BwktnlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/cSMF5JUGF4j5Vs0rkwdIoxiy8DVCoWNaD7NY6y+f/Gxkfzs
	G3NKI3vgp8BtdjxLEyshkYdko1IQ5F4IOGJBUjPxJTj4fs5fD7KD+WbH+7mXCHUhDVkDejlHwTN
	9/gcgER6ImrG7jpzg8T/9dwkzmWPGDMK8HkoJdWaF+ZhEH+op3mHTOFbHWsFu/7hJhzqYbPwLz6
	dncA1/2mlrWyGtWXyrAPFd2bOdLrlf/QCsDgP9rZ8=
X-Gm-Gg: ASbGncvXUXdk0/YGlVCU1YvBk84v7c+ZLDbnk3bMk4shlBNFnlVLqZ2Wg3rRQuzpZ39
	74i/ADgede22ULdAEfKoQjKYZ/vsCXsTfHj4pknEL9x6UxsveX71J6RqqYiGWmWFDyOfvgpyK2T
	qPrQ45WUXJBHm5kW7KmfIbAw==
X-Received: by 2002:a05:6102:604f:b0:553:542d:d96b with SMTP id ada2fe7eead31-553542e23b1mr318275137.35.1757579570336;
        Thu, 11 Sep 2025 01:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7RxGRvxB0KESnNm1fQzRvAttPjrog09VO04UKVzL9R9UVKLP144K7mjNmYBqT8Q10hQ4CoQvunkSenPeiG0w=
X-Received: by 2002:a05:6102:604f:b0:553:542d:d96b with SMTP id
 ada2fe7eead31-553542e23b1mr318265137.35.1757579569967; Thu, 11 Sep 2025
 01:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910213254.1215318-1-bvanassche@acm.org> <20250910213254.1215318-2-bvanassche@acm.org>
In-Reply-To: <20250910213254.1215318-2-bvanassche@acm.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 11 Sep 2025 16:32:38 +0800
X-Gm-Features: AS18NWAuamT7W0s4-N10dU_ImwG6VbrcGNE5yj2f8OBIwcY2MMcVKnBfjON6sR4
Message-ID: <CAFj5m9+8qyEjmRXJHHhZbD1cAKQReTxqahGr69PMKuy=9JMHLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: Export blk_mq_all_tag_iter()
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 5:33=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Prepare for using blk_mq_all_tag_iter() in the SCSI core.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-tag.c     | 1 +
>  block/blk-mq.h         | 2 --
>  include/linux/blk-mq.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d880c50629d6..1d56ee8722c5 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -419,6 +419,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, bu=
sy_tag_iter_fn *fn,
>  {
>         __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>  }
> +EXPORT_SYMBOL(blk_mq_all_tag_iter);

IMO, it isn't correct to export an API for iterating over static
requests for drivers.

Thanks

