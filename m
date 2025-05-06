Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61C2853ED
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548073; cv=none; b=kYP6yhI+JYpDDXZyRIy3j5iEF3Enxp3ewXKVAyIUhHPHg/mjd2h2Zua5hB4rqXyrfdpMo8bRrjsHzh9AYbbnbckSa9osPJXftSB5uRID5WlOIqbMMsEUTO40Wd0MYg3ndKlQvmF2Vki2wvoxL1Es3PGR0Bxtrg2AjoJOeSuyffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548073; c=relaxed/simple;
	bh=FeGhKK7HKYftvaCCImcMeFqf7zocGpe0177CE24sKQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cC2pRN8XuPmZoDZx2JTPi548mSNA9HNEwVPoyV27SyNbYzERgB9Z0QeWSn8ZQnVSAmFtdiWaY9d7i5wL/A9tRwEe6GUkjNR8CKnvmr6hLK79raLU7omyS47DVXBYC5TvF4LfxSrKNrJ003fxAzR8TrEQ3DoinaQ9tjrn1i7A6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JgDBqKtS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JgDBqKtS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b01d8d976faso670082a12.0
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746548071; x=1747152871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WRNweJbn4r/3TvWDCNLlpaWwC6HbAU8UMzkpb3TS/E=;
        b=JgDBqKtS1T1/gCQmYkS4XKWYS6uGlYQoGJCgFbQZE30KD0qX9Y0BTnPWnxpcIg1G93
         KNBOzD3b8l/uVC3oSf4RezM7fMtg8EYrrRJlfDNLDIBngV9NH+9Ys+XKISvH1w7P9Sfk
         PNQq59IdTXjHB0KrIuvLpNYe4AqdGHVTCzKXpQYiPEze41Ys+HYxsYbrmYC9ZmWj4c9e
         AbtoBLtVOuy/cn8iGc2Sw5QHrCqIZOpCXzEIocz/Yv4/nh6tinIDcX4zQNReME0esI+J
         Mr4cW0PqlM5UkkneAGCBaEh8K1NnXgGboKk/6QjZUGYO1XRJb9SgYUfehZLWZb6gEc7+
         7eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548071; x=1747152871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WRNweJbn4r/3TvWDCNLlpaWwC6HbAU8UMzkpb3TS/E=;
        b=AlWmJuaERAQrsS9oceUnbi9coX359kVmtiBczbzc+ubZikV5ATlTfv4aO6TYqDaLPf
         NgI/g1oPD77TVCXoL1O3zG7fuvbbWPG3SYP69MZsGPVb/wP3yPkFFseO1dOXkYtzHMw1
         yL0cATI35r7pa3ESgeD5IduIbL7Os2GkfGNiL3avbrc9/oA9gPTmCP1b70Ep1evOE1Lk
         Y2FwEUc2WKrZp/A0DSHNUf3qXCmsMNN0SMcyjEYIfoD4+NuNc7p169kf/44tEjA8nDeK
         y4Ln+0k4fffB77QZls/6+prBllY1jP1u9NqhQEtkidjbUtQOBAq2S6BBReLg13jFSERs
         XR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJntUhUhmbN5Clni6uOQUSuStqz4miN+ktHoNGBdWeljTIwg7qobzk2Lv11vJ1+3KKHTz2XF+KB9rH8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ79IIymoQWXyiHzAbB3R2KcjpT9iw6BRAqV0xHjPNgMIC9hjB
	OmLQlz44BiZ0L2rfu6lnmxdyJxL8mtAYhSt0agKctZhF7GM3psy9A12dxBs7WdMFyRpFTXYb8Mb
	XD5EjFf74PaOI7UNiA4sbyfrfLmC/U0NMPs0Sdw==
X-Gm-Gg: ASbGnct162m8NWeqP5Y03eFtX+IQqTJ8nBgFlFRkPStBHiqWvpdlnui/5brJdpz5nCr
	hMJDmV7ZELTQZTBfO5uylcqVuutocCol6Z7rm2nsOharE6sIKz3vf5iAFWfZx/I7pC6wCJq5FaN
	o4EpzOVb90TLAP2VxRFRLG
