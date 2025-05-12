Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2F25742F
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747081549; cv=none; b=Kgyg6XF2ZQff04c8ejYeEUQ7PzNS3cc1gIk4qVbnmvMvsX5UtJUiF1VrBFdN+jQT3qwCGhemwVjqT6Pk5E70h1oGBLwoLSXSLKcm+v6JCs5RZoo1cGUd1qhD7dhQfBgHz9vWe1N3EQtxPfwczs1YZ7ETjWlfpCZXQycfHaWOCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747081549; c=relaxed/simple;
	bh=HdnrZTqKG/mgiBL8XA0lspvGLs9udpp+9SL1i7+G5og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uT9/C5XKgtO/AayZA2ny/iHhmcgiXvnOpbUu0r950fGa0TDKStfjS+FiDpHWUUwWcFO7CclEipFPGsHfmzrkFqqO/ZnaF+bLSRG4JavV/YdCOirpEKCngyr5kzcBDKBTLHmfW2SqsN/7Tq99TjcDybV9aPta/ebPln7zR2JsKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DmC2AoSp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DmC2AoSp"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2001aafc3cso400801a12.2
        for <linux-block@vger.kernel.org>; Mon, 12 May 2025 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747081546; x=1747686346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50VBPj4PMggqehirySR5yaohZlS19sJa+O8LoRhy/u0=;
        b=DmC2AoSpPTDAU5WBTBGFd5klZnak45Ud1W/c7avJnAB04LS3wn+kuaf+/ys3JztCvM
         AyMYTQ+Ka3C+RkV3UtEHknItL8Urxbzt0vvqFa1vkQSr9A0eqlpMzc2/iZjje4ZB3EQm
         INxeRPZOkKdG7/NgiMpBQsC3mmpcRbSaO7ZJ/iti9I7suh2tKEvmEyqSBIy2Zmv5lOHo
         5GNdjU8q43n9onYDWhINJXPFxC977mcPIeJ9IxtFyhpKy4jSSXlufL9eWC0dO1lsa1cd
         iY59upR5WM1Jgjc4xaMczoN6V9tQrLqaJqODV7e+5lGmXIhm58Tlu3OPCJiWp4L53d1C
         tapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747081546; x=1747686346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50VBPj4PMggqehirySR5yaohZlS19sJa+O8LoRhy/u0=;
        b=ngWpAfzEL/ard5OKVu3qnhkPs2wMD7LTdHgyHQq8+GWunqTxCo6I3VnYTpx28Mzvuz
         IKCpD+FhOVJMky0F4IA8e38Jnx0jPUCTutWayEv4KrHu41VnVrh0xgFk+1UUFrC2/4ho
         rfTvA95MBXaXVCL7vfoWeHs/+ZH3c0HSy0NM7JLwk7SXQtg1DZUxTlRvNsaKSrmp+mM9
         h9suIb1ZUWFBtTXqqcqr/uOmY0k+C/F87Libs+iXBPrAWbGJoao2gGNqn7I/gXf0uo24
         KggBBGlpmxpbSSkzm3KETLN34btCcSm8Kf4DDpHuCojToEYrBFSiFmQC929pfP81mSnQ
         mVtg==
X-Forwarded-Encrypted: i=1; AJvYcCVSqe2sY9MRko2Nv7Uwij/gc6t5avBZdRCwcKOSaz/tCBDkWjZLF3wqzdZTbKWJyPWeLxFwiGSgSEVX3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwJLnR/OX2yDXao23KhFJLKigmWahcQ6gb5JAZ8PGJ5XRGT1e
	QSpBUZMayeT/6ACyaTEPiD5FkwcRTgyojkwIe32JqM5R6CPVMRn5RHtGrLQA+ec37yuXULR4nkI
	RcvaCpqBgKrxuqeBmXA6QwwEd9FPuGr5vClQ7fl59I8L93RtIroY=
