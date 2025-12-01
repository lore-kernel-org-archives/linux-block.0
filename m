Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1912773D9
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626118; cv=none; b=V891u4njmDRxVjbvQshYcPB1xjOTiuvGhbOLSxZ3MkKUGKTC32ZoQOquFbaD8gC2o3sse3mhABS9H8HGinBMf7mWwJxVj2/MTHVGMxZFVyl5s4iEKtG9IbCRWwIEzbTRoTMZl1OV/mFuvkj8O37+acNWMPRL07jKhDkA4GvsJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626118; c=relaxed/simple;
	bh=NogvjGdxvUnv4VxpWOypj4wgWsOJCV9HGiSpdtLQ6qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epOjXmV5uGh2qKFHQ9I4J6DnVKaG9CqIFebMcR2TYs9yd2RefXUUsZ4mFXHuuSlFvjyc0vmDouqzA6VvfyQZhjTINNyEpZ6uz6jd4dtsUyPQH1rDzpZMHGIM7OKFW2HrHx9iWVSpHuxp/ffmSv39FuaZbPnn/XH8MWXQvI4Ceh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xyugk6M2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xyugk6M2"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7c9011d6039so347070b3a.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764626115; x=1765230915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epMNbb4ZJjNAxXGbG21OthNJNmZvmsqFGbfOtKvTivU=;
        b=Xyugk6M2tMFCksWcDdY7R92bMphVXEs89aKiUMGaHOqETBwBPSd8LINbOvHmXgnXRn
         0sNWLN7CnbygfEFaMNObgOSpnC/NfDWOlSvEq4NM0MXbJfAvwfxihYAHpVvyQUHLVKou
         IVkvxvlOckea4LS82tg9a1DpvPJzTXjEE2KiZc/zIAn1CH7WzZ2CplyAJQSColhVA1K6
         t86p4xMXxJFqexJNY5YcN5dxErW1bJTTqEUR/O1nS18BAEj+ds0aa3CTrZgj453x1u9G
         LKEemB0jgQ+7Yjt4azJVZIWIsCqFk2Xvb+1JRDw/zjVvo2ltH0XwGZAPhTKvA9EFuB+D
         E27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626115; x=1765230915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=epMNbb4ZJjNAxXGbG21OthNJNmZvmsqFGbfOtKvTivU=;
        b=tLAwZPw71NUR7mEbFBZ5xfwJ849H0W6NLU5bXMmQKU04ajZyCcc3FLxOzHhKbj4bCw
         842coDOQPwgiu1GXmPgG083/wIgl1GduizQaWPppYkhup4eNCDOfB1wo83gP3xpz5nW4
         K5mm/0bIrOntDglLgXLdmQct8iEx+sPnpG5a70zaW/nwdV1ewCE2xhvmbtX+mh/KwrAv
         Sm/a1sWWSmTdezVxaVnUYiNsY8kneOXJoG8j9YLiZB+BaFzr2CdYj+SFrNpaFOk/Cthp
         iEMQDsiUsSshIpcfbZYvIji3g1naSr44cwFBuY2PgnXzew3FXWY7WIjWYPu0SWt3oV3P
         Ft4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPhNUGrABILBvlTRAWxfzFf7thkqnZ4yn2yYCcIMowo0+c7K3gRzzhFIIq1HcXD67SnFj7dOYVR6DDEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjjBoySpe3VUU/l5qmBx0n6OOVKdbP+uS1KlSNDYEo5mCFXX2
	HQDgBTE6ERvtcPqb4XdmtS8CIrC0DbuYFxjpiuyQKRdPFzAsAXQYrA41g6OkhHXUuKwliYd5mhS
	TiBlzMy+czA0NBydNtErQyL8OtLxSFVevoUb3auGKuA==
X-Gm-Gg: ASbGncsB4Y8JpoKKfkxgJ/q/yDM4V3MWGM9PQYTJLXzdPIFRy0fg+hkIL9IKqGpttPn
	0IRcBY4BpIS2GnxqV92Y2it2cAlAgZNbxq5fCkVwMrSuYuHejIGU+YFwEMCi8X0SFnbyLfpGa1B
	imZzb1HKtq9GmhB8XmEZA2ldVbbquedxxkyO8TKH1ZbGy5Uw88Rra/6YCMHVFVuQiCCfnW91r/B
	GzAC4w2O6RsL9j2U/q5FJO73W+UvO70tQ3HABrGbqAeU1raiMp6f0WY+8cOR3lqFHFYRqU5
X-Google-Smtp-Source: AGHT+IE2SI04CXAtat8Fo9++vrjY9CSGoAhlmNs+yaXPKgDUB4dcdk7vYRzR5dlWbOUP8KnoRNJZoIjxNbaeEAeSLb4=
X-Received: by 2002:a05:7022:c8c:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11c9d709e67mr18649288c88.1.1764626114566; Mon, 01 Dec 2025
 13:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-19-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-19-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 13:55:02 -0800
