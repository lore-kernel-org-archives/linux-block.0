Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136852BB1D
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764819535; cv=none; b=gzNBcgFjCWVDTVzdf66Tz8v+abeHrMWTIQnfKmYD2hdjScCDrSSTE7RR9AIX9uSTK15YpBqpqus9ESVlisKuClGsOomEpplsWkypFbeSJ4mfg5IK8bIZKaanYLkv3zjI7PAL+P2QzOg3p2aQhDnvMMeD0W2x1J1W4fXUGkrTsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764819535; c=relaxed/simple;
	bh=y63EgrthsoEgR1fmwQygDFqMOrhQf1CXA4UgiUusB7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhnfktkRbz45JvSKMWTOfKj+eImO1Z6LlDzZUSystBZ2dwv0AXN8yCaDgIanoNE6Nktks2r5LCPjyMW4alKroyrQCm3bZrH/XhMFySgdHVz2I0JjSHUigSx3gZK33GPVGFIGYZB0EGIww/dDZUsx1lGp1PACiILPbWVhDQC1Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DvT5B9MZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DvT5B9MZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297ec8a6418so634045ad.1
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 19:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764819533; x=1765424333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBNS1kw/I4HywQj0koMRIYIXFqM4qE3fKO6M9muFKhY=;
        b=DvT5B9MZxgPdhW5BLLoS4nrk9fadPdlj+yMVYLQ4fB2pepBEIKrMUk1XkGezIahRom
         QtZcfUeNlhVM7APcOf+GEEt2n5yO+FFhwpAi1FwOzP1PPFBfyEtqZevDI2GBDM6vnYLk
         1VrP1HtzAwsfSXiVwduhnHTSFtZsLFAu8Wy4qUrs1GhzrQ2sE9FiuxeDYxv0JvRXz5f1
         AumLTnrmIkpAKc1FZQ7XBgZKXN/KHh2bH9OFyejqQqUB6SZyixYufHdj+eBEiWXrAiZL
         FgHSCFhJcy/C12UsL6JedQ5Uq9kJGEAdgiwppBalPIjLY8hKYOIesQZ03HSisbn6O2Qf
         UZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764819533; x=1765424333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBNS1kw/I4HywQj0koMRIYIXFqM4qE3fKO6M9muFKhY=;
        b=ekEbSnLF28qhAObc3Lw/P2eDGsl8Ng1mGEV3ElxlXzuTWPm4d8UydD2UNzHLPeOPdG
         RwVJ6DecGm50Spqd1Rk1EZnPA0j1lnzSQNRoPwv3E0wzsCdSYd4PrRbUjzWqwblcIuqb
         EKqnda6pt7NNRpHh8b1DCjR/D/DNmHzGtbFvgQMWvA6jfG+HGKTYUkmdQTBnu0HxCpkr
         H4V81lMk99csMCrqHza69z9cuOHvzFpd3V9GLqPjGa6lPkbbnt7GYBGdSiEmifZ3uLdz
         naN3gWpBscVtoB1110ssD/US7AjXojqPJGsO3LkbcSX16tjsqeU4Ii8a+T9SUbVIGb3Y
         J5/w==
X-Forwarded-Encrypted: i=1; AJvYcCV57WeHdw3ABLRG+uiVQRpZMxZcE2LdfhFnVZvitgWmr9REGpJfJI+DXR4TBOPz7cA7ldwO/+Br2pm8Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjoasa3n47W9SRg5Keg7/LnUXb3HjACwLUp4RtTbdvckyUjwLD
	ee9RxRpxOUiE51mZwOVcm++CfZg58ugdb9ENF/nbl4HsQlbR2m/XingA/2tReSDvEHGRkYBEm0C
	MEQkhrX39s6fpJW7SaxvrVftyNGq8N6WaEgEG6vMXww==
X-Gm-Gg: ASbGnct0VIOvHL5Pb6Hb5JABotii56L4EMAQWBU5yVwEBYUwLm90n1uG7m8lLqb5XYk
	9G8RUvcfm5zdRVMF88qHZzHGZvdVHF4aQ0vS0Pn+Tobf60MDOSeiJZJpOnGC0vWZ3NMmsp0s9e2
	3Buu3rWTeba901PjEkOqehQmaCy6k/5nNFLt/3yO8o5XCGoNbduvQoBO5ShUwNJFIHfiMWNq9pc
	z3K+/CcANqkHe2jbOf5siT5SAZVyHTGaU12JV92tWc6jK2tyYDm9Wb7ygVcljjEnXDenepC7IRL
	DeZsmNg=
X-Google-Smtp-Source: AGHT+IF3O6MDfWWVj8SKeorQbw5E6KPiZVtET5A3FeX85GKDv6+4z1dLo5j9fCEajxa1JkOFwWjVCIBFTyw2A4U95cs=
X-Received: by 2002:a05:7022:252a:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-11df25cac52mr2864611c88.5.1764819533081; Wed, 03 Dec 2025
 19:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-8-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-8-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 3 Dec 2025 19:38:41 -0800
