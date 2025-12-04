Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533F30FF06
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764818211; cv=none; b=BkFuVcYCPxll4Km426D/mf6I50r14CBiZt7/gWGB/63k01yPca4Fo2JxlbW+/pT8cwwe/V/oK3w5FIUv5OB6FiAz8gtaCb5N6br7TZHd6K2v9k11Us9W/FAquTq0szZbd/Vvj3OqFhixLoc6vZ1S+ECetD1BwgwEkmAdRiPfSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764818211; c=relaxed/simple;
	bh=IHYSXpdTacB+eRYN7jRfloRznWY8dSuQ+NfPDbhIiTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inFy1Fsm4Kibsl1zOCCowWHalhTWiVOn/p4mrvSkW49fTk6DCmyT+5IxzArA281ibcCeUN7CvHulIrBeb6tU+7uGAcvVowKS/8hmXJ8lUwALXucGBmUW+nkC6bZwIcVAWyKXzc53xZIKu52ls56wmLlGB8ocu0AMh2exLoOjAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BvA+zBzr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BvA+zBzr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b90db89b09so54033b3a.0
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 19:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764818207; x=1765423007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+r2Dxf1xibFUIUn/dFkdTyeoUAAg84C6r8L9PUO4m0=;
        b=BvA+zBzrTAis5sHsiwVkYYMMK6grUmCAWjO57rX1HpmfQLhLQsvI8eR5mCAHfw9p3J
         K8DEpuI/D2XJsyZ3wyyOI0gP5BbekU1VlTqbToIWyOaxWIu7p4TvqEaTeXX6cLDbnE+v
         Fzu0h4Jer7wG7O65c5cjaoQVwo00XHeJtdJo6WE26/abd2WABt5ltSojJqZ8f97M/H+7
         5xkgsX10lQugeUd+omhEpB9An/TshW8eQw/apOwFDGoI/GKIOTRCNGAcTj8gvPR7YiN0
         9A25QWWQDQSNbQZaIrN6ksp1aeRix23ZOslz3Fe0IZTLDD+bs2fX6AQs189tjciG1MZx
         bDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764818207; x=1765423007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+r2Dxf1xibFUIUn/dFkdTyeoUAAg84C6r8L9PUO4m0=;
        b=jCWN8amBv8c4mIk0ispZRqng2R9Rz5w0NE339CPO81tU+sac+oV4zLjO0BzHknYV83
         DKtl2VB8hQXDkz56fIHA9xwmkrZWhuZOPgT14dIxU3AR4ideDnpGIpD61xwXeOTOZc5r
         158TKrBysx4cPb8leFjVdNVTSNMeETNGaVib81sPW9JSq8Hyte4IQe0MguwebliKFc5Q
         kv2fIoqLbVYaMwIEZuKNeEs5i8WPdhxQuh9HPvpFfShK48wOrKJ3iOe8svttwY1eyTgT
         /Eet6NbiIGf8zhGwNiRalMFG7k4oquf1qLg7BigcMxvZBSHfTx/lM1H26NeT1/L0leTr
         867g==
X-Forwarded-Encrypted: i=1; AJvYcCX1GaxH2qKhpYUJhT/3yo4HDqr3lsppkbo/Kq7+HuWIlbFUDP4fl5Z9n1i+llD3HD79AqAtDSgqvbYdSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HEEpw6hYWTuZQDl6NMI2mqgPfPxXCS9nJx6A0nNor4ZyFnVT
	g3pzbzageawqrBkEsWD33PodsDs6YlQyjxuhTQzLnWM3EefCsWLvreryxig4LiRH/tevjA/k9Wu
	hCYfjhGqUegZvFWEQbW7f4lToOYulLK/y/FzMkWdhVQ==
X-Gm-Gg: ASbGncuCcBtImkP2xmsvayjfr+1ReHCynemrlgnWN6i6EIpZ90+BKr4hnK9rMwjJ0oM
	4gZJ1B03BPYRt2eNQWFusYDzVeoox3luMfnwlrT/JK0V2SrQoGZAW4tnC6+mz0DNYuOq2ydd+Jf
	CkJb/VhiNfF2PwXIKFcP4YCKC2Ta6IAH1h+7cKEAx81hFKoKshcAmCBfVLeQUxtPrPc4io+34bs
	6XQjZBJQlZmT2TYhzhSpsNZHb0hBgkum2qf2C7OqzoV0TcT9J4Z52XC69Zl5sRytNE7PYuH
X-Google-Smtp-Source: AGHT+IFYYHyof16iI3CEpar5veG2Jj2ej/bB0kqylsZJYmb2j2rSxMM8RCE31Y3R06xnWYaGhipO9KTekNBDw7eYEkw=
X-Received: by 2002:a05:7022:3d0f:b0:119:e56b:46b9 with SMTP id
 a92af1059eb24-11df0cd2596mr2925698c88.3.1764818206825; Wed, 03 Dec 2025
 19:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-7-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-7-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 3 Dec 2025 19:16:35 -0800
