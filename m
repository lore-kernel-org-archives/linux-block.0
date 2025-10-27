Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8271E49F
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583256; cv=none; b=XNaI93teeBnckGIMvHWyzXVjfBk+4OrhFNNZEpGc7sjaN7B+gQtDKH+xhUmZ54GMUSva2HA8l63Xy29b5cLHBKYboeePKCBaB1xXcyRQ/IfaGA79euJqC3bIsvjeUePqvJNkm/9AXdkppEb4UUHcoGL+Ma81wju/DT2s6hJvoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583256; c=relaxed/simple;
	bh=w7NiV7MxZhN92p/QKe17pDyDbwE207lVNUR//Io85AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyMNJ7/GwM/mIxQfYjrD/0g4925iemKd5TdprlWT+I/A86BcuB0gHRme7qTL7F9+VQ7WvR6oe6Ta/r9kwSnA+CL28ow2mT/2KQ20bcWWB64tBry1laTYorfZtHwTSLlEdCwHJO6uKSgt0uanUQVWZaPxYQENfLdYZ2ZrG5Ao79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UZfGP9Gh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UZfGP9Gh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290bcb326deso8786335ad.2
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761583254; x=1762188054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1khaojH/NtUOkoR0RaxT4PkWOJpNehZz7yesvkUMYiA=;
        b=UZfGP9Gh1cuPuh7FxT0ZehryYSsi35s7wupNxxdC0BevNN56NFl7OuBiPEhNAOwExi
         FWrf1K6QW3Cbyiaoq2dCgNznTU4jGwMsTIEOaefip4313pfg6tQGQkLI/4c+g/Vft7d3
         9c+JdGZ/sh0WCAyS6DTf9sBR1ccewZiMP+JAbBP5q4TG50zarTcNx28H1qjODrwGykd3
         ewjNsIi349yw+AYxNzgcTRVnetD64slT8uaF/As0ys3gXx92L4qR/g8kpRHNrn5b/Sgi
         ol/2d9yO1bFdLJFNUVUbYlpk3mues6Xt3MHoqy/D9ljkXrJs2KYunvxeTZEjwENaNsia
         5evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583254; x=1762188054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1khaojH/NtUOkoR0RaxT4PkWOJpNehZz7yesvkUMYiA=;
        b=dMtmAfY+Nrg60isbbuSMO2IuMYAWg4mK0Y2NHh3mYu1HiQzRRlycXxguJqLpQj74HY
         CE3iuzyU/B0rjIyRCPPDD+71P+lhch2etbk1216zF+UKv4L41amFOKVugzioPMEkkGvZ
         i1nki19uWM6scybhXM8a7VuCVvi/1GybKS0n045Nbu3wYj7GPpe//vVnHIZj32APuPle
         EZno7WeU0oU6pEz+OnXE3NOEPQqfEQ9P3vyLJ6MPXzHCYzqXRpwK6a6YMQSsDVgVV14Q
         zHiDDVBulRRuD8UgxZBHfyCpFgo7AH+54EefYi7Vx8EVBB+rkvxPn+L/7Jx6NmPQPEED
         DRxw==
X-Forwarded-Encrypted: i=1; AJvYcCX8xHGac1/MCmEbPR7FmMdAkJw2jZkPk6siuict4bWzP68vvu2oxIdb5HZdMS9ozNvP+GXOx3VC/5Zy6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsOXUFLy47TAGH8zeIyTntpz4zEDVQg4E9BYOEap5b/7vrvt8
	wJ3DB/5T4qbccyrHTDKX+nfECluIHZMJsw6VAxcaOTWXjQkIlrNp/18TKo9aRLqNqVAqHcSCMVX
	QECZn9eSI2wFrVlSrwX9VslqbnD+Yn/vQbpAclSgU2A==
X-Gm-Gg: ASbGncviv0BIKWmAy3QGbdHaMkfWmUumK8hAzlEWNn56blyEpaqeBTlcnJB/f+nEsO+
	6JjHQdK13dY8MyU2zKr364XWSdBZtmv32+Kxt2P244ddA2NtvRG1mNmRCGgmmJW8HECR9dB5wdK
	i09Hrw7uYreRgvIfqcsEfOx6zVBVI8a8lSznMv5isWbZnaJNzpwr29ik8lO+xuGxuI0kBXDyyDY
	F7Kl4n6q4LkZ0HW8eK23todjOm5LF8Vmpd46RxwlWNbmvfA/enV+/1nzB1qeu9TwpiVUT1b+YOT
	eDG+9bVpnFTk8ZsmyLrW3psWhwjT
X-Google-Smtp-Source: AGHT+IGWILTS6oPGFrQH/MGVyUrrWPs3nCQPr0dpp8ewZBzqAmWrwo5Yb8lMpzMzOli4khsco1zsED59kJExCKjUvO0=
X-Received: by 2002:a17:902:db11:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-294cb502797mr2668265ad.8.1761583253609; Mon, 27 Oct 2025
 09:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027114950.129414-1-ming.lei@redhat.com> <20251027114950.129414-3-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 27 Oct 2025 09:40:41 -0700
