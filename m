Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C350313559
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296001; cv=none; b=paNL80KMOiGmIpUla8KvphjO8Jl8JSD28UTDZMnPjYbqTJ6FEaxIpfuzdubxEuKOnJ7BWJ6N252dHwuof9/CibgaL0BDrOZiIM3O8JleUPhmIv/DH8MyXWMtpu5v3iPBba1ci4qZHG15f6OYiCOSlOcAWgY13kMjo5VBy1iuNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296001; c=relaxed/simple;
	bh=RkKS85a0GN25d6rfI06LWNVM1cUCe2R3OeSl7Fftbeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLDi0VrwMHnS1TRsdZaTj5WojPUOMvDIj/wmOOkqapW49YlUNVS78zMZlMv9DoyutVdbUCWhkgJIOHESwyiN7mcqjZCqqapo464paUNAp8z57aSN7c8ilrD8IyuZ/K7KpUBfqPwyGyghi37HZqqJ7opLsMkWNiL4/RxYhVXp71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HU6RrqgU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HU6RrqgU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e893561f38so10008161cf.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762295998; x=1762900798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmEsWMPH7op/Tb36OMzWCkWHxDTK+AUjMzjOkLG1p78=;
        b=HU6RrqgU8eWrq1y2R+UcQdmLEoomn7bc5e7j+RaxaC5+HOKoJtnXOHJhgzarFUxF8r
         ulS+bQFJiCli8ScsP2LqkHxbLaTwgGC2MCkf0XQTkKCiz7S6jlfChLNay0vndR2KKT7G
         QVR0mOWnsr1E0GLCNfs5JqFs492p0lpmi4djB+kkYeKWIonxfMxRJMhNe9lISgBogbM9
         rfnUfwrWQIK0eExELAvm8p4YRGVwa28w3Stmi1QozTDGyBi1jRgDrn9C4h5YHPW8qWmY
         nxRQu4g8wFNiFKxh3P99b/h428Tp6XJGCH3wO0HNcB3ZO6QxOQiGeAC5k9mikXKjsxJ2
         Ohcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295998; x=1762900798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmEsWMPH7op/Tb36OMzWCkWHxDTK+AUjMzjOkLG1p78=;
        b=rORXfJV2cCRmARRS2bgBrHTlcH7b2PuaInkPaVBTkG6IPAMU68a/xNoFjVJBSzY5XK
         6g3jKzVDeIFJ2CzQqvI5iQ1k8EK500eeKCVjKKTaPte2Nw7oeOxEzU4C4lK2H4VJcYLF
         1MBqPTs8jRiqGVHB+GETUdR1f+U8jFxS5QxtVpEm4TjShI+ICVwQxIZnk/EOfu4WAW8S
         mJZMk2hQj8R/1fZLN47RCO4M1XOVmEmjPPkfpI1+QuRSq/1o29G1/BYMShiGA36AZ7y5
         7+O3gE5WAgB+/J2OoWVNm6t7tTr5HdCp+mdiOvCTJMCFjZlD0mSiIxL34oustpzz7OI+
         oWrA==
X-Forwarded-Encrypted: i=1; AJvYcCUQUC2UrArda+jhm1R5e6kJCJ9ZGEz10/Zq46tnFCfQpzDxFrvwMQl7kVStziaNsTfn7OoSpJEepN0aLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoiOZo7tStDwEz/1/5ERnjOfHwX6iRQELtxzRq8kxPJktHcQA
	RXfiYx8YSRJmQpkETYahoYfkmt2dSx8ftrMhDSuVhIozFhKNu2cJRmwRZjpbZx+KnRUmQ6IcEHO
	1K6L4Fhd//Jbj2BnhDBWZLmPGpL5I7+BNzV8TI8rWNA==