X-Gm-Features: AWmQ_bmfR9qfYYP4aF27HNq9iNDHy_47QipIG0_Cp1cI1LDDAcXgHEuv8W-ib9s
Message-ID: <CADUfDZpoOxTQOZmupjWJz5QKcK4OrqjKZAYHGVUCSwiBbfLF9g@mail.gmail.com>
Subject: Re: [PATCH V5 07/21] ublk: add batch I/O dispatch infrastructure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:20=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add infrastructure for delivering I/O commands to ublk server in batches,
> preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.
>
> Key components:
>
> - struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that will

ublk_batch_fcmd -> ublk_batch_fetch_cmd

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>   receive multiple I/O tags in a single operation, using io_uring's
>   multishot command for efficient ublk IO delivery.
>
> - ublk_batch_dispatch(): Batch version of ublk_dispatch_req() that:
>   * Pulls multiple request tags from the events FIFO (lock-free reader)
>   * Prepares each I/O for delivery (including auto buffer registration)
>   * Delivers tags to userspace via single uring_cmd notification
>   * Handles partial failures by restoring undelivered tags to FIFO
>
> The batch approach significantly reduces notification overhead by aggrega=
ting
> multiple I/O completions into single uring_cmd, while maintaining the sam=
e
> I/O processing semantics as individual operations.
>
> Error handling ensures system consistency: if buffer selection or CQE
> posting fails, undelivered tags are restored to the FIFO for retry,
> meantime IO state has to be restored.
>
> This runs in task work context, scheduled via io_uring_cmd_complete_in_ta=
sk()
> or called directly from ->uring_cmd(), enabling efficient batch processin=
g
> without blocking the I/O submission path.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 195 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 670233f0ec2a..05bf9786751f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -91,6 +91,12 @@
>          UBLK_BATCH_F_HAS_BUF_ADDR | \
>          UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
>
> +/* ublk batch fetch uring_cmd */
> +struct ublk_batch_fetch_cmd {
> +       struct io_uring_cmd *cmd;
> +       unsigned short buf_group;
> +};
> +
>  struct ublk_uring_cmd_pdu {
>         /*
>          * Store requests in same batch temporarily for queuing them to
> @@ -168,6 +174,9 @@ struct ublk_batch_io_data {
>   */
>  #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
>
> +/* used for UBLK_F_BATCH_IO only */
> +#define UBLK_BATCH_IO_UNUSED_TAG       ((unsigned short)-1)
> +
>  union ublk_io_buf {
>         __u64   addr;
>         struct ublk_auto_buf_reg auto_reg;
> @@ -612,6 +621,32 @@ static wait_queue_head_t ublk_idr_wq;      /* wait u=
ntil one idr is freed */
>  static DEFINE_MUTEX(ublk_ctl_mutex);
>
>
> +static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data =
*data,
> +                                       struct ublk_batch_fetch_cmd *fcmd=
,
> +                                       int res)
> +{
> +       io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> +       fcmd->cmd =3D NULL;
> +}
> +
> +static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
> +                                    struct io_br_sel *sel,
> +                                    unsigned int issue_flags)
> +{
> +       if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
> +               return -ENOBUFS;
> +       return 0;
> +}
> +
> +static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fetch_cmd *fcmd=
,
> +                                      void __user *buf, const u16 *tag_b=
uf,
> +                                      unsigned int len)
> +{
> +       if (copy_to_user(buf, tag_buf, len))
> +               return -EFAULT;
> +       return len;
> +}
> +
>  #define UBLK_MAX_UBLKS UBLK_MINORS
>
>  /*
> @@ -1374,6 +1409,166 @@ static void ublk_dispatch_req(struct ublk_queue *=
ubq,
>         }
>  }
>
> +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> +                                      const struct ublk_batch_io_data *d=
ata,
> +                                      unsigned short tag)
> +{
> +       struct ublk_device *ub =3D data->ub;
> +       struct ublk_io *io =3D &ubq->ios[tag];
> +       struct request *req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_=
id], tag);
> +       enum auto_buf_reg_res res =3D AUTO_BUF_REG_FALLBACK;
> +       struct io_uring_cmd *cmd =3D data->cmd;
> +
> +       if (!ublk_start_io(ubq, req, io))
> +               return false;
> +
> +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> +               res =3D __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> +                               data->issue_flags);
> +
> +               if (res =3D=3D AUTO_BUF_REG_FAIL)
> +                       return false;
> +       }
> +
> +       ublk_io_lock(io);
> +       ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> +       ublk_io_unlock(io);
> +
> +       return true;
> +}
> +
> +static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> +                                    const struct ublk_batch_io_data *dat=
a,
> +                                    unsigned short *tag_buf,
> +                                    unsigned int len)
> +{
> +       bool has_unused =3D false;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < len; i++) {
> +               unsigned short tag =3D tag_buf[i];
> +
> +               if (!__ublk_batch_prep_dispatch(ubq, data, tag)) {
> +                       tag_buf[i] =3D UBLK_BATCH_IO_UNUSED_TAG;
> +                       has_unused =3D true;
> +               }
> +       }
> +
> +       return has_unused;
> +}
> +
> +/*
> + * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
> + * Returns the new length after filtering.
> + */
> +static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
> +                                           unsigned int len)
> +{
> +       unsigned int i, j;
> +
> +       for (i =3D 0, j =3D 0; i < len; i++) {
> +               if (tag_buf[i] !=3D UBLK_BATCH_IO_UNUSED_TAG) {
> +                       if (i !=3D j)
> +                               tag_buf[j] =3D tag_buf[i];
> +                       j++;
> +               }
> +       }
> +
> +       return j;
> +}
> +
> +#define MAX_NR_TAG 128
> +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> +                                const struct ublk_batch_io_data *data,
> +                                struct ublk_batch_fetch_cmd *fcmd)
> +{
> +       const unsigned int tag_sz =3D sizeof(unsigned short);
> +       unsigned short tag_buf[MAX_NR_TAG];
> +       struct io_br_sel sel;
> +       size_t len =3D 0;
> +       bool needs_filter;
> +       int ret;
> +
> +       sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &l=
en,
> +                                        data->issue_flags);
> +       if (sel.val < 0)
> +               return sel.val;
> +       if (!sel.addr)
> +               return -ENOBUFS;
> +
> +       /* single reader needn't lock and sizeof(kfifo element) is 2 byte=
s */
> +       len =3D min(len, sizeof(tag_buf)) / tag_sz;
> +       len =3D kfifo_out(&ubq->evts_fifo, tag_buf, len);
> +
> +       needs_filter =3D ublk_batch_prep_dispatch(ubq, data, tag_buf, len=
);
> +       /* Filter out unused tags before posting to userspace */
> +       if (unlikely(needs_filter)) {
> +               int new_len =3D ublk_filter_unused_tags(tag_buf, len);
> +
> +               /* return actual length if all are failed or requeued */
> +               if (!new_len) {
> +                       /* release the selected buffer */
> +                       sel.val =3D 0;
> +                       WARN_ON_ONCE(!io_uring_mshot_cmd_post_cqe(fcmd->c=
md,
> +                                               &sel, data->issue_flags))=
;
> +                       return len;
> +               }
> +               len =3D new_len;
> +       }
> +
> +       sel.val =3D ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len =
* tag_sz);
> +       ret =3D ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
> +       if (unlikely(ret < 0)) {
> +               int i, res;
> +
> +               /*
> +                * Undo prep state for all IOs since userspace never rece=
ived them.
> +                * This restores IOs to pre-prepared state so they can be=
 cleanly
> +                * re-prepared when tags are pulled from FIFO again.
> +                */
> +               for (i =3D 0; i < len; i++) {
> +                       struct ublk_io *io =3D &ubq->ios[tag_buf[i]];
> +                       int index =3D -1;
> +
> +                       ublk_io_lock(io);
> +                       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> +                               index =3D io->buf.auto_reg.index;
> +                       io->flags &=3D ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK=
_IO_FLAG_AUTO_BUF_REG);
> +                       io->flags |=3D UBLK_IO_FLAG_ACTIVE;
> +                       ublk_io_unlock(io);
> +
> +                       if (index !=3D -1)
> +                               io_buffer_unregister_bvec(data->cmd, inde=
x,
> +                                               data->issue_flags);
> +               }
> +
> +               res =3D kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
> +                       tag_buf, len, &ubq->evts_lock);
> +
> +               pr_warn_ratelimited("%s: copy tags or post CQE failure, m=
ove back "
> +                               "tags(%d %zu) ret %d\n", __func__, res, l=
en,
> +                               ret);
> +       }
> +       return ret;
> +}
> +
> +static __maybe_unused void
> +ublk_batch_dispatch(struct ublk_queue *ubq,
> +                   const struct ublk_batch_io_data *data,
> +                   struct ublk_batch_fetch_cmd *fcmd)
> +{
> +       int ret =3D 0;
> +
> +       while (!ublk_io_evts_empty(ubq)) {
> +               ret =3D __ublk_batch_dispatch(ubq, data, fcmd);
> +               if (ret <=3D 0)
> +                       break;
> +       }
> +
> +       if (ret < 0)
> +               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> +}
> +
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
>                            unsigned int issue_flags)
>  {
> --
> 2.47.0
>
