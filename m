Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED3262A6
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423478; cv=pass; b=KpXicWPfpVWwlddAXl2hmUS+ZLZ7Khv5fFV/Qicv6LspR93YIuXL/sWmI5liKWrKMqgmrHT8V+qnmhzpN31jYNAxFP8ly8HL0eKYi0VAiYvsUKqJ+AtAtyrxnyMJaaAhZVU9ReUT1ErOAZM8TAPr2VulP2xN8t6h3LKbutBXkhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423478; c=relaxed/simple;
	bh=JqacWfAt0ZXZ69hE4OkTIVIFQV9cJx9Hva6On2owtTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3SbLiR3IKkDWDmtHHfL/AJTrI36PbgMCqGVipBrEroUXGoWqvlLIfYkEcxi0gas/aR9f0AbuTkP5gE0qlCUKykNTu9yvUlwROFGUUAJkIhmXop5i7t3ASJCgkY/SLfXGjwp3XMme9NIFLcvP0WbQgE7NQH04qpPc+HfzWv0EWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gXAhgWJq; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gXAhgWJq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7c9011d6039so148019b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 09:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766423476; cv=none;
        d=google.com; s=arc-20240605;
        b=iifZ53T9IGfgChC41ZWA5IThFxWEf1avszpAAoVIrw7VpCg9/DDI0MDWPIULJXV3BZ
         bSn48zpBREyY4njGhns1sL1LCxiA2N+owflQU6X+EphzlQrY7UOLVMTKQ2AVHSRVAk3J
         /8T+SkiHAuHvC/D253c+2c4pdk2NdUK+2kHYEOu4dP3i6OUr2I4uy0lAXB4W1zb1Zvz4
         aCm5s34n2zKmouJ94JS4izr2SVKiEgQS+uuoIkvA2VLmGvLKs2nJut6T8l/rewVntROh
         +j5z1ixVEhL0jTSRlv1vRtXlXBDmrKKiBWG7i9gFIKhQqQ7pNwG5oBC+v2cEbcvTodf/
         g+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        fh=6r2ABKtPxu5aSAF1q19YJsDSjzrGTdSW8J4n9RdzN08=;
        b=WpQ0fBK1ea4Oe5BcelT/BiqOd+f282NhnYCE2S80iSIg/qA/UwQLs+zTc3MfD2HIVh
         waKImNHQ0gwgxok5S94eMOpPbSAY6AfwLqPsMds8kWSNkxGeL76RSnSxWF1mK2Yzd83U
         yPbSE0NMA+DnEDT5swU/C9MADkr4xq4V1H76t1xD3Dc9bDhukwPEquEcfjptqvprpVf+
         F96PWhAqrVBIxmpPZ+JUn7rAm6t7NwxH55Dq6Lk55VfNU1/YDv/MvMqxvB8gyVLGFb5q
         bUtve7DSG5wKAHwShbVMKDsR8NCAHDKCTUR4Ke3HECDzJsoLO6Rb3xf9uNcOSzqbG9Gp
         X/uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766423476; x=1767028276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        b=gXAhgWJqu+hgR4ekHjrujxpRlBeI68PVwRESwXvkBuPyt+HOOuqT7a7CtdXOilzXUX
         KN0MBm/+inJwU6ZfdL1bJ9FcUhncH/S9T8tMQGnBk9jyWKV8prWRcyQH6yrPqI04oTZb
         dJer1lttS5AsUdCQhMEh5rspzuRxXz65Bay9xhlNYMzzGwtxx6FthDdlgr5+YjNq8FCd
         sVjQkRL7FXX/CgKlP596NWFA8+mb7PtwxbWrpq33J1a/gWfmkQoHNQ01TtKZF+pcwZeo
         YBjozgz4pgReegBfyciip4zHA1oB0Nfcrm1bI0m3GiVE2kqpBaYqjVm+ZLHlBTQUoh8F
         LE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766423476; x=1767028276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WyI3oyBXBFxhrviz8e5X3C6yj6KOriffXerfRYoiv9M=;
        b=nfTUJDAswq1uM923mtM3vVtCpk08mkUKqroY8xydBMUuPpeeoD+Q8wQO1zxjO7KZMy
         HeGLc3xz1VZuxUV6mJyAiXzdYTzkLs9aMZvoOllux9AoL9rlqpPFZXeK6e8zZdYrNo+O
         dx9RrOY0fs+Gv7Lqt4unj0dIIfDngKkS8MdLwObWhvHNYpGpQfPLjclLTv8VYRvdYP6r
         JEFCkTsTsd5/yDIfYYew7L5B4y3s6eyajThu3TXrY7doUL8ERJHRMjxccN975QGDHyon
         TnABpDwdUoMXJGWfpGIH+/AkbGzyqBmucFwtQNxeiadwEVhgjz8kd1p8stFgf+F9cqoR
         //BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWZgC9Dzp4GG36EqXUKK4rdvrRwLRXps8ytT8d5Ge9HL2RvqZqtIirPusPqaydnZbQXGJpfhXSNlv7cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzK9YXXctjTLXG8Hiw/Z+5fJ6w0+RiaKbTbqmdW6qsRUAHcgCw
	fN5m/RY0GtYRd1xtDX9sbaNxamWJig2lkWXMG+nAaLee4+pXu5tlVDCTeJCBpcsjuVyRmNUUASZ
	xSEyongLb2+EVPxPiQXjWz++ABwi/aB0T5ixU8G9dIA==
