Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59BC04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3475204FD
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfEaGmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 02:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:60860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaGmW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 02:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAB80AFAB;
        Fri, 31 May 2019 06:42:19 +0000 (UTC)
Subject: Re: [PATCH 7/9] scsi: hisi_sas_v3: convert private reply queue to
 blk-mq hw queue
To:     Ming Lei <tom.leiming@gmail.com>
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
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-8-ming.lei@redhat.com>
 <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
 <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <1c5bd151-d4ac-aa40-25ed-cbb63d704c35@suse.de>
Date:   Fri, 31 May 2019 08:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/19 8:34 AM, Ming Lei wrote:
> On Fri, May 31, 2019 at 2:21 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 5/31/19 4:27 AM, Ming Lei wrote:
>>> SCSI's reply qeueue is very similar with blk-mq's hw queue, both
>>> assigned by IRQ vector, so map te private reply queue into blk-mq's hw
>>> queue via .host_tagset.
>>>
>>> Then the private reply mapping can be removed.
>>>
>>> Another benefit is that the request/irq lost issue may be solved in
>>> generic approach because managed IRQ may be shutdown during CPU
>>> hotplug.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  drivers/scsi/hisi_sas/hisi_sas.h       |  2 +-
>>>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 36 ++++++++++----------
>>>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 46 +++++++++-----------------
>>>  3 files changed, 36 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
>>> index fc87994b5d73..3d48848dbde7 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas.h
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas.h
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/platform_device.h>
>>>  #include <linux/property.h>
>>>  #include <linux/regmap.h>
>>> +#include <linux/blk-mq-pci.h>
>>>  #include <scsi/sas_ata.h>
>>>  #include <scsi/libsas.h>
>>>
>>> @@ -378,7 +379,6 @@ struct hisi_hba {
>>>       u32 intr_coal_count;    /* Interrupt count to coalesce */
>>>
>>>       int cq_nvecs;
>>> -     unsigned int *reply_map;
>>>
>>>       /* debugfs memories */
>>>       u32 *debugfs_global_reg;
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> index 8a7feb8ed8d6..a1c1f30b9fdb 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> @@ -441,6 +441,19 @@ static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
>>>       return rc;
>>>  }
>>>
>>> +static struct scsi_cmnd *sas_task_to_scsi_cmd(struct sas_task *task)
>>> +{
>>> +     if (!task->uldd_task)
>>> +             return NULL;
>>> +
>>> +     if (dev_is_sata(task->dev)) {
>>> +             struct ata_queued_cmd *qc = task->uldd_task;
>>> +             return qc->scsicmd;
>>> +     } else {
>>> +             return task->uldd_task;
>>> +     }
>>> +}
>>> +
>>>  static int hisi_sas_task_prep(struct sas_task *task,
>>>                             struct hisi_sas_dq **dq_pointer,
>>>                             bool is_tmf, struct hisi_sas_tmf_task *tmf,
>>> @@ -459,6 +472,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
>>>       struct hisi_sas_dq *dq;
>>>       unsigned long flags;
>>>       int wr_q_index;
>>> +     struct scsi_cmnd *scsi_cmnd;
>>>
>>>       if (DEV_IS_GONE(sas_dev)) {
>>>               if (sas_dev)
>>> @@ -471,9 +485,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
>>>               return -ECOMM;
>>>       }
>>>
>>> -     if (hisi_hba->reply_map) {
>>> -             int cpu = raw_smp_processor_id();
>>> -             unsigned int dq_index = hisi_hba->reply_map[cpu];
>>> +     scsi_cmnd = sas_task_to_scsi_cmd(task);
>>> +     if (hisi_hba->shost->hostt->host_tagset) {
>>> +             unsigned int dq_index = scsi_cmnd_hctx_index(
>>> +                             hisi_hba->shost, scsi_cmnd);
>>>
>>>               *dq_pointer = dq = &hisi_hba->dq[dq_index];
>>>       } else {
>>> @@ -503,21 +518,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
>>>
>>>       if (hisi_hba->hw->slot_index_alloc)
>>>               rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
>>> -     else {
>>> -             struct scsi_cmnd *scsi_cmnd = NULL;
>>> -
>>> -             if (task->uldd_task) {
>>> -                     struct ata_queued_cmd *qc;
>>> -
>>> -                     if (dev_is_sata(device)) {
>>> -                             qc = task->uldd_task;
>>> -                             scsi_cmnd = qc->scsicmd;
>>> -                     } else {
>>> -                             scsi_cmnd = task->uldd_task;
>>> -                     }
>>> -             }
>>> +     else
>>>               rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
>>> -     }
>>>       if (rc < 0)
>>>               goto err_out_dif_dma_unmap;
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> index 49620c2411df..063e50e5b30c 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>>> @@ -2344,30 +2344,6 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
>>>       return IRQ_HANDLED;
>>>  }
>>>
>>> -static void setup_reply_map_v3_hw(struct hisi_hba *hisi_hba, int nvecs)
>>> -{
>>> -     const struct cpumask *mask;
>>> -     int queue, cpu;
>>> -
>>> -     for (queue = 0; queue < nvecs; queue++) {
>>> -             struct hisi_sas_cq *cq = &hisi_hba->cq[queue];
>>> -
>>> -             mask = pci_irq_get_affinity(hisi_hba->pci_dev, queue +
>>> -                                         BASE_VECTORS_V3_HW);
>>> -             if (!mask)
>>> -                     goto fallback;
>>> -             cq->pci_irq_mask = mask;
>>> -             for_each_cpu(cpu, mask)
>>> -                     hisi_hba->reply_map[cpu] = queue;
>>> -     }
>>> -     return;
>>> -
>>> -fallback:
>>> -     for_each_possible_cpu(cpu)
>>> -             hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
>>> -     /* Don't clean all CQ masks */
>>> -}
>>> -
>>>  static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>  {
>>>       struct device *dev = hisi_hba->dev;
>>> @@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>
>>>               min_msi = MIN_AFFINE_VECTORS_V3_HW;
>>>
>>> -             hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
>>> -                                                sizeof(unsigned int),
>>> -                                                GFP_KERNEL);
>>> -             if (!hisi_hba->reply_map)
>>> -                     return -ENOMEM;
>>>               vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
>>>                                                        min_msi, max_msi,
>>>                                                        PCI_IRQ_MSI |
>>> @@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>                                                        &desc);
>>>               if (vectors < 0)
>>>                       return -ENOENT;
>>> -             setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
>>>       } else {
>>>               min_msi = max_msi;
>>>               vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
>>> @@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
>>>       clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
>>>  }
>>>
>>> +static int hisi_sas_map_queues(struct Scsi_Host *shost)
>>> +{
>>> +     struct hisi_hba *hisi_hba = shost_priv(shost);
>>> +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>>> +
>>> +     if (auto_affine_msi_experimental)
>>> +             return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
>>> +                             BASE_VECTORS_V3_HW);
>>> +     else
>>> +             return blk_mq_map_queues(qmap);
>>> +}
>>> +
>>>  static struct scsi_host_template sht_v3_hw = {
>>>       .name                   = DRV_NAME,
>>>       .module                 = THIS_MODULE,
>>
>> As mentioned, we should be using a common function here.
>>
>>> @@ -2906,6 +2888,8 @@ static struct scsi_host_template sht_v3_hw = {
>>>       .scan_start             = hisi_sas_scan_start,
>>>       .change_queue_depth     = sas_change_queue_depth,
>>>       .bios_param             = sas_bios_param,
>>> +     .map_queues             = hisi_sas_map_queues,
>>> +     .host_tagset            = 1,
>>>       .this_id                = -1,
>>>       .sg_tablesize           = HISI_SAS_SGE_PAGE_CNT,
>>>       .sg_prot_tablesize      = HISI_SAS_SGE_PAGE_CNT,
>>> @@ -3092,6 +3076,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       if (hisi_sas_debugfs_enable)
>>>               hisi_sas_debugfs_init(hisi_hba);
>>>
>>> +     shost->nr_hw_queues = hisi_hba->cq_nvecs;
>>> +
>>>       rc = scsi_add_host(shost, dev);
>>>       if (rc)
>>>               goto err_out_ha;
>>>
>> Well, I'd rather see the v3 hardware converted to 'real' blk-mq first;
>> the hardware itself is pretty much multiqueue already, so we should be
>> better off converting it to blk-mq.
> 
> From John Garry's input, the tags is still hostwide, then not sure how to
> partition the hostwide tags into each hw queue's tags. That can be quite
> hard to do if the queue depth isn't big enough.
> 
Shouldn't be much of an issue; the conversion to blk-mq would still be
using a host-wide tag map.
Problem is more the 'v2' hardware, which has some pretty dodgy hardware
limitations. But I'll be looking into it and will be posting a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
