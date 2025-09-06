Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72D14A8E
	for <linux-block@vger.kernel.org>; Sat,  6 Sep 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184502; cv=none; b=azlqaQ9dgSoYlmtUTapmTf82NiyuY46H+vaM46xFAUqVcO2ifL/DO1hRHH1PF9W+m+L7Jb6RWOmDCljM6Ezoi8IzY/RLKnTLzyjRrmQc49y8JKov2igA7lKK4ZriPP/Xv1WIig8Ytytz79kFbxWIne6E0Wt9YMT5eYog/gpFzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184502; c=relaxed/simple;
	bh=F/UEtKtJLCeFuixv7rYpESsHu5i+16oy/WE+9nQ0suk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK9j6D7sHHXkd0BZckR90POUJi7XnHiLS9gSTlSi/fyi6wQ0isOCSscyMbYCSZax6DxLJBLuU3Tmbc5ZKmK3A2YTouaVM0oqYzBRbfLHUp6+pnf8bf3TAKskdiH4rYyICPTnlPhCIOAnV75U1mqDAGhpH+ybBEqMmQ+T9zY/Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dh/uuds8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dh/uuds8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b14d062acso5942565ad.1
        for <linux-block@vger.kernel.org>; Sat, 06 Sep 2025 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757184500; x=1757789300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DFBxFp63QQfbyeNeAzYru825AJlbIebdy6/oBCyvSA=;
        b=Dh/uuds8f68jBgiQ3s3iOneysG9zMmPxOyUeMKbIBqbn59UQ7M3jFWFOkwkW3g5euw
         ozc3814yA98qHPMF9ZnRncW65FRSqa/c9ie7AlCfpchtcvKkmj7G/A6eBqpamgX4mPks
         jhaptzs9gObzK4UxRyDJEv6KggQvtTt0VKgp4UxcrsaJx7lM2vzC3e5gJRqtWeGiHAR8
         XFjatgVCBj6hc7Iw57utu434NbJ02Y5998NW4VPs61vxVax+5oeEr7yOgmg1EnPDmGuM
         cp+VIGe/KvUKz4Zel5crLy5F18Nupe9txRfxN7f6H5JrklDqtC6po67IDUMU0wN/5s33
         KImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184500; x=1757789300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DFBxFp63QQfbyeNeAzYru825AJlbIebdy6/oBCyvSA=;
        b=V5yJHlOWwNS1+xTOUvqllFkzxler9pc5+IHyyHboFtgAW0h1lEngkU0GNm3bf0Tdbm
         bmif7guV0obRRc3XDD7NorN5QFD4mGjiFkyRxru0J+tCL6kD14a8kRREH6dXsZZGqdY5
         6G9n7KCQBQizIcF7/V+4VMxBCAaEADYNyr6Mjk/Phh4sLw3t+EhIp5A3eR0yodN2Fnsw
         PLBAXoz0ShFZXhPLLvNB5C/vcJQ7abh6jvmOO5hCwUvyydE860mu2IGKluzlNWKRySkj
         9/PJYuyhuaTVsdHKedN6IlKtXmAIUUo2Hd3mf8CYWUCbfII7ZhMzsKzR14vMISWYVJAV
         1/ag==
X-Forwarded-Encrypted: i=1; AJvYcCWxJfjoO40bUAqBQ5pK1LbZ+PO9vIqzV39pVZOAdZFaKRydGbWUJxUKSSGxmY7UVYiGzNkYLhnmutgdxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwBBBm0flMN0zThyKF+P7leQzhzPA116kXogDoYB6/dp86nfS
	jW3wwzVufvafEV2ViHF0R0S2opNRN8tv0a4xSxM33Oq2EYzdLiqiPj4aUS7eiaG+q250hOIGJM/
	gq+MY/JIcKup3AYODYMfqjqjWreZqSL+BS6ZSQ+OFyw==
X-Gm-Gg: ASbGnctvQrK5aBGGYV9tX79uVOVjllRo+bUWKZppguV0OT6ewI91MIHYKq0R9C1S9m7
	NpbfK20CE9KnrKHfKJo4jKueQq+GPZifh0ImEEuXA1KFcpPK9V7RUhhR2IWEtGQWCc/V5UPPoPk
	PFztQf3hiTcPrTlq09ju0iBVvTjCNAKSb0pmYgq1mZHowK4245MCMQQKuKpicaMZ52vCnG0wgRo
	PUpUU+mS65ycJrWhwyo9Fk=
X-Google-Smtp-Source: AGHT+IE5ZnEPotWry0WjIh6LhxxUngE+tj1Pe1CBv4fTzb+8dOskVqV5Q9RL3i6A/vW7t35VdYCXFivXCcLljf5XT70=
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id
 d9443c01a7336-2516f23de24mr20022125ad.5.1757184500082; Sat, 06 Sep 2025
 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-7-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-7-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Sep 2025 11:48:08 -0700
X-Gm-Features: Ac12FXyqsXzhgzfbcqSXfcb8WQWfm5tluhIGG-2H-Evwx6UNiOiTMGTBrmuggU4
Message-ID: <CADUfDZrQF+VS8U8Z923qfj+jHsLDjNVsoy=dMxdDMW+2JcpMdg@mail.gmail.com>
Subject: Re: [PATCH 06/23] ublk: prepare for not tracking task context for
 command batch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> batch io is designed to be independent of task context, and we will not
> track task context for batch io feature.
>
> So warn on non-batch-io code paths.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index a0dfad8a56f0..46be5b656f22 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -261,6 +261,11 @@ static inline bool ublk_dev_support_batch_io(const s=
truct ublk_device *ub)
>         return false;
>  }
>
> +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> +{
> +       return false;
> +}
> +
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
>  {
> @@ -1309,6 +1314,8 @@ static void ublk_dispatch_req(struct ublk_queue *ub=
q,
>                         __func__, ubq->q_id, req->tag, io->flags,
>                         ublk_get_iod(ubq, req->tag)->addr);
>
> +       WARN_ON_ONCE(ublk_support_batch_io(ubq));

Hmm, not a huge fan of extra checks in the I/O path. It seems fairly
easy to verify from the code that these functions won't be called for
batch commands. Do we really need the assertion?

> +
>         /*
>          * Task is exiting if either:
>          *
> @@ -1868,6 +1875,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_urin=
g_cmd *cmd,
>         if (WARN_ON_ONCE(pdu->tag >=3D ubq->q_depth))
>                 return;
>
> +       WARN_ON_ONCE(ublk_support_batch_io(ubq));
> +
>         task =3D io_uring_cmd_get_task(cmd);
>         io =3D &ubq->ios[pdu->tag];
>         if (WARN_ON_ONCE(task && task !=3D io->task))
> @@ -2233,7 +2242,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, =
struct ublk_queue *ubq,
>
>         ublk_fill_io_cmd(io, cmd);
>
> -       WRITE_ONCE(io->task, get_task_struct(current));
> +       if (ublk_support_batch_io(ubq))
> +               WRITE_ONCE(io->task, NULL);

Don't see a need to explicitly write NULL here since the ublk_io
memory is zero-initialized.

Best,
Caleb


> +       else
> +               WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub, ubq);
>  out:
>         return ret;
> @@ -2347,6 +2359,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         if (tag >=3D ubq->q_depth)
>                 goto out;
>
> +       WARN_ON_ONCE(ublk_support_batch_io(ubq));
> +
>         io =3D &ubq->ios[tag];
>         /* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->t=
ask */
>         if (unlikely(_IOC_NR(cmd_op) =3D=3D UBLK_IO_FETCH_REQ)) {
> --
> 2.47.0
>
