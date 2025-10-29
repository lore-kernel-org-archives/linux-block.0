Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050B34AB1C
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753628; cv=none; b=RuyrHlGi49lv14PL5HRanlv4CV9uPxbQjjeW1pMQTu6z+xWttR5syEo2TfMjIsfZ54quuwUXfiZ7DzERSSk/gN/n2A6v6SSgFmaSs97dbtkGSRTzhtPGpoauHR7Mq9PsswPftmzHykLoWYYu1rPS3QVzP5qv47xwOw+9u/swpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753628; c=relaxed/simple;
	bh=Fr7U5baYRN8HfbdSjE7ZI3OSi+lUhCiRsDDJhQiI/uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv+87PbeSM5JrZLI81x8o1P8mhgoTTv2Cn6gENQ6DvJZ8Wss83s1FDlTHzkHLcsdEHxD2jLdkr55TyehI0Lo7ColxYGRE1cRw4/VHiKaYSMUmSvBdkV5Ea5huIvtYkqMuEX/K45wUof3v7/rqSeW/Z9THMYmdMBCDKoY4nVwuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PpMlbWl/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PpMlbWl/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eca7297a7so8328125ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761753626; x=1762358426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3tYa5A7MyefjzRhEXSfNpMUwfO4ju4wXaq3vjxUkHo=;
        b=PpMlbWl/tZ+YsJjH3aG3qjve4f119fQjVjwOvzohZWydJkpJnkIayaZLh8Pul9IAeR
         SBEhI7xs6AaDnB6YP0xHvA+5PR+IQZav5/azCIeVsL6mKSvIM0oqg7adB8R4XsQ7K3lp
         kDA6lqq3+OYRWPO/ahgijX0FmV6ahvOmP8oroKpqEDfptw/nHc7y4j3HrB1H7d9uqZGE
         2TwPfD/4g9Im60mGecP6Vye5zaZBrC1UKDyfEyxEa19F4pkNiPVg/8bKZI+bZ9E3JS/9
         KlJ/5b/W/ZDYOZ4bRdwOSc5fh5tGBS22EX1EZ3E9uQbbiViuDCoYuUE8OjSxvmDv6rG7
         g9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753626; x=1762358426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3tYa5A7MyefjzRhEXSfNpMUwfO4ju4wXaq3vjxUkHo=;
        b=NWLlC8JGE1FCOzd7xwUiliI6E83jImQJ4zZ0ZgUMy1uw7PI0nO65OrGfksgNbKqSVk
         AGUllRr0gI4RLnArzlIT994jdBvKJ4Ht9m/VTH+DjtCDH3j5Yu7kQwEugpw5w2CRIYrI
         L7JYnuo+bVTfG/0ZCbLoO868zMrgVQGAso6I9L2v96i+/wIzG89LQP1OI/ib/OHMMb/F
         7yUqDG6hhw8T5LRCoYz7HMmqOEgpKoWWofpOFgEiMeWlPmvE19tLxKOblrTqyPnOJve5
         se/ig76Fz3DfZaEyZ/f63iD6j5IZvb3A6FtLjdpdJOEFsGo14tuBUJDdGvmzYlPgSTCZ
         5guw==
X-Forwarded-Encrypted: i=1; AJvYcCUezME2USCZw+Z5f6pgCm9O914Wnab6QSg7ZlvmsAPUbe7QsszRkcIyA4UMkqMFEY4szRU+pS7m8aXQlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycx7DTpf6K5cGJp15N08gqoEF2AhGc0ZGmXpUUAEAUT/lq5wlg
	qMrgVhwob+SWdJK++Qok9Hb9DqbYMBFJQuedJmMp1YsTdYAbpOibT4PjQrPEVL7aNmtbelQGFZW
	vsias2swHBRx+lIvcLGtcCVW3DWHnYqlkl9SWeg1rztFjq3zZApUgK6te2g==
X-Gm-Gg: ASbGnctpKXaz/lpGBp3HWSjvMX53kAULCg7EMFVHSTQgK2aTgygANHRVG9/KFPXEG0a
	+okrTHEmf+1rQwJ2kLr4IkX3GrJ2iut0Ww8zyIGAbKO06dGO57128/6867H1Kgh/ceG0pAfFXwm
	tNQ6Va8GQLnJr1LL5g+6iRroE1wU8jVgHjptVf8Kk+4P+DY32YJfw4+pb4Ui83uv+b8Wy+Znv6x
	IQaDumsn4NjE0uGUpyCDORiESMwgvu6ilXz9bJ4uhPDbWpWb/WFrrs4xPn7e0H5omLyvaLOvvp2
	pQAflCEXi55JzTssig==