X-Gm-Features: AWmQ_bk6ivBl3mWFC3jDlbhfi81i9Bq_aWXjX7GQHtiMKaXBkh0KiSoyIMEWFVM
Message-ID: <CADUfDZpR-vUvn73ke3bLfb6UMMzbROYd95Fgq4HvsBfP2kpoZg@mail.gmail.com>
Subject: Re: [PATCH V4 18/27] ublk: implement batch request completion via blk_mq_end_request_batch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Reduce overhead when completing multiple requests in batch I/O mode by
> accumulating them in an io_comp_batch structure and completing them
> together via blk_mq_end_request_batch(). This minimizes per-request
> completion overhead and improves performance for high IOPS workloads.
>
> The implementation adds an io_comp_batch pointer to struct ublk_io and
> initializes it in __ublk_fetch(). For batch I/O, the pointer is set to
> the batch structure in ublk_batch_commit_io(). The __ublk_complete_rq()
> function uses io->iob to call blk_mq_add_to_batch() for batch mode.
> After processing all batch I/Os, the completion callback is invoked in
> ublk_handle_batch_commit_cmd() to complete all accumulated requests
> efficiently.
>
> So far just covers direct completion. For deferred completion(zero copy,
> auto buffer reg), ublk_io_release() is often delayed in freeing buffer
> consumer io_uring request's code path, so this patch often doesn't work,
> also it is hard to pass the per-task 'struct io_comp_batch' for deferred
> completion.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 90cd1863bc83..a5606c7111a4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -130,6 +130,7 @@ struct ublk_batch_io_data {
>         struct io_uring_cmd *cmd;
>         struct ublk_batch_io header;
>         unsigned int issue_flags;
> +       struct io_comp_batch *iob;
>  };
>
>  /*
> @@ -642,7 +643,12 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk=
_queue *ubq,
>  #endif
>
>  static inline void __ublk_complete_rq(struct request *req, struct ublk_i=
o *io,
> -                                     bool need_map);
> +                                     bool need_map, struct io_comp_batch=
 *iob);
> +
> +static void ublk_complete_batch(struct io_comp_batch *iob)
> +{
> +       blk_mq_end_request_batch(iob);
> +}

Don't see the need for this function, just use blk_mq_end_request_batch ins=
tead?

Otherwise,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
>  static dev_t ublk_chr_devt;
>  static const struct class ublk_chr_class =3D {
> @@ -912,7 +918,7 @@ static inline void ublk_put_req_ref(struct ublk_io *i=
o, struct request *req)
>                 return;
>
>         /* ublk_need_map_io() and ublk_need_req_ref() are mutually exclus=
ive */
> -       __ublk_complete_rq(req, io, false);
> +       __ublk_complete_rq(req, io, false, NULL);
>  }
>
>  static inline bool ublk_sub_req_ref(struct ublk_io *io)
> @@ -1251,7 +1257,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_u=
ring_cmd_pdu(
>
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req, struct ublk_i=
o *io,
> -                                     bool need_map)
> +                                     bool need_map, struct io_comp_batch=
 *iob)
>  {
>         unsigned int unmapped_bytes;
>         blk_status_t res =3D BLK_STS_OK;
> @@ -1288,8 +1294,11 @@ static inline void __ublk_complete_rq(struct reque=
st *req, struct ublk_io *io,
>
>         if (blk_update_request(req, BLK_STS_OK, io->res))
>                 blk_mq_requeue_request(req, true);
> -       else if (likely(!blk_should_fake_timeout(req->q)))
> +       else if (likely(!blk_should_fake_timeout(req->q))) {
> +               if (blk_mq_add_to_batch(req, iob, false, ublk_complete_ba=
tch))
> +                       return;
>                 __blk_mq_end_request(req, BLK_STS_OK);
> +       }
>
>         return;
>  exit:
> @@ -2249,7 +2258,7 @@ static void __ublk_fail_req(struct ublk_device *ub,=
 struct ublk_io *io,
>                 blk_mq_requeue_request(req, false);
>         else {
>                 io->res =3D -EIO;
> -               __ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
> +               __ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NUL=
L);
>         }
>  }
>
> @@ -2986,7 +2995,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_=
cmd *cmd,
>                 if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                         req->__sector =3D addr;
>                 if (compl)
> -                       __ublk_complete_rq(req, io, ublk_dev_need_map_io(=
ub));
> +                       __ublk_complete_rq(req, io, ublk_dev_need_map_io(=
ub), NULL);
>
>                 if (ret)
>                         goto out;
> @@ -3321,11 +3330,11 @@ static int ublk_batch_commit_io(struct ublk_queue=
 *ubq,
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                 req->__sector =3D ublk_batch_zone_lba(uc, elem);
>         if (compl)
> -               __ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub=
));
> +               __ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub=
), data->iob);
>         return 0;
>  }
>
> -static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data =
*data)
> +static int ublk_handle_batch_commit_cmd(struct ublk_batch_io_data *data)
>  {
>         const struct ublk_batch_io *uc =3D &data->header;
>         struct io_uring_cmd *cmd =3D data->cmd;
> @@ -3334,10 +3343,15 @@ static int ublk_handle_batch_commit_cmd(const str=
uct ublk_batch_io_data *data)
>                 .total =3D uc->nr_elem * uc->elem_bytes,
>                 .elem_bytes =3D uc->elem_bytes,
>         };
> +       DEFINE_IO_COMP_BATCH(iob);
>         int ret;
>
> +       data->iob =3D &iob;
>         ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_commit_io);
>
> +       if (iob.complete)
> +               iob.complete(&iob);
> +
>         return iter.done =3D=3D 0 ? ret : iter.done;
>  }
>
> --
> 2.47.0
>
