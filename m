Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AD383C9D
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437397; cv=pass; b=cEyAVE8Zno+VM0QP6Hol0kiTm3yeupfYCrJjrRPY8iKYFC00L9AO0UTcXcxeQ08bpI2FDuN8K8Cvzc6qhl2OgN7MGszDTswDdWdn+NIYJFkVulrzmTT6jafWqQmahWwA7rwToXsJ9yIG0niZzl9yf2vlkdA3WpeQyrh5g2CWYx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437397; c=relaxed/simple;
	bh=iPKbVxKym7OQgnizmhUo9y9f2ovSerP9EfVW2i8EjkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5IRthcT4ZDeiXNWB2mKD8iFixw/wIav0zMF90CNSgkY2naImt08sootrtwpihYGH7/1JZshIAxSerXH8Z15xz5u4hsGF06iDUnTmQetgCyGg9EAcd+usy511wu8iemihTXdoAjQmDoJLIoD1YGRX5Iq40FaCz1O5S/Ua0d3+XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVkoMsLG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEOebG+d; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVkoMsLG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEOebG+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772437394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfrdMnxpEB8TADAgRj2qIx2G9ezghKOnJZAwo8+c12g=;
	b=cVkoMsLGcrQoZlCW+GxJ0xb6QKH3xdmzXDDtcn/NMUKiHADYQgH0mPYxWFh8E5kPhAlPTy
	FOdfKK1hip3hA2K1Frk8DEN0yi2hnSRengjlB1xS6lYOxJNYYQWLiPa36yz80CwgUK5erM
	ZI3CicASWU7qZaus4FzZLctd+egrPiM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-OmPCRiN8MRSKURAGgopEZQ-1; Mon, 02 Mar 2026 02:43:13 -0500
X-MC-Unique: OmPCRiN8MRSKURAGgopEZQ-1
X-Mimecast-MFC-AGG-ID: OmPCRiN8MRSKURAGgopEZQ_1772437392
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3884fe7ace1so41200061fa.1
        for <linux-block@vger.kernel.org>; Sun, 01 Mar 2026 23:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772437392; cv=none;
        d=google.com; s=arc-20240605;
        b=H/mRr5TF0Y1fHxde8ErqF0dP2cy6s9iHbM6Y3Tmu7yo3Yb5anOhPsrqrVizeRIFhAS
         8UFF9hZ9cwoJU6pp7UA0Qt4NXqDfXGCFQzDT1gO8oihxFVbJbKK9dDS7wCebVIoB8OXz
         c/JQPd1+QwQMsQ+dnbKKBmWP//gJYbW4SECR0FX6qPx4KWUubSktRarPgL6OD3czQENC
         5XsjEzVci5GnVHkO3xm5+sW9dwLdaTwZRL99nKaVRdQaTaHRsdM5DjkDnih1rIpsBFR6
         4QaT7dn2Atd22b0BoK0PinO36wjaNG69OmlI7itjXt3eTnfw4Zlh4Vd95j7bLNETxT6P
         8O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfrdMnxpEB8TADAgRj2qIx2G9ezghKOnJZAwo8+c12g=;
        fh=uRfzHG52hD+wVDdCorI3z6kwJ6X2q5UycVo3bzCgH9o=;
        b=Jv/O+M5n3lJ1LXvk51GXz/g9Zf3QEkfAiIcM+pZ6m3t0EW2XWMvIQdsscndbXLKdPM
         EK6/uYIBC7rK5miq90UZVXsXbdHutgpnQ08Frfx+sBb/r5pTwG1ke7DyByH/4cvH+ydM
         IExpvGuUuiVflQIb5fJYzKde6GcOSHNkghQSYuGIcKRq7CPpsHp+5vI/9hCidTizZArA
         oQH4zUUYADnkGmH+0XYoPH9togfWHEL7WUtdgR8IOu6oUm6pWqyCLnUQ65rDf/88buJV
         06hW64EFuMB65AoOO6j+AlmNIojzrCELh2VzsO6tCNSGQxFjsidQLaxSIGYMZEPMNyz3
         aSsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772437392; x=1773042192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfrdMnxpEB8TADAgRj2qIx2G9ezghKOnJZAwo8+c12g=;
        b=hEOebG+d8as/DecEIKfRs6htkgrtJWgem35ln4kSg7wpThl5Kb9RiL5fQ5ZtxZrYGm
         2kzKizxHNeYuywdghFTBHqExJGbQOVzMwbs7HDVrPs0U3KxwlxCKmy0PpnzSgoRCCzdz
         6HRrFSsBQtvQhdZEnZ40VOxL9TBpa7dnZ8VXtJEgkyvJwVzRdrEMxOShoG+8TrHn17JX
         ArOx+B9M0OpynChB+o5YSu85QWM3n6HkfD/nmHQFq2HZJFv/cPe1/OfUa9nEeSHFqcBf
         GY/sQRAmbExLioQbrnjqO1ZuyUjc8VHNJAfjTtfzWUIkm3P0GR/4cBWAeWd4GDFNBvDD
         N8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772437392; x=1773042192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfrdMnxpEB8TADAgRj2qIx2G9ezghKOnJZAwo8+c12g=;
        b=I4ZS7BH6B7wFgbuRQIR10q5kSmc9epxxVr6X8OyVQrfu8aWNXZThvl2eWwjeEV1pX7
         Pk42tG+I3tjf9FOKLHWZSh/91TXRIxbNvfBdNLuLkDXI4XjEHQi9U1KfRjj4urXZ19Tk
         lakqkWfuTds6c3vI4DsqTYbYWKp18q3tCpQDuIuX1r/GvayhLRJuZeqYI08Kggm0tyDk
         cIBCtldxvfVLxEqiKl42zHHkCsMMSDzc0mAEJuC+mRpyBQpdte6XqSYhHqJVHT0WTqHr
         rHklU8xnp7eV4y4463/4gkebjy7LEXlOT5JMdkrT9/ig/bGzdapAlpJR2jjUe7OkfrAM
         VCow==
