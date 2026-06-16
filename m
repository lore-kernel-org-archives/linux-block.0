Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A49379EFC
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626409; cv=pass; b=XAbVXzK+ikCJSfm2g6YdW6kETdHh870tN9Fl6LVmKow2fvBbdHewL6vRgEwnXWd4FcHm7OP5ocBfozs1n6PFyO4Dneft84vwXEH8DBcIXg/vKOyrm6r2LGElc15NpKaYNmnpEMQ1zgR59fnJdnvZkTaY4l/O0+8dKfviAp5PYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626409; c=relaxed/simple;
	bh=INLYcZrV3QuKm75pdIMrIr8147xGwzc+6ZPdS9YmgG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbLKx3OFlx1EzRr4VA4VvvmDzYuJTSrCHC6DMjQh88zIrWS0JL4UaaPsdoTi0yJVd0nHUvJPOxANTtgcxNNVJHbpQcCWJ8onapkdpFLgCXbijbw+1UhKyYcNI9s0Yr2PsuMS9BVWsxRkJkp2+Ldb2PQ8KHit/J613sJFLVoXgeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WSuGBDIG; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WSuGBDIG"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-486db28a56fso200530b6e.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626407; cv=none;
        d=google.com; s=arc-20240605;
        b=FTWTY57muG60zdnr2HvOcKumnizDsjNAJm4duauI+xJVHvCBQyLYZh6ZSyWKy5RVv6
         bCj9P87hcycOSCn1EhOLgXU15uo05XbVuy/vMViE4lCKixHIfarmSjrsiJdHZlxeEjm/
         wo2DwA00UUqZqR8q44ehXobu9MGPyIUfdqH0ciPHEqnP3GhPCrb8B3jRNdZkEMs8iIHn
         8vg26IS6Ua4+Id4f77JwrWDKLJKhTnbGC/kg2pVUn+reOeSDAwBgxkoqgKGyJs1zA59R
         6SvMR8zJWvjh2oyHJjZwxAoW68HuApyNz+YqCnoBw00+ShZ+MSpwkV6BUyFY3WR+VfsI
         wNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsjBM/M91nacI6u8aYv890VROsaIrNXQpFwsgRJ3eTk=;
        fh=gLwGq7D95e/QlqytCWabczA8Xg3fb/GOxjJWAj9bH5M=;
        b=EDYeOVFYytECXogUCbD87Byktit9feEayrlROtMLD6dKrx3Rtf9jSgdlLiXQ20qoaq
         ep4EQvoCvWl3aQ2BOIlmZeNDzYyPQSVf3XR+06sPmYA248r6r8N1OyOoxZKS0mSuXGcA
         b7qJRCrP6dqwzj2Hfta0OYNcsLgXP9+hKWlEUZCI+5wgJGaU3l5XQayl+NXbpMOLE0Ft
         HlL1Xnu04/q33w55YmB6ipqaof4m3p6436bttqrkbBtH7RX5HJgIvvPRMAOksEZmzhOZ
         cAhG19bYnxaf16PJ+NDqNvsBlvqyRKHv4GpnL9tUs6t7N2212Xltujo7hqCZIU4ICxRu
         7w2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1781626407; x=1782231207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsjBM/M91nacI6u8aYv890VROsaIrNXQpFwsgRJ3eTk=;
        b=WSuGBDIGMU2NWQvvPiRJ3am6dseRkSg5s2mEWIBDkMLPD91X/mamCJAHlQ9rgE90HO
         J1r8c2QxOK5lKPzfYIPZXm54iISWsFPirFjBW/HZTgD0df1ZtSndHCwwVtFR7ryerUSr
         q9ZJ5wIdIo+YhTzJeMBo5O8iR/FW3KxQY7CVikyxT2mEMiqYSqbmdq+KgXZzbbeyIqGN
         WMOoqjA7LQbvBClsyWB3/zb+ubKo1PfwfnjxTslRit5HEokr+AFk0fV0WXfakT3P8tLu
         KdpDAjYtdhTt6n+0FxVxVSwqSM1xlRhFxO320LtB6I4NzZANXqigrZmZGjJLUXpXhGKB
         yYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626407; x=1782231207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hsjBM/M91nacI6u8aYv890VROsaIrNXQpFwsgRJ3eTk=;
        b=KrycxJQ+/hI05C4rggtRoa9udrEzD11A1eK4gROELNQVmnPeRBsZInDa3MAzkiostd
         z7VZmZY9QtQw928S1c/gb/I2GgOvW/bXhnTTDo9NYCeLhvpfEDds1XrB6SoEn+4bKl7x
         xsbnRUz9xkvYNkMrhAQwdkTusFU303bUeto3zImC50d2FnOpXtbc9eHTRKJQrz7c/lZU
         kWVy1T1IqIlmM0fD61hPe7OOU8wU/kGC9vZxhaDkDnMzAJ8/UT88IuJ1woQdOFu0Yami
         fpGpEKvX+gqAEXmESVKTsHQqvp8MqXj/nrzdcb3E88HyxOxzTMKiYbxkOEyTNuuKGtXB
         Odhg==
