Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3F221D8B
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829980; cv=none; b=SFddkalXNHFqLYsLCDb9X3eptzIxWqs4kX5gYuMe585OynsVbStnelRA3+60aXUpG0wmc7c+FRHRA8xM+pZ2hX+YhmPEZ4or4EiyU2y+CpXWmjK+Lv52yt/FwHsYNn//st6Izz+lOVB2Ihk9T6fU61xzNprse3pvHAw0YINJ660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829980; c=relaxed/simple;
	bh=51nkwLlT5jg0VROfv/tO2kx9Y2MHMUOAVbGk81PhBFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0lZW/qTpkcA67bqtpQ5yisbOl9gR+bU7Q8b2SR51a2013LkHNt74uYc7+q9084yv0mz7v4e+9j3QA1hXECDYemwbulbS4eov/nt79TgpF0JNWFJQ4AfVWtMZwC6IItRodV02MgOQYib0nxHDpZC3ZOqPTODuOl57HsbGOcjoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NtIOQshP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NtIOQshP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227e29b6c55so36985ad.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744829977; x=1745434777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT4C3mEaVrvFwtlJvm7OQIQmXZZGsey90MSNFFjJZxk=;
        b=NtIOQshPf2jpfpKxV8skjmhcgBUgRxibOo9J4Fz182kdGDSLpzx8cMlx2UF09Y5n9g
         XuekCo4ZYBqf7qJsJNewzQaZFEtz/UaG44g5o179HWKiCXAXVUuIJAmvuSwdT425FrTg
         bk5RhhT8TP8NtnHj5BweFkTJT0UfbV+d6x/w2aqTENfCzDmR10tnmDxJQ1ZP7RZKHftu
         3RS01WzKzYjbSLHRk9oeSyPLM5+xAQf8RgG0mguHIe99gIBX2t7U9oWsD5NOPEV1S3C5
         EC27zVIwAnqBdB4nZTpL9HGA2yBRYhTlNtYg2WjBEiwCeFnhJn37i7mIF1CjTIa3sz1R
         zHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829977; x=1745434777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT4C3mEaVrvFwtlJvm7OQIQmXZZGsey90MSNFFjJZxk=;
        b=MU/uRhCxgyNgoRQQLCTXQqmjElMcg9x5AZIkOcvtv1t6VkmJdrOfpyecfhMrePpWr6
         izJbna6xNTOhSl8zPTeKLx2W3HnfKJf64s8i4RCG1YKR7tC0vdlzX0FDKEwn02qlIyT7
         4NcjFi6TkC5IEvdDK4oVQOqYsYErx8bGEqMSw4UokO1WLGwYKhioKZvNYQrRbRgAZZrB
         xi4hDT9jQ4d4flX+EaHdH7bkDsps46WiTm7Hrc6v+TJOo5El8+hHU9R7NxQXhUVl9ncB
         eW9cnaQeC3AZ+ICqK9N9BTHEc3h4Gy9Pjb94vwv/09dkDG3H+Z7VJfvciZiAvKROuw/d
         Czeg==
X-Forwarded-Encrypted: i=1; AJvYcCUcTgFEl58zHCvoOk3dQunKqWrxxllC8XZVOjUgT7bdCXdBl+rezIfhfBkAN3yi/cnBwraiFFUWZ4+qtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTcX5Xu7u22mJ1pgZwadDA2ZtdzkyEgowo3jxElODrcqPjFQA
	4tF+N6W9lglXyiR1d2BRf63Ur1DsqjDwXeTitr+W+YllbwPO0O05pTEpVj/zPMIK3s3xgnRgoCK
	o9We1IMNZULVIu/rfLO7vQN6LWlw0eiB5vbe7JQ==
X-Gm-Gg: ASbGncssP7EYZhjanptwJkmzzy+UD/c2r95NMUKndLD9ceiCvOjes9DRWfcZf+vXuTt
	GmavaJ7D+4FTd381zdKOjTgXZbGWSWkHQ8cgy7fUJ5f/GZxZOdefNwqE8EkjSrohL3RzacO1GqG
	u+IDxhdlXHNMPpRw1qP3doLIy5
