Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE687C04AB5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C6280E7
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 11:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfFCLBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfFCLBW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Jun 2019 07:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B10E83091753;
        Mon,  3 Jun 2019 11:01:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C4C60FFE;
        Mon,  3 Jun 2019 11:01:01 +0000 (UTC)
Date:   Mon, 3 Jun 2019 19:00:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/9] scsi: hisi_sas_v3: convert private reply queue to
 blk-mq hw queue
Message-ID: <20190603110054.GG11812@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-8-ming.lei@redhat.com>
 <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
 <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
 <c11faee4-fc38-9636-59b4-bc5c0d94ffbf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11faee4-fc38-9636-59b4-bc5c0d94ffbf@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 03 Jun 2019 11:01:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 12:38:10PM +0100, John Garry wrote:
> 
> > > > -fallback:
> > > > -     for_each_possible_cpu(cpu)
> > > > -             hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
> > > > -     /* Don't clean all CQ masks */
> > > > -}
> > > > -
> > > >  static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > >  {
> > > >       struct device *dev = hisi_hba->dev;
> > > > @@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > > 
> > > >               min_msi = MIN_AFFINE_VECTORS_V3_HW;
> > > > 
> > > > -             hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
> > > > -                                                sizeof(unsigned int),
> > > > -                                                GFP_KERNEL);
> > > > -             if (!hisi_hba->reply_map)
> > > > -                     return -ENOMEM;
> > > >               vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
> > > >                                                        min_msi, max_msi,
> > > >                                                        PCI_IRQ_MSI |
> > > > @@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > >                                                        &desc);
> > > >               if (vectors < 0)
> > > >                       return -ENOENT;
> > > > -             setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
> > > >       } else {
> > > >               min_msi = max_msi;
> > > >               vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
> > > > @@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
> > > >       clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
> > > >  }
> > > > 
> > > > +static int hisi_sas_map_queues(struct Scsi_Host *shost)
> > > > +{
> > > > +     struct hisi_hba *hisi_hba = shost_priv(shost);
> > > > +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> > > > +
> > > > +     if (auto_affine_msi_experimental)
> > > > +             return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
> > > > +                             BASE_VECTORS_V3_HW);
> > > > +     else
> > > > +             return blk_mq_map_queues(qmap);
> 
> I don't think that the mapping which blk_mq_map_queues() creates are not
> want we want. I'm guessing that we still would like a mapping similar to
> what blk_mq_pci_map_queues() produces, which is an even spread, putting
> adjacent CPUs on the same queue.
> 
> For my system with 96 cpus and 16 queues, blk_mq_map_queues() would map
> queue 0 to cpu 0, 16, 32, 48 ..., queue 1 to cpu 1, 17, 33 and so on.

blk_mq_map_queues() is the default or fallback mapping in case that managed
irq isn't used. If the mapping isn't good enough, we still can improve it
in future, then any driver applying it can got improved.

> 
> > > > +}
> > > > +
> > > >  static struct scsi_host_template sht_v3_hw = {
> > > >       .name                   = DRV_NAME,
> > > >       .module                 = THIS_MODULE,
> > > 
> > > As mentioned, we should be using a common function here.
> > > 
> > > > @@ -2906,6 +2888,8 @@ static struct scsi_host_template sht_v3_hw = {
> > > >       .scan_start             = hisi_sas_scan_start,
> > > >       .change_queue_depth     = sas_change_queue_depth,
> > > >       .bios_param             = sas_bios_param,
> > > > +     .map_queues             = hisi_sas_map_queues,
> > > > +     .host_tagset            = 1,
> > > >       .this_id                = -1,
> > > >       .sg_tablesize           = HISI_SAS_SGE_PAGE_CNT,
> > > >       .sg_prot_tablesize      = HISI_SAS_SGE_PAGE_CNT,
> > > > @@ -3092,6 +3076,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >       if (hisi_sas_debugfs_enable)
> > > >               hisi_sas_debugfs_init(hisi_hba);
> > > > 
> > > > +     shost->nr_hw_queues = hisi_hba->cq_nvecs;
> 
> There's an ordering issue here, which can be fixed without too much trouble.
> 
> Value hisi_hba->cq_nvecs is not set until after this point, in
> hisi_sas_v3_probe()->hw->hw_init->hisi_sas_v3_init()->interrupt_init_v3_hw()
> 
> 
> Please see revised patch, below.

Good catch, will integrate it in V2.

Thanks,
Ming
