Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E42DCBF7
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981354; cv=none; b=eKLgH9st2yOMT0UlZDyPJzacdItAhspL9/5aRnAkyPRS0FMbHLc8pYorjzGosDUWsEN+NtMM4PpmddJ3A6OR6OWJ1Wpg0r+US/evuAaMwsLzMSbhCBZSOPSu1O6Y+jz+vjUM8RfM1HtVpNPwIJOPWqw91W1S0rkH7H37ZX2TRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981354; c=relaxed/simple;
	bh=BY5s0HjX2lwrG8cl/+4zpVzBgs6uvPYqGbDDskVqAIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auVUT+fdjo24YhYczGMPUOTSzXnTYmy20GBYoxXBB0M6NVIYBRCPJWmqDjT+eiOVRpqHV2gOIb7v9373H9K//fJteJmUH797s9pkcuqERDOzoPOGJEeEm0u+gPMsoaFfEk/IAeYyxGFnFLrUZfmfJsZtbtSDTHuJUjs8PuJ8h50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NlaaJ2Z+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NlaaJ2Z+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2369da67bacso4665575ad.3
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751981352; x=1752586152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2aRmOGEKTNjVpFxhI+KNKMSYDYuEbNFqvPQ+6YXdXw=;
        b=NlaaJ2Z+EzdGQNXyqfOyC1Y6m5NMEZsiBPh26sXOm0wDYjoHP+HiTY3fxyKM0f7qIO
         rBZ3WyYfExTt9FrjcWzEeIMLSLIXACFPc3pmpihHzUGw0tKpHvC9GwFMMZ83MA5fCZyd
         PS96wF3sWa/cXup25BBuY3bJCqmFoRBvGP5WZC+AW9Lrdn3ovPmgX2pOcL7P8CY0WW53
         PyzAyY0HmN8JtFrPiOak8jYdReVdv7GOpkWLQf3yblpLF9kjYf6vc33FVbFzlm5rzt65
         29774Xqw0dbOAbG24RRIbH38ldagkCcau0Njpio/noD4zoIQGXobGmVYkZIuUE1VaSz5
         0I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981352; x=1752586152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2aRmOGEKTNjVpFxhI+KNKMSYDYuEbNFqvPQ+6YXdXw=;
        b=mLE0NLzdzWcuIo0fJKX1FB1wgN9fe2p3lddRLtqIhZQDKKGtx7qrAwMVJdi0szkz6j
         FH3cjW9dLN4Nydxn20eNZZ6rKxt1vgEFNJUMCCDiYJQNEY+FzUI4S8+DGbfE9hDhKGba
         dU0nzuNBILO2cYm+/mxA7+g30Knjk/CtjXYPcavT6dqL6D/gsCiJ/1jqiOrrz6PgV62f
         +A3ydS3JEVKrqIoeLjCHV2cr1StLzGGQ9Yjq7VswucJw7h2ECP7hyQyhDyQ+avAaLIu6
         AxA5efAeQIMK0zHLS6FsaCpatGEu9ts6yA3r7enaht+i5jAy8hFV22LbjBvM9XQvCG7S
         G8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw61h5zoX60hZ+tS2kwwXZbifgHkTf4+Gxuqa3xaXNUNFC6Ln6oMwm8Fj/bXfVKZiBG1DpU31SFry5Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6+R6sLurf1mr+g8FciPL5gG4U8RLzEgy6eUgJM3R3rNHNTbS
	rzHXvyPtZ+w6/cbt2j4kOHaNmGlCUHRMMn36ErhNyY/Bg0wtxxGD/DjSlN3SZJKoHXTJhg6Qn0j
	TTJbLsLJkb6/uGgluGcJURoYimzAuUKeqMJ5fB48o/KtcCWgyckdn6dO/yQ==
X-Gm-Gg: ASbGncs+ZJksYb4uw4zq+yQywR/L8rVCcElXuhtXUHqMf/trtHRx5DFyKD8RQZMqvso
	2asXkdHmL6dwEQdrZ6G05qm2Gyn3uz3R/T5NsjYyK+0c1hBZkK/ntqgCWT+nhkM/3O8UIa2eJqY
	Uma1vyZbRCnuxZLJh1xVKuJUJVl0xJFZUKyRzOZF8CtvG7
X-Google-Smtp-Source: AGHT+IGcLo/k8sT5DZlQAHYtbSgV8uvX64DjRDLLpWhT00tOXP5aAU8xCOq5V4HgElWaB0kHdoiYPnZsaMJ9cFtTrz4=
X-Received: by 2002:a17:903:1c4:b0:234:a734:4abe with SMTP id
 d9443c01a7336-23c8722f4fbmr92736545ad.1.1751981352139; Tue, 08 Jul 2025
 06:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-10-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 09:29:00 -0400
X-Gm-Features: Ac12FXw-5pcgKDhyw6OKb4o0vrNLa2C1sT-Y6-mGTES_3OIeSIsXq5g4SdSMPGY
Message-ID: <CADUfDZo-yRZhcyk6Gm2oXtUM+C5WWx7w-BMmst83op3RpTAq0g@mail.gmail.com>
Subject: Re: [PATCH 09/16] ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Pass 'const struct ublk_io *' to ublk_[un]map_io() since just io->addr
> and io->res are read in the two helpers.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 13c6b1e0e1ef..3934254f7b99 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -993,7 +993,7 @@ static inline bool ublk_need_unmap_req(const struct r=
equest *req)
>  }
>
>  static int ublk_map_io(const struct ublk_queue *ubq, const struct reques=
t *req,
> -               struct ublk_io *io)
> +                      const struct ublk_io *io)
>  {
>         const unsigned int rq_bytes =3D blk_rq_bytes(req);
>
> @@ -1017,7 +1017,7 @@ static int ublk_map_io(const struct ublk_queue *ubq=
, const struct request *req,
>
>  static int ublk_unmap_io(const struct ublk_queue *ubq,
>                 const struct request *req,
> -               struct ublk_io *io)
> +               const struct ublk_io *io)
>  {
>         const unsigned int rq_bytes =3D blk_rq_bytes(req);
>
> --
> 2.47.0
>
