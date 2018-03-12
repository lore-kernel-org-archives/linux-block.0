Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:61120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751281AbeCLPjZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Mar 2018 11:39:25 -0400
From: Don Brace <don.brace@microsemi.com>
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "James Bottomley" <james.bottomley@hansenpartnership.com>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: RE: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
Date: Mon, 12 Mar 2018 15:39:19 +0000
Message-ID: <287e393494de437790b61fe6dff4f03c@microsemi.com>
References: <20180309033218.23042-1-ming.lei@redhat.com>
 <20180309033218.23042-2-ming.lei@redhat.com>
In-Reply-To: <20180309033218.23042-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Thursday, March 08, 2018 9:32 PM
> To: James Bottomley <James.Bottomley@HansenPartnership.com>; Jens Axboe
> <axboe@fb.com>; Martin K . Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>; linux-scsi@vger.kernel.org; linux-
> block@vger.kernel.org; Meelis Roos <mroos@linux.ee>; Don Brace
> <don.brace@microsemi.com>; Kashyap Desai
> <kashyap.desai@broadcom.com>; Laurence Oberman
> <loberman@redhat.com>; Mike Snitzer <snitzer@redhat.com>; Ming Lei
> <ming.lei@redhat.com>; Hannes Reinecke <hare@suse.de>; James Bottomley
> <james.bottomley@hansenpartnership.com>; Artem Bityutskiy
> <artem.bityutskiy@intel.com>
> Subject: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
>=20
> EXTERNAL EMAIL
>=20
>=20
> From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
> one msix vector can be created without any online CPU mapped, then one
> command's completion may not be notified.
>=20
> This patch setups mapping between cpu and reply queue according to irq
> affinity info retrived by pci_irq_get_affinity(), and uses this mapping
> table to choose reply queue for queuing one command.
>=20
> Then the chosen reply queue has to be active, and fixes IO hang caused
> by using inactive reply queue which doesn't have any online CPU mapped.
>=20
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Meelis Roos <mroos@linux.ee>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Tested-by: Don Brace <don.brace@microsemi.com>
> Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPU=
s")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Acked-by: Don Brace <don.brace@microsemi.com>
Tested-by: Don Brace <don.brace@microsemi.com>
   * Rebuilt test rig: applied the following patches to Linus's tree 4.16.0=
-rc4+:
                 [PATCH V4 1_4] scsi: hpsa: fix selection of reply queue - =
Ming Lei <ming.lei@redhat.com> - 2018-03-08 2132.eml
                 [PATCH V4 3_4] scsi: introduce force_blk_mq - Ming Lei <mi=
ng.lei@redhat.com> - 2018-03-08 2132.eml
        * fio tests on 6 LVs on P441 controller (fw 6.59) 5 days.
        * fio tests on 10 HBA disks on P431 (fw 4.54) controller. 3 days. (=
 concurrent with P441 tests)

