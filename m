Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C39C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186852085A
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="pPoYN4p+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCRMWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:22:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40045 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCRMWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:22:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id z18so9298070vso.7
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wp8IcHrc3LupWAQNcX22XPAct576zyu3f4urp9cAls4=;
        b=pPoYN4p+LzgoPrRRQcVlGJMxkMU5Dvw81/jby9isaV46UWs6VmHHaCjdAvbtlWnOcw
         cQj/SnoCsiNCvUULh6y8Qi1iRt0z71jK9RWqDyFrsSn/FaSk6qrftSzgM+OJWaGFkSNG
         1/fR3ai00f9rHlHbqNBXJ5MY2ywEqP99e2YMyfZyfW/C80YXM+47YZ1/xxwUfIAk5QTs
         3XRuICj/QO7A9PE21tw5KRTsuUFN14aGRD/08c9ANan8XNT2DyaWwbLeI8OzUCXL+XDd
         RdMMOQJKnD2D9SsSAVdCG5ATgHVAfRHHEhOS9Q1CnVK978m/JBpCzbKMgMdKft3t35AX
         zMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wp8IcHrc3LupWAQNcX22XPAct576zyu3f4urp9cAls4=;
        b=mXpngakrHD8uIg5jtfftN+/20da5uoFGLhTJIUt2y/0svkVy0Qmo1evw2eIWgJTOra
         Wy8pMr38zT2oaVGGY4iMg22+I7txjAmhkrt2mkGFQX0c2Lg1nis2ESbeWuJGKuQXFP+5
         CtQyNUUVROCoWtEJ46OndKVLCFL0DHyn4ih+H+jbtGX1Gnj13zuzpxuLCsCK38hI4fih
         Xr65wp6jIDx7tdJqUfkYW+OdPvpsElUblFs691F2ctNQC+CzW11dKCFrIlesavj10HLb
         8hbwCfDmwdcmQ5CflmHGIfg42WokFklI0Z6K1OcMJhUXjl/OC11q7SvLBCPX4yenMUpL
         yjsw==
X-Gm-Message-State: APjAAAV8PcqnaLgEMv88ITDLSPxs5aCTq3EhAJKFpCJ7pE9hjzyKwN1m
        eJaUeerPzrSTrrncF/0897tbzk09s44jcSTZZ1dejQ==
X-Google-Smtp-Source: APXvYqwd6G1TY+qchmkvK8/iGu8bVtCZL3nxK7rBLTo5neQu59OnehTkXPOFEBYayO5UjYD0oLZ+ms/HC1NWULbLDHI=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr8707898vsr.42.1552911741789;
 Mon, 18 Mar 2019 05:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
 <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com> <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
 <a63ef9e7-214a-a701-5c40-d1d1107de4a4@intel.com>
