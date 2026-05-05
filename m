Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34D47DD67
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995146; cv=pass; b=ilKNnputyQMoAgshjMOyBWfVmfLJStcLCbVMRY4NcDG4dl9GV4WEk3SGddKCCjx/SXLQtMQqkftzf0M63u1EBVAigrtwfb7iygeoFXT9iE8IWaMyoaJNFnlk6CLQkdvL4dqZ2nwQHIMIL3xaH1dOPNxozBNRDbfOtuxjQq2kwDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995146; c=relaxed/simple;
	bh=r65TzzxtQTWgl0OpayDWw9kz8vb7+5rzgETYp+raU9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC1jevOFAY2yOl3BeYiLiSBJlmxj0+JLjpXMllVV5SXj8m+/CJNCIHltpefljt1SuOK9azw3TZ2PL/X4KSYsc9oKe0fmBgKz7hp61pmsRQJ7RdFJ45jWFzvDxeJY9qQutpm3DuT/RspI2g9Iebt6ZWgMAR+YPAH5L+OrDb55cII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bZfmYpnT; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bZfmYpnT"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69489e55b7aso260498eaf.0
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 08:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777995143; cv=none;
        d=google.com; s=arc-20240605;
        b=Y17llL5ZfVB2bC0EAprTKMs0dHS3PvhEdyOQss7ajgdLn/6q0CrGoVcUrPBMrMn/ig
         4SEv18pSA8343PSAsZ/PZc4p5jCHnw6vYaa+QIx73DsEbF5SIc8saI24t6b26SOzodsc
         y7DMyp+upTinW2NnN/45pzUmpeI1p7W0N99DOlAMkUeMON5ZnJp3OO0VfzKQsI3ohAzA
         96FfnSNRqIwgQsTvuzRY2jb6xXJgAGZV8fxZhs8RrCBj5CuOmHONesxT5SaxvcmwW8Mo
         B3n0lkMyfC8iaWXgNstsD/VSARX2r2pdXx4ahnsy8g62RjMiOV/CacoHQ86yWzCKqva0
         PJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZEGBvreH59D8jcxtF+D+iv0DZwjXYLS+XTuG8dQ1TA=;
        fh=vu+NOfMmkqTL7zAejC5rcxVE2rbwBvDUFq6gCkIC5tg=;
        b=dhWyQFY5Td4riEhDsDYaIeRc5F7PzhuMzsenpUULykyAL9VH9kXOyyCEcOB7SXjGS+
         F83zxqJ6IBuzz/ho6EAla+Gd+KNYH4MyyegQfnTnxbugJu0fJVpTk9Aqx9dhsPs4wUqt
         gx8qVy6grY9H7W9BxUCLvvIF15PYJ5JfZyU8duorwNoV4sJWYKP5DYAdrOKvQ+KVGMBA
         979D/QVGVPURjb35zJZJxVojZ04koCHs9YsdJlVhzZVD0k7b8IPqozIRzynTAU/Buobt
         pVyAGsjYjTRY7ajLxZ6NGi71hMgDGjADmPIxIXmrCOUnaubnN4j8P7yZAIUJwRSOyVlh
         VWhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777995143; x=1778599943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZEGBvreH59D8jcxtF+D+iv0DZwjXYLS+XTuG8dQ1TA=;
        b=bZfmYpnTB0fb6pvm1UmcMom69ukWaVUUWF7F7MZK7omgJvQLEh+7sq3J5zSUjKnnZp
         86szIvnQD/rcsLVn+Sc6xhQsKyWoQQznUW6HZlPSxLtkNroNYp9WI3aNK2++wEMQf/gv
         OUfviY8GCdFiYEEGyZRMDRZGdGbWBHRT4F/dmnR37qU3XxRt91wQYococoAss8Wl+8kH
         BC03/YzRrRY6pLqOg1z89NFvSCYCE3A3UZu/+LOXC6qj9zpvGMmVKiPpvT5hSjS4Y7c3
         t6njyIjihrFS7gkXJdx+ha9T5L8JYuWNlPRRMaVevh0+xHaeWhGgTGKeUZ7TsZjr5wq+
         nZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995143; x=1778599943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZEGBvreH59D8jcxtF+D+iv0DZwjXYLS+XTuG8dQ1TA=;
        b=GTHyb9mbfL2UR3MYHKvJh/yZur3Skrpwl6VJVJ2I4p+vU/RRTD9EJuK89yx/d83icK
         E6GAZ3nuLLFPbSa0ACCfdiX4zgg2KtIHy35xDhV3poccdOhZXLc6khvfpXJni80H6p7D
         0rl/elk+4L07cxw4PQhPWf/95ZuCtoF/Mr38UXtS3eunV8Y48IYEWdXa/UPTA3h2T0pv
         GSh5OFAl0NfBjIPR+CMGvkxSg5AfaUGcqs1GV/gYyHwppnk5yp5t+85OhBpn5dgLI5Yc
         JJzAw2m0QkFieNe2qzg4JqwmnyTcqR9rDte4RD7+GwfPmOIkYV2RmCSOkQW14RoN0lIe
         t95A==
