Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108853E4C95
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916469; cv=pass; b=kOaD9KuKR6NUj7VGKEWKd4Dh0VZ+6KQBeG4wEqiOEvoroZadVILY2sJp1kME4UBOwdhmSTbUD/z5xTDaLpm7xTxJiAVP4BNztRH8CxT8FksPxwY2gHmXGIbY3tGY9nrKlnskPyGCX/nuIIyBaL0+hPhCNde1Q8EHxPQJ/mlqgUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916469; c=relaxed/simple;
	bh=0clKQYIOKoni7veBGH6WUx86f/jHz3tzgYwL1kSYCr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwE/AFO+RYst+QlJjihzCEbRCKxpi0glTy6G++MrMYAMTr2/Vk+M4lEEobVW8EYR3jnaS4HepI/mQt4spj5O6G/pZhfOE2Z5SfDvbVzd6Z8QeBm/YE25qjSOTbaMhlgp+3KZw1h83opPXmc8P54AFAT+fMUC2OcRwFqinGzrLGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WL0kh5NY; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WL0kh5NY"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbbf1e1058so676164a34.0
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 10:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777916467; cv=none;
        d=google.com; s=arc-20240605;
        b=HvO+0EZnYFg/HtErDpQVNj6CO7dSuy9dBC5BJ469Y5COyGHovu4ZTETXVOnn8eES1k
         YrmgMu0PilHvWabpQGnn4dVWKw9frnOBmPy6BdVM+SNxhH6OGEfPdBxOGy8XtgYl1JFW
         hp/STEgVja3de3SkEx1R2bTAPIR5AESpy+tWOix1ZHpMkXhbsfvNkHkaZHn9boZXXxMw
         e/YBvMxY50IH//GvECueXtW02vMi2DTFX7xrzHXzbCdtM6rycGM1BTlnoa1DdXw0rvER
         aXrPT2ILoGMTFwf0uLxFUn+Dkr9n0E6618klt0ZSTCJwSr34S9rEQEpgd7zduIILXlbo
         /Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vEu05cN6cisrNYgG7dGV7tiqc8ttSV8rFmY4ZAaFzaI=;
        fh=vu+NOfMmkqTL7zAejC5rcxVE2rbwBvDUFq6gCkIC5tg=;
        b=b5QXxktErqyhb5tmjq0tVNAtJZHy7CzGLDn4qrqOWRMNM2IniwmPncaateF0SDokVq
         4aUq/D6Tg5MaEZLCqo/BuydkZaNMco3HX68gdldw4YCTDBkHUUmQxrDn8BHHGX11vULY
         jgZZGeWO4ZUXx2ClDDqtoTofv3JgtNwGuHMsvxwOR+BSDNjphi9InTaBr86hWCZmo62N
         Qt0pO+OpAv+rkEaggYDLPRyZzitljpZhjQSwIoCeR+FZVmPMJQQxDI4MELf0GxIcwpmP
         MvC7M4/n6yzn+of28CdaYQNV6c128fzK1KIiv2jwJRrZsmKp/VAciJiwmRu6D9HoFeVb
         8w0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777916467; x=1778521267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEu05cN6cisrNYgG7dGV7tiqc8ttSV8rFmY4ZAaFzaI=;
        b=WL0kh5NY5dqBV2lB/KZoafDGsiUG8KEkp3RTESiUjWmcyM4YflIHpTHzl0lT6MBh1Y
         /9oU2oqBSThDL9HpXlBHVlPlaLnog6MeNBD9ZrC04OMZNWamDwiLcNrUpz0jTzE/124G
         JnXi8fGUuIo1rzO2YY+Smb/LbGwNq3BuG3+N2E7fVCfdumLcWhLDfguKqGyWexm8A/PE
         gbKhNP98wycK+hSKIURimeKBd1uetWv1+/s5y8y/i+hbJsnlj7beRvMWGnDHkuWoFzYd
         fSDK8bV9y1YrQSQRUx1NC1bCksQQjB/dokWCDqzGttyJ7uECYg/TuLmu3LjeiyOkDG0s
         V6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916467; x=1778521267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEu05cN6cisrNYgG7dGV7tiqc8ttSV8rFmY4ZAaFzaI=;
        b=TPl3RUUoXAZE9cYOj2YPSl5gFUwXbfRUkMwXVGIww0IRtTSMjCqNXQ3ShwY0xBjDTL
         l4YrlkrwAgc28sbRasT4zrHCY1UvvQLyYmcvtj2rtLN7atRj+3E+5rtMBqednC4bTVWI
         uOcrFwP25dcBy+XAAIQ5WMmzuD5WmOSAyac08zBJ0aD+RhwaMYUlnQ6SAPOBQRVef9Uu
         DmygPPgM/5t0gSDZ04ZqcCe1Asa6o9sHgkfwQMjVPXwUgyDD7SD6hNYgh2MDV3RZ8NIF
         Dmy+xa30V/Z2epTy5vk3MTIyH6OVX4NMlDloRNy4I3O3WkQVMi12HfblQHiKRmCDHjou
         jOzg==
