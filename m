Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5AFC04AB6
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 02:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485C921721
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 02:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfE2Cg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 22:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfE2Cg4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 22:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9ABE30C2533;
        Wed, 29 May 2019 02:36:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D5695D784;
        Wed, 29 May 2019 02:36:41 +0000 (UTC)
Date:   Wed, 29 May 2019 10:36:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/5] scsi: select reply queue from request's CPU
Message-ID: <20190529023635.GB21398@ming.t460p>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-2-ming.lei@redhat.com>
 <546f5060-d39a-3057-a181-fa3ff1b921d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546f5060-d39a-3057-a181-fa3ff1b921d4@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 29 May 2019 02:36:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 28, 2019 at 11:33:29AM +0100, John Garry wrote:
> On 27/05/2019 16:02, Ming Lei wrote:
> > Hisi_sas_v3_hw, hpsa, megaraid and mpt3sas use single blk-mq hw queue
> > to submit request, meantime apply multiple private reply queues served as
> > completion queue. The mapping between CPU and reply queue is setup via
> > pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) just like the usual
> > blk-mq queue mapping.
> > 
> > These drivers always use current CPU(raw_smp_processor_id) to figure out
> > the reply queue. Switch to use request's CPU to get the reply queue,
> > so we can drain in-flight request via blk-mq's API before the last CPU of
> > the reply queue becomes offline.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/hisi_sas/hisi_sas_main.c       |  5 +++--
> >  drivers/scsi/hpsa.c                         |  2 +-
> >  drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
> >  drivers/scsi/mpt3sas/mpt3sas_base.c         | 16 ++++++++--------
> >  include/scsi/scsi_cmnd.h                    | 11 +++++++++++
> >  5 files changed, 25 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> > index 8a7feb8ed8d6..ab9d8e7bfc8e 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> > @@ -471,9 +471,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
> >  		return -ECOMM;
> >  	}
> > 
> > +	/* only V3 hardware setup .reply_map */
> >  	if (hisi_hba->reply_map) {
> > -		int cpu = raw_smp_processor_id();
> > -		unsigned int dq_index = hisi_hba->reply_map[cpu];
> > +		unsigned int dq_index = hisi_hba->reply_map[
> > +			scsi_cmnd_cpu(task->uldd_task)];
> 
> Hi Ming,
> 
> There is a problem here. For ATA commands in libsas, task->uldd_task is
> ata_queued_cmd *, and not a scsi_cmnd *. It comes from https://elixir.bootlin.com/linux/v5.2-rc2/source/drivers/scsi/libsas/sas_ata.c#L212
> 

Yeah, that is one problem.

> Please see this later code, where we have this check:
> 	if (task->uldd_task) {
> 		struct ata_queued_cmd *qc;
> 
> 		if (dev_is_sata(device)) {
> 			qc = task->uldd_task;
> 			scsi_cmnd = qc->scsicmd;
> 		} else {
> 			scsi_cmnd = task->uldd_task;
> 		}
> 	}
> 	rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
> 
> I suppose that we could solve by finding scsi_cmnd * earlier in
> hisi_sas_task_prep().

Yeah, it can be fixed easily, or move delivery queue selection
after .slot_index_alloc.

> 
> > 
> >  		*dq_pointer = dq = &hisi_hba->dq[dq_index];
> >  	} else {
> > diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> > index 1bef1da273c2..72f9edb86752 100644
> > --- a/drivers/scsi/hpsa.c
> > +++ b/drivers/scsi/hpsa.c
> > @@ -1145,7 +1145,7 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,
> 
> [snip]
> 
> > diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> > index 76ed5e4acd38..ab60883c2c40 100644
> > --- a/include/scsi/scsi_cmnd.h
> > +++ b/include/scsi/scsi_cmnd.h
> > @@ -332,4 +332,15 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
> >  	return xfer_len;
> >  }
> > 
> > +static inline int scsi_cmnd_cpu(struct scsi_cmnd *scmd)
> > +{
> > +	if (!scmd || !scmd->request)
> > +		return raw_smp_processor_id();
> > +
> > +	if (!scmd->request->mq_ctx)
> > +		return raw_smp_processor_id();
> 
> nit: can we combine these tests? Or do you want a distinct check on

OK.

> scmd->request->mq_ctx, since blk_mq_rq_cpu() does not check it?

blk_mq_rq_cpu() needn't to check it, however SCSI has to run the check
because some request may not have .mq_ctx, such as reset request.

Thanks,
Ming