X-Google-Smtp-Source: AGHT+IEoCRbEb52RtTy5icslCFqy278IzbjfHRANIbzt8mqyds2SX41wVt/1NyVR99WCRavejHBhvuXeWSeJvRjWL7I=
X-Received: by 2002:a17:903:2445:b0:257:3283:b859 with SMTP id
 d9443c01a7336-294deee3548mr18277985ad.9.1761753625487; Wed, 29 Oct 2025
 09:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029031035.258766-1-ming.lei@redhat.com> <20251029031035.258766-3-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 29 Oct 2025 09:00:12 -0700
X-Gm-Features: AWmQ_bmN7W1ZzrfnfgX5e28iMzDRDfX64ZaHKIVvQARSNuu_kYcPSPnhtgSJEVE
Message-ID: <CADUfDZpBhBO8cppa2phmhkaCSJW1Yzk1aLzoF4zH3Cgu+D9Pcg@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:11=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Implement NUMA-friendly memory allocation for ublk driver to improve
> performance on multi-socket systems.
>
> This commit includes the following changes:
>
> 1. Convert struct ublk_device to use a flexible array member for the
>    queues field instead of a separate pointer array allocation. This
>    eliminates one level of indirection and simplifies memory management.
>    The queues array is now allocated as part of struct ublk_device using
>    struct_size().

Technically it ends up being the same number of indirections as
before, since changing queues from a single allocation to an array of
separate allocations adds another indirection.

