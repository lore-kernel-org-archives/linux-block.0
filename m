Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141EC04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66826463
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9P/f6RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEaGev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 02:34:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 02:34:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so5695904wrx.0;
        Thu, 30 May 2019 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLLDn3r9/x0ct5lwlOsJ9Hki0SUJ/gJro+Et8VQ+Zv4=;
        b=B9P/f6RKLiH46PK7LV73AL0U+ROCt+qc4TaHFcl5F2f6jw4UzbZOMs3OlDO4a+h7rt
         0+486oQeyynV32aqwyHUiL0QdtoEUqut+6sHwO4ofgLktFZUhI5lTH35Dg7JhTWMRshL
         ZabrYQ6knIwBn9ooHlyK9R9AP/XczrL6FRFeOhgS/X6vx2pxnyN/5AUEitIV06497rff
         lDPjoYxWM1AwyFJMo1Qfvib6EVQ94KNdor85NGbT6B+41Z/hwJiCJPqaMrFsTYJp9dGo
         X+vlUCZn6Xv4FtHgeO5RwPMqu2YFFQG2a7yhm4B/GD1EoMEEnfEVst2sBuPkLhTvmN1K
         eWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLLDn3r9/x0ct5lwlOsJ9Hki0SUJ/gJro+Et8VQ+Zv4=;
        b=Dtp3keCFUMZuq+Cu0uNzFlgghPQpZGMmQLc8uVYrjiUu/hCg82oDLba7B/inAV20Ov
         NXkVOZs2AjhM/BCDgRxKnTiP8/LTfw/gH3rRCbYzZ28qqTUzl0PjsStgOp/6KtwcIsQZ
         CFM98e5cJJT86/C+ZDLo7grJJBxh66vLGa9m0Q8Wfurfipcf+2MabaWm9ZviBRryc00/
         u/OzPtM+QOKrxKhDoQ7X3i7cLY6WkRAUGJA8vAqSR5vgKzqXrBxTuv63CogG6jM2Aco4
         ROjeIX72YYcCd95Y8wsqTjsw2iuRcu1+vSvBmRIls/Zg10O46W7iG1JOKjLir082dsoc
         pprQ==
X-Gm-Message-State: APjAAAV0P6omObgQMwcZgT5hv1jInV+orNRrZtfp7waUzlExr/d3lnLw
        GRbVJfoDFJ0l+FKK3sO2fJkvlocq3i/k3RBOmm0=
X-Google-Smtp-Source: APXvYqwBHOrnuajwkp8bq3AEU/EEPD9mmLE58NQI51QONEHayFEieVBkh9Xjda+SZKIJLpQ6Yvzw1AvDOcP7YL7MhtA=
X-Received: by 2002:adf:fc87:: with SMTP id g7mr1445022wrr.229.1559284487874;
 Thu, 30 May 2019 23:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-8-ming.lei@redhat.com>
 <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