X-Gm-Message-State: AOJu0YzLDC7JAtVc7hfhe9F4UNBUoE1uJgrDNHZSlYpyaQg7DPj3sjB8
	YcjcvkMQcPE6d3fX3Or/7TQqvRKVWvcW6VcRwYDmOXL6CPNxOlrB8NzbT08qPQajg+b8RAvdSft
	cjEw3u09MIGY+8Ole04cYp/16ng/SToK5HYvkU87nQijr/tYGIiXLmUv0BBk/A2KrE0dW7PFXkR
	T+v09DjzVJ7FcBxTTWvyNcNX8hoUZ48VV8qpnsboY=
X-Gm-Gg: ATEYQzw2+xAIINKQSvQImJgybszcezyEKIzOyF795SfUkYuKVfPUZYyYJ3K2jv0tbJk
	yGdALxjQgoFS/q99iPLTq6y26Z97hMcvaVTAiisWP1AHjphbR6TJ+Ifh47t12t4VFJYq7UvQYv8
	PJtsVtlyuKdp2Bf1SBBuid31lgG0RRp9aKsiDE46+fQTBIa83AilbeT0DgThQXjqeORlTtL6vCS
	mBI6xEZUqD1quKm0Uv4j7dPy5Lc2Zf9WrYN6Mf35X5ydNdifls=
X-Received: by 2002:a05:651c:1511:b0:385:e793:fb11 with SMTP id 38308e7fff4ca-389ff350b5emr71792371fa.20.1772437392151;
        Sun, 01 Mar 2026 23:43:12 -0800 (PST)
X-Received: by 2002:a05:651c:1511:b0:385:e793:fb11 with SMTP id
 38308e7fff4ca-389ff350b5emr71792131fa.20.1772437391662; Sun, 01 Mar 2026
 23:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301125951.582690-1-nilay@linux.ibm.com>
In-Reply-To: <20260301125951.582690-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 2 Mar 2026 15:42:58 +0800
X-Gm-Features: AaiRm50oGc6IAkdQrz8U3lmjw6vs9h5zvpZ5eHCUS-5rkuRhSd2WL9YdeuoKBmM
Message-ID: <CAHj4cs9HoZZQ5RTAQ1obqaKpznGKsaOy-6F6uCm5CTwbnv09Cw@mail.gmail.com>
Subject: Re: [PATCHv2] block: break pcpu_alloc_mutex dependency on freeze_lock
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
	ming.lei@redhat.com, yukuai@fnnas.com, shinichiro.kawasaki@wdc.com, 
	gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 9:00=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
