Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2D27F01E
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923008; cv=none; b=FgxVV9TdjRyKVkly1AkcJ5N/11niJ5o3hPboQZdZF2xx08Trp8bKzeAookAsYWkuKhKZqR5XhIDnRX58qZqLXAULPYZmT4Pp6pNP+krRvzPLu06fUE8wXndtQUQ1W4wyvqGZQtKWIYKcKKUIckic+UTMIlL8fFiGuvrOjGsImn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923008; c=relaxed/simple;
	bh=yoBF7NteWxO7V+9rX/VdmtjM5yQb9HwaGA6pLPBFbAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG3q6lp0IQ87bM6PpZoEWssv+rygjrdURUGh9HuAzY1I812gas1tVCnTrErdloNluY5F0lxUBM0pYXZaNxmwWq8dA4xNavl9mmQgaB0qcsPnv0BQufiaF6gTlWeK+hYDeJggaIbJ0YWRRX2bLZafHl40MtxXbyKB1hlN27oJ7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afHFy6AY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEtfsCQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afHFy6AY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEtfsCQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762923005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/gVlLyl+6IP/4a5pM4X/V86R1cLR/q9YjmXCiqnp70=;
	b=afHFy6AYru3t1aPhImhrHtNKY1uQTu87vWfXFnEg2a64yrQI6HyB19C6RRox0qukluDokO
	o3jVY0F3+E8qJ5UCjRTu7WNEGGo4XbkoWKzwc9ANhTb3KkXfxKo53uHDgEYgKsnAOv/Tsh
	dgCqGwRxqQWLwcpJasbGfG2FJ+FMJwM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-f196-pYGPxipLQ52n4TLJA-1; Tue, 11 Nov 2025 23:50:04 -0500
X-MC-Unique: f196-pYGPxipLQ52n4TLJA-1
X-Mimecast-MFC-AGG-ID: f196-pYGPxipLQ52n4TLJA_1762923003
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-935298312cfso869764241.0
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762923003; x=1763527803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/gVlLyl+6IP/4a5pM4X/V86R1cLR/q9YjmXCiqnp70=;
        b=KEtfsCQchLVM7NbUymgDiRr4pMOdfvguHTTF35HWGAsbxAF8QMtf1dr5awANkYGtwD
         o/lMWboL8fvF+gdm+ApFXkb2az/Xct2sdh5Mgz2OfCxqUszFdPYlvbjn97My+cFvQQps
         /L+aAWBOYzZmqOQ69pQaakZEFEXpG3Lu4MJPhNz+yKbQY9dVjDjFqXz0LX2LtWGc4JEZ
         f839g0NWKbvTfVw2F/5bMkAWURR2AEp5qoipjip5VjC91iB4F2wSsayE0/KRU+qYCHJz
         G6vIrkObHiS3waqhzY5f2ZYwd+qRLW/n2kXy6SwRMgsMAbCUUeoUlJFaNsiRhFnCxgsQ
         l6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762923003; x=1763527803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/gVlLyl+6IP/4a5pM4X/V86R1cLR/q9YjmXCiqnp70=;
        b=wVIdU8oeYuJSuL6/HhLpzzMRTJRvTsPtyXslAGEVLpu9MWivbJ87GyNUovCfyO48Hc
         DCUtOCYt8uNUg7nlBOIhM6KitE7USUjmhnI+aEQWHy9HmC3Ch20ClPR7wU3B+U7QaT1y
         tZlZYWt2gNTt3ciKw4xCu5qZBSt7IG25WnEZTtqM8aydrjS/HsM2Bkt3sGsCTThwL3sn
         qvJdqVTZdV798Rip9ITl3Q1XALnqKbUY3DmUTozBTXtTOyeM8VwU+BNdnMRCO34AJZ/Q
         tNIrKXhdKyZrw1bvwiYCJLe7y5nLAOpMZuBrqourqwiWKoEIcYzn224eb8ABk10n+P70
         rDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjUL85Hr42pyqn7XTdadHmyMxcwFFzzPNn1EK9TyKl2Z2rzEdXLB+78Q6TuCpnjLf7KtDm45Fg6JEJnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45Z/jESPzrR5JfwF6CziRV9VKo2EMMnfkCX6Kwxeol9DLQOFR
	J//0GVTBzy+SL6F2xst4XT31LppSxZMQm0TJsIbt7zIvGavpbuM9a2L2MKJozVwkhAe4YdEx1+y
	4n24pnmLQ/b1b6HS8ikvyzzHb1n6Z13mTEa1LKQSj4TajdnV+AXL+GVdcqBY4hlC7pjKBHPR2SI
	1SysWtsrW3hZZzIoFqwTQsEdiBULuazZgQmdbU65w=
X-Gm-Gg: ASbGncuMLsiBJd6R6Em1Iq9ydAFYfPKPt2l4AXZ+GJZurnemoQe0wzb2pwP/mUva26l
	euI+Q1mrp50iAE5oVIU/YrNnSeQ1G4zNbKEghcDBNusYHJvrrWMjvzZB/7bR/zfwgD6vLfGHGbB
	YES/hZGBdcVrT8wYRHvK1NsdZLQE2OJcRuGIYPtZQMmKz1/GCqxDtT+Ci2