>  drivers/scsi/hpsa.c | 73 +++++++++++++++++++++++++++++++++++++++--------=
------
>  drivers/scsi/hpsa.h |  1 +
>  2 files changed, 55 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 5293e6827ce5..3a9eca163db8 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -1045,11 +1045,7 @@ static void set_performant_mode(struct ctlr_info
> *h, struct CommandList *c,
>                 c->busaddr |=3D 1 | (h->blockFetchTable[c->Header.SGList]=
 << 1);
>                 if (unlikely(!h->msix_vectors))
>                         return;
> -               if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
> -                       c->Header.ReplyQueue =3D
> -                               raw_smp_processor_id() % h->nreply_queues=
;
> -               else
> -                       c->Header.ReplyQueue =3D reply_queue % h->nreply_=
queues;
> +               c->Header.ReplyQueue =3D reply_queue;
>         }
>  }
>=20
> @@ -1063,10 +1059,7 @@ static void set_ioaccel1_performant_mode(struct
> ctlr_info *h,
>          * Tell the controller to post the reply to the queue for this
>          * processor.  This seems to give the best I/O throughput.
>          */
> -       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
> -               cp->ReplyQueue =3D smp_processor_id() % h->nreply_queues;
> -       else
> -               cp->ReplyQueue =3D reply_queue % h->nreply_queues;
> +       cp->ReplyQueue =3D reply_queue;
>         /*
>          * Set the bits in the address sent down to include:
>          *  - performant mode bit (bit 0)
> @@ -1087,10 +1080,7 @@ static void
> set_ioaccel2_tmf_performant_mode(struct ctlr_info *h,
>         /* Tell the controller to post the reply to the queue for this
>          * processor.  This seems to give the best I/O throughput.
>          */
> -       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
> -               cp->reply_queue =3D smp_processor_id() % h->nreply_queues=
;
> -       else
> -               cp->reply_queue =3D reply_queue % h->nreply_queues;
> +       cp->reply_queue =3D reply_queue;
>         /* Set the bits in the address sent down to include:
>          *  - performant mode bit not used in ioaccel mode 2
>          *  - pull count (bits 0-3)
> @@ -1109,10 +1099,7 @@ static void set_ioaccel2_performant_mode(struct
> ctlr_info *h,
>          * Tell the controller to post the reply to the queue for this
>          * processor.  This seems to give the best I/O throughput.
>          */
> -       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
> -               cp->reply_queue =3D smp_processor_id() % h->nreply_queues=
;
> -       else
> -               cp->reply_queue =3D reply_queue % h->nreply_queues;
> +       cp->reply_queue =3D reply_queue;
>         /*
>          * Set the bits in the address sent down to include:
>          *  - performant mode bit not used in ioaccel mode 2
> @@ -1157,6 +1144,8 @@ static void __enqueue_cmd_and_start_io(struct
> ctlr_info *h,
>  {
>         dial_down_lockup_detection_during_fw_flash(h, c);
>         atomic_inc(&h->commands_outstanding);
> +
> +       reply_queue =3D h->reply_map[raw_smp_processor_id()];
>         switch (c->cmd_type) {
>         case CMD_IOACCEL1:
>                 set_ioaccel1_performant_mode(h, c, reply_queue);
> @@ -7376,6 +7365,26 @@ static void hpsa_disable_interrupt_mode(struct
> ctlr_info *h)
>         h->msix_vectors =3D 0;
>  }
>=20
> +static void hpsa_setup_reply_map(struct ctlr_info *h)
> +{
> +       const struct cpumask *mask;
> +       unsigned int queue, cpu;
> +
> +       for (queue =3D 0; queue < h->msix_vectors; queue++) {
> +               mask =3D pci_irq_get_affinity(h->pdev, queue);
> +               if (!mask)
> +                       goto fallback;
> +
> +               for_each_cpu(cpu, mask)
> +                       h->reply_map[cpu] =3D queue;
> +       }
> +       return;
> +
> +fallback:
> +       for_each_possible_cpu(cpu)
> +               h->reply_map[cpu] =3D 0;
> +}
> +
>  /* If MSI/MSI-X is supported by the kernel we will try to enable it on
>   * controllers that are capable. If not, we use legacy INTx mode.
>   */
> @@ -7771,6 +7780,10 @@ static int hpsa_pci_init(struct ctlr_info *h)
>         err =3D hpsa_interrupt_mode(h);
>         if (err)
>                 goto clean1;
> +
> +       /* setup mapping between CPU and reply queue */
> +       hpsa_setup_reply_map(h);
> +
>         err =3D hpsa_pci_find_memory_BAR(h->pdev, &h->paddr);
>         if (err)
>                 goto clean2;    /* intmode+region, pci */
> @@ -8480,6 +8493,28 @@ static struct workqueue_struct
> *hpsa_create_controller_wq(struct ctlr_info *h,
>         return wq;
>  }
>=20
> +static void hpda_free_ctlr_info(struct ctlr_info *h)
> +{
> +       kfree(h->reply_map);
> +       kfree(h);
> +}
> +
> +static struct ctlr_info *hpda_alloc_ctlr_info(void)
> +{
> +       struct ctlr_info *h;
> +
> +       h =3D kzalloc(sizeof(*h), GFP_KERNEL);
> +       if (!h)
> +               return NULL;
> +
> +       h->reply_map =3D kzalloc(sizeof(*h->reply_map) * nr_cpu_ids, GFP_=
KERNEL);
> +       if (!h->reply_map) {
> +               kfree(h);
> +               return NULL;
> +       }
> +       return h;
> +}
> +
>  static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_i=
d *ent)
>  {
>         int dac, rc;
> @@ -8517,7 +8552,7 @@ static int hpsa_init_one(struct pci_dev *pdev, cons=
t
> struct pci_device_id *ent)
>          * the driver.  See comments in hpsa.h for more info.
>          */
>         BUILD_BUG_ON(sizeof(struct CommandList) %
> COMMANDLIST_ALIGNMENT);
> -       h =3D kzalloc(sizeof(*h), GFP_KERNEL);
> +       h =3D hpda_alloc_ctlr_info();
>         if (!h) {
>                 dev_err(&pdev->dev, "Failed to allocate controller head\n=
");
>                 return -ENOMEM;
> @@ -8916,7 +8951,7 @@ static void hpsa_remove_one(struct pci_dev *pdev)
>         h->lockup_detected =3D NULL;                      /* init_one 2 *=
/
>         /* (void) pci_disable_pcie_error_reporting(pdev); */    /* init_o=
ne 1 */
>=20
> -       kfree(h);                                       /* init_one 1 */
> +       hpda_free_ctlr_info(h);                         /* init_one 1 */
>  }
>=20
>  static int hpsa_suspend(__attribute__((unused)) struct pci_dev *pdev,
> diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
> index 018f980a701c..fb9f5e7f8209 100644
> --- a/drivers/scsi/hpsa.h
> +++ b/drivers/scsi/hpsa.h
> @@ -158,6 +158,7 @@ struct bmic_controller_parameters {
>  #pragma pack()
>=20
>  struct ctlr_info {
> +       unsigned int *reply_map;
>         int     ctlr;
>         char    devname[8];
>         char    *product_name;
> --
> 2.9.5