In-Reply-To: <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 31 May 2019 14:34:36 +0800
Message-ID: <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
Subject: Re: [PATCH 7/9] scsi: hisi_sas_v3: convert private reply queue to
 blk-mq hw queue
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 2:21 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/31/19 4:27 AM, Ming Lei wrote:
> > SCSI's reply qeueue is very similar with blk-mq's hw queue, both
> > assigned by IRQ vector, so map te private reply queue into blk-mq's hw
> > queue via .host_tagset.
> >
> > Then the private reply mapping can be removed.
> >
> > Another benefit is that the request/irq lost issue may be solved in
> > generic approach because managed IRQ may be shutdown during CPU
> > hotplug.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/hisi_sas/hisi_sas.h       |  2 +-
> >  drivers/scsi/hisi_sas/hisi_sas_main.c  | 36 ++++++++++----------
> >  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 46 +++++++++-----------------
> >  3 files changed, 36 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
> > index fc87994b5d73..3d48848dbde7 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas.h
> > +++ b/drivers/scsi/hisi_sas/hisi_sas.h
> > @@ -26,6 +26,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> > +#include <linux/blk-mq-pci.h>
> >  #include <scsi/sas_ata.h>
> >  #include <scsi/libsas.h>
> >
> > @@ -378,7 +379,6 @@ struct hisi_hba {
> >       u32 intr_coal_count;    /* Interrupt count to coalesce */
> >
> >       int cq_nvecs;
> > -     unsigned int *reply_map;
> >
> >       /* debugfs memories */
> >       u32 *debugfs_global_reg;
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> > index 8a7feb8ed8d6..a1c1f30b9fdb 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> > @@ -441,6 +441,19 @@ static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
> >       return rc;
> >  }
> >
> > +static struct scsi_cmnd *sas_task_to_scsi_cmd(struct sas_task *task)
> > +{
> > +     if (!task->uldd_task)
> > +             return NULL;
> > +
> > +     if (dev_is_sata(task->dev)) {
> > +             struct ata_queued_cmd *qc = task->uldd_task;
> > +             return qc->scsicmd;
> > +     } else {
> > +             return task->uldd_task;
> > +     }
> > +}
> > +
> >  static int hisi_sas_task_prep(struct sas_task *task,
> >                             struct hisi_sas_dq **dq_pointer,
> >                             bool is_tmf, struct hisi_sas_tmf_task *tmf,
> > @@ -459,6 +472,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
> >       struct hisi_sas_dq *dq;
> >       unsigned long flags;
> >       int wr_q_index;
> > +     struct scsi_cmnd *scsi_cmnd;
> >
> >       if (DEV_IS_GONE(sas_dev)) {
> >               if (sas_dev)
> > @@ -471,9 +485,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
> >               return -ECOMM;
> >       }
> >
> > -     if (hisi_hba->reply_map) {
> > -             int cpu = raw_smp_processor_id();
> > -             unsigned int dq_index = hisi_hba->reply_map[cpu];
> > +     scsi_cmnd = sas_task_to_scsi_cmd(task);
> > +     if (hisi_hba->shost->hostt->host_tagset) {
> > +             unsigned int dq_index = scsi_cmnd_hctx_index(
> > +                             hisi_hba->shost, scsi_cmnd);
> >
> >               *dq_pointer = dq = &hisi_hba->dq[dq_index];
> >       } else {
> > @@ -503,21 +518,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
> >
> >       if (hisi_hba->hw->slot_index_alloc)
> >               rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
> > -     else {
> > -             struct scsi_cmnd *scsi_cmnd = NULL;
> > -
> > -             if (task->uldd_task) {
> > -                     struct ata_queued_cmd *qc;
> > -
> > -                     if (dev_is_sata(device)) {
> > -                             qc = task->uldd_task;
> > -                             scsi_cmnd = qc->scsicmd;
> > -                     } else {
> > -                             scsi_cmnd = task->uldd_task;
> > -                     }
> > -             }
> > +     else
> >               rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
> > -     }
> >       if (rc < 0)
> >               goto err_out_dif_dma_unmap;
> >
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > index 49620c2411df..063e50e5b30c 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > @@ -2344,30 +2344,6 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > -static void setup_reply_map_v3_hw(struct hisi_hba *hisi_hba, int nvecs)
> > -{
> > -     const struct cpumask *mask;
> > -     int queue, cpu;
> > -
> > -     for (queue = 0; queue < nvecs; queue++) {
> > -             struct hisi_sas_cq *cq = &hisi_hba->cq[queue];
> > -
> > -             mask = pci_irq_get_affinity(hisi_hba->pci_dev, queue +
> > -                                         BASE_VECTORS_V3_HW);
> > -             if (!mask)
> > -                     goto fallback;
> > -             cq->pci_irq_mask = mask;
> > -             for_each_cpu(cpu, mask)
> > -                     hisi_hba->reply_map[cpu] = queue;
> > -     }
> > -     return;
> > -
> > -fallback:
> > -     for_each_possible_cpu(cpu)
> > -             hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
> > -     /* Don't clean all CQ masks */
> > -}
> > -
> >  static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> >  {
> >       struct device *dev = hisi_hba->dev;
> > @@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> >
> >               min_msi = MIN_AFFINE_VECTORS_V3_HW;
> >
> > -             hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
> > -                                                sizeof(unsigned int),
> > -                                                GFP_KERNEL);
> > -             if (!hisi_hba->reply_map)
> > -                     return -ENOMEM;
> >               vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
> >                                                        min_msi, max_msi,
> >                                                        PCI_IRQ_MSI |
> > @@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> >                                                        &desc);
> >               if (vectors < 0)
> >                       return -ENOENT;
> > -             setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
> >       } else {
> >               min_msi = max_msi;
> >               vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
> > @@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
> >       clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
> >  }
> >
> > +static int hisi_sas_map_queues(struct Scsi_Host *shost)
> > +{
> > +     struct hisi_hba *hisi_hba = shost_priv(shost);
> > +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> > +
> > +     if (auto_affine_msi_experimental)
> > +             return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
> > +                             BASE_VECTORS_V3_HW);
> > +     else
> > +             return blk_mq_map_queues(qmap);
> > +}
> > +
> >  static struct scsi_host_template sht_v3_hw = {
> >       .name                   = DRV_NAME,
> >       .module                 = THIS_MODULE,
>
> As mentioned, we should be using a common function here.
>
> > @@ -2906,6 +2888,8 @@ static struct scsi_host_template sht_v3_hw = {
> >       .scan_start             = hisi_sas_scan_start,
> >       .change_queue_depth     = sas_change_queue_depth,
> >       .bios_param             = sas_bios_param,
> > +     .map_queues             = hisi_sas_map_queues,
> > +     .host_tagset            = 1,
> >       .this_id                = -1,
> >       .sg_tablesize           = HISI_SAS_SGE_PAGE_CNT,
> >       .sg_prot_tablesize      = HISI_SAS_SGE_PAGE_CNT,
> > @@ -3092,6 +3076,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       if (hisi_sas_debugfs_enable)
> >               hisi_sas_debugfs_init(hisi_hba);
> >
> > +     shost->nr_hw_queues = hisi_hba->cq_nvecs;
> > +
> >       rc = scsi_add_host(shost, dev);
> >       if (rc)
> >               goto err_out_ha;
> >
> Well, I'd rather see the v3 hardware converted to 'real' blk-mq first;
> the hardware itself is pretty much multiqueue already, so we should be
> better off converting it to blk-mq.

From John Garry's input, the tags is still hostwide, then not sure how to
partition the hostwide tags into each hw queue's tags. That can be quite
hard to do if the queue depth isn't big enough.

Thanks,
Ming Lei
