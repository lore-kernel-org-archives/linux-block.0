Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FF2DE710
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751510021; cv=none; b=Uo0vhME7Rh4dow4FgGQ4OSGp3jN2L6tB8sLmccmELDTL0LryBnjkGUa+t6Q7qd/JGce6plVsUiW2a69uDyd6y+Dy8Zbbdv0ow8D/PMqqCYSiCsWN9oSL1ATu7uBNp1845D6luxLqnzjxOczHuycdPBayRAf9eqAs7SGoJMWm+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751510021; c=relaxed/simple;
	bh=m7man3lPLg6/YVK5C/zQcjtDJTVMHedVgqxZoYdy7L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6PV87XqaKON+x4FdbdLZTNLs9lw4cw2M+/UENKpYLCySDz9TXtKpUJKRB4jo8uJEFJ6qRUveCEWBtsZ0ezJ4TaKXo7LmbtHr6yXbygti71iszdV8MRYMCrClWKCBFXk/D3hTT3I+kig5qWaGPLgCUC+3VjZpnFYnT0Ux/sZ4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EhiJ+Etp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EhiJ+Etp"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-312efc384fcso1018190a91.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751510018; x=1752114818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VraFNwm6Wz2P0NSaaWR1JWMSUmBi4F2SuZ6VekOG15M=;
        b=EhiJ+EtpmLF9la9MQDOZYAOdTr6iSm92sImrq+wM9ir7FGdsUKXrlRXjUkFfjd/bzy
         QicdZKMBaR440+48KJ2oAJRpiDsI+OAOZi0NfTnGj+nt+bkQPQiW5S18caR+2lvjqpnE
         Qm8H2lxDCVFjTJx5jUxchB1GbtSuB+gIlUspEUNMpcCFe8T4xVz3LB7vOxa/k69FN4t/
         jGn+wOb9l+ZISWJJxVpvtZA1KonWGSACkclM4XNwlb0bb1jl5HlBfyJ6HU33/7iec4tf
         xtbyZtzE7j+Yi/mpL2JHd6IFiJo+zE610MUb5guhQ79D478BARiwtizcIpMfqKuV9Q7Q
         lezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751510018; x=1752114818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VraFNwm6Wz2P0NSaaWR1JWMSUmBi4F2SuZ6VekOG15M=;
        b=CYCIHRpHug3jmW1WMb0yteCzPpnziUV2CvUfAyM09dvELMJ05lBzcI6QXFmGShw0J8
         K/mwyfRVI8V77tvGg3u+3Shjn0rOp0uYgdDIfQ4ITwgmE8YLTUfJ0/yeYxS/CVZBXYhs
         s8uAheUZ+NQn/qcB/2RVuYgrAUtu1UHSmncRKs+YLeCBActuuXUEtNCcLDOm9jnXB5Ac
         uvnHh2DSb2Ln2yoKtR6arlpi0XO4ds6j/yVplawUB6YM97e2RvcQ6Swt6olnhr1GJjht
         yR1rIyjrRrHYS5H53+kxkVH1VgnetMAk+2r8p6H1LXUMzY9oUBHuKC1RP+xCLnRXUtS9
         wtQA==
X-Forwarded-Encrypted: i=1; AJvYcCU2XXt845K2tTLPBRC4hsnSgpr4uDv9iICPZ7FiH5VHoPWRh3pe3dlb9NKAyJTYdhN0toKNUSIvoM2caQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDVeJEClRTtaZ8aIc3P5zLjc3IjUjOZLYQX7LsSJ+ne55CBqL
	ckkpTQxk64LXTU1I7W9lspLIi67QFXppjOGSlnDSe4DanObJgc0mTNHsXq4G3bk96CHjcsmdjuw
	KC+5maELJAlvSV5NngXQcDhWdQsb6fvF1v+6gca8CsA==
X-Gm-Gg: ASbGnctnXucoLHjr3ov7YWTn6MDGAvMECk8ARffcBuiY+AbJsVx7bOekl6iFJz1ls28
	Alyy060w4FJyPFSgyyLHVrB+953U9HE/+OGzJYfG8p5nYU/4bzdWAo+spjllRAauK0tkuuv+zbb
	hmipKMTRCw9mhSq4unRXXmEe36UdsjyWAVrBHe6Jn5oA==
X-Google-Smtp-Source: AGHT+IFAk+0TNMoK+8RtWCW2LVYjFJ9/WE4XTlOZzfecHv6yy59ZLxOIRRHPJI342qo68IKx6biYBj8qSQL065BlY7s=
X-Received: by 2002:a17:90b:2f0b:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31a90bdb55emr2624244a91.3.1751510017532; Wed, 02 Jul 2025
 19:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-5-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 2 Jul 2025 22:33:25 -0400
