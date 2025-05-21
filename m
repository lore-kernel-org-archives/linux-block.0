Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D422173C
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855195; cv=none; b=eb+BNDXeOxE8dTs2dr7CSQS2CZOiTINEjETUxSkx1pUaIt2km+xC3/gHLxGkg6Wep+cp8tR5gMbykH9j6vOeThunPOYvnkqoh/24EjI2UgtKFMly1h3co1mKms/QLRmi3mD05t1gOZDjpiqB9+XwXIELNfCg7lEOMOHfv1mQ6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855195; c=relaxed/simple;
	bh=V4P6v1JqRC+f7XWVGOuxiZNIt4j9i7n2VtkG/XZmTpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxO/q5oka1Wo9oHrN4n7VBW83jsPTY53hpYM6T23xDF6JHDeKUEeAjc4ZeHuD0yWr/vhunOumWTKvWG5ZoWfi2v615vvIqScarFlmpoPgHvwrhsjBsO1JrUovcv6XzKwseSWP/9RbM+/5J3Vi6K97o31h0BrT14ZTCZLD3MtbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G+McaRjY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G+McaRjY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26ed340399so661000a12.2
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747855192; x=1748459992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBVpdbkDW3ct7PyReZW89EBjBI86YhEftfTXLrbIjdA=;
        b=G+McaRjYGiqt43FdItV0J79wa3aVFBNx2Iv2XRmPn78qOTU0NCqh/gtiPmkW3X/vv1
         iqlbKZmAhspSOdM+pQm9cLjYBe1P5W47ttBm5CCYgBZZqRdE/0nY3AT0Vf6gZPGRsL4z
         RcdwrPP/s0cDDkXerAAk4jUo/vj8V5HrUzwPknzFqR+6vD2hwGSOA4iL+qDK8cbVpio/
         o6kBqzDj1W94lBVbwhtm1STuyK9c/yp6+OJS+9t2i5OIUXI+ITRo3N5548/+oTJYDCsW
         2NDDdaLQCvbOQzF4OXMw9L+PxNxH1ow+jXYyNTu4Svuy9nvItro8xcD1rwZwoabhUPyi
         Ghuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747855192; x=1748459992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBVpdbkDW3ct7PyReZW89EBjBI86YhEftfTXLrbIjdA=;
        b=rvRuync0FJ63D8IqsBku5Qpg9D5zB+KsW3w5HJA0EvsfCjiTCpf24EZ6LQYhyXwifR
         qMw7lMZ/+lNAK3ZAmLQdu/d+O83wHyz5gCgs8AJ4J1DQHcG46mWJvcSssarrkCi7Ec4U
         fjf0sBlKyu0D5roury2hJ0sIFMYk/p/c/otlIXUGA81ZE2DkKkkuiXaqvx0ZSJIDmb/9
         Nlf4QUTiwfNDbKEHLXlGvNbQVFgWNsl1iWESWpp3/Xz1q7hTAKsgRJCOmv6evz6xpuGd
         rMwrsIoNGETm7f+AxoYFHVnOCIqyEOcvi7wvBAqQYSHNXeG8xDwcQQB/MhirhmGvX/wW
         3HdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4YhKoyJCvh6AzkOX8q3ob8mk1+zKUHjxYP3qjtJskIu1uAQqsIrbxRLMEQY7FO7elsAS822ZX+UjoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYe+1a05ghYZidYFJC0SIc83NmGJPr0qqDPF4238xw3DCggWm
	mHqqHc6MxNXAADvoY1X1sVPulT5QYl5OvLlnAow087rdvkprPYjjSsbHwooJqpGQsboVXtthM2F
	WEsalRQh/NzFZh1RLqLwJXMdigzievKLZ0QHY0bpTaO0i5gpO2G91UPA=
X-Gm-Gg: ASbGncuxoTsSG3vOUjGJmqEZnInb+P+uvSbDQ1sxwmyU2NCGH2oe8cQgVtPP2TmUVIf
	rYe2Zr51+ntdMVgC2y7DhET3ZaGcuvdYRVUu/6pBVz65eiT/aUdB9Gq45wIHzQpJdPbI4/wQvam
	DqgMuyw1dukyhtLd08WNpDt3r/WeZFq5w=
X-Google-Smtp-Source: AGHT+IHeSzL8NaUoui84uoaBxC8BOdS79eZHCQRKat76o98hQaH03Fy+YoagleByeIWVqtFTO/o4waHzL0s4GRfjQKU=
X-Received: by 2002:a17:903:3316:b0:231:e331:b7d0 with SMTP id
 d9443c01a7336-231e331bb9cmr87088265ad.10.1747855192126; Wed, 21 May 2025
 12:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521025502.71041-1-ming.lei@redhat.com> <20250521025502.71041-3-ming.lei@redhat.com>
