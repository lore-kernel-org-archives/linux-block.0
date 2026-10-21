Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544487;
	b=PYiuLyCytsY9sxY6B+NeFt6vC0kbMfZxC4p89QqP3WjxJ4tqNlfKFxG5onS4UMXzHaiP
	 ypyakFcoUi4IDWlX6ChRL3FfuGakoMrWOwcjO5h008SZQRDSyaFSqYW6/9GsUbEcr5QS5
	 zGbDdtIwAzZvy1BtusrfkGk3wmj/psP9Im/KJwEueJw5V0f8ymf1HALymCMDxvkckbFCH
	 QyFrNqi5e8sgsGLxZkTepOVw7sMWww2C48SNLuTHCx0G7gw0t7vmYysDsyaIOnbxr4lwl
	 6JgBDeMgrjsK90THng7KnRoKaOa+wcZyJ09K3JZjJh+rmwwj3ae8Yrgt92tb+iwI2ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
	b=Z7h41B9x37zqFQ4FlMKhAFm/91M1LTkxwMHopnTtUSZIRqwdB2flh9vHEJBnJnU6O42R
	 mpUFD28o6kAZEkO/r/10fkv3aca8/5U3AjHT0HOOyjOXKjObqgdweIlOYrb9/oZIZsUbP
	 xxXrpNiiVim3d3OfIAXO3C/uw3owSXMxoy1vDkAQ7MLN+xrn49kBiX3WOmLw562nrtQPD
	 32NYxIlGWFDJGyeKv3imvI80T1gewhMmkwCVWPNxPQ/lWD4pMCz9Xc2FA9YvaUi+w1hsK
	 lNzYJCnM6N0pwDZuZs1yBfu5T1bbgDPYesHBshyUp53jsReojrOgL8msNO2Rc5TXtMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQ4M66GL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA1606A321
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 01:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQ4M66GL
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53ec92375d2so117714b6e.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 18:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544485; cv=none;
        d=google.com; s=arc-20260327;
        b=M3uX0TODJOkuo+n66X/j6yrMJ3zTh10dwRa/BlY5BjoMka4Pjdylx/O0dfEDG53BmZ
         Fz/rB+b9U/bkGocqnmIysnrMGc6IitpG84WCIHasMPOGRtTWTl3HwTiZolbKydhoOtBS
         4ZjmskCrO0GsRogdo3+7emKkhOAhl0UKFQSQtYhyffUoiZYlieYArvOV1CBbqrsCF8JE
         5/+Q7/PsZjqZilAk4HBGw7EvXQPZs1aLAUOLPC5LZylxRbCY55yzqpnmuIW2a++tfkpM
         D26dT07a8c0xuXeXL+wTWZm3OKR7NQ4/pxqdmz+YfRt4Z8jOciL8Veyb8scnXL9S/ft2
         3PSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        fh=c+ahA9DOxEJpXTk3bQMtxyR0vtaUpUF8jNl8oV7M/g0=;
        b=Chf47rlxOrwgRfBKegyIJkZFdsyCCGTAHb0iA2ZBhqwaltU0XyZGnuSF1IxwlgnGoR
         hGaWqatv7a74n2a9FZw5yPqy8ifmRJuYj2IPf+DRNQWHKKZOFKdpBSwJt91l7M+hVIlg
         MVnLPFEGd6nk3x/SrDGIXeStjFCEVHmErD21OluUO55GC19K7uvlc1ovSBRZnYy3Pxee
         6VOB8Uo3KHoeSCzLAGlRL5wQkg+Lsg7sQPc6qE3vXu9Brx6/LGG9gQOiGYgF8ZAQcEtQ
         Vz2ml3H681/vY+OxFq+aRcRvqxVg+mINxqmIgrMEV6/00b/TKRlP80eHpJp0gbCtok3J
         g2EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544485; x=1793149285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        b=RQ4M66GLU9ef17wCLB+WCgS2nvMDKuICeaSUq/hkdumJICcZPBGREDxkSoAFbZINWG
         B+bfYSu9eOD4zesOc9i8AFBQjBWRBXjFGSLDtbmy5+v29Y3hgl20+yJeTWN9rKUwScuf
         KsO0aWOgpkTL9qCItooVUJ/UFSycDneknrHXmqHXc0oTPrKrd8N/0tNibzP0UrQ9bYIE
         ZDFer4+etiK67gKVrdT3QtWzczU+Bu3PLCkojnSHDFKcf8Z5ZtJKiBZOZLbiaVVV9NMK
         6PMpHV1aTTEU44J6I83nsBBJ/w/EJT5oSD2uN9qEVtNG9N63rAqdK27Spy1EGclxcxrW
         ie1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544485; x=1793149285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        b=KquIOoDs6LHqpTtVhY3krYrWZMV/Nl1zOEWpHUlp4GhlkQD7NN4xw91Kp7bD7ac/2s
         EDGi3mHgrgzZgapXBjuHkOD7RJW6MKJgDmxyP5D93cwVMieefAt/QLhtGdOTr8ttmUEg
         GDtVID58Aq2vM0SRmXdAohSgIkk7YfvTnwr3vrV72Oqwi1vcerLotrijdm/X3tYFUjAg
         cL6LkZiaIL5auDQPW4d+QaLQzJLm9RrBhOrkj3NrUZE4eZihyQRAlyNoQ1D7k3g5ZYjB
         4xr2I4/0dCDo3Pr+fvOZIGFuZF7SQbTWQdNknKqcXraQ3llD2/V/+FpuoUIv+FeSyRen
         Q/rA==