In-Reply-To: <a63ef9e7-214a-a701-5c40-d1d1107de4a4@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 13:22:10 +0100
Message-ID: <CANr-nt3B8UknSTdKOj2PbfDRTfPJZ+g1s83XY2egtBdZqsU6tQ@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular cpu
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 10:44 AM Marcin Dziegielewski
<marcin.dziegielewski@intel.com> wrote:
>
> On 3/14/19 3:22 PM, Javier Gonz=C3=A1lez wrote:
> >
> >> On 14 Mar 2019, at 07.22, Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
> >>
> >>> On 14 Mar 2019, at 07.17, Marcin Dziegielewski <marcin.dziegielewski@=
intel.com> wrote:
> >>>
> >>> In some cases write thread migration between cpus can cause
> >>> sending writes in improper order and in consequence a lot of
> >>> errors from device.
> >>>
> >>> Write thread affinity to particular cpu prevent before it.
> >>>
> >>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
> >>> drivers/lightnvm/pblk.h      |  1 +
> >>> drivers/nvme/host/lightnvm.c |  1 +
> >>> include/linux/lightnvm.h     |  2 ++
> >>> 4 files changed, 33 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-ini=
t.c
> >>> index 81e8ed4..bd25004 100644
> >>> --- a/drivers/lightnvm/pblk-init.c
> >>> +++ b/drivers/lightnvm/pblk-init.c
> >>> @@ -21,6 +21,8 @@
> >>>
> >>> #include "pblk.h"
> >>> #include "pblk-trace.h"
> >>> +#include <linux/cpumask.h>
> >>> +#include <linux/numa.h>
> >>>
> >>> static unsigned int write_buffer_size;
> >>>
> >>> @@ -47,6 +49,8 @@ struct pblk_global_caches {
> >>>
> >>> struct bio_set pblk_bio_set;
> >>>
> >>> +cpumask_t free_cpumask;
> >>> +
> >>> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> >>>                       struct bio *bio)
> >>> {
> >>> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk *pblk)
> >>>
> >>> static int pblk_writer_init(struct pblk *pblk)
> >>> {
> >>> +   cpumask_t tmp_cpumask, cpumask;
> >>> +   int cpu;
> >>> +
> >>>     pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, "pblk-wri=
ter-t");
> >>>     if (IS_ERR(pblk->writer_ts)) {
> >>>             int err =3D PTR_ERR(pblk->writer_ts);
> >>> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk *pblk)
> >>>             return err;
> >>>     }
> >>>
> >>> +   cpumask_and(&tmp_cpumask, cpumask_of_node(pblk->dev->parent->node=
),
> >>> +                   cpu_online_mask);
> >>> +   cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
> >>> +
> >>> +   if (!cpumask_weight(&free_cpumask)) {
> >>> +           free_cpumask =3D CPU_MASK_ALL;
> >>> +           cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
> >>> +   }
> >>> +
> >>> +   cpu =3D cpumask_last(&cpumask);
> >>> +
> >>> +   kthread_bind(pblk->writer_ts, cpu);
> >>> +
> >>> +   cpumask_clear_cpu(cpu, &free_cpumask);
> >>> +   pblk->writer_cpu =3D cpu;
> >>> +
> >>>     timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
> >>>     mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
> >>>
> >>> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk *pblk=
)
> >>>                     "Stopping not fully synced write buffer\n");
> >>>
> >>>     del_timer_sync(&pblk->wtimer);
> >>> -   if (pblk->writer_ts)
> >>> +   if (pblk->writer_ts) {
> >>> +           set_cpus_allowed_ptr(pblk->writer_ts, cpu_online_mask);
> >>>             kthread_stop(pblk->writer_ts);
> >>> +           cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
> >>> +   }
> >>> }
> >>>
> >>> static void pblk_free(struct pblk *pblk)
> >>> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
> >>> {
> >>>     int ret;
> >>>
> >>> +   free_cpumask =3D CPU_MASK_ALL;
> >>> +
> >>>     ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
> >>>     if (ret)
> >>>             return ret;
> >>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >>> index 381f074..650f983 100644
> >>> --- a/drivers/lightnvm/pblk.h
> >>> +++ b/drivers/lightnvm/pblk.h
> >>> @@ -690,6 +690,7 @@ struct pblk {
> >>>     atomic_t inflight_io;           /* General inflight I/O counter *=
/
> >>>
> >>>     struct task_struct *writer_ts;
> >>> +   int writer_cpu;
> >>>
> >>>     /* Simple translation map of logical addresses to physical addres=
ses.
> >>>      * The logical addresses is known by the host system, while the p=
hysical
> >>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnv=
m.c
> >>> index 949e29e..971a19f 100644
> >>> --- a/drivers/nvme/host/lightnvm.c
> >>> +++ b/drivers/nvme/host/lightnvm.c
> >>> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *d=
isk_name, int node)
> >>>     memcpy(dev->name, disk_name, DISK_NAME_LEN);
> >>>     dev->ops =3D &nvme_nvm_dev_ops;
> >>>     dev->private_data =3D ns;
> >>> +   dev->node =3D node;
> >>>     ns->ndev =3D dev;
> >>>
> >>>     return nvm_register(dev);
> >>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> >>> index 5d865a5..312029e 100644
> >>> --- a/include/linux/lightnvm.h
> >>> +++ b/include/linux/lightnvm.h
> >>> @@ -427,6 +427,8 @@ struct nvm_dev {
> >>>     char name[DISK_NAME_LEN];
> >>>     void *private_data;
> >>>
> >>> +   int node;
> >>> +
> >>>     void *rmap;
> >>>
> >>>     struct mutex mlock;
> >>> --
> >>> 1.8.3.1
> >>
> >> We have a per-CPU semaphore that only allows to send a single I/O in
> >> order to prevent write pointer violations. Are you seeing this error, =
or
> >> is it theoretical?
> >>
> >> Javier
> >
> > I meant per PU (parallel unit)=E2=80=A6
> >
>
> You are right, for current upstream implementation it's theoretical. I
> saw it after some experimental changes in lightnvm layer.
>
> But I see one more potential benefit from this patch (correct me if I'm
> wrong), after this patch we will be sure that write thread is working on
> cpu from right numa node for device. Now I think, we can also take under
> consideration binding to whole set of cpus from right numa node instead
> of particular one.

If this is just a potential benefit, I'd rather not do this, at least
not until we have numbers on any performance benefits and an analysis
of any trade offs.

Thanks,
Hans
>
> Marcin