X-Gm-Features: AWmQ_bm-wmMJoqvXtyIxOVVq_BkmHVtcmyM0eMA5wGXyZJIdfmjdRC5slwP2utw
Message-ID: <CADUfDZovPb3SZHHxK2FgSyQK7PQ4afjEqQt8dgRCiynS-v40nQ@mail.gmail.com>
Subject: Re: [PATCH V5 06/21] ublk: add io events fifo structure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:20=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add ublk io events fifo structure and prepare for supporting command
> batch, which will use io_uring multishot uring_cmd for fetching one
> batch of io commands each time.
>
> One nice feature of kfifo is to allow multiple producer vs single
> consumer. We just need lock the producer side, meantime the single
> consumer can be lockless.
>
> The producer is actually from ublk_queue_rq() or ublk_queue_rqs(), so
> lock contention can be eased by setting proper blk-mq nr_queues.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 69 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 5cc95e13295d..670233f0ec2a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -44,6 +44,7 @@
>  #include <linux/task_work.h>
>  #include <linux/namei.h>
>  #include <linux/kref.h>
> +#include <linux/kfifo.h>
>  #include <uapi/linux/ublk_cmd.h>
>
>  #define UBLK_MINORS            (1U << MINORBITS)
> @@ -217,6 +218,24 @@ struct ublk_queue {
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         spinlock_t              cancel_lock;
>         struct ublk_device *dev;
> +
> +       /*
> +        * For supporting UBLK_F_BATCH_IO only.
> +        *
> +        * Inflight ublk request tag is saved in this fifo
> +        *
> +        * There are multiple writer from ublk_queue_rq() or ublk_queue_r=
qs(),
> +        * so lock is required for storing request tag to fifo
> +        *
> +        * Make sure just one reader for fetching request from task work
> +        * function to ublk server, so no need to grab the lock in reader
> +        * side.
> +        */
> +       struct {
> +               DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> +               spinlock_t evts_lock;
> +       }____cacheline_aligned_in_smp;
> +
>         struct ublk_io ios[] __counted_by(q_depth);
>  };
>
> @@ -282,6 +301,26 @@ static inline void ublk_io_unlock(struct ublk_io *io=
)
>         spin_unlock(&io->lock);
>  }
>
> +/* Initialize the event queue */
> +static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int s=
ize,
> +                                   int numa_node)
> +{
> +       spin_lock_init(&q->evts_lock);
> +       return kfifo_alloc_node(&q->evts_fifo, size, GFP_KERNEL, numa_nod=
e);
> +}
> +
> +/* Check if event queue is empty */
> +static inline bool ublk_io_evts_empty(const struct ublk_queue *q)
> +{
> +       return kfifo_is_empty(&q->evts_fifo);
> +}
> +
> +static inline void ublk_io_evts_deinit(struct ublk_queue *q)
> +{
> +       WARN_ON_ONCE(!kfifo_is_empty(&q->evts_fifo));
> +       kfifo_free(&q->evts_fifo);
> +}
> +
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
>  {
> @@ -3003,14 +3042,10 @@ static const struct file_operations ublk_ch_batch=
_io_fops =3D {
>         .mmap =3D ublk_ch_mmap,
>  };
>
> -static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
> +static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queu=
e *ubq)
>  {
> -       struct ublk_queue *ubq =3D ub->queues[q_id];
>         int size, i;
>
> -       if (!ubq)
> -               return;
> -
>         size =3D ublk_queue_cmd_buf_size(ub);
>
>         for (i =3D 0; i < ubq->q_depth; i++) {
> @@ -3024,7 +3059,20 @@ static void ublk_deinit_queue(struct ublk_device *=
ub, int q_id)
>         if (ubq->io_cmd_buf)
>                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
>
> +       if (ublk_dev_support_batch_io(ub))
> +               ublk_io_evts_deinit(ubq);
> +
>         kvfree(ubq);
> +}
> +
> +static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
> +{
> +       struct ublk_queue *ubq =3D ub->queues[q_id];
> +
> +       if (!ubq)
> +               return;
> +
> +       __ublk_deinit_queue(ub, ubq);
>         ub->queues[q_id] =3D NULL;
>  }
>
> @@ -3048,7 +3096,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         struct ublk_queue *ubq;
>         struct page *page;
>         int numa_node;
> -       int size, i;
> +       int size, i, ret;
>
>         /* Determine NUMA node based on queue's CPU affinity */
>         numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> @@ -3076,9 +3124,18 @@ static int ublk_init_queue(struct ublk_device *ub,=
 int q_id)
>         for (i =3D 0; i < ubq->q_depth; i++)
>                 spin_lock_init(&ubq->ios[i].lock);
>
> +       if (ublk_dev_support_batch_io(ub)) {
> +               ret =3D ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
> +               if (ret)
> +                       goto fail;
> +       }
>         ub->queues[q_id] =3D ubq;
>         ubq->dev =3D ub;
> +
>         return 0;
> +fail:
> +       __ublk_deinit_queue(ub, ubq);
> +       return ret;
>  }
>
>  static void ublk_deinit_queues(struct ublk_device *ub)
> --
> 2.47.0
>