X-Gm-Features: AWmQ_bk5nRt8laTUKakRe8D-8dQpYWt9adR8YjxbDf9b_9Rl7_rBg63MMClRJxw
Message-ID: <CADUfDZrvyuhyQ4RVJHiXrx-cge_pgg+fewicE4n7Bpvk0KxvYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ublk: implement NUMA-aware memory allocation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Implement NUMA-friendly memory allocation for ublk driver to improve
> performance on multi-socket systems.
>
> This commit includes the following changes:
>
> 1. Change __queues from char* to struct ublk_queue** pointer array
>    to enable per-queue NUMA-aware allocation. Update ublk_get_queue()
>    helper to use simple array indexing.
>
> 2. Add ublk_get_queue_numa_node() helper function to determine the
>    appropriate NUMA node for a queue by finding the first CPU mapped
>    to that queue via tag_set.map[HCTX_TYPE_DEFAULT].mq_map[] and
>    converting it to a NUMA node using cpu_to_node().
>
> 3. Allocate each queue structure on its local NUMA node using
>    kvzalloc_node() in ublk_init_queues().
>
> 4. Pass the calculated NUMA node from ublk_init_queues() to
>    ublk_init_queue() and allocate the I/O command buffer on the
>    same NUMA node using alloc_pages_node().
>
> 5. Update ublk_deinit_queues() to free each queue individually.
>
> This reduces memory access latency on multi-socket NUMA systems by
> ensuring each queue's data structures are local to the CPUs that
> access them.

This is great, thanks!

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 48 +++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2569566bf5e6..a3f596022b6d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -209,7 +209,7 @@ struct ublk_queue {
>  struct ublk_device {
>         struct gendisk          *ub_disk;
>
> -       char    *__queues;
> +       struct ublk_queue       **__queues;

This could be a tail array in struct ublk_device to avoid the
additional indirection?

Also, would it make sense to drop the "__" prefix now that this field
is used directly instead of only through the ublk_get_queue() helper?

>
>         unsigned int    queue_size;

Can be removed now?

>         struct ublksrv_ctrl_dev_info    dev_info;
> @@ -781,7 +781,7 @@ static noinline void ublk_put_device(struct ublk_devi=
ce *ub)
>  static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
>                 int qid)
>  {
> -       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size=
]);
> +       return dev->__queues[qid];
>  }
>
>  static inline bool ublk_rq_has_data(const struct request *rq)
> @@ -2678,11 +2678,11 @@ static void ublk_deinit_queue(struct ublk_device =
*ub, int q_id)
>                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
>  }
>
> -static int ublk_init_queue(struct ublk_device *ub, int q_id)
> +static int ublk_init_queue(struct ublk_device *ub, int q_id, int numa_no=
de)
>  {
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
>         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
> -       void *ptr;
> +       struct page *page;
>         int size;
>
>         spin_lock_init(&ubq->cancel_lock);
> @@ -2691,11 +2691,12 @@ static int ublk_init_queue(struct ublk_device *ub=
, int q_id)
>         ubq->q_depth =3D ub->dev_info.queue_depth;
>         size =3D ublk_queue_cmd_buf_size(ub);
>
> -       ptr =3D (void *) __get_free_pages(gfp_flags, get_order(size));
> -       if (!ptr)
> +       /* Allocate I/O command buffer on local NUMA node */
> +       page =3D alloc_pages_node(numa_node, gfp_flags, get_order(size));
> +       if (!page)
>                 return -ENOMEM;
>
> -       ubq->io_cmd_buf =3D ptr;
> +       ubq->io_cmd_buf =3D page_address(page);
>         ubq->dev =3D ub;
>         return 0;
>  }
> @@ -2708,11 +2709,26 @@ static void ublk_deinit_queues(struct ublk_device=
 *ub)
>         if (!ub->__queues)
>                 return;
>
> -       for (i =3D 0; i < nr_queues; i++)
> +       for (i =3D 0; i < nr_queues; i++) {
>                 ublk_deinit_queue(ub, i);
> +               kvfree(ub->__queues[i]);
> +       }
>         kvfree(ub->__queues);
>  }
>
> +static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
> +{
> +       unsigned int cpu;
> +
> +       /* Find first CPU mapped to this queue */
> +       for_each_possible_cpu(cpu) {
> +               if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[cpu] =3D=3D=
 q_id)
> +                       return cpu_to_node(cpu);
> +       }
> +
> +       return NUMA_NO_NODE;
> +}
> +
>  static int ublk_init_queues(struct ublk_device *ub)
>  {
>         int nr_queues =3D ub->dev_info.nr_hw_queues;
> @@ -2721,12 +2737,24 @@ static int ublk_init_queues(struct ublk_device *u=
b)
>         int i, ret =3D -ENOMEM;
>
>         ub->queue_size =3D ubq_size;
> -       ub->__queues =3D kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
> +       ub->__queues =3D kvcalloc(nr_queues, sizeof(struct ublk_queue *),
> +                               GFP_KERNEL);
>         if (!ub->__queues)
>                 return ret;
>
>         for (i =3D 0; i < nr_queues; i++) {
> -               if (ublk_init_queue(ub, i))
> +               int numa_node;
> +
> +               /* Determine NUMA node based on queue's CPU affinity */
> +               numa_node =3D ublk_get_queue_numa_node(ub, i);
> +
> +               /* Allocate this queue on its local NUMA node */
> +               ub->__queues[i] =3D kvzalloc_node(ubq_size, GFP_KERNEL,
> +                                               numa_node);
> +               if (!ub->__queues[i])
> +                       goto fail;

Feels like this might belong better in ublk_init_queue(), but up to you

Other than those minor comments,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +
> +               if (ublk_init_queue(ub, i, numa_node))
>                         goto fail;
>         }
>
> --
> 2.47.0
>