X-Gm-Gg: ASbGncu4ORw+rI2I+o5vwvLiboI9B4WSoh+N27d+yC6HIuiL4jFMzLDYWs+If4kLjdR
	Iacijf8boMbctudeLnj9Wz5nhuvNQpQRsYukOJv8cI/bVNFxI6EfkYrLyIQBA0QWt6HdX28ewlL
	bZdTidwYyHRqSK3Bu9PXqjCknfPvfYvgI=
X-Google-Smtp-Source: AGHT+IF2WSgGduPWAJa+PxfFWhEMU9q97EVP89+VnkO8V0kHiKGoabLUcUmIYywyn5Hol3FRrVlSEozqIWhZhuqymsA=
X-Received: by 2002:a17:903:2cb:b0:22f:a481:b9d9 with SMTP id
 d9443c01a7336-22fc8c79db1mr80299695ad.8.1747081546371; Mon, 12 May 2025
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-2-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 May 2025 13:25:35 -0700
X-Gm-Features: AX0GCFu6IU6LmYmxwBQZcDybr4pC32LkhgPiMWDsEefbXqoP3xwZj-5swTuUKD0
Message-ID: <CADUfDZpf=dXnjo4Jpf+U33_H1OYUwvvDA4O=aw2xM9zZY7-rOQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] ublk: allow io buffer register/unregister command
 issued from other task contexts
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> `ublk_queue` is read only for io buffer register/unregister command. Both
> `ublk_io` and block layer request are read-only for IO buffer register/
> unregister command.
>
> So the two command can be issued from other task contexts.
>
> Not same with other three ublk commands, these two are for handling targe=
t
> IO only, we shouldn't limit their issue task context, otherwise it become=
s
> hard for ublk server(backend) to use zero copy feature.
>
> Reported-by: Uday Shankar <ushankar@purestorage.com>
> Closes: https://lore.kernel.org/linux-block/20250410-ublk_task_per_io-v3-=
2-b811e8f4554a@purestorage.com/

I don't agree that this change obviates the need for per-io tasks.
Being able to perform zero-copy buffer registration on other threads
can't help with spreading the load if the ublk server isn't using
zero-copy in the first place. And sending I/Os between ublk server
threads adds cross-CPU synchronization overhead (as Uday points out in
the commit message for his change). Distributing I/Os among the ublk
server threads at the point where the blk-mq request is queued seems
like a natural place to do load balancing, as the request is already
being sent between CPUs there.

Best,
Caleb

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cb612151e9a1..31f06e734250 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2057,6 +2057,12 @@ static bool ublk_get_data(const struct ublk_queue =
*ubq, struct ublk_io *io)
>         return ublk_start_io(ubq, req, io);
>  }
>
> +static bool is_io_buf_reg_unreg_cmd(unsigned int cmd_op)
> +{
> +       return _IOC_NR(cmd_op) =3D=3D UBLK_IO_REGISTER_IO_BUF ||
> +               _IOC_NR(cmd_op) =3D=3D UBLK_IO_UNREGISTER_IO_BUF;
> +}
> +
>  static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>                                unsigned int issue_flags,
>                                const struct ublksrv_io_cmd *ub_cmd)
> @@ -2076,8 +2082,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>                 goto out;
>
>         ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> -       if (ubq->ubq_daemon && ubq->ubq_daemon !=3D current)
> -               goto out;
> +       /*
> +        * Both `ublk_io` and block layer request are read-only for IO
> +        * buffer register/unregister command, so the two are allowed to =
be
> +        * issued from other task contexts
> +        */
> +       if (!is_io_buf_reg_unreg_cmd(cmd_op)) {
> +               if (ubq->ubq_daemon && ubq->ubq_daemon !=3D current)
> +                       goto out;
> +       }
>
>         if (tag >=3D ubq->q_depth)
>                 goto out;
> --
> 2.47.0
>
