Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757B283FDB
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548037; cv=none; b=KeJIOTiVWilGWFGmE6z5/AsQlzReyowy6Y5o6iSGLPcudKshaFMOTrjkBepRgIrA66efo/BeQ8VgiqRV+HyNpKy52fBNHtAOFztGb3AszwIezKg5UQyzAm9iQClE+wL/rvryVSMgqcZJpjeAOrIIse2df46XKMP+I7XeYu1afFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548037; c=relaxed/simple;
	bh=ctEJGduRkC2qEEhy+2LbPD9UxeStYYphXNtfefVEQbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moK4rSC4fsVmnMsmOGhb+KnujglBEMj+VNrixpPntxL3Qp2vPPTAO92HthmZhlPSuIvVFIwsSgFyqcFHF7tfONQUB20dE4Ie1qaMnHn8s0yOwcPtUTW8HJ0i+Ub4NO/hBf/fEBpsfPfFnsA47YmjMpex2DOzN7urqlO9zlNZnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VolozZ25; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VolozZ25"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a8831e462so116160a91.0
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746548035; x=1747152835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYWN5cRoGfT1PfSiqnzPsV4NQG6bqVTjCaW1CwrUJcM=;
        b=VolozZ256Rjn+7z/1yPNGVRV2dWyQz7KeNP+GPWRI27v7l4LDHNdarr+IO0roMDhHi
         QJdN8FpiAfP2cIMaWWfIOx1P+BKxoaWixKq3Aaqu1lDJtYG0K3A9R6HUrxLRFnvsFmQ/
         l97DHLF1PzselBbPbVyqge5o2j+gwG3be5QV7bNmpkCz74aVyO5MrjE5wM3hLpgtWb6P
         tePYqkt++pdXtZvhk9BSjDwB3Haxpyqa61aYdBPKs5xQ+0gNdnOXAfCieurCoi9VZaEU
         3p9/ySYSXXjLvGB0FZE7Z8O29F0Uqc7ogumV9jWtsRTgx9c1ZnPXxL1FXY74hgnoP01c
         qO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548035; x=1747152835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYWN5cRoGfT1PfSiqnzPsV4NQG6bqVTjCaW1CwrUJcM=;
        b=magVNs/xY2Zo05AqWKfynUsXWUExNAYTjEVda6BFyX6Q+3MdCiYMU5fJ2iQnqCfz9+
         ulUadxZVjIegucASYio0a/k1K4V/UVG1fdYdIIJs0Vr6Sh26Y09ZDbtWfSs2eqGAFjt7
         tOwy43P5p5nNNQS6ddcry4TSvQsuA+BNo9F9zxBfI2al1/Y9e6f8cdvORy98PGLiPxAO
         TQKyGvoWrsntJwVx39bnig0BDBkuee5LuSK/w6VoCyw2ndNJuU8gSB8SeLsM7mE+ORtG
         7yrhS6MJ5bw5tVOPX+gBwajQ/gC6RV68sz6VMbfD75SbawZKPlpYKFeXKfqkP2cCZqX5
         QHaA==
X-Forwarded-Encrypted: i=1; AJvYcCW3/f4mdsoWfkxegJ2aNb8SvGY0WK/6MgHTz3um3A54D/D/uWQ3SmgUiY5eIbw1nBJM6Cu5/3Xzfg5Z9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iBgvYNbxh3Fm18gvS7YTgGgLy55is7OAQRh/9tKZqTd5sLfr
	R8f5rWoMMYVez2xYD13xyEHDU86NdyKcJVpezGxZq0wx6WNmX6Zqamte0ZSMci5Z0g4aJ5AF18R
	G6KR+MbIcFVg2UX7cGdxHqBR+d71E8kgljM2Z0g==
X-Gm-Gg: ASbGnctwH1gMwkTTBfUtge7WhZOBalFyev5PGXhmOL7yPtskHdmLynYh5d3Ic6fGR16
	vfD9l0e2c+owGQyakVC9j4pXG1bW3tEQLuWwOOF8UFOJrbbFcCDYvrdsdIjnrfdYU8fb+mpGyjc
	c7s9Va0eAtBsWgNr86hG4K