X-Received: by 2002:a05:6122:2511:b0:559:6788:7b55 with SMTP id 71dfb90a1353d-559e822c02bmr645158e0c.3.1762923003510;
        Tue, 11 Nov 2025 20:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAzWjOyScxN5v0aEUnsY6e9lgpbZDgGt9hc9lZDUY3nbYkPsK2n6koEuszfTjYN3tSlaNvfr5mOMVFJ+jCcnk=
X-Received: by 2002:a05:6122:2511:b0:559:6788:7b55 with SMTP id
 71dfb90a1353d-559e822c02bmr645156e0c.3.1762923003173; Tue, 11 Nov 2025
 20:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
 <aRP6KdADdbnhwwrj@kbusch-mbp> <efb44fe0-6d2e-4c91-be68-a30b53ebdbf2@nvidia.com>
In-Reply-To: <efb44fe0-6d2e-4c91-be68-a30b53ebdbf2@nvidia.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 12 Nov 2025 12:49:51 +0800
X-Gm-Features: AWmQ_bnzeZVltzWURXz_oxFYvjMfnvo7m8C4bzGYMNTzjJrfbdTtduerit3kdfA
Message-ID: <CAFj5m9KtSFF6Fx+Qf4SL3tazcQ9yp1Q+-pB5uGG40mExoFCmcA@mail.gmail.com>
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, 
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Ming Lei <minlei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:11=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 11/11/25 19:08, Keith Busch wrote:
> > On Tue, Nov 11, 2025 at 03:22:52PM -0800, Chaitanya Kulkarni wrote:
> >> This patch also provides a clear API to avoid any potential misuse of
> >> blk_nr_phys_segments() for calculating the bvecs since, one bvec can
> >> have more than one segments and use of blk_nr_phys_segments() can
> >> lead to extra memory allocation :-
> > Perhaps blk_nr_phys_segments is misnamed as it represents device
> > segments, not physical host memory segments. Instead of rewalking to
> > calculate physical segments, maybe just introduce a new field into the
> > request so that we can save both the physical and device segments to
> > avoid having to repeatedly rewalk the same list. There is an ongoing
> > effort to avoid such repeated work.
>
> I like the idea, how about something like this on the top of this patch.
>
> Totally untested, incomplete, only good for conceptual discussion :-
>
>   block/blk-merge.c      | 10 ++++++++--
>   block/blk-mq.c         |  2 ++
>   include/linux/blk-mq.h | 13 +++----------
>   3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index c47d18587a0b..40b7ba3b6216 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -458,6 +458,7 @@ EXPORT_SYMBOL(bio_split_to_limits);
>   unsigned int blk_recalc_rq_segments(struct request *rq)
>   {
>         unsigned int nr_phys_segs =3D 0;
> +       unsigned int nr_bvecs =3D 0;
>         unsigned int bytes =3D 0;
>         struct req_iterator iter;
>         struct bio_vec bv;
> @@ -482,9 +483,12 @@ unsigned int blk_recalc_rq_segments(struct request *=
rq)
>                 break;
>         }
>
> -       rq_for_each_bvec(bv, rq, iter)
> +       rq_for_each_bvec(bv, rq, iter) {
>                 bvec_split_segs(&rq->q->limits, &bv, &nr_phys_segs, &byte=
s,
>                                 UINT_MAX, UINT_MAX);
> +               nr_bvecs++;
> +       }
> +       rq->nr_bvecs =3D nr_bvecs;
>         return nr_phys_segs;
>   }
>
> @@ -531,6 +535,7 @@ static inline int ll_new_hw_segment(struct request *r=
eq, struct bio *bio,
>          * counters.
>          */
>         req->nr_phys_segments +=3D nr_phys_segs;
> +       req->nr_bvecs +=3D bio->bi_vcnt;
>         if (bio_integrity(bio))
>                 req->nr_integrity_segments +=3D blk_rq_count_integrity_sg=
(req->q,
>                                                                         b=
io);
> @@ -626,6 +631,7 @@ static int ll_merge_requests_fn(struct request_queue =
*q, struct request *req,
>
>         /* Merge is OK... */
>         req->nr_phys_segments =3D total_phys_segments;
> +       req->nr_bvecs +=3D next->nr_bvecs;
>         req->nr_integrity_segments +=3D next->nr_integrity_segments;
>         return 1;
>   }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..61cd0bd5b5af 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -436,6 +436,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_=
mq_alloc_data *data,
>         rq->stats_sectors =3D 0;
>         rq->nr_phys_segments =3D 0;
>         rq->nr_integrity_segments =3D 0;
> +       rq->nr_bvecs =3D 0;
>         rq->end_io =3D NULL;
>         rq->end_io_data =3D NULL;
>
> @@ -2675,6 +2676,7 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
>         rq->__sector =3D bio->bi_iter.bi_sector;
>         rq->__data_len =3D bio->bi_iter.bi_size;
>         rq->nr_phys_segments =3D nr_segs;
> +       rq->nr_bvecs =3D bio->bi_vcnt;

Please do not use bio->bi_vcnt, which should only be available for FS bio c=
ode.

It is obviously wrong to touch it for cloned bio...

Thanks,
Ming

