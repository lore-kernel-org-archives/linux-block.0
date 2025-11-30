Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDE2BE625
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530668; cv=none; b=F18v8UaVmI8mY9iVr/DcRb4ASnrMkKP5rnYm8ddd6okTgw7kFjJxGnjzMB7V+de21HOLB/Tjtc4aQloAZDSXOMVvozgGQlMKMrmVNa4FrfTRlou0VuA2xDzHRLjf287byZrh3ZaXNAOylas7lOFd+wkWPsM5orVuj1YsG+ptpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530668; c=relaxed/simple;
	bh=W/IRE+mR/gP1/l68rQjofU0W/9RplVQh7ZC3aVcwvL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VovmBhfCJZcEiIEeXcC23S7m+k70CXxHRL1WXSvChSp6LniAfFBF5lyZIr07o4bjVYUUoxEdmCm/KbOdiY9CUHjhR5BV+JU5FID8nGFRq9hFq/oFyiJNLmAOuqOVeYhsgLPETmknBkCiBoiDskosLDivI6c/NMFN+XIeTiFeZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=E/lo2AKW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="E/lo2AKW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29806bd4776so5732595ad.0
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764530665; x=1765135465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fPGk1zfO5/kDQycKL4x7TGgYPMNkCUCZYITt3x4+As=;
        b=E/lo2AKWvdethqjGEi1F6l+uZKKFTVYz4uB4WaZj2h6OjbtDzdoW566k23KfJizfta
         ehPWwKMwEpPBicmM4LAshblP58Tfpr5n//+b+AIFB2IJVgXWISItvwdd7edA/eCN3f5U
         IBwkFL4Cx9b5YtUEYVxGz9eQEDbiBCtIVjeOotBNBYSJI07Sgae0NiydCRZq9//coJhf
         nNXLMR81KzNQqI0iiLjwsuG/RK+PllGJHSMXAC+FtVc7hJP46wMpLvccygjiwjJ19ErL
         zN/bg1L9Qw187h/7IhBlLjED3ol2gFXXEGjMy7zZk1zBymJs3Y2Dftp7iEpnD0Tek6lu
         PfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764530665; x=1765135465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0fPGk1zfO5/kDQycKL4x7TGgYPMNkCUCZYITt3x4+As=;
        b=bQ0yDCrwt40OlTEoCXou0JSl7ibs+CGtYXr7rbKRqLVCFgj8XIaFZ7fu1SWvLbGZng
         gWwywll2GaZWbLCruLd58wKAVjZTZ9+E/8Mi7s5MsSgaC09clgv10JC/i2lYuGKt8F33
         lEl7ZIhFhakhIjVUAlK9ndBGhC3DQOQJ1SBdS50J0j8WVgUacvYZnIY40bRcaLLlkT5u
         u19h7vmGOmNdsuGrJEEEcszuYq5ksdpgGdQIzTSzr7c0kxnHLYmeXxz8ob14GaGOpY9P
         jLF5zinyeOO/AHrkB5rlfdNWj1by0cTu0moeiZI6DLg9KcMc+VkgkFZ6clbx4+90TRqS
         AQIA==
X-Forwarded-Encrypted: i=1; AJvYcCV0pptvsGZJxXijNZwCAedRERkiBBcU8SGiV/4E0xtB7ebWa2BkuleWLXHjL/UcCKvazcJYMTx2qQTx3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWl08yJCD0eYTmmnJ3njgi+ZPlXespzsdL/4EG/JxneE/Ue6at
	UCmJFXdZR+4Yfe3qPVqXH0o1q5U/oV/PtfZ+3JbsUa6SujjfdZnVMTokFpdpEtHzZpn3eGOc2KF
	hyMmvlnBLEouhsLX3P4HHs3lvkwk2A+0Be4wMA4m4UIG3po7Yi7/S27PR3A==
X-Gm-Gg: ASbGnctfQJ2vM7AFgBKPg3+1BwI0/gU+mxAO02Qwh5+NJgPXjkA99iiVDeM1O1cW6TS
	aObxpz2KX0tPLPGm2nmkQruSGIi0Sc8of1nSp/IhvWi5Fcxt6XuyUR/Ug1NF/T/jIIkbqaam5Yu
	I/mHe0RIuZCIFhhtUEx+WS0dMd186A/XzU4YAB2Cdcn82BySXvqtmyMeAUW2fruHJFyIYt9aZ5u
	llJqJv8/p880qvX8K/WWIXdAWzQpcSoIioqPQwtjuJ4PvZYVDbJWmgBCUEhzUbhCNlVNRGW