X-Forwarded-Encrypted: i=1; AFNElJ/PHYxkZvjD1+Kd6R3MB+RmYxLA6C8eHQI5Mf3oOSGikgV9QxiHtPDkral8rTYseHKPlgWvzQToAYIdcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUsvQpgTAuWDdGYgLcG+oS8nm6fhnOVzdAcUaw2Kbejx10Ael
	Eg1S0eD+5db3bbsykCII5LezWRr9BcwXdexpZE52GCp2iS0koPEF2fjtSSuifIOh9JuQAHXk7g5
	Jslj9J/TYO2wvZed8C5UhUxFr3K1bl4JeChowEwmuEg==
X-Gm-Gg: Acq92OFl3nOyiJrWe8IlGhcy5+ymvoc+yEptDwgnDwm7FQCamZIkP2UdfwvWimQ9YuE
	/TPl9Q9UOXV48FxspI6cNW2Cv/7RlixaUdatPH+Cnl7bw0acOIpYKukHLrNOIp08ZbRRnZi1pLs
	fFbiWK67CV/kT97fY25pHEs3T6RllPLqu0fWJuDGt5x/3btzAr9S9k0bZuiWpv0GBzBjDH83/q0
	S6oZjiSI0BesQ41UXjiJP1HJqy4jfd51D/8S6NRHWqfDTKWO6vGJNCKK56UrdeHEnTq6z7Qu2uK
	mxaEglw=
X-Received: by 2002:a05:6808:1795:b0:486:5409:d9e0 with SMTP id
 5614622812f47-489428d99c7mr143466b6e.1.1781626406840; Tue, 16 Jun 2026
 09:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155129.406057-1-yi1tang.yang@gmail.com>
In-Reply-To: <20260616155129.406057-1-yi1tang.yang@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 16 Jun 2026 09:13:15 -0700
X-Gm-Features: AVVi8CeMSeePXq3Hd2o-77wSjb_wDVZBrJQ8bdSsvoFcwkNZym21UNW7fLR_os4
Message-ID: <CADUfDZoqJamuQtODswV0ua8jS32euS_fpgsw8R1=bHYUmzZCZw@mail.gmail.com>
Subject: Re: [PATCH] block: fix IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd
To: Yitang Yang <yi1tang.yang@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:11=E2=80=AFAM Yitang Yang <yi1tang.yang@gmail.com=
> wrote:
>
> blkdev_uring_cmd() checks IORING_URING_CMD_REISSUE to determine whether
> this is the first issue. However, this flag lives in cmd->flags instead
> of issue_flags.
>
> Coincidentally, IO_URING_F_NONBLOCK shares bit 31 with
> IORING_URING_CMD_REISSUE. As a result, the SQE read was never performed,
> bic->len remained zero, and every BLOCK_URING_CMD_DISCARD failed with
> -EINVAL.
>
> Fix it by checking cmd->flags as intended.
>
> Fixes: 212ec34e4e72 ("block: only read from sqe on initial invocation of =
blkdev_uring_cmd")
> Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  block/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index ab2c9ed79946..3d4ea1537457 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -951,7 +951,7 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsign=
ed int issue_flags)
>         u32 cmd_op =3D cmd->cmd_op;
>
>         /* Read what we need from the SQE on the first issue */
> -       if (!(issue_flags & IORING_URING_CMD_REISSUE)) {
> +       if (!(cmd->flags & IORING_URING_CMD_REISSUE)) {
>                 const struct io_uring_sqe *sqe =3D cmd->sqe;
>
>                 if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
> --
> 2.43.0
>
>
