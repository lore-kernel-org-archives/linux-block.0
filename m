Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AF18C31
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764521597; cv=none; b=n/o/gJHYNVHqaseHSCxtVkF4V49J+UfQDvT2vnEReVZeapZYd1Z5Spjcip2nrgqojajqLDkkAVSSJGjwqaTljclsMR/ygqamgQ5MRFclOlw81ANLwKgDhAKYfg7yTw1WUnF449UMZ52ipBC2uk6OdqCMLptZLrAzSUEcF5D2hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764521597; c=relaxed/simple;
	bh=o7YNeHl0FDEmtnizqz6uhekWQQwslcUZezkSJMqzpQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABdB93hH3ZxI0jgKpigBd3ugtJn6UMk47HfhhRKVvdQfK/6BBoxlvhFh2XYNz69XI3NCyE6qdVP/9pPA0/WpHrrOE6Rj8x8bF0KpI8Uez/Tfqxs1Fcy8Xz1UeCNI225pULW6Ry69yYT9nxTdVqyJr9pInxqHptOdYQ33lnzJoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Zy8kqPFg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Zy8kqPFg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295351ad2f5so7171465ad.3
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764521595; x=1765126395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK+SLDvv0m567JDHYyAB2fpS216BH7Up4WDwfUavnQM=;
        b=Zy8kqPFgfdgDYeYXH5zhiWxtSEHb6QqKpdiWx7sT18m6RlLzOVW3r2VLIzLFxUKNEL
         ph1eyZRvSBlnUkmQ9WztEAeW5yCn3OcmHnNuDy7I0k8GaH9LxstRmHE6HsooqtSjLrMH
         OeiLLwFtro16PQucK53Urg+Yh+t7442zGhAlljvaBnypHgxtvuBIKIFXCbfMdgvd7XlX
         z6fKrtu6hSPHXjEsoOmelVpjkOQv7r7tsEOVi0nLVCWywzUlqSGlWUet4Wl3jtGzIzwJ
         QsunzXZb3xSmSSKwVL2U6RRtIbHpClScShAMKCW+Nta4pepXwuWiyUHTJVUI1x0wz6Uf
         vqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764521595; x=1765126395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FK+SLDvv0m567JDHYyAB2fpS216BH7Up4WDwfUavnQM=;
        b=TODeFrdKhxK7sREvCrOvWCtGPhHl+ZUGsZb4AOMdH1lmwUiN5IY8axPRfObEnhchdF
         6F76QQPv6Rv5TDZQx3m3qz/1XC4EtB+h6nEJsGx7r/LQ4iJwl78t81KwwBlcyCb4hmVQ
         hvc9YNWOw5Kc3pnD6yyCWsRsKtfCCZoaaLffGJw8w+DIJ4Yt7wj84QwGC/t00YYn/NM6
         1QeYE8Veq6DsAMLqbLR99a/F720ijowOguGSljIScaAnrcAgfg4ybxw3G58zlyYKQRXw
         duTE/35E666c1d1E4XvzkJQA3fBUur0uisR3MJ+jCldQ6UOjqggv+EtwGxTu8DEJRjXw
         O0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWor2gmEbyS9QmMaPWQ9fRsBAJgbuzNYQlFzjETF1AMwOIyo7IPK/q8oZl7uX+vO2vRImFdIuBkhvNlnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFske216N+MUKHMrW2KyXU6SZyRprqqHqZvjcNuyamx/7X6vP
	oBO3v5lTmf23DZEQtCw2dXayMBcz1GUmE7BZLYhGAAR3pD9hMS30ljXts0JsB6EO0FgNwrY1ECr
	aa24YNRL0PtFQyajh6YZh+U/v9bu57aXwjsVHdwjmPQ==
X-Gm-Gg: ASbGncvXJNJt8Bz9gy+9jnpRm3TaCtgdzgezlfDGZKrX2J/i0ZJMptjtf3rGZ2M5ujC
	X1XGyT5PzaoUx+E8UUY2++ryuRrON6VTkZeDTGE4tBGYRtSpbD6YI+kfHfAC2fxBjXr8NfbXCIA
	LV+/sDPbZx+VPpUKx8FQVjcELzUAwxzz7dft9glV+lqScMpc6LUirkdbVrC4uey1tELAET352d9
	2/xMk8C3HNyETyzVos99h+J+/MsF2k34RBxExmsHt7AFhr4KEPIt2vuH7Wh/K7yM9FvrBfD