X-Google-Smtp-Source: AGHT+IGdsC8uvnUb6saIWMBZ5JVGmJp2+eUcZLblD2kTPQkA7riedsUPTHF7KhmRtcQ1KGnO8vEJgd5er5FCL578OsY=
X-Received: by 2002:a05:7022:ea46:10b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11c9d70be14mr18842759c88.1.1764530664497; Sun, 30 Nov 2025
 11:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-14-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-14-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 11:24:12 -0800
X-Gm-Features: AWmQ_bkeFkwfs-Z3LofRSMEd5lM2SqCu6VqUqiQ82r1v1CDAsxQ2W5MmN8yO5YE
Message-ID: <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com>
Subject: Re: [PATCH V4 13/27] ublk: add batch I/O dispatch infrastructure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add infrastructure for delivering I/O commands to ublk server in batches,
> preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.
>
> Key components:
>
> - struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that will
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
>  drivers/block/ublk_drv.c | 189 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6ff284243630..cc9c92d97349 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -91,6 +91,12 @@
>          UBLK_BATCH_F_HAS_BUF_ADDR | \
>          UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
>
> +/* ublk batch fetch uring_cmd */
> +struct ublk_batch_fcmd {

I would prefer "fetch_cmd" instead of "fcmd" for clarity

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
> @@ -616,6 +625,32 @@ static wait_queue_head_t ublk_idr_wq;      /* wait u=
ntil one idr is freed */
>  static DEFINE_MUTEX(ublk_ctl_mutex);
>
>
> +static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data =
*data,
> +                                       struct ublk_batch_fcmd *fcmd,
> +                                       int res)
> +{
> +       io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> +       fcmd->cmd =3D NULL;
> +}
> +
> +static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> +                                    struct io_br_sel *sel,
> +                                    unsigned int issue_flags)
> +{
> +       if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
> +               return -ENOBUFS;
> +       return 0;
> +}
> +
> +static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fcmd *fcmd,
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
> @@ -1378,6 +1413,160 @@ static void ublk_dispatch_req(struct ublk_queue *=
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

This doesn't look correct for UBLK_F_NEED_GET_DATA. If that's not
supported in batch mode, then it should probably be disallowed when
creating a batch-mode ublk device. The ublk_need_get_data() check in
ublk_batch_commit_io_check() could also be dropped.

> +               return false;
> +
> +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> +               res =3D __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> +                               data->issue_flags);

__ublk_do_auto_buf_reg() reads io->buf.auto_reg. That seems racy
without holding the io spinlock.

> +
> +       if (res =3D=3D AUTO_BUF_REG_FAIL)
> +               return false;

Could be moved into the if (ublk_support_auto_buf_reg(ubq) &&
ublk_rq_has_data(req)) statement since it won't be true otherwise?

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
> +       int i;

unsigned?

> +
> +       for (i =3D 0; i < len; i +=3D 1) {

i++?

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
> +                                struct ublk_batch_fcmd *fcmd)
> +{
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
> +       len =3D min(len, sizeof(tag_buf)) / 2;

sizeof(unsigned short) instead of 2?

> +       len =3D kfifo_out(&ubq->evts_fifo, tag_buf, len);
> +
> +       needs_filter =3D ublk_batch_prep_dispatch(ubq, data, tag_buf, len=
);
> +       /* Filter out unused tags before posting to userspace */
> +       if (unlikely(needs_filter)) {
> +               int new_len =3D ublk_filter_unused_tags(tag_buf, len);
> +
> +               if (!new_len)
> +                       return len;

Is the purpose of this return value just to make ublk_batch_dispatch()
retry __ublk_batch_dispatch()? Otherwise, it seems like a strange
value to return.

Also, shouldn't this path release the selected buffer to avoid leaking it?

> +               len =3D new_len;
> +       }
> +
> +       sel.val =3D ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len =
* 2);

sizeof(unsigned short)?

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

This is missing the io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd)
check from ublk_handle_auto_buf_reg().

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
> +               pr_warn("%s: copy tags or post CQE failure, move back "
> +                               "tags(%d %zu) ret %d\n", __func__, res, l=
en,
> +                               ret);
> +       }
> +       return ret;
> +}
> +
> +static __maybe_unused int

The return value looks completely unused. Just return void instead?

Best,
Caleb

> +ublk_batch_dispatch(struct ublk_queue *ubq,
> +                   const struct ublk_batch_io_data *data,
> +                   struct ublk_batch_fcmd *fcmd)
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
> +
> +       return ret;
> +}
> +
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
>                            unsigned int issue_flags)
>  {
> --
> 2.47.0
>