X-Gm-Message-State: AOJu0YxF0/9AfTR7MKDp9o/S8YdIcg6Wbbg1dYoDhv7ST9WqCqqOnuyA
	EY9GD1aUD4dmWJmPLQ/6eSV15Gi6rkxvsgTsaxwpbF+BjtOOm033Q27Nbk+b6ObKUy3Z9dAa2YU
	h741dTlmmFWKxgYGFk6q7DaKDwClWhxlTAeIsOx/+cCeO8g4XLLovh5ze3Q==
X-Gm-Gg: AeBDieuMy6zGz7xtw/OicdRGlD1hc14AtzcecoevL+l8jMb8fZcqOBaY+b1khKDg00Y
	JofffytIM95fPHHhRXzCFCyS2jjeAKM9rphVbxIMs0ObHpoC/IEwhT/yJRDxTed/17qxubn8oD6
	+yixV7conPRncEqEn+MolgaUcIKCL68F0+ZkZT8VHlnDMcPjlOA91niC99c66bDrCFuBhDBy0DA
	UxZHwi4a9N6V9ixi1nXbxpGq5t3Lcr1z9LsSUgNMYzvBLzkJ1glAAvYGxFiPPjh/J+pJGCVsjL7
	2lvO4PkIoNSy9DCBTRs=
X-Received: by 2002:a05:6830:34a6:b0:7de:4260:944d with SMTP id
 46e09a7af769-7dee1471792mr5001640a34.7.1777916466725; Mon, 04 May 2026
 10:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14e454d3-8f27-459a-a515-8a2b70ac109d@kernel.dk>
In-Reply-To: <14e454d3-8f27-459a-a515-8a2b70ac109d@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 4 May 2026 10:40:55 -0700
X-Gm-Features: AVHnY4Iqsc1E6yII4LWr_weLRlKOUxOp8AhbPr3KelwtHdPfz6AV3pwsd-7ZRRM
Message-ID: <CADUfDZqw6P1a5Q55cEgAPbULxJatEXNL6UXyn=ftS_dqBBqq9A@mail.gmail.com>
Subject: Re: [PATCH] block: only read from sqe on initial invocation of blkdev_uring_cmd()
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:39=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> This passthrough helper currently only supports discards. Part of that
> command is the start and length, which is read from the SQE. It does
> so on every invocation, where it really should just make it stable
> on the first invocation. This avoids needing to copy the SQE upfront,
> as we only really need those two 8b values stored in our per-req
> payload.
>
> Cc: stable@vger.kernel.org # 6.17+
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index fc3be0549aa7..6aa02575e08d 100644
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
> +       if (issue_flags & IO_URING_F_INLINE) {

I don't think IO_URING_F_INLINE is guaranteed to be set on the first
issue? For example, a subsequent command in a linked chain, or one
that sets REQ_F_FORCE_ASYNC or REQ_F_IO_DRAIN will be issued
asynchronously originally. Could you check !(issue_flags &
IORING_URING_CMD_REISSUE) instead?

Best,
Caleb

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
>
