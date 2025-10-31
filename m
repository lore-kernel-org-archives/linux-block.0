Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476D3A1CD
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938361; cv=none; b=oDMYXF+G9Adk9hGfNBnId9qbDQMa0sdRLFB4g2lRoPwV2yfL+Cq5+14HV2GxF6DiKzMiKJ5wEUikI32eKXQ8eWJXtyMqMksuIAfYbL1QZmO/NfmohfgxfPUiIhEOXh9UM0ZIRWaSX80xsSspym2s5rtKjtE6PoHtdxlx6eHnNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938361; c=relaxed/simple;
	bh=IsXAQl5ES5eHlQl/WXqXlMIxfOLf1esZulCzSKKm8As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYG0KWjQncv5qlfdmmPo3OXTxT9rPEdBHJQXdjLa0f3zs4s3i1HmfY8lzzjx92VSf4gMgZG0GaS17NqB3kYQL7Hz/5fmmeidJBOH8n6U810zKaBc5FuQuTJafA//MbGu/CKT3+gF+GcmchrnRq2hZv0O3BJnve1ufGkEkQ6SzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W24YrTT2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W24YrTT2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88fbbec670aso34182285a.0
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761938358; x=1762543158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ObbBtY4bAACLHGXaCLYX4TLQoujOeHfNhffdejq4q8=;
        b=W24YrTT22cnjMjEA4+ZG27axr9gzY8PUkkJ6YTluQseCS5alMxnyyqONMYdOeQBdoH
         GwzrkORJF10zb16B5/trw7bsHQM15WXU4tfzL/yoA63Mkrqh7EM5qBGhMmVr1elvCqJA
         NPvjn6+PeHjBjDVwDzIkJsH50CEoSbJ1QwO47zdUFEaH9uskKqP7nfwVOvZbvyuP5pgL
         B0+44ljF/F1Zrx7mSJB29ZYV7kjL97pm0RfzPIvfsO+9pFnHIWtLxtgxJbQXyPCy1pcp
         ScfgBzvlxEBjPD7SwEkLDEmM5UBj0dByIXFRxI/aCOP4yNTyDuV5EwwP9Njq90XBY2yH
         QkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938358; x=1762543158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ObbBtY4bAACLHGXaCLYX4TLQoujOeHfNhffdejq4q8=;
        b=IRwZORTTIzeiGXZEgdCdIgXYvJyrP2Eq9T9uOOdD+qffHviFFrKhGuFHeG55AJpW+E
         orypLbpSJLUj/aqvLd4kLEqpeBM9ZJ6eA7/GxTQlV3FNF1m2ld5gmm6u6ttGKYX+oDBN
         vD9IAGxhSf576TYjX12b0zYMvha/evvAAU4WDKcdPvGuUGs/JBfI5cRhX5YsOvJJ7eL1
         Kca2K4tbMzld6AB5y7sc+qdTTA8eeGZZYaCPWjkX30g6lHSf0gESmKNc4VOJpDdbn4up
         UphfVRpaWg5r6zj56ppeSGr33AKHqz4zcS7aSTwrPeKso8DKWXUExPhJono4RggmxhNb
         Kzfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGZYEr15k8azM8mfmHj7sg/YFl1NuMsiU5zjy4Bb1tbI+vyIbMpBtRRW0Uz4KMshPH++J4is6YjvWckA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkTg1DD1hqKYyL04sE7VQf/nzNfzL2+tO6Hbyv1nWofCHudCn
	G+Bfdi6UIyz+T2zH4APsNw8FKW+xFtPcQa53UW6rCCNIV8Uq/K16RNop6faB8Osru7NQ5YT8zQW
	sUXy81NtcOFc8hpY+cFQQX9Jk8RLC6YPg8i7e83eUJw==
X-Gm-Gg: ASbGnctN0MR4YD2lLftmSTMrGV4pUbDoUtbWUWIk0ucX02v7ZUFk1zcJGiD/mZOW/d4
	Fr+OdeQAiKoHjZEJ/GrMB9EXIvQeju6kcEnRyByBNrUDpgcHvKNrtBsol+3oFomOreGARVjt6Q7
	ZRKCVoMj+xwxpFafkoDZLGnHAceXAUI/w5u3iOiLOeP0mHsiSQcVtatNL3wnNiqinClX+QIcX1O
	Vo9pmQPHbwl/WN5fRdPYPAQ8cSfJ+DKckZbM0uwoD3ETIWW/BQU6eWA8lVe
X-Google-Smtp-Source: AGHT+IHXoeGmi8LnCdXA77pFlBZKMCAMSpt8AYomLHc17PLdvJiM/1UMje1jR4m5+81nyZw+tLwE34AQdhYwBck5Yz0=
X-Received: by 2002:a05:620a:1a85:b0:863:88f9:3edf with SMTP id
 af79cd13be357-8ab9b694e4fmr379255185a.13.1761938358244; Fri, 31 Oct 2025
 12:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp> <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
In-Reply-To: <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
From: Casey Chen <cachen@purestorage.com>
Date: Fri, 31 Oct 2025 12:19:06 -0700
X-Gm-Features: AWmQ_blv_5UoJMF1pDaZQg5T4Bip-zzv__0KvKfNk-uc74laM-93_6kfXXbTk20
Message-ID: <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale pointer
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"yzhong@purestorage.com" <yzhong@purestorage.com>, 
	"sconnor@purestorage.com" <sconnor@purestorage.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:12=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/29/25 17:39, Keith Busch wrote:
> > On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> >> Fix this by taking an additional reference on the admin queue during
> >> namespace allocation and releasing it during namespace cleanup.
> > Since the namespaces already hold references on the controller, would i=
t
> > be simpler to move the controller's final blk_put_queue to the final
> > ctrl free? This should have the same lifetime as your patch, but with
> > simpler ref counting:
> >
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index fa4181d7de736..0b83d82f67e75 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *=
ctrl)
> >           */
> >          nvme_stop_keep_alive(ctrl);
> >          blk_mq_destroy_queue(ctrl->admin_q);
> > -       blk_put_queue(ctrl->admin_q);
> >          if (ctrl->ops->flags & NVME_F_FABRICS) {
> >                  blk_mq_destroy_queue(ctrl->fabrics_q);
> >                  blk_put_queue(ctrl->fabrics_q);
> > @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
> >                  container_of(dev, struct nvme_ctrl, ctrl_device);
> >          struct nvme_subsystem *subsys =3D ctrl->subsys;
> >
> > +       blk_put_queue(ctrl->admin_q);
> >          if (!subsys || ctrl->instance !=3D subsys->instance)
> >                  ida_free(&nvme_instance_ida, ctrl->instance);
> >          nvme_free_cels(ctrl);
> > --
> >
>
> above is much better approach that doesn't rely on taking extra
> ref count but using existing count to protect the UAF.
> I've added required comments that are very much needed here,
> totally untested :-
>
> nvme: fix UAF when accessing admin queue after removal
>
> Fix a use-after-free where userspace IOCTLs can access ctrl->admin_q
> after it has been freed during controller removal.
>
> The Race Condition:
>
>    Thread 1 (userspace IOCTL)          Thread 2 (sysfs remove)
>    --------------------------          -------------------
>    open(/dev/nvme0n1) -> fd=3D3
>    ioctl(3, NVME_IOCTL_ADMIN_CMD)
>      nvme_ioctl()
>      nvme_user_cmd()
>                                         echo 1 > .../remove
>                                         pci_device_remove()
>                                         nvme_remove()
>   nvme_remove_admin_tag_set()
>                                           blk_put_queue(admin_q)
>                                           [RCU grace period]
>                                           blk_free_queue(admin_q)
>                                             kmem_cache_free() <- FREED
>      nvme_submit_user_cmd(ns->ctrl->admin_q) <- STALE POINTER
>        blk_mq_alloc_request(admin_q)
>          blk_queue_enter(admin_q)
>            *** USE-AFTER-FREE ***
>
>
> The admin queue is freed in nvme_remove_admin_tag_set() while userspace
> may still hold open file descriptors to namespace devices. These open
> file descriptors can issue IOCTLs that dereference ctrl->admin_q after
> it has been freed.
>
> Defer blk_put_queue(ctrl->admin_q) from nvme_remove_admin_tag_set() to
> nvme_free_ctrl(). Since each namespace holds a controller reference via
> nvme_get_ctrl()/nvme_put_ctrl(), the controller will only be freed after
> all namespaces (and their open file descriptors) are released. This
> guarantees admin_q remains allocated while it may still be accessed.
>
> After blk_mq_destroy_queue() in nvme_remove_admin_tag_set(), the queue
> is marked dying (QUEUE_FLAG_DYING), so new IOCTL attempts fail safely
> at blk_queue_enter() with -ENODEV. The queue structure remains valid for
> pointer dereference until nvme_free_ctrl() is called.
>
> ---
>   drivers/nvme/host/core.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 734ad725e6f4..dbbcf99dbef8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4897,7 +4897,19 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl
> *ctrl)
>        */
>       nvme_stop_keep_alive(ctrl);
>       blk_mq_destroy_queue(ctrl->admin_q);
> -    blk_put_queue(ctrl->admin_q);
> +    /**
> +     * Defer blk_put_queue() to nvme_free_ctrl() to prevent use-after-fr=
ee.
> +     *
> +     * Userspace may hold open file descriptors to namespace devices and
> +     * issue IOCTLs that dereference ctrl->admin_q after controller remo=
val
> +     * starts. Since each namespace holds a controller reference, deferr=
ing
> +     * the final queue release ensures admin_q remains allocated until a=
ll
> +     * namespace references are released.
> +     *
> +     * blk_mq_destroy_queue() above marks the queue dying
> (QUEUE_FLAG_DYING),
> +     * causing new requests to fail at blk_queue_enter() with -ENODEV wh=
ile
> +     * keeping the structure valid for pointer access.
> +     */
>       if (ctrl->ops->flags & NVME_F_FABRICS) {
>           blk_mq_destroy_queue(ctrl->fabrics_q);
>           blk_put_queue(ctrl->fabrics_q);
> @@ -5041,6 +5053,14 @@ static void nvme_free_ctrl(struct device *dev)
>           container_of(dev, struct nvme_ctrl, ctrl_device);
>       struct nvme_subsystem *subsys =3D ctrl->subsys;
>
> +    /**
> +     * Release admin_q's final reference. All namespace references have
> +     * been released at this point. NULL check is needed for to handle
> +     * allocation failure in nvme_alloc_admin_tag_set().
> +     */
> +    if (ctrl->admin_q)
> +        blk_put_queue(ctrl->admin_q);
> +
>       if (!subsys || ctrl->instance !=3D subsys->instance)
>           ida_free(&nvme_instance_ida, ctrl->instance);
>       nvme_free_cels(ctrl);
>
> -ck
>
>
>

Thanks Chaitanya. I tested your fix and all tests look good. We're
looking forward to your final version.
