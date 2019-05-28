Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8EC04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE412075C
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 10:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfE1Kdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 06:33:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfE1Kdm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 06:33:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B8F3C9335531791EB208;
        Tue, 28 May 2019 18:33:39 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 18:33:36 +0800
Subject: Re: [PATCH V2 1/5] scsi: select reply queue from request's CPU
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-2-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-scsi@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <546f5060-d39a-3057-a181-fa3ff1b921d4@huawei.com>
Date:   Tue, 28 May 2019 11:33:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190527150207.11372-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2019 16:02, Ming Lei wrote:
> Hisi_sas_v3_hw, hpsa, megaraid and mpt3sas use single blk-mq hw queue
> to submit request, meantime apply multiple private reply queues served as
> completion queue. The mapping between CPU and reply queue is setup via
> pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) just like the usual
> blk-mq queue mapping.
>
> These drivers always use current CPU(raw_smp_processor_id) to figure out
> the reply queue. Switch to use request's CPU to get the reply queue,
> so we can drain in-flight request via blk-mq's API before the last CPU of
> the reply queue becomes offline.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_main.c       |  5 +++--
>  drivers/scsi/hpsa.c                         |  2 +-
>  drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
>  drivers/scsi/mpt3sas/mpt3sas_base.c         | 16 ++++++++--------
>  include/scsi/scsi_cmnd.h                    | 11 +++++++++++
>  5 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 8a7feb8ed8d6..ab9d8e7bfc8e 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -471,9 +471,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
>  		return -ECOMM;
>  	}
>
> +	/* only V3 hardware setup .reply_map */
>  	if (hisi_hba->reply_map) {
> -		int cpu = raw_smp_processor_id();
> -		unsigned int dq_index = hisi_hba->reply_map[cpu];
> +		unsigned int dq_index = hisi_hba->reply_map[
> +			scsi_cmnd_cpu(task->uldd_task)];

Hi Ming,

There is a problem here. For ATA commands in libsas, task->uldd_task is 
ata_queued_cmd *, and not a scsi_cmnd *. It comes from 
https://elixir.bootlin.com/linux/v5.2-rc2/source/drivers/scsi/libsas/sas_ata.c#L212

Please see this later code, where we have this check:
	if (task->uldd_task) {
		struct ata_queued_cmd *qc;

		if (dev_is_sata(device)) {
			qc = task->uldd_task;
			scsi_cmnd = qc->scsicmd;
		} else {
			scsi_cmnd = task->uldd_task;
		}
	}
	rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);

I suppose that we could solve by finding scsi_cmnd * earlier in 
hisi_sas_task_prep().

>
>  		*dq_pointer = dq = &hisi_hba->dq[dq_index];
>  	} else {
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 1bef1da273c2..72f9edb86752 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -1145,7 +1145,7 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,

[snip]

> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 76ed5e4acd38..ab60883c2c40 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -332,4 +332,15 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
>  	return xfer_len;
>  }
>
> +static inline int scsi_cmnd_cpu(struct scsi_cmnd *scmd)
> +{
> +	if (!scmd || !scmd->request)
> +		return raw_smp_processor_id();
> +
> +	if (!scmd->request->mq_ctx)
> +		return raw_smp_processor_id();

nit: can we combine these tests? Or do you want a distinct check on 
scmd->request->mq_ctx, since blk_mq_rq_cpu() does not check it?

> +
> +	return blk_mq_rq_cpu(scmd->request);
> +}
> +
>  #endif /* _SCSI_SCSI_CMND_H */

Thanks

>


