Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58B2253A7
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831577; cv=none; b=d6sKnXAQ9wDNIP5F9MwgBfzp+ZPR9NXSB+zorCD63g5XK75LDEzmxG32wnvdZVv7Cm/KoE8BGWjKIXEW5z+lCabM5TywEAQSTQo2mzD4bh5cLTmvO0hJVYyUII8SSrS8UBYNz43ryX1Sdn55CTFbKNrttE7cLTTpNjuIL7wscIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831577; c=relaxed/simple;
	bh=X7et3RrZILIPjEpiaMiFJbrNQbSEXNJ22QaebrjkSRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/clu3efD4yWGlXWKHShyoYHHwGVqftejAKyIFMDseGNvJ8hw3xN0I1Tt/dgKeByi429IuCP25dv+6xZSw0eRpiu9erl45ewEi/9ue4H29K7uY4OVCdLlycpv91Bt0ufDNyiUojHzQEfLxw5Ff7qAZqho/zRGQ6Ix5jI5c4nIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NLt0eJjx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NLt0eJjx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1248423a91.2
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744831575; x=1745436375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v136KPBUfeWctX821wpDfpEMmAQPlOwcQGqNHm98l1U=;
        b=NLt0eJjxnUDJGIAHToE/KqKi/UNcr4HEYUSSERKIJ9gYz4COiWidjnslmR/yPqeLlu
         17ilwaZH1KMfJqEbUKSD1TPDIz5WE0X7gAn8rxpFLESTOlc8M8WsZ90iItTBgbVxeEYh
         W7Q+pPGnMinY4u+0qjCQWlPjAg8bqbfYHXQBkS9VUhEqt5FhjH3w/LJijMRntvB7McrJ
         XIUE+H6YikwgdP/oHqsz87DlMsP5jy6wXWBfoU8Eq3KP+y1K6yaLwrVCL8BG/Hs88YOu
         YEvOQnSH9kashEu4tGrxpMx6KqBNSuBq3g8//4hgNx4+d5GD9Qcmuo7zkNsLdu4dDtz9
         dZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831575; x=1745436375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v136KPBUfeWctX821wpDfpEMmAQPlOwcQGqNHm98l1U=;
        b=Wonwq9HuyVGoN74dUqYSv/OmrsrcFOklHqIudz7F7M0St7mTOqUBnbZk4KmddjgtMj
         lLCf0Zvr1VyuT2CdpDQgcHozQbLbV9PY9q+2gyOovLrqaozmFO+r7txHMsRCojMBGhkH
         8Vh3l6uRNNkfjiJB4VPe/ROAup/oJ4TVVOBv1YGFN9bR3OFHbYl5pmVhARkWjE/Mtgv9
         3OTUCTO7tRcfUoUMZZdXsqW+oLVNKxLUTXSMDBacvDRXY6sdp8JYDbTy9br6BJGRQziO
         coAIEGVlGz6jxZzyGD4pWTFSOpfif54USP77Rj5CVLhPK0aHwKWIHlqNplgCRTq3sVC6
         3iDw==
X-Forwarded-Encrypted: i=1; AJvYcCUJa6m8HiLN3iXwETSFuykswIu9bmKOlsZ1cfDhgUkKoq69ZcSeeMJl250CfeL35dFlaV7MNIXqq02ODQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOs3zDwlUX6hrkoeNyl6sfhF9l8OnJ3usC1WfDwGTGlhszXF6
	sBaiLV6coPSbNimMXehcID6pFJgaB8S4M3AYsBvhpF0bZYtuX1Kg4qji9BTQJx4eQIdiP/nwvMI
	OGeIj63TKPdtD2B3gUH4XGkzNYT0EL0uW9Sgs674hcaCTVPhF2y4=
X-Gm-Gg: ASbGnculsChgU22wA94ICLzETG9DG4yMlrehNlkKM2dcxU8X5Gg9G6pziC2kHqpLNQN
	+iEBiznwxjU3Lu4UsZQBsF4FxjqjMtNF4AcFuK3ZnoylRWf7NKuts6JER9wSN4tvySGn6Sm+bhE
	qNsp+eLe2Bp50b7rduS46yOk+Q
X-Google-Smtp-Source: AGHT+IEWpOFikRcikSR7TvWbWA+aPXr313JDMQhrjxeK3Zc0LZNWEVrrWyvYR0BbI4Yf4OlY/YcAnvQcEYvrUMh+74w=
X-Received: by 2002:a17:90b:4f8e:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-3086efc52a8mr160501a91.4.1744831574096; Wed, 16 Apr 2025
 12:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com> <20250415-ublk_task_per_io-v4-4-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-4-54210b91a46f@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 12:26:02 -0700
X-Gm-Features: ATxdqUGIS_mLDbTNW2Vz3yO-3QvcHH9ZRF-p-XiKlf_8vMq6XRTjMbGkMql01ds
Message-ID: <CADUfDZosV8M3YOeJ90WK3R8o5OdMN1QKJyi1J-70hh3Vj+JiTA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ublk: mark ublk_queue as const for ublk_handle_need_get_data
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:00=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> We now allow multiple tasks to operate on I/Os belonging to the same
> queue concurrently. This means that any writes to ublk_queue in the I/O
> path are potential sources of data races. Try to prevent these by
> marking ublk_queue pointers as const in ublk_handle_need_get_data. Also
> move a bit more of the NEED_GET_DATA-specific logic into
> ublk_handle_need_get_data, to make the pattern in __ublk_ch_uring_cmd
> more uniform.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e2cb54895481aebaa91ab23ba05cf26a950a642f..c8ce9349ca280b8b16040a124=
2a62b895ee01b5d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1291,7 +1291,7 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd=
,
>         ublk_dispatch_req(ubq, pdu->req, issue_flags);
>  }
>
> -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> +static void ublk_queue_cmd(const struct ublk_queue *ubq, struct request =
*rq)
>  {
>         struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> @@ -1813,15 +1813,6 @@ static void ublk_mark_io_ready(struct ublk_device =
*ub, struct ublk_queue *ubq)
>         mutex_unlock(&ub->mutex);
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
> -
>  static inline int ublk_check_cmd_op(u32 cmd_op)
>  {
>         u32 ioc_type =3D _IOC_TYPE(cmd_op);
> @@ -1933,6 +1924,21 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>         return -EIOCBQUEUED;
>  }
>
> +static int ublk_handle_need_get_data(const struct ublk_queue *ubq,
> +                                    struct ublk_io *io,
> +                                    struct io_uring_cmd *cmd,
> +                                    const struct ublksrv_io_cmd *ub_cmd,
> +                                    struct request *req)

nit: I see this is matching the name of the opcode (I am not sure why
it has "need" in its name) and there is already a function named
"ublk_need_get_data". But maybe naming this function "ublk_get_data"
would be clearer?

> +{
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;
> +
> +       ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> +       ublk_queue_cmd(ubq, req);
> +
> +       return -EIOCBQUEUED;

Here too, I think a return value of 0 would be clearer.

Best,
Caleb
