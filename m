Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761522D7DCE
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236764; cv=none; b=eTVUTGgWo9IfnHDJ8VjykTq2A4IFRy/Q2opO7T8lC26WCy5PVtJ5b+i0qLtuaYaXJDQCWyUdGylm6kh5qPbORk0AJlNYJIuGrssjefNiquLVfEDma0Dd5zFLqzGshm3DYCreF3HF6yvFOzng9FNLVwRX6dIPYsW7vgfY4BNuVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236764; c=relaxed/simple;
	bh=8YnbExP3SLrmfqGuPpH3MYlZAXEo3Z3IMJJFHj03LKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXRv3JmzkH3Uo90gmZnNrZ6NwELWkdIP6DoKuHoyT79OpfuW6ZHko3DrK5CahUDTM09oTFMKqyUr5mtYB3bIA8ao2o13MBqie/9TR634shgFYbFw7P9mLwvq5DJNEcJZF1xaAUTSJ3dShfT+wQzfbE5mfa3WDu/k/jicbdBeAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LeXYNV7b; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LeXYNV7b"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b1161400afso282978eec.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768236763; x=1768841563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d8RGVoLZF16RMD2YJSY2roZJEszVFUP22HFSw0KR30=;
        b=LeXYNV7b1s+6xy0QR9upKA6NP3Gx82RNcg4sKQ7M+3OcmqYwMBqXN43M/NYF9du0Mv
         e+2xxXX/I+r/H0fbdqvp/MvWmNkHrXj7AT3YVBtZmc2cvkmKsQUb3SW8k9tQXHPy40x/
         aA2Rhwgib87KXsepXYl+YHp9f0MD+bxIbV1YWy/+gqG5gaX4zHfvdqbl5sG878670Wl9
         w7ecqy4tRTC/pHrS5nl1nn1xpRejG6FYTu1/p+fUgYIr6OkGAIbKS+GXCKgsZqNhCOxV
         hiaCz+WLZzL7QQKhw/NluubCME5o/ddIAr+oXSWu0xqnIzsnKTFvb8OT+QptHcvajpOC
         Q3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236763; x=1768841563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7d8RGVoLZF16RMD2YJSY2roZJEszVFUP22HFSw0KR30=;
        b=iOfB5f2IyBzFfFMglNX9LJOi3nl8h7N126cV12tueaYxlyG/LXY3Q+L9XMH9mxF++x
         rBX6D2i9HhUd7DmqfTgSCpVqvCWr38ArArQAxYFiZwz3vrzugvt/p+hBYgDhFF1bm50d
         KxhJu89JhYsO//3thPO8gmGJzyf5fddMV0YKQmDyZtSU/i6PkRjeJ5PzBioGjlD4m3y2
         5DUW/0NSRItGOrd2T9StPgr/MoPJL9dU3AiNEELv3vl1hWxJuVPPPGEoiKocIRfODYMQ
         bxbxXhS4Muh37IajYDwRB/7B9yoTkKA+0gCBBHtpbFLU6CMOX6vM4AWgbwABdbUPwPPS
         wiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXwSPSck8DDyNJyNcenVuAI0szoaqBruZgu/Xmoc3EBtbOBh2gSs0u0MwmAplwc/jrmZVxepgTL1seWZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGXSNREQ31H/gBMmykWCRvO4BjwLkSnDeR/wkK1P0OirBsDSS
	VUmDemtGN5hV+d98e0vBDQK93fRdpesegu/53BCrDzHqJt6bG1Vy4g5THR7TZqq6BptoTP1/gWT
	pTvqxND5GuZgPqOvYu6qZpg+d2QBqj3e1BYJ4BzF/vRcXwT2w0dZOf48=
X-Gm-Gg: AY/fxX5oAbOT79VQYjFNeGRpzMxnSbosJHIqDGkFNoHHTXl9we39uATy5MnI4jLhWG0
	44Dtw5IVBKJX6PdGPvCUBMWJXCqxxfX9noUqxX+nshaNnUUuUofNaL0KLuh3BKIdJ1ak4YyxJbZ
	Zykp/nxSqp/JZ+cdkmALhiqFPpAF4YoubMwAkYlvNzR9+vm+NmdQ97S//tdwxkHjxNIxDemOALZ
	pcHVHcl/opu/wIXUPiqIbM/XqsLjQsnZUJArDNH2bJ9gybBRqPeUMAewqLeGl5lr0DrMCaR
X-Google-Smtp-Source: AGHT+IFcqY9wm+FrDAvGu8UBn0lXhR0EABOn/a64TPj7RpIMEBmOWydS17e3P6DagQnAC6bk4DYoY9tl4eaJSZAUxto=
X-Received: by 2002:a05:7300:2d15:b0:2ab:ca55:89c9 with SMTP id
 5a478bee46e88-2b17d310ca4mr9130094eec.4.1768236762423; Mon, 12 Jan 2026
 08:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112041209.79445-1-ming.lei@redhat.com> <20260112041209.79445-2-ming.lei@redhat.com>
In-Reply-To: <20260112041209.79445-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 08:52:31 -0800
X-Gm-Features: AZwV_QiWuHDfTGO_FTDMI-l8fAkP9zpVb53e4l9TUQfP1jFFeC2a6Mubfo7mhJ8
Message-ID: <CADUfDZp_4pOSAuPE52OWGU1q46bQHZL_9LLp8ANP3umZ1upmYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: cancel device on START_DEV failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Seamus Connor <sconnor@purestorage.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:12=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> When ublk_ctrl_start_dev() fails after waiting for completion, the
> device needs to be properly cancelled to prevent leaving it in an
> inconsistent state. Without this, pending I/O commands may remain
> uncompleted and the device cannot be cleanly removed.
>
> Add ublk_cancel_dev() call in the error path to ensure proper cleanup
> when START_DEV fails.

It's not clear to me why the UBLK_IO_FETCH_REQ commands must be
cancelled if UBLK_CMD_START_DEV fails. Wouldn't they get cancelled
whenever the ublk device is deleted or the ublk server exits?
And this seems like a UAPI change. Previously, the ublk server could
issue UBLK_CMD_START_DEV again if it failed, but now it must also
resubmit all the UBLK_IO_FETCH_REQ commands. This also means that
issuing UBLK_CMD_START_DEV after the ublk device has already been
started behaves like UBLK_CMD_STOP_DEV, which seems highly
unintuitive.

Best,
Caleb

>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f6e5a0766721..2d6250d61a7b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2953,8 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>         if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
>                 return -EINTR;
>
> -       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> -               return -EINVAL;
> +       if (ub->ublksrv_tgid !=3D ublksrv_pid) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
>
>         mutex_lock(&ub->mutex);
>         if (ub->dev_info.state =3D=3D UBLK_S_DEV_LIVE ||
> @@ -3017,6 +3019,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *=
ub,
>                 put_disk(disk);
>  out_unlock:
>         mutex_unlock(&ub->mutex);
> +out:
> +       if (ret)
> +               ublk_cancel_dev(ub);
>         return ret;
>  }
>
> --
> 2.47.0
>