X-Gm-Gg: AY/fxX5sPNWxppZ9svxvGyncGPFQG2yefwjONenv7EBfnd7JWAZQYUb7y4GMHrxE8p6
	UAIC1jgdWW/ejFN7bUlBf/spbKjkhmqWAJEHTd4LFCQpBnkqdvXzLpDz/vKQDpOzliZYGGHh6Ro
	ttf8TBH+AuQZmUwcS22Dua9NTpOPss0SpdZbtE3IBWMnT+d8y7zs6kf9HNZ/nX/xwg61X1JCAgE
	+QvOacCZ5zUaAwTBDCE9m2YUbVraKwV7OFd8DOakh2bklxQJbNmpCJcPXHbeelCJGnr8CI=
X-Google-Smtp-Source: AGHT+IEgoFt5onRyuFBvCdWzpye1MCSgMGvEELbkTWdAfyq9Bby3/aulgO/3PI5bxZIcAsJz2e+7U/96+CK/y5Z9WUo=
X-Received: by 2002:a05:7022:e1b:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-1217215cb5bmr7000590c88.0.1766423475371; Mon, 22 Dec 2025
 09:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220095322.1527664-1-ming.lei@redhat.com> <20251220095322.1527664-2-ming.lei@redhat.com>
In-Reply-To: <20251220095322.1527664-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 12:11:03 -0500
X-Gm-Features: AQt7F2rdEb1Bo1fkp8d0Z7EFB8KTv6YCIzuB9VKDVyEzrXaw4etsbK_h7EA5mAU
Message-ID: <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 4:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppres=
s
> automatic partition scanning when starting a ublk device.

Is this approach superseded by your patch series "ublk: scan partition
in async way", or are you expecting both to coexist?

>
> This is useful for network-backed devices where partition scanning
> can cause issues:
> - Partition scan triggers synchronous I/O during device startup
> - If userspace server crashes during scan, recovery is problematic
> - For remotely-managed devices, partition probing may not be needed
>
> Users can manually trigger partition scanning later when appropriate
> using standard tools (e.g., partprobe, blockdev --rereadpt).
>
> Reported-by: Yoav Cohen <yoav@nvidia.com>
> Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D=
65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>
> - suggest to backport to stable, which is useful for avoiding problematic
>   recovery, also the change is simple enough

Not sure backporting to stable makes sense. It's a new feature that
requires the ublk server to opt in, so any existing ublk server being
used on a stable kernel won't be able to make use of it.

>
>  drivers/block/ublk_drv.c      | 16 +++++++++++++---
>  include/uapi/linux/ublk_cmd.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 78f3e22151b9..ca6ec8ed443f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -73,7 +73,8 @@
>                 | UBLK_F_AUTO_BUF_REG \
>                 | UBLK_F_QUIESCE \
>                 | UBLK_F_PER_IO_DAEMON \
> -               | UBLK_F_BUF_REG_OFF_DAEMON)
> +               | UBLK_F_BUF_REG_OFF_DAEMON \
> +               | UBLK_F_NO_AUTO_PART_SCAN)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2930,8 +2931,13 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>
>         ublk_apply_params(ub);
>
> -       /* don't probe partitions if any daemon task is un-trusted */
> -       if (ub->unprivileged_daemons)
> +       /*
> +        * Don't probe partitions if:
> +        * - any daemon task is un-trusted, or
> +        * - user explicitly requested to suppress partition scan
> +        */
> +       if (ub->unprivileged_daemons ||
> +           (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>                 set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>
>         ublk_get_device(ub);
> @@ -2947,6 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>         if (ret)
>                 goto out_put_cdev;
>
> +       /* allow user to probe partitions from userspace */
> +       if (!ub->unprivileged_daemons &&
> +           (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
> +               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>         set_bit(UB_STATE_USED, &ub->state);
>
>  out_put_cdev:
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index ec77dabba45b..0827db14a215 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -311,6 +311,14 @@
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>
> +/*
> + * If this feature is set, the kernel will not automatically scan for pa=
rtitions
> + * when the device is started. This is useful for network-backed devices=
 where
> + * partition scanning can cause deadlocks if the userspace server crashe=
s during
> + * the scan. Users can manually trigger partition scanning later when ap=
propriate.
> + */
> +#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 15)

This is the same bit you've used for UBLK_F_BATCH_IO in your other
patch series. Are you planning to change that one?

Best,
Caleb

> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>