X-Gm-Gg: ASbGncu9UB/HYrTtAFatHzuOg4/u8FixBnhgEMEeQb5huvzp+lrOsw1r7jgS7D85ts5
	G8JEjKTR8pPqfVfDO10bfx8AWjvzjUOPsb9gGIqeR896gAb17vVFZ0Rjij7Zm8eDp9m+4tnszYh
	s1WejiE+fFflRLnXLAcEA5tBNP/4tE0UwHTv3qxyGbrUdlUFAzhhV1IpRXyEEMr+h93byM1Fqyy
	KxYVgGWGHA7DSxvVX7xxN0T6uU7zwNfWSorqoucDA2fPm4sG2MoMQuaakz5Lg==
X-Google-Smtp-Source: AGHT+IEyeHjjFj8+TsVUUEgbqqLfkWtfVgrvKYzGLN4yJzAm6F/wkmEMp7Ibqd0wOiB4hBO3OW6u8353lny/xj50vEg=
X-Received: by 2002:a05:6214:2027:b0:880:5cc1:693e with SMTP id
 6a1803df08f44-880712318cbmr12872266d6.7.1762295997796; Tue, 04 Nov 2025
 14:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com> <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
 <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
In-Reply-To: <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 4 Nov 2025 14:39:47 -0800
X-Gm-Features: AWmQ_bmWbTcDiAXhZk6QVYMFqbQYIPaXR33cpXP-v32VMmaMiZ-W8SWLAHSC9bM
Message-ID: <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 12:31=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/31/25 12:19, Casey Chen wrote:
> > On Thu, Oct 30, 2025 at 1:12=E2=80=AFAM Chaitanya Kulkarni
> > <chaitanyak@nvidia.com> wrote:
> >> On 10/29/25 17:39, Keith Busch wrote:
> >>> On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> >>>> Fix this by taking an additional reference on the admin queue during
> >>>> namespace allocation and releasing it during namespace cleanup.
> >>> Since the namespaces already hold references on the controller, would=
 it
> >>> be simpler to move the controller's final blk_put_queue to the final
> >>> ctrl free? This should have the same lifetime as your patch, but with
> >>> simpler ref counting:
> >>>
> >>> ---
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index fa4181d7de736..0b83d82f67e75 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl=
 *ctrl)