In-Reply-To: <20250521025502.71041-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 12:19:39 -0700
X-Gm-Features: AX0GCFsVO3ZPXDJCZray4jREHZ4x_lTnHFK8P93SGPiT5swUc8QVmz_As3MTISo
Message-ID: <CADUfDZrymgBoEMUgrQEOAA81sti+SDJ3vsdLw6Ky7bJQa2HGCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: run auto buf unregisgering in same io_ring_ctx
 with register
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There's also a typo "unregisgering" in the commit message.

On Tue, May 20, 2025 at 7:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
> is unregistered in same `io_ring_ctx`, so check it explicitly.
>
> Meantime return the failure code if io_buffer_unregister_bvec() fails,
> then ublk server can handle the failure in consistent way.
>
> Also force to clear UBLK_IO_FLAG_AUTO_BUF_REG in ublk_io_release()
> because ublk_io_release() may be triggered not from handling
> UBLK_IO_COMMIT_AND_FETCH_REQ, and from releasing the `io_ring_ctx`
> for registering the buffer.
>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provid=
ed buf index via UBLK_F_AUTO_BUF_REG")
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 35 +++++++++++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h |  3 ++-
>  2 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index fcf568b89370..2af6422d6a89 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -84,6 +84,7 @@ struct ublk_rq_data {
>
>         /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
>         u16 buf_index;
> +       unsigned long buf_ctx_id;
>  };
>
>  struct ublk_uring_cmd_pdu {
> @@ -1192,6 +1193,11 @@ static void ublk_auto_buf_reg_fallback(struct requ=
est *req, struct ublk_io *io)
>         refcount_set(&data->ref, 1);
>  }
>
> +static unsigned long ublk_uring_cmd_ctx_id(struct io_uring_cmd *cmd)
> +{
> +       return (unsigned long)(cmd_to_io_kiocb(cmd)->ctx);
> +}
> +
>  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>                               unsigned int issue_flags)
>  {
> @@ -1211,6 +1217,8 @@ static bool ublk_auto_buf_reg(struct request *req, =
struct ublk_io *io,
>         }
>         /* one extra reference is dropped by ublk_io_release */
>         refcount_set(&data->ref, 2);
> +
> +       data->buf_ctx_id =3D ublk_uring_cmd_ctx_id(io->cmd);
>         /* store buffer index in request payload */
>         data->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> @@ -1994,6 +2002,21 @@ static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
> +
> +       /*
> +        * In case of UBLK_F_AUTO_BUF_REG, the `io_uring_ctx` for registe=
ring
> +        * this buffer may be released, so we reach here not from handlin=
g
> +        * `UBLK_IO_COMMIT_AND_FETCH_REQ`.
> +        *
> +        * Force to clear UBLK_IO_FLAG_AUTO_BUF_REG, so that ublk server
> +        * still may complete this IO request by issuing uring_cmd from
> +        * another `io_uring_ctx` in case that the `io_ring_ctx` for
> +        * registering the buffer is gone
> +        */
> +       if (ublk_support_auto_buf_reg(ubq) &&
> +                       (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG))
> +               io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>
>         ublk_put_req_ref(ubq, rq);
>  }
> @@ -2109,14 +2132,18 @@ static int ublk_commit_and_fetch(const struct ubl=
k_queue *ubq,
>         }
>
>         if (ublk_support_auto_buf_reg(ubq)) {
> +               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>                 int ret;
>
>                 if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> -                       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(re=
q);
>
> -                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
> -                                               data->buf_index,
> -                                               issue_flags));
> +                       if (data->buf_ctx_id !=3D ublk_uring_cmd_ctx_id(c=
md))
> +                               return -EBADF;
> +
> +                       ret =3D io_buffer_unregister_bvec(cmd, data->buf_=
index,
> +                                                       issue_flags);
> +                       if (ret)
> +                               return ret;
>                         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>                 }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index c4b9942697fc..3db604a3045e 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -226,7 +226,8 @@
>   *
>   * For using this feature:
>   *
> - * - ublk server has to create sparse buffer table
> + * - ublk server has to create sparse buffer table on the same `io_ring_=
ctx`
> + *   for issuing `UBLK_IO_FETCH_REQ` and `UBLK_IO_COMMIT_AND_FETCH_REQ`
>   *
>   * - ublk server passes auto buf register data via uring_cmd's sqe->addr=
,
>   *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
> --
> 2.47.0
>