X-Gm-Features: Ac12FXzM8oDKkgtQZbge_rZnwPd8Ldid4yddjEKkM0uzMXduc916SaI3lpfWrvI
Message-ID: <CADUfDZq84Lt+xK+JYqdp5sGjp4c_7E1nb_sdfjMa0V2Qv+-prw@mail.gmail.com>
Subject: Re: [PATCH 04/16] ublk: avoid to pass `struct ublksrv_io_cmd *` to ublk_commit_and_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Refactor ublk_commit_and_fetch() in the following way for removing
> parameter of `struct ublksrv_io_cmd *`:
>
> - return `struct request *` from ublk_fill_io_cmd(), so that we can
> use request reference reliably in this way cause both request and
> io_uring_cmd reference share same storage
>
> - move ublk_fill_io_cmd() before calling into ublk_commit_and_fetch(),
> so that ublk_fill_io_cmd() could be run with per-io lock held for
> supporting command batch.
>
> - pass ->zone_append_lba to ublk_commit_and_fetch() directly
>
> The main motivation is to reproduce ublk_commit_and_fetch() for fetching
> io command batch with multishot uring_cmd.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2dc6962c804a..1780f9ce3a24 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1983,10 +1983,13 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
>         return 0;
>  }
>
> -static inline void ublk_fill_io_cmd(struct ublk_io *io,
> -               struct io_uring_cmd *cmd, unsigned long buf_addr,
> -               int result)
> +/* Once we return, `io->req` can't be used any more */
> +static inline struct request *
> +ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
> +                unsigned long buf_addr, int result)
>  {
> +       struct request *req =3D io->req;
> +
>         io->cmd =3D cmd;
>         io->flags |=3D UBLK_IO_FLAG_ACTIVE;
>         io->addr =3D buf_addr;
> @@ -1994,6 +1997,8 @@ static inline void ublk_fill_io_cmd(struct ublk_io =
*io,
>
>         /* now this cmd slot is owned by ublk driver */
>         io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> +
> +       return req;

This is nice symmetry with __ublk_prep_compl_io_cmd().

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>  }
>
>  static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
> @@ -2159,10 +2164,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_queue *ubq,
>         return ret;
>  }
>
> -static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> -                                struct ublk_io *io, struct io_uring_cmd =
*cmd,
> -                                const struct ublksrv_io_cmd *ub_cmd,
> -                                unsigned int issue_flags)
> +static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
> +                                      struct ublk_io *io, __u64 buf_addr=
)
>  {
>         struct request *req =3D io->req;
>
> @@ -2171,10 +2174,10 @@ static int ublk_commit_and_fetch(const struct ubl=
k_queue *ubq,
>                  * COMMIT_AND_FETCH_REQ has to provide IO buffer if
>                  * NEED GET DATA is not enabled or it is Read IO.
>                  */
> -               if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
> +               if (!buf_addr && (!ublk_need_get_data(ubq) ||
>                                         req_op(req) =3D=3D REQ_OP_READ))
>                         return -EINVAL;
> -       } else if (req_op(req) !=3D REQ_OP_ZONE_APPEND && ub_cmd->addr) {
> +       } else if (req_op(req) !=3D REQ_OP_ZONE_APPEND && buf_addr) {
>                 /*
>                  * User copy requires addr to be unset when command is
>                  * not zone append
> @@ -2182,6 +2185,14 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>                 return -EINVAL;
>         }
>
> +       return 0;
> +}
> +
> +static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> +                                struct ublk_io *io, struct io_uring_cmd =
*cmd,
> +                                struct request *req, unsigned int issue_=
flags,
> +                                __u64 zone_append_lba)
> +{
>         if (ublk_support_auto_buf_reg(ubq)) {
>                 int ret;
>
> @@ -2207,10 +2218,8 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>                         return ret;
>         }
>
> -       ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
> -
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -               req->__sector =3D ub_cmd->zone_append_lba;
> +               req->__sector =3D zone_append_lba;
>
>         if (ublk_need_req_ref(ubq))
>                 ublk_sub_req_ref(io, req);
> @@ -2316,7 +2325,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>                 return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->=
addr,
>                                                    issue_flags);
>         case UBLK_IO_COMMIT_AND_FETCH_REQ:
> -               ret =3D ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue=
_flags);
> +               ret =3D ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr=
);
> +               if (ret)
> +                       goto out;
> +               req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->r=
esult);
> +               ret =3D ublk_commit_and_fetch(ubq, io, cmd, req, issue_fl=
ags,
> +                                           ub_cmd->zone_append_lba);
>                 if (ret)
>                         goto out;
>                 break;
> @@ -2326,8 +2340,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                  * uring_cmd active first and prepare for handling new re=
queued
>                  * request
>                  */
> -               req =3D io->req;
> -               ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
> +               req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>                         return UBLK_IO_RES_OK;
> --
> 2.47.0
>
