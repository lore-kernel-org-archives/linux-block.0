Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D5C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A6924B41
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 13:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfFDNho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfFDNho (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 09:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8CB43003E5F;
        Tue,  4 Jun 2019 13:37:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2370D1001DD2;
        Tue,  4 Jun 2019 13:37:14 +0000 (UTC)
Date:   Tue, 4 Jun 2019 21:37:10 +0800
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
Message-ID: <20190604133709.GB17248@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-8-ming.lei@redhat.com>
 <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
 <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
 <c11faee4-fc38-9636-59b4-bc5c0d94ffbf@huawei.com>
 <20190603110054.GG11812@ming.t460p>
 <f1a66b3a-5549-b69d-79fa-7d89b5627a15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a66b3a-5549-b69d-79fa-7d89b5627a15@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 04 Jun 2019 13:37:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 03, 2019 at 02:00:19PM +0100, John Garry wrote:
> On 03/06/2019 12:00, Ming Lei wrote:
> > On Fri, May 31, 2019 at 12:38:10PM +0100, John Garry wrote:
> > > 
> > > > > > -fallback:
> > > > > > -     for_each_possible_cpu(cpu)
> > > > > > -             hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
> > > > > > -     /* Don't clean all CQ masks */
> > > > > > -}
> > > > > > -
> > > > > >  static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > > > >  {
> > > > > >       struct device *dev = hisi_hba->dev;
> > > > > > @@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > > > > 
> > > > > >               min_msi = MIN_AFFINE_VECTORS_V3_HW;
> > > > > > 
> > > > > > -             hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
> > > > > > -                                                sizeof(unsigned int),
> > > > > > -                                                GFP_KERNEL);
> > > > > > -             if (!hisi_hba->reply_map)
> > > > > > -                     return -ENOMEM;
> > > > > >               vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
> > > > > >                                                        min_msi, max_msi,
> > > > > >                                                        PCI_IRQ_MSI |
> > > > > > @@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
> > > > > >                                                        &desc);
> > > > > >               if (vectors < 0)
> > > > > >                       return -ENOENT;
> > > > > > -             setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
> > > > > >       } else {
> > > > > >               min_msi = max_msi;
> > > > > >               vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
> > > > > > @@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
> > > > > >       clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
> > > > > >  }
> > > > > > 
> > > > > > +static int hisi_sas_map_queues(struct Scsi_Host *shost)
> > > > > > +{
> > > > > > +     struct hisi_hba *hisi_hba = shost_priv(shost);
> > > > > > +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> > > > > > +
> > > > > > +     if (auto_affine_msi_experimental)
> > > > > > +             return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
> > > > > > +                             BASE_VECTORS_V3_HW);
> > > > > > +     else
> > > > > > +             return blk_mq_map_queues(qmap);
> > > 
> > > I don't think that the mapping which blk_mq_map_queues() creates are not
> > > want we want. I'm guessing that we still would like a mapping similar to
> > > what blk_mq_pci_map_queues() produces, which is an even spread, putting
> > > adjacent CPUs on the same queue.
> > > 
> > > For my system with 96 cpus and 16 queues, blk_mq_map_queues() would map
> > > queue 0 to cpu 0, 16, 32, 48 ..., queue 1 to cpu 1, 17, 33 and so on.
> > 
> 
> Hi Ming,
> 
> > blk_mq_map_queues() is the default or fallback mapping in case that managed
> > irq isn't used. If the mapping isn't good enough, we still can improve it
> > in future, then any driver applying it can got improved.
> > 
> 
> That's the right attitude. However, as I see, we can only know the mapping
> when we know the interrupt affinity or some other mapping restriction or
> rule etc, which we don't know in this case.
> 
> For now, personally I would rather if we only expose multiple queues for
> when auto_affine_msi_experimental is set. I fear that we may make a
> performance regression for !auto_affine_msi_experimental with this patch. We
> would need to test.

I suggest to use the blk-mq generic helper.

The default queue mapping of blk_mq_map_queues() has been used for a
while, so far so good, such as, very similar way is applied on
megaraid_sas and mpt3sas, see _base_assign_reply_queues() and
megasas_setup_reply_map().

If performance drop is caused, just report it out, we could fix it.
Or even you can write a new .map_queues method just for hisi_sas v3.


Thanks,
Ming