> after ->freeze_lock is acquired or queue is frozen. This potentially
> creates a circular dependency involving ->fs_reclaim if reclaim is
> triggered simultaneously in a code path which first acquires ->pcpu_
> alloc_mutex. As the queue is already frozen while nr_hw_queue update
> allocates tagsets, the reclaim can't forward progress and thus it could
> cause a potential deadlock as reported in lockdep splat[1].
>
> Fix this by pre-allocating tagset tags before we freeze queue during
> nr_hw_queue update. Later the allocated tagset tags could be safely
> installed and used after queue is frozen.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs8F=3DOV9s3La2kEQ34YndgfZP-B5PH=
S4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>   - Make blk_mq_prealloc_tag_set_tags() return the tags pointer directly,
>     encoding error conditions using ERR_PTR(). Update caller to use IS_ER=
R()
>     to distinguish between success and failure. (Yu Kuai)
> ---
>  block/blk-mq.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)

Confirmed the issue was fixed with this patch:

Tested-by: Yi Zhang <yi.zhang@redhat.com>


>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9af8c3dec3f6..a27bade45de3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4793,38 +4793,45 @@ static void blk_mq_update_queue_map(struct blk_mq=
_tag_set *set)
>         }
>  }
>
> -static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
> -                                      int new_nr_hw_queues)
> +static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
> +                               struct blk_mq_tag_set *set,
> +                               int new_nr_hw_queues)
>  {
>         struct blk_mq_tags **new_tags;
>         int i;
>
>         if (set->nr_hw_queues >=3D new_nr_hw_queues)
> -               goto done;
> +               return NULL;
>
>         new_tags =3D kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_=
tags *),
>                                 GFP_KERNEL, set->numa_node);
>         if (!new_tags)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         if (set->tags)
>                 memcpy(new_tags, set->tags, set->nr_hw_queues *
>                        sizeof(*set->tags));
> -       kfree(set->tags);
> -       set->tags =3D new_tags;
>
>         for (i =3D set->nr_hw_queues; i < new_nr_hw_queues; i++) {
> -               if (!__blk_mq_alloc_map_and_rqs(set, i)) {
> -                       while (--i >=3D set->nr_hw_queues)
> -                               __blk_mq_free_map_and_rqs(set, i);
> -                       return -ENOMEM;
> +               if (blk_mq_is_shared_tags(set->flags))
> +                       new_tags[i] =3D set->shared_tags;
> +               else {
> +                       new_tags[i] =3D blk_mq_alloc_map_and_rqs(set, i,
> +                                       set->queue_depth);
> +                       if (!new_tags[i])
> +                               goto out_unwind;
>                 }
>                 cond_resched();
>         }
>
> -done:
> -       set->nr_hw_queues =3D new_nr_hw_queues;
> -       return 0;
> +       return new_tags;
> +out_unwind:
> +       while (--i >=3D set->nr_hw_queues) {
> +               if (!blk_mq_is_shared_tags(set->flags))
> +                       blk_mq_free_map_and_rqs(set, new_tags[i], i);
> +       }
> +       kfree(new_tags);
> +       return ERR_PTR(-ENOMEM);
>  }
>
>  /*
> @@ -5113,6 +5120,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>         unsigned int memflags;
>         int i;
>         struct xarray elv_tbl;
> +       struct blk_mq_tags **new_tags;
>         bool queues_frozen =3D false;
>
>         lockdep_assert_held(&set->tag_list_lock);
> @@ -5147,11 +5155,18 @@ static void __blk_mq_update_nr_hw_queues(struct b=
lk_mq_tag_set *set,
>                 if (blk_mq_elv_switch_none(q, &elv_tbl))
>                         goto switch_back;
>
> +       new_tags =3D blk_mq_prealloc_tag_set_tags(set, nr_hw_queues);
> +       if (IS_ERR(new_tags))
> +               goto switch_back;
> +
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue_nomemsave(q);
>         queues_frozen =3D true;
> -       if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> -               goto switch_back;
> +       if (new_tags) {
> +               kfree(set->tags);
> +               set->tags =3D new_tags;
> +       }
> +       set->nr_hw_queues =3D nr_hw_queues;
>
>  fallback:
>         blk_mq_update_queue_map(set);
> --
> 2.53.0
>


--=20
Best Regards,
  Yi Zhang

