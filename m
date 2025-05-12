Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2025178A
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071611; cv=none; b=er0UT/sAhZoNDYyoPcciEAJ76nAldjvmCGNwXVMzdwSaF/B0UwZYvHTnrcxOSBNVMyGTsvAdEB79tBXhVdnVN7U446V7k7YCA7nXwCX5bGz/NvN13eGMfzBfj2nAudNvrA8zS0F9yB9n9v3kL7yJ57NqkE1qxu6T6MwRemriJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071611; c=relaxed/simple;
	bh=jfMJguNy7KP1f8dfjRlpGKCvHAvmMUQdTLAXZWe/HOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBWN3txZUXuqDZJz4dxq17NsxyiIAK4qIYuSaDfdcccUCysB3NX8Tj2Rp4XvtDZWnYBBBvcSRt8ROOhRkxVRszCrC1eLNKi+JGVnnafzXUJJtVx4+FBwxjfmXmPic4jH8HuWrc4aA0C5hXf+R3teXJi813EBLr20nOSfxvJeliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WSTKq5b7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WSTKq5b7"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2414d565edso228692a12.1
        for <linux-block@vger.kernel.org>; Mon, 12 May 2025 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747071608; x=1747676408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypP5iD4c0wcoN82wgQ8cULjPKQS3qu6K5cMT5U5Jo8o=;
        b=WSTKq5b7uMfbznl3v+s7uS/Vt/k9OJj7zzPG2DShRvVrbRIt7Ri0zdT1t5Gvztx2vp
         S/uoSwauan2JpIADO5WKlcbUumJXPeQdYDUpGzoz+YzCzGfAHPJXASHkjO0rSGO7rpwM
         qCm+tZHlG8T2f5qZHBKuc701mKGjrE4YtV0zxX3aAwRJVcfI1myJX6Br+dAwXZ+SoyNH
         hcsGsd1aLUAMKnYAD8j3hwYaUJnhfMaSrk14leOHZNoTnCp3X7xu2UcxeEIIyuJHmkDa
         78Oz96sckoiSKBrpTc5CGRtHhlK/dLc39V9gWKwGCxzyJx2O4TCY29dgdetWFRPzsp61
         aViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071608; x=1747676408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypP5iD4c0wcoN82wgQ8cULjPKQS3qu6K5cMT5U5Jo8o=;
        b=l9yRVGvByxglgzrpL5xlewmXiCy6dSKJyOeFpzHj5DM9TXiMLdvDhQd0qizjzxbWBr
         mrl8lVdELo6zXNCcDVMXTXDlDayAIfuLwjtAewYO6hW/zNiuwJlwP4fRsd0PztQpZv6v
         jSQFAfKb9gt9lw/x0RJLTra662z5GE7HPo5L1Z+Ns+NcR7IIjRoRwfhcxtdGs9mhD/8f
         n170z2YgJFtXnWwEfCkHrlN9zh9A5AtR075IpLO0qKjCvEM0aWcu4+nTjK4g0BNa+RN1
         +mVG8GNdtZ3+ra3kHkQiDb6e7w3HlCAN/YpwR/BDA/MBQLrtAjo57zqqFg0KnkocIlgh
         pcqw==
X-Forwarded-Encrypted: i=1; AJvYcCXEm7xCY3VKcg3eEF7KShKhy2Yk3Kmgi76MN3og5h+jF/LBx9buUu6urVBT25FmKob3O/KDp5+dHK+vQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7s36s5E2el0mpN4B4mVuyBchUD+ayjwsAHnDtvzzDloegUQ+4
	PY1t6oZsEDh/CVein+GvV1iE6v9vmEOXzVS4Ss2wCaKRmqzpQpx3GnY6piec2uHrJa+BDDzQIYq
	FdrM3otFUhhjckiYE5x1I8ThKz1/qbM/mLvcRmQ==
X-Gm-Gg: ASbGncun6LLt0bAPZm3kNyUv3ZqbzYNT4RAwhYsph1+rrePHBgXsbcxTqst2osH8mK7
	SYb77KhMnTt8jQ9Cm7FcqtUqsHVrZciG2nmN70DPL8K6qc1IUGJoUCFmVyvANNaYtS8FLHby0CW
	AeduVPkhpgWV8u4a/6Bopn2FGwQn9axbw=
X-Google-Smtp-Source: AGHT+IEhGX+VOP8JRV3PKBQ0e8ItEaK5lhq2CAV6tXNDC8fNKHaoaYjuda0RnfSiNau/4INxqwvMqHfpR8B+o0HMZT0=
X-Received: by 2002:a17:902:ea01:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-22fc8b0cbdfmr78835025ad.2.1747071608542; Mon, 12 May 2025
 10:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-2-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 May 2025 10:39:57 -0700
X-Gm-Features: AX0GCFto4Z93-Hjr-vxU-18YXHcc1Qm7JKyqvRC6HYdfOMzv929WTcDhHqj-s80
Message-ID: <CADUfDZqfEnOM1hmZJw7VTNUUu_zqf1fBcju_ZvDt9tNe3-KcHw@mail.gmail.com>
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

I mentioned this before in
https://lore.kernel.org/linux-block/CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhCbzNu=
Nsc9kJTmX2sA@mail.gmail.com/

But UBLK_IO_(UN)REGISTER_IO_BUF still reads io->flags. So it would be
a race condition to handle it on a thread other than ubq_daemon, as
ubq_daemon may concurrently modify io->flags. If you do want to
support UBLK_IO_(UN)REGISTER_IO_BUF on other threads, the writes to
io->flags should use WRITE_ONCE() and the reads on other threads
should use READ_ONCE(). With those modifications, it should be safe
because __ublk_check_and_get_req() atomically checks the state of the
request and increments its reference count.

Best,
Caleb


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