> >>>            */
> >>>           nvme_stop_keep_alive(ctrl);
> >>>           blk_mq_destroy_queue(ctrl->admin_q);
> >>> -       blk_put_queue(ctrl->admin_q);
> >>>           if (ctrl->ops->flags & NVME_F_FABRICS) {
> >>>                   blk_mq_destroy_queue(ctrl->fabrics_q);
> >>>                   blk_put_queue(ctrl->fabrics_q);
> >>> @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
> >>>                   container_of(dev, struct nvme_ctrl, ctrl_device);
> >>>           struct nvme_subsystem *subsys =3D ctrl->subsys;
> >>>
> >>> +       blk_put_queue(ctrl->admin_q);
> >>>           if (!subsys || ctrl->instance !=3D subsys->instance)
> >>>                   ida_free(&nvme_instance_ida, ctrl->instance);
> >>>           nvme_free_cels(ctrl);
> >>> --
> >>>
> >> above is much better approach that doesn't rely on taking extra
> >> ref count but using existing count to protect the UAF.
> >> I've added required comments that are very much needed here,
> >> totally untested :-
> >>
> >> nvme: fix UAF when accessing admin queue after removal
> >>
> >> Fix a use-after-free where userspace IOCTLs can access ctrl->admin_q
> >> after it has been freed during controller removal.
> >>
> >> The Race Condition:
> >>
> >>     Thread 1 (userspace IOCTL)          Thread 2 (sysfs remove)
> >>     --------------------------          -------------------
> >>     open(/dev/nvme0n1) -> fd=3D3
> >>     ioctl(3, NVME_IOCTL_ADMIN_CMD)
> >>       nvme_ioctl()
> >>       nvme_user_cmd()
> >>                                          echo 1 > .../remove
> >>                                          pci_device_remove()
> >>                                          nvme_remove()
> >>    nvme_remove_admin_tag_set()
> >>                                            blk_put_queue(admin_q)
> >>                                            [RCU grace period]
> >>                                            blk_free_queue(admin_q)
> >>                                              kmem_cache_free() <- FREE=
D
> >>       nvme_submit_user_cmd(ns->ctrl->admin_q) <- STALE POINTER
> >>         blk_mq_alloc_request(admin_q)
> >>           blk_queue_enter(admin_q)
> >>             *** USE-AFTER-FREE ***
> >>
> >>
> >> The admin queue is freed in nvme_remove_admin_tag_set() while userspac=
e
> >> may still hold open file descriptors to namespace devices. These open
> >> file descriptors can issue IOCTLs that dereference ctrl->admin_q after
> >> it has been freed.
> >>
> >> Defer blk_put_queue(ctrl->admin_q) from nvme_remove_admin_tag_set() to
> >> nvme_free_ctrl(). Since each namespace holds a controller reference vi=
a
> >> nvme_get_ctrl()/nvme_put_ctrl(), the controller will only be freed aft=
er
> >> all namespaces (and their open file descriptors) are released. This
> >> guarantees admin_q remains allocated while it may still be accessed.
> >>
> >> After blk_mq_destroy_queue() in nvme_remove_admin_tag_set(), the queue
> >> is marked dying (QUEUE_FLAG_DYING), so new IOCTL attempts fail safely
> >> at blk_queue_enter() with -ENODEV. The queue structure remains valid f=
or
> >> pointer dereference until nvme_free_ctrl() is called.
> >>
> >> ---
> >>    drivers/nvme/host/core.c | 22 +++++++++++++++++++++-
> >>    1 file changed, 21 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index 734ad725e6f4..dbbcf99dbef8 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -4897,7 +4897,19 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl
> >> *ctrl)
> >>         */
> >>        nvme_stop_keep_alive(ctrl);
> >>        blk_mq_destroy_queue(ctrl->admin_q);
> >> -    blk_put_queue(ctrl->admin_q);
> >> +    /**
> >> +     * Defer blk_put_queue() to nvme_free_ctrl() to prevent use-after=
-free.
> >> +     *
> >> +     * Userspace may hold open file descriptors to namespace devices =
and
> >> +     * issue IOCTLs that dereference ctrl->admin_q after controller r=
emoval
> >> +     * starts. Since each namespace holds a controller reference, def=
erring
> >> +     * the final queue release ensures admin_q remains allocated unti=
l all
> >> +     * namespace references are released.
> >> +     *
> >> +     * blk_mq_destroy_queue() above marks the queue dying
> >> (QUEUE_FLAG_DYING),
> >> +     * causing new requests to fail at blk_queue_enter() with -ENODEV=
 while
> >> +     * keeping the structure valid for pointer access.
> >> +     */
> >>        if (ctrl->ops->flags & NVME_F_FABRICS) {
> >>            blk_mq_destroy_queue(ctrl->fabrics_q);
> >>            blk_put_queue(ctrl->fabrics_q);
> >> @@ -5041,6 +5053,14 @@ static void nvme_free_ctrl(struct device *dev)
> >>            container_of(dev, struct nvme_ctrl, ctrl_device);
> >>        struct nvme_subsystem *subsys =3D ctrl->subsys;
> >>
> >> +    /**
> >> +     * Release admin_q's final reference. All namespace references ha=
ve
> >> +     * been released at this point. NULL check is needed for to handl=
e
> >> +     * allocation failure in nvme_alloc_admin_tag_set().
> >> +     */
> >> +    if (ctrl->admin_q)
> >> +        blk_put_queue(ctrl->admin_q);
> >> +
> >>        if (!subsys || ctrl->instance !=3D subsys->instance)
> >>            ida_free(&nvme_instance_ida, ctrl->instance);
> >>        nvme_free_cels(ctrl);
> >>
> >> -ck
> >>
> >>
> >>
> > Thanks Chaitanya. I tested your fix and all tests look good. We're
> > looking forward to your final version.
>
>
> This is Keith's patch I just tested his patch and added commit log-commen=
ts.
>
>

Hi Keith,

Could you make a patch based on this ? So we can backport upstream
patch instead of keeping our own patch. Thanks

> -ck
>
>
