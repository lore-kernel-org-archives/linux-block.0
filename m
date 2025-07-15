Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535A1DE892
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593940; cv=none; b=FnYnNEkOxlVwfWaWZRb8H0ZVauoiZgb5cbFhM0EcMC4t2KB1OWC10miCxEbzdi8BJ1xr3t9vGTNLuwIf3SIzZm8QOLfW/bpeZP8Q2r6WmsGfEHUQl0f/Rxw1t+E2rsQUmYWz84SbY+drCKb3POzrAaDwdUU5gzNlkLU9WYXHteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593940; c=relaxed/simple;
	bh=yOYvhAAOEXUwai4t9mtodhgxqIspj1Zdb0VJNIsFLOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Q3dg3U1zuu6iR5YyAhkmsXKINMoaydd68d2XlDj02bQr03awUOW79/GOfZ0U5Q3bbhMe+u+Cm4sbFHBb4iupovEAja/c58oPZ7Qtz8HePMdKiMW+ObStcm4/pCalOex4dfE29fW38vnoDRWrCfnybtKOT+R0kwQXbMMkLcOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I1MXLdAC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I1MXLdAC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234ae2bf851so8974685ad.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752593938; x=1753198738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ6EWpRe74y6YmZIxKq53KxF6TI4cvpY1NXlZ+hctxk=;
        b=I1MXLdAC4ond+SXT0RP+2wF0vd4TbTCVUoq0s8CqTmEXQc6z7/liy/jEXS/BsE0LyT
         oMIZp5Ac3Eh9fSYv7diRkL8kWZ53aeoVxxUCw42/9ek2V41hZXpoTWMi0BiNopIxVuW1
         hGGyfUn+7ODOiqL4/NnmrxHaS5jg+4BG3soRDEnw1cKE09QMHlHzFVbNq+5x1wwnqnPQ
         56wzVmnq2r4O9KrVTSBaWNS2IxJJQ0PtcSrYBQTTC4WBe6iOrMkHRT3unQCEBVv+wz7f
         TkDfdCID1sStzUDWIR7i6wYETC6RXmUi3Sc9b0GgYU5s7Wz9JJsgZ5D2Y6Cjel3bwFtB
         DkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593938; x=1753198738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ6EWpRe74y6YmZIxKq53KxF6TI4cvpY1NXlZ+hctxk=;
        b=JfM1O3a0/Rj331mAzqhJiUu7IE6f83G7+j/YSlTiW+vWjo/gc6IBlvEqXVpa9upVzX
         Kq5Df8E21EZK9Wzatv+Z7Tfcb2QpoWXM6OwSyvod3G84wzGtGc3bI88oluRowuavkd8U
         swUldPa1WkWi6cP21A1k/DE0oLnDEi7Hc5xd7MDp2vU2TAb7kU3PjKouTBp7J9A1FiY5
         4/x9h/dBqHnQHZGjmnVWpAwVCazWkOPnhM2KoBlCIfYyLta6dbvl4iZg8SgOo9FMd6tH
         JLRljl0JBy5oXUT1jTMt7eSwP3TtcBfY65WhN6RASsNPLjQ8GSt+KN/Pq6dinn99i7Nv
         J96A==
X-Forwarded-Encrypted: i=1; AJvYcCUbQLqGOL2QDWm8ZyAS3Uy8RbL9+vfwhmUVmPptTOTPF+InPQoczRTh4Gchor+vVMBtmG2Oa1qGHhHdiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyavvP6JP4r4qdL4pTVGe5v9O9hIy3kSummcHn4b6XEXiqXw4yv
	GjZt+sVSnjicxT2IQpUPp3NBKSWQHGZG/Jl88ndl6J/1MZ13anSer2kHwEo1/dd784Pj3w2jwNP
	qIH1NIobt3NmNXbCy+xQTOKPeiPzRrGML500Yz+tj5w==
X-Gm-Gg: ASbGncunwkWU+k0qCs3imoiOkgMvlqmX0Q9n6PO3xIS4kV4KKA5VykJBBN1Tnqk1+N0
	QehKU4P7UZ7qjxud9lwpQ2d28aqqW6DBQHtz6qJ6234yuuPVmAJjx/uQv/jq4fxhU61ERV7S0wa
	GZUBnlkdYX2xWyNcGO817R5JyhKsv4l+zgYjohh61qf07cXdLYOYvGRncWZlxSG8JkmCRX08iMn
	/UoDQ==