X-Gm-Message-State: AOJu0Yx4ysCsjozXO+zx/e1Bmq+lQN371o5aO+gz45ytfPFUqlJDGXBe
	i1GgYPUVtZKJcH94yntVFEnEgimzn4aQuOWBJkJf9RkH6ZN5uYRl/Wu+60ipjfZp6kKRy97bOcE
	4sSyVksfjVrU1N44jxyR1azgVOo4Iya8+MMU+o+w8oxWe7pSy4CO13EMFyQ==
X-Gm-Gg: AeBDiet+Jn+vo4fL5RQhQHWQ9za34Wk6vfionrrqPupmBL6jmAHTjLkQXECZdJAVRJd
	NhLYabnhCzusnahdQ+LdGuns0OIRXfovtkAAxMfA+wMbao2QgSokzaKrLeLbgxqwVXj6QwKjKqW
	347Ekj3MzkXJoMaVlVrnROz/xU07OZRTqNzPvaSkC/Gy2aeAf++dDfJPgZGKTcQ94liWFny7dsE
	s/uuXBb1UK6QBt2NSMM1tu1Qj2bxBIdCvfeaeKWXLZ66thyPUwzoGBx+peDyMtlYL7AU1TPMTBG
	Q4jWZt6Dzh0VP5fErA==
X-Received: by 2002:a05:6820:8587:10b0:694:59c8:852 with SMTP id
 006d021491bc7-69697527a2bmr2757074eaf.0.1777995143274; Tue, 05 May 2026
 08:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
In-Reply-To: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 5 May 2026 08:32:10 -0700
X-Gm-Features: AVHnY4IfvDa3YQcNkbZhKXxNRDit-hGv9cIhkBBVWS-fYMvh4dYHdmVMVq6uWVA
Message-ID: <CADUfDZq11PnyH5Vh8VjUzsV9Mxq6=0poGw--umMxccfwXiz54g@mail.gmail.com>
Subject: Re: [PATCH v2] block: only read from sqe on initial invocation of blkdev_uring_cmd()
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 12:38=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> This passthrough helper currently only supports discards. Part of that
> command is the start and length, which is read from the SQE. It does
> so on every invocation, where it really should just make it stable
> on the first invocation. This avoids needing to copy the SQE upfront,
> as we only really need those two 8b values stored in our per-req
> payload.

Maybe I'm missing something, but how does this avoid the SQE copy?
Won't io_uring_cmd_sqe_copy() still copy the SQE if the command issue
is delayed by links/drain/forced async or if the initial issue returns
EAGAIN? The code change looks fine to me, but I'm not sure I
understand the motivation.

Best,
Caleb

>
> Cc: stable@vger.kernel.org # 6.17+
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> Changes since v1:
> - Use IORING_URING_CMD_REISSUE flag (Caleb)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index fc3be0549aa7..ab2c9ed79946 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -857,6 +857,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned =
cmd, unsigned long arg)
>  #endif
>
>  struct blk_iou_cmd {
> +       u64 start;
> +       u64 len;
>         int res;
>         bool nowait;
>  };
> @@ -946,23 +948,27 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsi=
gned int issue_flags)
>  {
>         struct block_device *bdev =3D I_BDEV(cmd->file->f_mapping->host);
>         struct blk_iou_cmd *bic =3D io_uring_cmd_to_pdu(cmd, struct blk_i=
ou_cmd);
> -       const struct io_uring_sqe *sqe =3D cmd->sqe;
>         u32 cmd_op =3D cmd->cmd_op;
> -       uint64_t start, len;
>
> -       if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
> -                    sqe->rw_flags || sqe->file_index))
> -               return -EINVAL;
> +       /* Read what we need from the SQE on the first issue */
> +       if (!(issue_flags & IORING_URING_CMD_REISSUE)) {
> +               const struct io_uring_sqe *sqe =3D cmd->sqe;
> +
> +               if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
> +                            sqe->rw_flags || sqe->file_index))
> +                       return -EINVAL;
> +
> +               bic->start =3D READ_ONCE(sqe->addr);
> +               bic->len =3D READ_ONCE(sqe->addr3);
> +       }
>
>         bic->res =3D 0;
>         bic->nowait =3D issue_flags & IO_URING_F_NONBLOCK;
>
> -       start =3D READ_ONCE(sqe->addr);
> -       len =3D READ_ONCE(sqe->addr3);
> -
>         switch (cmd_op) {
>         case BLOCK_URING_CMD_DISCARD:
> -               return blkdev_cmd_discard(cmd, bdev, start, len, bic->now=
ait);
> +               return blkdev_cmd_discard(cmd, bdev, bic->start, bic->len=
,
> +                                         bic->nowait);
>         }
>         return -EINVAL;
>  }
>
> --
> Jens Axboe
>