X-Google-Smtp-Source: AGHT+IGomfxFuIVXIAJx2LE0nyDyaX/EDbj1YgVtK5jOGH1/g4wQgUzQAReH/W/vN9YObV6vQ1hyrrqDB71RRmZm9tk=
X-Received: by 2002:a17:90b:1a89:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30aac173ebcmr39388a91.1.1746548070717; Tue, 06 May 2025
 09:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250506122653epcas5p1824d4af64d0b599fde2de831d8ebf732@epcas5p1.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com> <20250506121732.8211-12-joshi.k@samsung.com>
In-Reply-To: <20250506121732.8211-12-joshi.k@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 09:14:19 -0700
X-Gm-Features: ATxdqUGbCedLb2BDJsLzNQ4a09UlvzPN29Syr7Nwkf-EIDAeNNy85cp_G9DdiZA
Message-ID: <CADUfDZrWstGcx+EqsmaQvSJJrMAK-Ls+HtGyS8j3okZQ+N4FKQ@mail.gmail.com>
Subject: Re: [PATCH v16 11/11] nvme: use fdp streams if write stream is provided
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:31=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Maps a user requested write stream to an FDP placement ID if possible.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f25e03ff03df..52331a14bce1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -672,6 +672,7 @@ static void nvme_free_ns_head(struct kref *ref)
>         ida_free(&head->subsys->ns_ida, head->instance);
>         cleanup_srcu_struct(&head->srcu);
>         nvme_put_subsystem(head->subsys);
> +       kfree(head->plids);
>         kfree(head);
>  }
>
> @@ -995,6 +996,18 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
_ns *ns,
>         if (req->cmd_flags & REQ_RAHEAD)
>                 dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
>
> +       if (op =3D=3D nvme_cmd_write && ns->head->nr_plids) {
> +               u16 write_stream =3D req->bio->bi_write_stream;
> +
> +               if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
> +                       return BLK_STS_INVAL;
> +
> +               if (write_stream) {
> +                       dsmgmt |=3D ns->head->plids[write_stream - 1] << =
16;
> +                       control |=3D NVME_RW_DTYPE_DPLCMT;
> +               }
> +       }
> +
>         if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
>                 return BLK_STS_INVAL;
>
> @@ -2240,7 +2253,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>         struct nvme_fdp_config fdp;
>         struct nvme_command c =3D {};
>         size_t size;
> -       int ret;
> +       int i, ret;
>
>         /*
>          * The FDP configuration is static for the lifetime of the namesp=
ace,
> @@ -2280,6 +2293,22 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
 struct nvme_ns_info *info)
>         }
>
>         head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
> +       if (!head->nr_plids)
> +               goto free;
> +
> +       head->plids =3D kcalloc(head->nr_plids, sizeof(head->plids),
> +                             GFP_KERNEL);

Should this be sizeof(*head->plids)?

Best,
Caleb

> +       if (!head->plids) {
> +               dev_warn(ctrl->device,
> +                        "failed to allocate %u FDP placement IDs\n",
> +                        head->nr_plids);
> +               head->nr_plids =3D 0;
> +               ret =3D -ENOMEM;
> +               goto free;
> +       }
> +
> +       for (i =3D 0; i < head->nr_plids; i++)
> +               head->plids[i] =3D le16_to_cpu(ruhs->ruhsd[i].pid);
>  free:
>         kfree(ruhs);
>         return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 3e14daa4ed3e..7aad581271c7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -498,6 +498,7 @@ struct nvme_ns_head {
>         struct gendisk          *disk;
>
>         u16                     nr_plids;
> +       u16                     *plids;
>  #ifdef CONFIG_NVME_MULTIPATH
>         struct bio_list         requeue_list;
>         spinlock_t              requeue_lock;
> --
> 2.25.1
>
>