X-Google-Smtp-Source: AGHT+IGk1i3RkpdcJp3QcE02uCrxSyG+iRG8aDx/SDyY97zYpvoc3S3Pq0DahgOGXI3ck/al/159MwKjHUp37ZuCwVA=
X-Received: by 2002:a17:902:dac2:b0:223:5525:622f with SMTP id
 d9443c01a7336-22c3f998c6bmr4546015ad.1.1744829976980; Wed, 16 Apr 2025
 11:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com> <20250415-ublk_task_per_io-v4-2-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-2-54210b91a46f@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 11:59:25 -0700
X-Gm-Features: ATxdqUFipM7PBblC7CSB15RCGnyvrvx_I-8-TA50XPH4OOX9U_PLbzucYr3kHYM
Message-ID: <CADUfDZpkDUE8heSFEhA1aCfn3a59D1+=2piWPtRvX3t9FLgjbw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ublk: mark ublk_queue as const for ublk_commit_and_fetch
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
> marking ublk_queue pointers as const when handling COMMIT_AND_FETCH.
> Move the logic for this command into its own function
> ublk_commit_and_fetch. Also open code ublk_commit_completion in
> ublk_commit_and_fetch to reduce the number of parameters/avoid a
> redundant lookup.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------=
------
>  1 file changed, 43 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9a0d2547512fc8119460739230599d48d2c2a306..153f67d92248ad45bddd2437b=
1306bb23df7d1ae 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1518,30 +1518,6 @@ static int ublk_ch_mmap(struct file *filp, struct =
vm_area_struct *vma)
>         return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_=
prot);
>  }
>
> -static void ublk_commit_completion(struct ublk_device *ub,
> -               const struct ublksrv_io_cmd *ub_cmd)
> -{
> -       u32 qid =3D ub_cmd->q_id, tag =3D ub_cmd->tag;
> -       struct ublk_queue *ubq =3D ublk_get_queue(ub, qid);
> -       struct ublk_io *io =3D &ubq->ios[tag];
> -       struct request *req;
> -
> -       /* now this cmd slot is owned by nbd driver */
> -       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> -       io->res =3D ub_cmd->result;
> -
> -       /* find the io request and complete */
> -       req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> -       if (WARN_ON_ONCE(unlikely(!req)))
> -               return;
> -
> -       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -               req->__sector =3D ub_cmd->zone_append_lba;
> -
> -       if (likely(!blk_should_fake_timeout(req->q)))
> -               ublk_put_req_ref(ubq, req);
> -}
> -
>  /*
>   * Called from io task context via cancel fn, meantime quiesce ublk
>   * blk-mq queue, so we are called exclusively with blk-mq and io task
> @@ -1918,6 +1894,45 @@ static int ublk_unregister_io_buf(struct io_uring_=
cmd *cmd,
>         return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>
> +static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> +                                struct ublk_io *io, struct io_uring_cmd =
*cmd,
> +                                const struct ublksrv_io_cmd *ub_cmd,
> +                                struct request *req)
> +{
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;
> +
> +       if (ublk_need_map_io(ubq)) {
> +               /*
> +                * COMMIT_AND_FETCH_REQ has to provide IO buffer if
> +                * NEED GET DATA is not enabled or it is Read IO.
> +                */
> +               if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
> +                                       req_op(req) =3D=3D REQ_OP_READ))
> +                       return -EINVAL;
> +       } else if (req_op(req) !=3D REQ_OP_ZONE_APPEND && ub_cmd->addr) {
> +               /*
> +                * User copy requires addr to be unset when command is
> +                * not zone append
> +                */
> +               return -EINVAL;
> +       }
> +
> +       ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> +
> +       /* now this cmd slot is owned by ublk driver */
> +       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> +       io->res =3D ub_cmd->result;
> +
> +       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +               req->__sector =3D ub_cmd->zone_append_lba;
> +
> +       if (likely(!blk_should_fake_timeout(req->q)))
> +               ublk_put_req_ref(ubq, req);
> +
> +       return -EIOCBQUEUED;

I think it would be clearer to just return 0. __ublk_ch_uring_cmd()
already takes care of returning -EIOCBQUEUED in the successful case.
Aside from that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