X-Google-Smtp-Source: AGHT+IFfIWJat9tKZNDeQcyCeAkSLyCw4zQISXTHNC6NxfaRSG3HNboWbkMZb7W5drgj4LiZEfPWJ9o8BcNj54tgJbg=
X-Received: by 2002:a17:90b:2543:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-31c94d4496fmr1348730a91.6.1752593937771; Tue, 15 Jul 2025
 08:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713143415.2857561-1-ming.lei@redhat.com> <20250713143415.2857561-10-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Jul 2025 11:38:46 -0400
X-Gm-Features: Ac12FXwtzfBCsIJB6JRNjwk8gQpI0Frd43txMKuw-F6_5zfvb7zC1psEiI-33fE
Message-ID: <CADUfDZpDU3twL8NRV7TojaoNcEkrkCx0bF8Q6K0N0XBqb9stgQ@mail.gmail.com>
Subject: Re: [PATCH V3 09/17] ublk: remove ublk_commit_and_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 10:35=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Remove ublk_commit_and_fetch() and open code request completion.
>
> Consolidate accesses to struct ublk_io in UBLK_IO_COMMIT_AND_FETCH_REQ. W=
hen
> the ublk_io daemon task restriction is relaxed in the future, ublk_io wil=
l
> need to be protected by a lock. Unregister the auto-registered buffer and
> complete the request last, as these don't need to happen under the lock.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1b22fd5f5610..252cae345b3a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -714,13 +714,12 @@ static inline void ublk_put_req_ref(struct ublk_io =
*io, struct request *req)
>                 __ublk_complete_rq(req);
>  }
>
> -static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *=
req)
> +static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *=
req)
>  {
>         unsigned sub_refs =3D UBLK_REFCOUNT_INIT - io->task_registered_bu=
ffers;
>
>         io->task_registered_buffers =3D 0;
> -       if (refcount_sub_and_test(sub_refs, &io->ref))
> -               __ublk_complete_rq(req);
> +       return refcount_sub_and_test(sub_refs, &io->ref);

I mentioned before that the struct request *req parameter can now be
removed from ublk_sub_req_ref() and ublk_need_complete_req().

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>  }
>
>  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> @@ -2243,21 +2242,13 @@ static int ublk_check_commit_and_fetch(const stru=
ct ublk_queue *ubq,
>         return 0;
>  }
>
> -static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
> -                                 struct ublk_io *io, struct io_uring_cmd=
 *cmd,
> -                                 struct request *req, unsigned int issue=
_flags,
> -                                 __u64 zone_append_lba, u16 buf_idx)
> +static bool ublk_need_complete_req(const struct ublk_queue *ubq,
> +                                  struct ublk_io *io,
> +                                  struct request *req)
>  {
> -       if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> -               io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> -
> -       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -               req->__sector =3D zone_append_lba;
> -
>         if (ublk_need_req_ref(ubq))
> -               ublk_sub_req_ref(io, req);
> -       else
> -               __ublk_complete_rq(req);
> +               return ublk_sub_req_ref(io, req);
> +       return true;
>  }
>
>  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io,
> @@ -2290,6 +2281,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         unsigned tag =3D ub_cmd->tag;
>         struct request *req;
>         int ret;
> +       bool compl;
>
>         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
>                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> @@ -2367,8 +2359,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>                 io->res =3D ub_cmd->result;
>                 req =3D ublk_fill_io_cmd(io, cmd);
>                 ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &b=
uf_idx);
> -               ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
> -                                     ub_cmd->zone_append_lba, buf_idx);
> +               compl =3D ublk_need_complete_req(ubq, io, req);
> +
> +               /* can't touch 'ublk_io' any more */
> +               if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> +                       io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
> +               if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +                       req->__sector =3D ub_cmd->zone_append_lba;
> +               if (compl)
> +                       __ublk_complete_rq(req);
> +
>                 if (ret)
>                         goto out;
>                 break;
> --
> 2.47.0
>
