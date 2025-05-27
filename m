Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98727E7DE
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362438; cv=none; b=Sqkgs2QQU2X2LpbEVtEWYQLOrITDrzs4m4uJ4sUAQSyz/pqmDOJh+RmX8q6+YU+0u0w5KBdkqFzB5Oy5zvkxn5dGhYofL9oWUa5XMx2HFOZ224EKJF+hXV0M/DWHIdO1m8JtU5NwGH74oMGCUAfc8n9XIF+u16R39SgfpSIocI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362438; c=relaxed/simple;
	bh=CuxoMbLgPY+5y3NgfY8ymEHz4zM3Tojh9flBTQN0qKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBQtVbBPmYUkKJzqYi12uIZ+CQQcSeb1O++uxf+KmdY5hoQTlxrfDOsBMGj9kkMwC7Ck5IuXBppxJEUq3w/aV/KMQ4g5dqpeb0tbmyp6Hrnc15dDCcHbQz/Tt26Yk7pqCqnw8Z80lz82g693QRhlUDsVmntCDMrLXWKGndcDw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BmXR9Yaa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BmXR9Yaa"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-309f26c68b8so233302a91.2
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748362436; x=1748967236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYZKGJT8+zSeROfThZqwZUF3uf9i+TM3WHPwxDT7h9A=;
        b=BmXR9Yaa0E2J/+VQDT77FCzzIAW1nz06wErpDlOE1D1ZTwXv4Aaz+4vbjfgIMppMMw
         ZHrnkfiu+qQbq2+S8V6x+ZRgHecbeFTcMrxzA24zkvWBNkAVC09XtnAFLV37N30uKr9L
         zIMgQaNBOPVK28bxHk3OhJs7+XfWFbAvy8WzTXqxr2hEIDS12mUszfNP14SSPSFFfGkV
         T98SeJMkBhBCZzdA699TfWAlUUepSrD6Othk/Gwk4cjr1uOr0jAfE6KPruSrzBMJhdYq
         PIAKHq4uq4qQ1+G56CFYAeclyAyx0RiChnv2D2JIWuaSjIrsDQqRirtg5j1z7pR8ZKte
         4y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362436; x=1748967236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYZKGJT8+zSeROfThZqwZUF3uf9i+TM3WHPwxDT7h9A=;
        b=Q7d1DqD72XRla9P9wk5Y69qt8NRbFFzd4KNPB6OCwDMZ9O6mGwOzyt7AaRGpIWBmpM
         WfdX+XfSfZs0OB75lYBSotxPT0oUhx/pBbNXPNyIxlvswA/fLc/YPmWkvNkk2EE81rLL
         zMBtWFixuPfmuguyclYz7ETNtI38BxPRIbxokiCDpZmvnafIlzkuXPmlQT6tE1opS52D
         Io0jwsvr3xMCr3DuirYkjizDWoQoFwXBy/XwAC/Yox8jwiIfb8YPYMACwkH1o2p7qSqY
         ew/idV2KxQ0PmxgFbmk9H1ZeffTOg4CWw1wBr7Jno3fZP3uVqK8lCVWZ1uRwhyDVHxdd
         ebOA==
X-Forwarded-Encrypted: i=1; AJvYcCW2HYpQvK3LSD4r1Nkg4VJ2AimUMsK0XwCtwjo7kadCWcl9iD5AGwnuzf6sTs91rhD7cqYF9seNNSRnPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoELWkaJeKcPlBPz+ti7n0mz6PQE5ovJv8dzTaqWEFjEKkE2t
	WjpmRcR/EGNuUr2hlc0jrZ4kfgKpPPAIat17wIuCdimtCTd2E6OJBevI5lfKUq+CjVzI2MBTEFv
	aAofPMZABy4UeAbKTDFFz7EEV/zKQ8aulUqu5e89Hzg==
X-Gm-Gg: ASbGncs3X/fDE7wwHP9y9/tY1LDKT6vTfrOapyk82cMzB0q/00yEmS2Haq5uYTyWXyN
	FZc6fv6v9dk69TwYi5WNjElB74XmUderHNWU9BTPEjjGjSIOV/kuk37mw0Ki6fVnfnlxma8Fa2p
	NpF5+ERO70Z2ZpzSljCYI/xxjqKMMXOc4=
X-Google-Smtp-Source: AGHT+IEo0buBe9XmXmCeL0Z2Pe435pv3trZjWBdDK3HHNt5hLvTaD1Pni7wJn6yRXUVO2Q0/2HijkPGWFPI5vwIAGAw=
X-Received: by 2002:a17:90a:e7ce:b0:30a:2173:9f16 with SMTP id
 98e67ed59e1d1-3110f0bcf33mr8585953a91.1.1748362435756; Tue, 27 May 2025
 09:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527153405.837216-1-ming.lei@redhat.com>
In-Reply-To: <20250527153405.837216-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 27 May 2025 09:13:43 -0700
X-Gm-Features: AX0GCFuxXy0ar2zlZFWI3o-D5XvlWk2JNM92IczYqZtl5fCr1RffktyW-_6XVkE
Message-ID: <CADUfDZr92uBe1GhVBnVnxt22XCd=uVd-NLj0Kx-3NYmNriJA3A@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] loop: add file_start_write() and file_end_write()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> file_start_write() and file_end_write() should be added around ->write_it=
er().
>
> Recently we switch to ->write_iter() from vfs_iter_write(), and the
> implied fs_start_write() and fs_end_write() are lost.

Still referring to "fs_start_write()" and "fs_end_write()" here

>
> Also we never add them for dio code path, so add them back for covering
> both.
>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered=
 I/O")
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - fix commit log & patch title
>
>  drivers/block/loop.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b8ba7de08753..7eca957dc656 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -308,11 +308,14 @@ static void lo_complete_rq(struct request *rq)
>  static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  {
>         struct request *rq =3D blk_mq_rq_from_pdu(cmd);
> +       struct loop_device *lo =3D rq->q->queuedata;
>
>         if (!atomic_dec_and_test(&cmd->ref))
>                 return;
>         kfree(cmd->bvec);
>         cmd->bvec =3D NULL;
> +       if (req_op(rq) =3D=3D REQ_OP_WRITE)
> +               file_end_write(lo->lo_backing_file);
>         if (likely(!blk_should_fake_timeout(rq->q)))
>                 blk_mq_complete_request(rq);
>  }
> @@ -387,9 +390,10 @@ static int lo_rw_aio(struct loop_device *lo, struct =
loop_cmd *cmd,
>                 cmd->iocb.ki_flags =3D 0;
>         }
>
> -       if (rw =3D=3D ITER_SOURCE)
> +       if (rw =3D=3D ITER_SOURCE) {
> +               file_start_write(lo->lo_backing_file);
>                 ret =3D file->f_op->write_iter(&cmd->iocb, &iter);
> -       else
> +       } else
>                 ret =3D file->f_op->read_iter(&cmd->iocb, &iter);
>
>         lo_rw_aio_do_completion(cmd);
> --
> 2.47.0
>