X-Forwarded-Encrypted: i=1; AKwUvBxedeKqfVFJPZT+ZEC0pitcJaXkUwn5KQflewozE9+kCLuYsuuLo/AXIVMTdpiqo568DZEs/5YiSdisDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYId8Bdic84ODP0eowlYDCpb3M6+5UIHpG10sdRjCxwC4IWO2dS7
	K95IzUeuBq6NM57Jb0S+g4yvqpEnOSrtII3Sj0O+QNiZEaRX8F1WKr9SFE/kJ4Kslaf+2cMB7Hk
	ejr4QPcULoLP2SisbmJ8S6CElAQF5kyQ=
X-Gm-Gg: AYBFou2ZikapUpafTcZvWsQLLuDaAKxKARNlGSGFlEEQnpDLWVHsEQ5G4QIF6JGNMaO
	dId43FNqsHEOYaKARyC8OZ3XGfEJeG6qIV333kjP0pBot9SGEV4yesInQH6tfQIMfubQFGuO6tb
	dI5N8rEHeO/XekP4H3YCSp2Kl+N52vybXVA3ELUJDrVGv/4py28xtEEKa9dhISCIPK6jklFmjpc
	9yxL3Vs2mYdtek8lqQC7+anJ9cz6oc+FLadfk9F4X2v5yv+tgszOjfNUT0H6HF/rye5IITdcqaY
	8gEZvSF+Jpw2mdQ0oYJUnTEmEHdGns8lctTacTpxiSZbxniwSNxrczF1NIF4rCnlYv2whuaWnNf
	POucGVf0KeR7BRNiLx0PeuTzS13rPoVpYRlANiURKEeandCVgj284MES/MBUQ3ETRMCIo
X-Received: by 2002:a05:6808:2507:b0:54f:ee4e:51ed with SMTP id
 5614622812f47-553557b3c63mr401658b6e.19.1792544482984; Tue, 20 Oct 2026
 18:01:22 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002152821.410591-1-yupeng0921@gmail.com>
In-Reply-To: <20261002152821.410591-1-yupeng0921@gmail.com>
From: peng yu <yupeng0921@gmail.com>
Date: Tue, 20 Oct 2026 18:01:12 -0700
X-Gm-Features: AclHuK_n6qsIakhZRQK5TQcKEGD7lzYcbicyH70R9FV2PExAFzVNyl2NSTa2zSY
Message-ID: <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
Subject: Re: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun, does this patch look good from the cgroup perspective?


