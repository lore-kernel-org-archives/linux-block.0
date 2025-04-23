Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CA7081C
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419467; cv=none; b=G41GO+PyiwOUiN/4aQtDn74XRk6dDyeVTPAxgl2ZniChhQDCQsja+fF2bBJwthrYjAmpiEvcavqO3+8PSVw0p9S5kG3LzogmC8mINa1WkRcLQT/LZXDYHsob962WEgl34Y+BDZFojMU4kG4vRClslm58BCLCh0/s0C4dSK5ELEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419467; c=relaxed/simple;
	bh=J2We6veHu4UqsqQOfp9MUi3s4ba4u1Q5GByEf/CE11M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRIwzE9jFi8zDAS5oYyNHavfRchrD+ehuh+THCw6bMEG1xeU55zMmgidCtQnavXp8eVm9z7ai07/JgWrP5XqlXN+bqX6io0EMU1R1w3/vrdNYdCxfbcGmqLzRyn7DDE3fX0WySmfu5TfTh7+xvpzufvQzpFrZ7vHAuIni3hWzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ajv9/eTW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ajv9/eTW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so813439a91.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745419465; x=1746024265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+ydMVkIV5J/T5u4PsxeGkTMKDJyszFFgWozvdfOHq0=;
        b=Ajv9/eTW0DcCgLsQQZ7oT3iHDFaSIOmEez18Q9Iar7oSubpYGxjYyaUWgCvLxZHTdh
         EmrcXtmhpgNDQNZBE/ODxRUY7stEwP1lwCyKXe3Qsu+CanOMwS4hWEqebnoHkH6sWwzJ
         b683r74LCYei4KveagQXkIdkeMzNIOT/hyrIsrsdgMEgXjX5s8z5jBuX9LHnAGx1h+Kh
         8bVCfXXTmB5EKIvjVxcIS92TaxkXbHohk9kFs9OKj5e8+DlpJvSvFLbWd9/txvY+3O0p
         GnO+nRzjVT3I1npNKVcWff94IUU76znU4/bzZaM543OKGYzb4/w/hYGp8h0LWhPdGuk7
         dLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419465; x=1746024265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+ydMVkIV5J/T5u4PsxeGkTMKDJyszFFgWozvdfOHq0=;
        b=l4eCTX9lO/P0EB/G9fYW52AxZjMiHc9dhFiyPRxuFJgpVNRpysOQC/WcCm/iZKvfJL
         MsVIAxheZ3vPnd2EpCgrMBnXJ1GmWWdAHjOsvtOQ7lKaUPjvg+pCiNaumdb4mMl2FAEb
         DXaYea6n34xIYYIaP2in0JF7NESBXys03Ji1dcfKPfRVK5NlhwGcnpmAlcDLIl2pzXmF
         2n1OsA6Gxhhfduaf5UiBvflzs8AZSLZ5aF4qt0apBpo55jZeT//FlLwXqssoQQA35bgW
         Z4tT2aGkzAAi4Kt69Ey2Xbo96HnzIiiYqLCGK8911/743welyP30Dmje23ptyc/jS1IG
         U0/g==
X-Forwarded-Encrypted: i=1; AJvYcCXptal+c31G6JMEx9Gp2ejoZ9RezHeljHK6PeBVk6qoJ/e++5Cz9nJNqdpKjfDweKgnyjH0FprYPWLRfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmS6Luixsc7/o1r9jeTnrz2OrbVOL9owZEnCqZyyKYtee0TOfA
	qUTGAsrs1cnWRLJEeyCz5gbwCAckraLZVa+nOt8rhKWEUQAL7L3SaKv1TPiIVn2nSsFdI5smnp0
	yz7jWQPpAxwEioHl7FGYjXWHFI/4bYBuTdW7cAw==
X-Gm-Gg: ASbGnctg79/9ltYv7ElUUPp8B934L9FJGrmVCkN3BN8LxsvBLhMML+nCYy1d7WMpWZC
	bKLUsNgCwUWa1bTLu7kMVe64VUgej5YAUK1NA+j+Qh5476T/0QSCx8MeNrO/VYTjarmmphQwOcd
	1klsDSjjglbm3OGwLVnfO1
X-Google-Smtp-Source: AGHT+IG7Hb/KQ9ed0bop1LqgZDL38BhBGOJoHzHZ7IdCjSNwx89+Y31Q36hu2fixLNe/nLx4Ac36dDUmdENrpB/D1o8=
X-Received: by 2002:a17:90b:1b50:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-309dee3ad27mr1665465a91.6.1745419464601; Wed, 23 Apr 2025
 07:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423092405.919195-1-ming.lei@redhat.com> <20250423092405.919195-2-ming.lei@redhat.com>
In-Reply-To: <20250423092405.919195-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 23 Apr 2025 07:44:12 -0700
X-Gm-Features: ATxdqUEMIAM2I_ZBPu_ev0MXjIA1zp7PWdoyj9OCotJ5PxSf7_-Q8R-z2vfbzYs
Message-ID: <CADUfDZrh6pO6rCXN-QbTY3EX+EyYFvRW96o0Lf_kuEBMQ8ysEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
	Ofer Oshri <ofer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 2:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> The in-tree code calls io_uring_cmd_complete_in_task() to schedule
> task_work for dispatching this request to handle
> UBLK_U_IO_NEED_GET_DATA.
>
> This ways is really not necessary because the current context is exactly
> the ublk queue context, so call ublk_dispatch_req() directly for handling
> UBLK_U_IO_NEED_GET_DATA.

Indeed, I was planning to make the same change!

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2de7b2bd409d..c4d4be4f6fbd 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1886,15 +1886,6 @@ static void ublk_mark_io_ready(struct ublk_device =
*ub, struct ublk_queue *ubq)
>         }
>  }
>
> -static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> -               int tag)
> -{
> -       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> -       struct request *req =3D blk_mq_tag_to_rq(ub->tag_set.tags[q_id], =
tag);
> -
> -       ublk_queue_cmd(ubq, req);
> -}

Looks like this will conflict with Uday's patch:
https://lore.kernel.org/linux-block/20250421-ublk_constify-v1-3-3371f9e9f73=
c@purestorage.com/
. Since that series already has reviews, I expect it will land first.

> -
>  static inline int ublk_check_cmd_op(u32 cmd_op)
>  {
>         u32 ioc_type =3D _IOC_TYPE(cmd_op);
> @@ -2103,8 +2094,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
>                         goto out;
>                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -               ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
> -               break;
> +               req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], =
tag);
> +               ublk_dispatch_req(ubq, req, issue_flags);

Maybe it would make sense to factor the UBLK_IO_NEED_GET_DATA handling
out of ublk_dispatch_req()? Then ublk_dispatch_req() (called only for
incoming ublk requests) could assume the UBLK_IO_FLAG_NEED_GET_DATA
flag is not yet set, and this path wouldn't need to pay the cost of
re-checking current !=3D ubq->ubq_daemon, ublk_need_get_data(ubq) &&
ublk_need_map_req(req), etc.

> +               return -EIOCBQUEUED;

It's probably possible to return the result here synchronously to
avoid the small overhead of io_uring_cmd_done(). That may be easier to
do if the UBLK_IO_NEED_GET_DATA path is separated from
ublk_dispatch_req().

Best,
Caleb