X-Google-Smtp-Source: AGHT+IFCGwN961BXH06DRBhWNZiELeWNl5swqMUlZYtsYp52E6ocyAf40B0euTNhiw+fkDDkPVM2Z+vpkebdo5y3ukk=
X-Received: by 2002:a05:7022:68a1:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c9f216eccmr22481064c88.0.1764521595074; Sun, 30 Nov 2025
 08:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-13-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-13-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 08:53:03 -0800
X-Gm-Features: AWmQ_bnR2Qmec1MDHC3ZrK8OvKjUuZ9Fmx9LScI0U-rXahwMFYdRF-ouQaHq9Vo
Message-ID: <CADUfDZrfo7RzNZ7hGxOwK9fTWrwA4JEunahZQPvfO3EXT=1cTQ@mail.gmail.com>
Subject: Re: [PATCH V4 12/27] ublk: add io events fifo structure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
> ---
>  drivers/block/ublk_drv.c | 65 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ea992366af5b..6ff284243630 100644
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
> @@ -217,6 +218,22 @@ struct ublk_queue {
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         spinlock_t              cancel_lock;
>         struct ublk_device *dev;
> +
> +       /*
> +        * Inflight ublk request tag is saved in this fifo
> +        *
> +        * There are multiple writer from ublk_queue_rq() or ublk_queue_r=
qs(),
> +        * so lock is required for storing request tag to fifo
> +        *
> +        * Make sure just one reader for fetching request from task work
> +        * function to ublk server, so no need to grab the lock in reader
> +        * side.

Can you clarify that this is only used for batch mode?

> +        */
> +       struct {
> +               DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> +               spinlock_t evts_lock;
> +       }____cacheline_aligned_in_smp;
> +
>         struct ublk_io ios[] __counted_by(q_depth);
>  };
>
> @@ -282,6 +299,32 @@ static inline void ublk_io_unlock(struct ublk_io *io=
)
>         spin_unlock(&io->lock);
>  }
>
> +/* Initialize the queue */

"queue" -> "events queue"? Otherwise, it sounds like it's referring to
struct ublk_queue.

> +static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int s=
ize,
> +                                   int numa_node)
> +{
> +       spin_lock_init(&q->evts_lock);
> +       return kfifo_alloc_node(&q->evts_fifo, size, GFP_KERNEL, numa_nod=
e);
> +}
> +
> +/* Check if queue is empty */
> +static inline bool ublk_io_evts_empty(const struct ublk_queue *q)
> +{
> +       return kfifo_is_empty(&q->evts_fifo);
> +}
> +
> +/* Check if queue is full */
> +static inline bool ublk_io_evts_full(const struct ublk_queue *q)

Function is unused?

> +{
> +       return kfifo_is_full(&q->evts_fifo);
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
> @@ -3038,6 +3081,9 @@ static void ublk_deinit_queue(struct ublk_device *u=
b, int q_id)
>         if (ubq->io_cmd_buf)
>                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
>
> +       if (ublk_dev_support_batch_io(ub))
> +               ublk_io_evts_deinit(ubq);
> +
>         kvfree(ubq);
>         ub->queues[q_id] =3D NULL;
>  }
> @@ -3062,7 +3108,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         struct ublk_queue *ubq;
>         struct page *page;
>         int numa_node;
> -       int size, i;
> +       int size, i, ret =3D -ENOMEM;
>
>         /* Determine NUMA node based on queue's CPU affinity */
>         numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> @@ -3081,18 +3127,27 @@ static int ublk_init_queue(struct ublk_device *ub=
, int q_id)
>
>         /* Allocate I/O command buffer on local NUMA node */
>         page =3D alloc_pages_node(numa_node, gfp_flags, get_order(size));
> -       if (!page) {
> -               kvfree(ubq);
> -               return -ENOMEM;
> -       }
> +       if (!page)
> +               goto fail_nomem;
>         ubq->io_cmd_buf =3D page_address(page);
>
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
> +       ublk_deinit_queue(ub, q_id);

This is a no-op since ub->queues[q_id] hasn't been assigned yet?

Best,
Caleb

> +fail_nomem:
> +       kvfree(ubq);
> +       return ret;
>  }
>
>  static void ublk_deinit_queues(struct ublk_device *ub)
> --
> 2.47.0
>