On Fri, Oct 2, 2026 at 8:28=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> wrote=
:
>
> nvmet issues namespace I/O from kernel threads, which are in the root
> cgroup, so io.max and the other io controller settings can't be applied
> per namespace. When namespaces on shared storage, e.g. LVM volumes on
> the same physical volumes, are exported to different users, nothing
> stops a noisy user from slowing down the others. Unlike loop, there is
> no userspace process whose cgroup could be used instead.
>
> Add a cgroup_id namespace attribute that takes a cgroup2 ID. While the
> namespace is enabled, nvmet holds the cgroup and charges each command's
> I/O to the cgroup's effective io css. Block device and file backed
> namespaces are supported, but not buffered_io: buffered writes are
> written back later by flusher threads that don't know the namespace's
> cgroup.
>
> Signed-off-by: Peng Yu <yupeng0921@gmail.com>
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> ---
> Change since v7:
> * Write the commit message as prose (Tejun).
> * Add a Documentation/ABI/stable/configfs-nvmet entry for cgroup_id
>   (Tejun).
> * Associate the read/write, flush and zone append bios through
>   nvmet_blkcg_begin()/end() and drop nvmet_blkcg_set_bio(), so each
>   bio is associated only once (Tejun).
> * v7 1/2 was applied to cgroup/for-7.4 as d5632ae01502 ("cgroup: Track
>   the effective css in each cgroup"). This patch doesn't depend on it.
>
> v7 (with test steps): https://lore.kernel.org/all/20260929232411.101087-1=
-yupeng0921@gmail.com/
>
>  Documentation/ABI/stable/configfs-nvmet | 15 +++++++
>  drivers/nvme/target/configfs.c          | 47 +++++++++++++++++++++
>  drivers/nvme/target/core.c              | 54 +++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-bdev.c       | 22 +++++++++-
>  drivers/nvme/target/io-cmd-file.c       | 21 +++++++++-
>  drivers/nvme/target/nvmet.h             | 42 +++++++++++++++++++
>  drivers/nvme/target/zns.c               |  7 ++++
>  7 files changed, 205 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/=
stable/configfs-nvmet
> index 36b587404ee7..bdcb705aa8c9 100644
> --- a/Documentation/ABI/stable/configfs-nvmet
> +++ b/Documentation/ABI/stable/configfs-nvmet
> @@ -314,6 +314,21 @@ Description:
>                 attr_subsys_vendor_id: Shows or sets the PCI subsystem
>                 vendor ID. Displayed in "0x%x" format.
>
> +What:          /config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_id
> +Date:          October 2026
> +KernelVersion: 7.4
> +Contact:       Peng Yu <yupeng0921@gmail.com>
> +Description:
> +               Shows or sets the cgroup2 ID of the cgroup to charge this
> +               namespace's I/O to. Writing 0 clears it. The I/O is
> +               charged to the cgroup's effective io css: the cgroup
> +               itself or its nearest ancestor with the io controller
> +               enabled. The namespace must be disabled before
> +               modification. Enabling the namespace fails if the cgroup
> +               can't be found or if buffered_io is set.
> +
> +               Only available when CONFIG_BLK_CGROUP is enabled.
> +
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_hash
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 6286e38436dd..cef832303d72 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -561,6 +561,50 @@ static ssize_t nvmet_ns_device_path_store(struct con=
fig_item *item,
>
>  CONFIGFS_ATTR(nvmet_ns_, device_path);
>
> +#ifdef CONFIG_BLK_CGROUP
> +static ssize_t nvmet_ns_cgroup_id_show(struct config_item *item, char *p=
age)
> +{
> +       struct nvmet_ns *ns =3D to_nvmet_ns(item);
> +       struct nvmet_subsys *subsys =3D ns->subsys;
> +       ssize_t ret;
> +
> +       mutex_lock(&subsys->lock);
> +       ret =3D snprintf(page, PAGE_SIZE, "%llu\n", ns->cgroup_id);
> +       mutex_unlock(&subsys->lock);
> +       return ret;
> +}
> +
> +static ssize_t nvmet_ns_cgroup_id_store(struct config_item *item,
> +               const char *page, size_t count)
> +{
> +       struct nvmet_ns *ns =3D to_nvmet_ns(item);
> +       struct nvmet_subsys *subsys =3D ns->subsys;
> +       u64 cgroup_id;
> +       int ret;
> +
> +       ret =3D kstrtou64(page, 0, &cgroup_id);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&subsys->lock);
> +
> +       if (ns->enabled) {
> +               ret =3D -EBUSY;
> +               goto out_unlock;
> +       }
> +
> +       /* Writing 0 clears the association. */
> +       ns->cgroup_id =3D cgroup_id;
> +       ret =3D count;
> +
> +out_unlock:
> +       mutex_unlock(&subsys->lock);
> +       return ret;
> +}
> +
> +CONFIGFS_ATTR(nvmet_ns_, cgroup_id);
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  #ifdef CONFIG_PCI_P2PDMA
>  static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page=
)
>  {
> @@ -833,6 +877,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] =
=3D {
>         &nvmet_ns_attr_buffered_io,
>         &nvmet_ns_attr_revalidate_size,
>         &nvmet_ns_attr_resv_enable,
> +#ifdef CONFIG_BLK_CGROUP
> +       &nvmet_ns_attr_cgroup_id,
> +#endif
>  #ifdef CONFIG_PCI_P2PDMA
>         &nvmet_ns_attr_p2pmem,
>  #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..6d9d55eb11eb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2015-2016 HGST, a Western Digital Company.
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/cgroup.h>
>  #include <linux/hex.h>
>  #include <linux/module.h>
>  #include <linux/random.h>
> @@ -474,8 +475,57 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
>         percpu_ref_put(&ns->ref);
>  }
>
> +#ifdef CONFIG_BLK_CGROUP
> +static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> +{
> +       struct cgroup *cgrp;
> +
> +       if (!ns->cgroup_id)
> +               return 0;
> +
> +       /*
> +        * Buffered writes will be handled by a separate thread,
> +        * these IOs have no namespace/cgroup information at that time,
> +        * so we don't support buffered io.
> +        */
> +       if (ns->buffered_io) {
> +               pr_err("cgroup_id is not supported with buffered_io: %s\n=
",
> +                      ns->device_path);
> +               return -EINVAL;
> +       }
> +
> +       cgrp =3D cgroup_get_from_id(ns->cgroup_id);
> +       if (IS_ERR(cgrp)) {
> +               pr_err("failed to resolve cgroup id %llu: %ld\n",
> +                      ns->cgroup_id, PTR_ERR(cgrp));
> +               return PTR_ERR(cgrp);
> +       }
> +
> +       ns->cgrp =3D cgrp;
> +       return 0;
> +}
> +
> +static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
> +{
> +       if (ns->cgrp) {
> +               cgroup_put(ns->cgrp);
> +               ns->cgrp =3D NULL;
> +       }
> +}
> +#else
> +static inline int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> +{
> +       return 0;
> +}
> +
> +static inline void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
> +{
> +}
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
>  {
> +       nvmet_blkcg_ns_disable(ns);
>         nvmet_bdev_ns_disable(ns);
>         nvmet_file_ns_disable(ns);
>  }
> @@ -602,6 +652,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>         if (ret)
>                 goto out_unlock;
>
> +       ret =3D nvmet_blkcg_ns_enable(ns);
> +       if (ret)
> +               goto out_dev_disable;
> +
>         ret =3D nvmet_p2pmem_ns_enable(ns);
>         if (ret)
>                 goto out_dev_disable;
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index f2d9e8901df4..615a403d2e06 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -262,6 +262,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>         struct sg_mapping_iter prot_miter;
>         unsigned int iter_flags;
>         unsigned int total_len =3D nvmet_rw_data_len(req) + req->metadata=
_len;
> +       bool associated;
>
>         if (!nvmet_check_transfer_len(req, total_len))
>                 return;
> @@ -289,6 +290,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>
>         sector =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         if (nvmet_use_inline_bvec(req)) {
>                 bio =3D &req->b.inline_bio;
>                 bio_init(bio, req->ns->bdev, req->inline_bvec,
> @@ -315,6 +317,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                                 rc =3D nvmet_bdev_alloc_bip(req, bio,
>                                                           &prot_miter);
>                                 if (unlikely(rc)) {
> +                                       nvmet_blkcg_end(associated);
>                                         bio_io_error(bio);
>                                         return;
>                                 }
> @@ -331,6 +334,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                 sector +=3D sg->length >> 9;
>                 sg_cnt--;
>         }
> +       nvmet_blkcg_end(associated);
>
>         if (req->metadata_len) {
>                 rc =3D nvmet_bdev_alloc_bip(req, bio, &prot_miter);
> @@ -347,6 +351,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>  {
>         struct bio *bio =3D &req->b.inline_bio;
> +       bool associated;
>
>         if (!bdev_write_cache(req->ns->bdev)) {
>                 nvmet_req_complete(req, NVME_SC_SUCCESS);
> @@ -356,8 +361,10 @@ static void nvmet_bdev_execute_flush(struct nvmet_re=
q *req)
>         if (!nvmet_check_transfer_len(req, 0))
>                 return;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         bio_init(bio, req->ns->bdev, req->inline_bvec,
>                  ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUS=
H);
> +       nvmet_blkcg_end(associated);
>         bio->bi_private =3D req;
>         bio->bi_end_io =3D nvmet_bio_done;
>
> @@ -366,10 +373,16 @@ static void nvmet_bdev_execute_flush(struct nvmet_r=
eq *req)
>
>  u16 nvmet_bdev_flush(struct nvmet_req *req)
>  {
> +       bool associated;
> +       int ret;
> +
>         if (!bdev_write_cache(req->ns->bdev))
>                 return 0;
>
> -       if (blkdev_issue_flush(req->ns->bdev))
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D blkdev_issue_flush(req->ns->bdev);
> +       nvmet_blkcg_end(associated);
> +       if (ret)
>                 return NVME_SC_INTERNAL | NVME_STATUS_DNR;
>         return 0;
>  }
> @@ -380,9 +393,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_=
req *req)
>         struct nvme_dsm_range range;
>         struct bio *bio =3D NULL;
>         sector_t nr_sects;
> +       bool associated;
>         int i;
>         u16 status =3D NVME_SC_SUCCESS;
>
> +       associated =3D nvmet_blkcg_begin(ns);
>         for (i =3D 0; i <=3D le32_to_cpu(req->cmd->dsm.nr); i++) {
>                 status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &r=
ange,
>                                 sizeof(range));
> @@ -394,6 +409,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_r=
eq *req)
>                                 nvmet_lba_to_sect(ns, range.slba), nr_sec=
ts,
>                                 GFP_KERNEL, &bio);
>         }
> +       nvmet_blkcg_end(associated);
>
>         if (bio) {
>                 bio->bi_private =3D req;
> @@ -431,6 +447,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nv=
met_req *req)
>         struct bio *bio =3D NULL;
>         sector_t sector;
>         sector_t nr_sector;
> +       bool associated;
>         int ret;
>
>         if (!nvmet_check_transfer_len(req, 0))
> @@ -440,8 +457,11 @@ static void nvmet_bdev_execute_write_zeroes(struct n=
vmet_req *req)
>         nr_sector =3D (((sector_t)le16_to_cpu(write_zeroes->length) + 1) =
<<
>                 (req->ns->blksize_shift - 9));
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         ret =3D __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
>                         GFP_KERNEL, &bio, 0);
> +       nvmet_blkcg_end(associated);
> +
>         if (bio) {
>                 bio->bi_private =3D req;
>                 bio->bi_end_io =3D nvmet_bio_done;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index 0b22d183f927..570e65259ad8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -79,6 +79,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req =
*req, loff_t pos,
>         struct kiocb *iocb =3D &req->f.iocb;
>         ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
>         struct iov_iter iter;
> +       bool associated;
> +       ssize_t ret;
>         int rw;
>
>         if (req->cmd->rw.opcode =3D=3D nvme_cmd_write) {
> @@ -97,7 +99,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req=
 *req, loff_t pos,
>         iocb->ki_filp =3D req->ns->file;
>         iocb->ki_flags =3D ki_flags | iocb->ki_filp->f_iocb_flags;
>
> -       return call_iter(iocb, &iter);
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D call_iter(iocb, &iter);
> +       nvmet_blkcg_end(associated);
> +       return ret;
>  }
>
>  static void nvmet_file_io_done(struct kiocb *iocb, long ret)
> @@ -251,7 +256,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *=
req)
>
>  u16 nvmet_file_flush(struct nvmet_req *req)
>  {
> -       return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
> +       bool associated;
> +       int ret;
> +
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D vfs_fsync(req->ns->file, 1);
> +       nvmet_blkcg_end(associated);
> +       return errno_to_nvme_status(req, ret);
>  }
>
>  static void nvmet_file_flush_work(struct work_struct *w)
> @@ -274,10 +285,12 @@ static void nvmet_file_execute_discard(struct nvmet=
_req *req)
>         int mode =3D FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>         struct nvme_dsm_range range;
>         loff_t offset, len;
> +       bool associated;
>         u16 status =3D 0;
>         int ret;
>         int i;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         for (i =3D 0; i <=3D le32_to_cpu(req->cmd->dsm.nr); i++) {
>                 status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &r=
ange,
>                                         sizeof(range));
> @@ -300,6 +313,7 @@ static void nvmet_file_execute_discard(struct nvmet_r=
eq *req)
>                         break;
>                 }
>         }
> +       nvmet_blkcg_end(associated);
>
>         nvmet_req_complete(req, status);
>  }
> @@ -336,6 +350,7 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>         int mode =3D FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
>         loff_t offset;
>         loff_t len;
> +       bool associated;
>         int ret;
>
>         offset =3D le64_to_cpu(write_zeroes->slba) << req->ns->blksize_sh=
ift;
> @@ -347,7 +362,9 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>                 return;
>         }
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
> +       nvmet_blkcg_end(associated);
>         nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) =
: 0);
>  }
>
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dbda55895f4f..db46f8fd583d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -21,6 +21,8 @@
>  #include <linux/radix-tree.h>
>  #include <linux/t10-pi.h>
>  #include <linux/kfifo.h>
> +#include <linux/kthread.h>
> +#include <linux/cgroup.h>
>
>  #define NVMET_DEFAULT_VS               NVME_VS(2, 1, 0)
>
> @@ -115,6 +117,16 @@ struct nvmet_ns {
>         struct nvmet_subsys     *subsys;
>         const char              *device_path;
>
> +#ifdef CONFIG_BLK_CGROUP
> +       u64                     cgroup_id;
> +       /*
> +        * Resolved from ->cgroup_id when the namespace is enabled and
> +        * released when it is disabled, so it has the same lifetime and
> +        * visibility rules as ->bdev and ->file.
> +        */
> +       struct cgroup           *cgrp;
> +#endif
> +
>         struct config_group     device_group;
>         struct config_group     group;
>
> @@ -732,6 +744,36 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_=
req *req);
>  void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>  void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>
> +#ifdef CONFIG_BLK_CGROUP
> +static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
> +{
> +       struct cgroup_subsys_state *css;
> +
> +       if (!ns->cgrp || !in_task() || !(current->flags & PF_KTHREAD))
> +               return false;
> +
> +       css =3D cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
> +       kthread_associate_blkcg(css);
> +       css_put(css);
> +       return true;
> +}
> +
> +static inline void nvmet_blkcg_end(bool associated)
> +{
> +       if (associated)
> +               kthread_associate_blkcg(NULL);
> +}
> +#else
> +static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
> +{
> +       return false;
> +}
> +
> +static inline void nvmet_blkcg_end(bool associated)
> +{
> +}
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
>  {
>         return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 23a17c02abee..c6cc4730285b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -480,8 +480,11 @@ static void nvmet_bdev_zmgmt_send_work(struct work_s=
truct *w)
>         struct block_device *bdev =3D req->ns->bdev;
>         sector_t zone_sectors =3D bdev_zone_sectors(bdev);
>         u16 status =3D NVME_SC_SUCCESS;
> +       bool associated;
>         int ret;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +
>         if (op =3D=3D REQ_OP_LAST) {
>                 req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cm=
d, zsa);
>                 status =3D NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_=
DNR;
> @@ -511,6 +514,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_st=
ruct *w)
>                 status =3D blkdev_zone_mgmt_errno_to_nvme_status(ret);
>
>  out:
> +       nvmet_blkcg_end(associated);
>         nvmet_req_complete(req, status);
>  }
>
> @@ -542,6 +546,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>         struct scatterlist *sg;
>         u32 data_len =3D nvmet_rw_data_len(req);
>         struct bio *bio;
> +       bool associated;
>         int sg_cnt;
>
>         /* Request is completed on len mismatch in nvmet_check_transfer_l=
en() */
> @@ -572,6 +577,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>                 goto out;
>         }
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         if (nvmet_use_inline_bvec(req)) {
>                 bio =3D &req->z.inline_bio;
>                 bio_init(bio, req->ns->bdev, req->inline_bvec,
> @@ -579,6 +585,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>         } else {
>                 bio =3D bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KE=
RNEL);
>         }
> +       nvmet_blkcg_end(associated);
>
>         bio->bi_end_io =3D nvmet_bdev_zone_append_bio_done;
>         bio->bi_iter.bi_sector =3D sect;
>
> base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
> --
> 2.53.0
>