>
> 2. Rename __queues to queues, dropping the __ prefix since the field is
>    now accessed directly throughout the codebase rather than only through
>    the ublk_get_queue() helper.
>
> 3. Remove the queue_size field from struct ublk_device as it is no longer
>    needed.
>
> 4. Move queue allocation and deallocation into ublk_init_queue() and
>    ublk_deinit_queue() respectively, improving encapsulation. This
>    simplifies ublk_init_queues() and ublk_deinit_queues() to just
>    iterate and call the per-queue functions.
>
> 5. Add ublk_get_queue_numa_node() helper function to determine the
>    appropriate NUMA node for a queue by finding the first CPU mapped
>    to that queue via tag_set.map[HCTX_TYPE_DEFAULT].mq_map[] and
>    converting it to a NUMA node using cpu_to_node(). This function is
>    called internally by ublk_init_queue() to determine the allocation
>    node.
>
> 6. Allocate each queue structure on its local NUMA node using
>    kvzalloc_node() in ublk_init_queue().
>
> 7. Allocate the I/O command buffer on the same NUMA node using
>    alloc_pages_node().
>
> This reduces memory access latency on multi-socket NUMA systems by
> ensuring each queue's data structures are local to the CPUs that
> access them.
>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 84 +++++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2569566bf5e6..ed77b4527b33 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -209,9 +209,6 @@ struct ublk_queue {
>  struct ublk_device {
>         struct gendisk          *ub_disk;
>
> -       char    *__queues;
> -
> -       unsigned int    queue_size;
>         struct ublksrv_ctrl_dev_info    dev_info;
>
>         struct blk_mq_tag_set   tag_set;
> @@ -239,6 +236,8 @@ struct ublk_device {
>         bool canceling;
>         pid_t   ublksrv_tgid;
>         struct delayed_work     exit_work;
> +
> +       struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_que=
ues);
>  };
>
>  /* header of ublk_params */
> @@ -781,7 +780,7 @@ static noinline void ublk_put_device(struct ublk_devi=
ce *ub)
>  static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
>                 int qid)
>  {
> -       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size=
]);
> +       return dev->queues[qid];
>  }
>
>  static inline bool ublk_rq_has_data(const struct request *rq)
> @@ -2662,9 +2661,13 @@ static const struct file_operations ublk_ch_fops =
=3D {
>
>  static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
>  {
> -       int size =3D ublk_queue_cmd_buf_size(ub);
> -       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> -       int i;
> +       struct ublk_queue *ubq =3D ub->queues[q_id];
> +       int size, i;
> +
> +       if (!ubq)
> +               return;
> +
> +       size =3D ublk_queue_cmd_buf_size(ub);
>
>         for (i =3D 0; i < ubq->q_depth; i++) {
>                 struct ublk_io *io =3D &ubq->ios[i];
> @@ -2676,57 +2679,76 @@ static void ublk_deinit_queue(struct ublk_device =
*ub, int q_id)
>
>         if (ubq->io_cmd_buf)
>                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
> +
> +       kvfree(ubq);
> +       ub->queues[q_id] =3D NULL;
> +}
> +
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

I think you could avoid this quadratic lookup by using blk_mq_hw_ctx's
numa_node field. The initialization code would probably have to move
to ublk_init_hctx() in order to have access to the blk_mq_hw_ctx. But
may not be worth the effort just to save some time at ublk creation
time. What you have seems fine.

Best,
Caleb

> +
> +       return NUMA_NO_NODE;
>  }
>
>  static int ublk_init_queue(struct ublk_device *ub, int q_id)
>  {
> -       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> +       int depth =3D ub->dev_info.queue_depth;
> +       int ubq_size =3D sizeof(struct ublk_queue) + depth * sizeof(struc=
t ublk_io);
>         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
> -       void *ptr;
> +       struct ublk_queue *ubq;
> +       struct page *page;
> +       int numa_node;
>         int size;
>
> +       /* Determine NUMA node based on queue's CPU affinity */
> +       numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> +
> +       /* Allocate queue structure on local NUMA node */
> +       ubq =3D kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
> +       if (!ubq)
> +               return -ENOMEM;
> +
>         spin_lock_init(&ubq->cancel_lock);
>         ubq->flags =3D ub->dev_info.flags;
>         ubq->q_id =3D q_id;
> -       ubq->q_depth =3D ub->dev_info.queue_depth;
> +       ubq->q_depth =3D depth;
>         size =3D ublk_queue_cmd_buf_size(ub);
>
> -       ptr =3D (void *) __get_free_pages(gfp_flags, get_order(size));
> -       if (!ptr)
> +       /* Allocate I/O command buffer on local NUMA node */
> +       page =3D alloc_pages_node(numa_node, gfp_flags, get_order(size));
> +       if (!page) {
> +               kvfree(ubq);
>                 return -ENOMEM;
> +       }
> +       ubq->io_cmd_buf =3D page_address(page);
>
> -       ubq->io_cmd_buf =3D ptr;
> +       ub->queues[q_id] =3D ubq;
>         ubq->dev =3D ub;
>         return 0;
>  }
>
>  static void ublk_deinit_queues(struct ublk_device *ub)
>  {
> -       int nr_queues =3D ub->dev_info.nr_hw_queues;
>         int i;
>
> -       if (!ub->__queues)
> -               return;
> -
> -       for (i =3D 0; i < nr_queues; i++)
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++)
>                 ublk_deinit_queue(ub, i);
> -       kvfree(ub->__queues);
>  }
>
>  static int ublk_init_queues(struct ublk_device *ub)
>  {
> -       int nr_queues =3D ub->dev_info.nr_hw_queues;
> -       int depth =3D ub->dev_info.queue_depth;
> -       int ubq_size =3D sizeof(struct ublk_queue) + depth * sizeof(struc=
t ublk_io);
> -       int i, ret =3D -ENOMEM;
> +       int i, ret;
>
> -       ub->queue_size =3D ubq_size;
> -       ub->__queues =3D kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
> -       if (!ub->__queues)
> -               return ret;
> -
> -       for (i =3D 0; i < nr_queues; i++) {
> -               if (ublk_init_queue(ub, i))
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               ret =3D ublk_init_queue(ub, i);
> +               if (ret)
>                         goto fail;
>         }
>
> @@ -3128,7 +3150,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>                 goto out_unlock;
>
>         ret =3D -ENOMEM;
> -       ub =3D kzalloc(sizeof(*ub), GFP_KERNEL);
> +       ub =3D kzalloc(struct_size(ub, queues, info.nr_hw_queues), GFP_KE=
RNEL);
>         if (!ub)
>                 goto out_unlock;
>         mutex_init(&ub->mutex);
> --
> 2.47.0
>
