Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957A284B3F
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048719; cv=none; b=GrZgmV2e7tHo8rsL5hdhKPTDURBODf8bOISda1EjP8ZTu9fo/UMYEauVLfxOb17jdCJ25vzyqp/9hrIO0MEl/sD/dqu0fatrXGWq799YjnGgZv+zevGUNyd1/+24SHJiU/ghltWi9tYoQodI9B5WWX7udEJFzJioRjjCKWUz2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048719; c=relaxed/simple;
	bh=jmfYmYyuWEpRGKg6t9NRAgF6MKtJrC7ft7iXy8ShjRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1Qkooj8ta5cSOnWl2RtqgGyeikDLT46QvfiW+4UDnKVXUqepwAelXnruPUHLnY85eBJI16UGcNAunRjEYz29qf5H1cav9S7CweOEWQn9wQVv6eVHi85DR6Xbd2pgB1iJI8k7pfq0bPSkAE7CYPR+cHyfAIOH65SWQ8UW2JfiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZK+h41F8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZK+h41F8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752048716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CygDYFg4LD05rAXGmEIR6KVF9VD54bTYRORnXbkiq8A=;
	b=ZK+h41F89ELDsd0PbherKiU0v9l3qOaokTFGagYGWfFQEyUv+ONeJqqAYCwOZ0urlxoY12
	mdhWmSzv+jSGVl6hKdhiJcTXHL25Z7Xe1X3zWcz3d2RGu7huzFUGu8rMeMC7x2eoclXJX2
	Iw7ouNn6wOZiLB1Re40/0B8kqxiQlKk=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ZCG7QspcPo-l4KPneduQDQ-1; Wed, 09 Jul 2025 04:11:11 -0400
X-MC-Unique: ZCG7QspcPo-l4KPneduQDQ-1
X-Mimecast-MFC-AGG-ID: ZCG7QspcPo-l4KPneduQDQ_1752048670
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53145a42434so1052070e0c.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048670; x=1752653470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CygDYFg4LD05rAXGmEIR6KVF9VD54bTYRORnXbkiq8A=;
        b=XiCArogKQ7fF7tFYIfZ76fOVe+vwUq5G/0ls0/ofNCCt38Kt2E41qdJ6JUApfFCk65
         4etRC3Bt8dmhPf9ulzJFjeF5bKXhqO5TpqYI+nm4z46nW/r4AujdhIgpKwmKOtKRGoSK
         /GphVfJ9z0bwOiAYHNB1hz9o8/aMVMGwzyrzhiCO7yjnkMJC7qE5YMDhRPQDXxAUhCDG
         2j8BR9DH7nFvMIDOh5kBFz6jk3Z4+Mohav5uHTbpUL49Yi/Tu9cliFbeJFvnNx21/1zK
         cv9cAEB7tTojDrPoctP25pKheHJivVKXd7iSi+ZpxhMl+nIrcnDZB90UaI5b2xiXNXbQ
         X1qw==
X-Forwarded-Encrypted: i=1; AJvYcCUfhEYEe3FYmsp9rqnLUaTZg8JKiEdaGJqbYBsp6dY25ljLkrMxBNF2OH34os8ZwH/XYKK0JKbVHwNbVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyOW/u3oWZ2d4r1+NVULj7ADO1zfTOOnOeRi3vU3e9y6gwX0X
	Qgk4PXTc+1SMlSHhthVKuDamaYFK2TDMwpEHbCDelhwHmB29Yhh58JnW4cG1JFmQG99eZ5pP+vA
	rtK/8LqhxoVY6D9eCPPU0cHkwtAmYndxzvRpQLlY35ceXxZbJ0XIrIzgNd86ZfZb9+j9WJ4oIf1
	KTDlOKYzUk7gRTe62bLha11/MeAblc9ryEUHk6WKg=
X-Gm-Gg: ASbGncsPlHoZ7Bnc0nK4+nZ3+LR7mq97bVtPaLBRo4bMKyeZK6hkJOjun4p5kKT341N
	06fLIDwSsRBI5FlePylkv2RLgOzcPdtbdBL/Zschj9fF+UFFLUD7RJ1nrOG00ZgSB8bw2uKiGsy
	cPj8F6
X-Received: by 2002:a05:6122:d12:b0:531:19ee:93e9 with SMTP id 71dfb90a1353d-535d7531b0dmr757148e0c.2.1752048670639;
        Wed, 09 Jul 2025 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0W5MA6EE24ZGWfX16D3hExrNdugUswdEht9/c4UpuDpVlT1JBY3LVxJJ1QgG9lKRs4X91KPxNUpcL+DnwESY=
X-Received: by 2002:a05:6122:d12:b0:531:19ee:93e9 with SMTP id
 71dfb90a1353d-535d7531b0dmr757146e0c.2.1752048670413; Wed, 09 Jul 2025
 01:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709014109.2292837-1-ming.lei@redhat.com> <95e6bce2-19dc-4085-908e-c81fa7a1d5d3@linux.ibm.com>
In-Reply-To: <95e6bce2-19dc-4085-908e-c81fa7a1d5d3@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 9 Jul 2025 16:10:59 +0800
X-Gm-Features: Ac12FXy8ks1l4Wo_-J8ivo8RgBG0uI5uU4efROU1pWrmbFfhdh-S3NkZbSqHa6s
Message-ID: <CAFj5m9Lira89JzPO9gf9gcnn0hDtiJ2f2+iayKXUtDu-J_P25A@mail.gmail.com>
Subject: Re: [PATCH] nbd: fix lockdep deadlock warning
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com, 
	Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:59=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
>
>
> On 7/9/25 7:11 AM, Ming Lei wrote:
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 7bdc7eb808ea..136640e4c866 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -1473,7 +1473,15 @@ static int nbd_start_device(struct nbd_device *n=
bd)
> >               return -EINVAL;
> >       }
> >
> > -     blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections=
);
> > +retry:
> > +     mutex_unlock(&nbd->config_lock);
> > +     blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
> > +     mutex_lock(&nbd->config_lock);
> > +
> > +     /* if another code path updated nr_hw_queues, retry until succeed=
 */
> > +     if (num_connections !=3D config->num_connections)
> > +             goto retry;
> > +
>
> Don't we need to update num_connections to config->num_connections
> here before we attempt retry?

Good catch, will fix it v2.

thanks,