X-Google-Smtp-Source: AGHT+IGOvJyPbLr4kwXZSGT/2CsH/jVCIq02WBu70npsFnHamIQl6sWwQf+KO12hU6AkAJPFapxgBzCBfCm4l5n/zjI=
X-Received: by 2002:a17:90b:33c1:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30aac16c2e2mr36846a91.1.1746548035169; Tue, 06 May 2025
 09:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250506122651epcas5p4100fd5435ce6e6686318265b414c1176@epcas5p4.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com> <20250506121732.8211-11-joshi.k@samsung.com>
In-Reply-To: <20250506121732.8211-11-joshi.k@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 09:13:33 -0700
X-Gm-Features: ATxdqUE6maBvoXv4TdPf4qTULxuJw6-FSb-pKV6qaK5B-HKqjYsETzXEW4MddQU
Message-ID: <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com>
Subject: Re: [PATCH v16 10/11] nvme: register fdp parameters with the block layer
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
> Register the device data placement limits if supported. This is just
> registering the limits with the block layer. Nothing beyond reporting
> these attributes is happening in this patch.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/core.c | 144 +++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |   2 +
>  2 files changed, 146 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd71b4c2b7b7..f25e03ff03df 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -38,6 +38,8 @@ struct nvme_ns_info {
>         u32 nsid;
>         __le32 anagrpid;
>         u8 pi_offset;
> +       u16 endgid;
> +       u64 runs;
>         bool is_shared;
>         bool is_readonly;
>         bool is_ready;
> @@ -1611,6 +1613,7 @@ static int nvme_ns_info_from_identify(struct nvme_c=
trl *ctrl,
>         info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
>         info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
>         info->is_ready =3D true;
> +       info->endgid =3D le16_to_cpu(id->endgid);
>         if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
>                 dev_info(ctrl->device,
>                          "Ignoring bogus Namespace Identifiers\n");
> @@ -1651,6 +1654,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
>                 info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
>                 info->is_rotational =3D id->nsfeat & NVME_NS_ROTATIONAL;
>                 info->no_vwc =3D id->nsfeat & NVME_NS_VWC_NOT_PRESENT;
> +               info->endgid =3D le16_to_cpu(id->endgid);
>         }
>         kfree(id);
>         return ret;
> @@ -2155,6 +2159,132 @@ static int nvme_update_ns_info_generic(struct nvm=
e_ns *ns,
>         return ret;
>  }
>
> +static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
> +                                     struct nvme_ns_info *info, u8 fdp_i=
dx)
> +{
> +       struct nvme_fdp_config_log hdr, *h;
> +       struct nvme_fdp_config_desc *desc;
> +       size_t size =3D sizeof(hdr);
> +       void *log, *end;
> +       int i, n, ret;
> +
> +       ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> +                              NVME_CSI_NVM, &hdr, size, 0, info->endgid)=
;
> +       if (ret) {
> +               dev_warn(ctrl->device,
> +                        "FDP configs log header status:0x%x endgid:%d\n"=
, ret,
> +                        info->endgid);
> +               return ret;
> +       }
> +
> +       size =3D le32_to_cpu(hdr.sze);
> +       if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
> +               dev_warn(ctrl->device, "FDP config size too large:%zu\n",
> +                        size);
> +               return 0;
> +       }
> +
> +       h =3D kvmalloc(size, GFP_KERNEL);
> +       if (!h)
> +               return -ENOMEM;
> +
> +       ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> +                              NVME_CSI_NVM, h, size, 0, info->endgid);
> +       if (ret) {
> +               dev_warn(ctrl->device,
> +                        "FDP configs log status:0x%x endgid:%d\n", ret,
> +                        info->endgid);
> +               goto out;
> +       }
> +
> +       n =3D le16_to_cpu(h->numfdpc) + 1;
> +       if (fdp_idx > n) {
> +               dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
> +                        fdp_idx, n);
> +               /* Proceed without registering FDP streams */
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       log =3D h + 1;
> +       desc =3D log;
> +       end =3D log + size - sizeof(*h);
> +       for (i =3D 0; i < fdp_idx; i++) {
> +               log +=3D le16_to_cpu(desc->dsze);
> +               desc =3D log;
> +               if (log >=3D end) {
> +                       dev_warn(ctrl->device,
> +                                "FDP invalid config descriptor list\n");
> +                       ret =3D 0;
> +                       goto out;
> +               }
> +       }
> +
> +       if (le32_to_cpu(desc->nrg) > 1) {
> +               dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       info->runs =3D le64_to_cpu(desc->runs);
> +out:
> +       kvfree(h);
> +       return ret;
> +}
> +
> +static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *=
info)
> +{
> +       struct nvme_ns_head *head =3D ns->head;
> +       struct nvme_ctrl *ctrl =3D ns->ctrl;
> +       struct nvme_fdp_ruh_status *ruhs;
> +       struct nvme_fdp_config fdp;
> +       struct nvme_command c =3D {};
> +       size_t size;
> +       int ret;
> +
> +       /*
> +        * The FDP configuration is static for the lifetime of the namesp=
ace,
> +        * so return immediately if we've already registered this namespa=
ce's
> +        * streams.
> +        */
> +       if (head->nr_plids)
> +               return 0;
> +
> +       ret =3D nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL=
, 0,
> +                               &fdp);
> +       if (ret) {
> +               dev_warn(ctrl->device, "FDP get feature status:0x%x\n", r=
et);
> +               return ret;
> +       }
> +
> +       if (!(fdp.flags & FDPCFG_FDPE))
> +               return 0;
> +
> +       ret =3D nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
> +       if (!info->runs)
> +               return ret;
> +
> +       size =3D struct_size(ruhs, ruhsd, S8_MAX - 1);
> +       ruhs =3D kzalloc(size, GFP_KERNEL);
> +       if (!ruhs)
> +               return -ENOMEM;
> +
> +       c.imr.opcode =3D nvme_cmd_io_mgmt_recv;
> +       c.imr.nsid =3D cpu_to_le32(head->ns_id);
> +       c.imr.mo =3D NVME_IO_MGMT_RECV_MO_RUHS;
> +       c.imr.numd =3D cpu_to_le32(nvme_bytes_to_numd(size));
> +       ret =3D nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
> +       if (ret) {
> +               dev_warn(ctrl->device, "FDP io-mgmt status:0x%x\n", ret);
> +               goto free;
> +       }
> +
> +       head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
> +free:
> +       kfree(ruhs);
> +       return ret;
> +}
> +
>  static int nvme_update_ns_info_block(struct nvme_ns *ns,
>                 struct nvme_ns_info *info)
>  {
> @@ -2192,6 +2322,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>                         goto out;
>         }
>
> +       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> +               ret =3D nvme_query_fdp_info(ns, info);
> +               if (ret < 0)
> +                       goto out;
> +       }
> +
>         lim =3D queue_limits_start_update(ns->disk->queue);
>
>         memflags =3D blk_mq_freeze_queue(ns->disk->queue);
> @@ -2225,6 +2361,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>         if (!nvme_init_integrity(ns->head, &lim, info))
>                 capacity =3D 0;
>
> +       lim.max_write_streams =3D ns->head->nr_plids;
> +       if (lim.max_write_streams)
> +               lim.write_stream_granularity =3D max(info->runs, U32_MAX)=
;

What is the purpose of this max(..., U32_MAX)? Should it be min() instead?

Best,
Caleb

> +       else
> +               lim.write_stream_granularity =3D 0;
> +
>         ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
>         if (ret) {
>                 blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> @@ -2328,6 +2470,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>                         ns->head->disk->flags |=3D GENHD_FL_HIDDEN;
>                 else
>                         nvme_init_integrity(ns->head, &lim, info);
> +               lim.max_write_streams =3D ns_lim->max_write_streams;
> +               lim.write_stream_granularity =3D ns_lim->write_stream_gra=
nularity;
>                 ret =3D queue_limits_commit_update(ns->head->disk->queue,=
 &lim);
>
>                 set_capacity_and_notify(ns->head->disk, get_capacity(ns->=
disk));
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index aedb734283b8..3e14daa4ed3e 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -496,6 +496,8 @@ struct nvme_ns_head {
>         struct device           cdev_device;
>
>         struct gendisk          *disk;
> +
> +       u16                     nr_plids;
>  #ifdef CONFIG_NVME_MULTIPATH
>         struct bio_list         requeue_list;
>         spinlock_t              requeue_lock;
> --
> 2.25.1
>
>
