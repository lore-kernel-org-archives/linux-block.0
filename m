Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA2C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9B2633F
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaGWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 02:22:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfEaGWd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 02:22:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6767BAF60;
        Fri, 31 May 2019 06:22:31 +0000 (UTC)
Subject: Re: [PATCH 8/9] scsi: megaraid: convert private reply queue to blk-mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-9-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <c3b412df-17ba-bffa-af25-ad7d01cc00e2@suse.de>
Date:   Fri, 31 May 2019 08:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531022801.10003-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/19 4:28 AM, Ming Lei wrote:
> SCSI's reply qeueue is very similar with blk-mq's hw queue, both
> assigned by IRQ vector, so map te private reply queue into blk-mq's hw
> queue via .host_tagset.
> 
> Then the private reply mapping can be removed.
> 
> Another benefit is that the request/irq lost issue may be solved in
> generic approach because managed IRQ may be shutdown during CPU
> hotplug.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c   | 50 ++++++++-------------
>  drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 +-
>  2 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 3dd1df472dc6..b49999b90231 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -33,6 +33,7 @@
>  #include <linux/fs.h>
>  #include <linux/compat.h>
>  #include <linux/blkdev.h>
> +#include <linux/blk-mq-pci.h>
>  #include <linux/mutex.h>
>  #include <linux/poll.h>
>  #include <linux/vmalloc.h>
> @@ -3165,6 +3166,19 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
>  	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
>  }
>  
> +static int megasas_map_queues(struct Scsi_Host *shost)
> +{
> +	struct megasas_instance *instance = (struct megasas_instance *)
> +		shost->hostdata;
> +	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> +
> +	if (smp_affinity_enable && instance->msix_vectors)
> +		return blk_mq_pci_map_queues(qmap, instance->pdev, 0);
> +	else
> +		return blk_mq_map_queues(qmap);
> +}
> +
> +
>  static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
>  	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
>  static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,

As mentioned, we should be using a common function here.

> @@ -3207,7 +3221,9 @@ static struct scsi_host_template megasas_template = {
>  	.shost_attrs = megaraid_host_attrs,
>  	.bios_param = megasas_bios_param,
>  	.change_queue_depth = scsi_change_queue_depth,
> +	.map_queues =  megasas_map_queues,
>  	.no_write_same = 1,
> +	.host_tagset = 1,
>  };
>  
>  /**
> @@ -5407,26 +5423,6 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
>  		instance->use_seqnum_jbod_fp = false;
>  }
>  
> -static void megasas_setup_reply_map(struct megasas_instance *instance)
> -{
> -	const struct cpumask *mask;
> -	unsigned int queue, cpu;
> -
> -	for (queue = 0; queue < instance->msix_vectors; queue++) {
> -		mask = pci_irq_get_affinity(instance->pdev, queue);
> -		if (!mask)
> -			goto fallback;
> -
> -		for_each_cpu(cpu, mask)
> -			instance->reply_map[cpu] = queue;
> -	}
> -	return;
> -
> -fallback:
> -	for_each_possible_cpu(cpu)
> -		instance->reply_map[cpu] = cpu % instance->msix_vectors;
> -}
> -
>  /**
>   * megasas_get_device_list -	Get the PD and LD device list from FW.
>   * @instance:			Adapter soft state
> @@ -5666,8 +5662,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
>  			goto fail_init_adapter;
>  	}
>  
> -	megasas_setup_reply_map(instance);
> -
>  	dev_info(&instance->pdev->dev,
>  		"firmware supports msix\t: (%d)", fw_msix_count);
>  	dev_info(&instance->pdev->dev,
> @@ -6298,6 +6292,8 @@ static int megasas_io_attach(struct megasas_instance *instance)
>  	host->max_lun = MEGASAS_MAX_LUN;
>  	host->max_cmd_len = 16;
>  
> +	host->nr_hw_queues = instance->msix_vectors ?: 1;
> +
>  	/*
>  	 * Notify the mid-layer about the new controller
>  	 */
> @@ -6464,11 +6460,6 @@ static inline int megasas_alloc_mfi_ctrl_mem(struct megasas_instance *instance)
>   */
>  static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
>  {
> -	instance->reply_map = kcalloc(nr_cpu_ids, sizeof(unsigned int),
> -				      GFP_KERNEL);
> -	if (!instance->reply_map)
> -		return -ENOMEM;
> -
>  	switch (instance->adapter_type) {
>  	case MFI_SERIES:
>  		if (megasas_alloc_mfi_ctrl_mem(instance))
> @@ -6485,8 +6476,6 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
>  
>  	return 0;
>   fail:
> -	kfree(instance->reply_map);
> -	instance->reply_map = NULL;
>  	return -ENOMEM;
>  }
>  
> @@ -6499,7 +6488,6 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
>   */
>  static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
>  {
> -	kfree(instance->reply_map);
>  	if (instance->adapter_type == MFI_SERIES) {
>  		if (instance->producer)
>  			dma_free_coherent(&instance->pdev->dev, sizeof(u32),
> @@ -7142,8 +7130,6 @@ megasas_resume(struct pci_dev *pdev)
>  	if (rval < 0)
>  		goto fail_reenable_msix;
>  
> -	megasas_setup_reply_map(instance);
> -
>  	if (instance->adapter_type != MFI_SERIES) {
>  		megasas_reset_reply_desc(instance);
>  		if (megasas_ioc_init_fusion(instance)) {
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 4dfa0685a86c..4f909f32bf5c 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -2699,7 +2699,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
>  	}
>  
>  	cmd->request_desc->SCSIIO.MSIxIndex =
> -		instance->reply_map[raw_smp_processor_id()];
> +		scsi_cmnd_hctx_index(instance->host, scp);
>  
>  	if (instance->adapter_type >= VENTURA_SERIES) {
>  		/* FP for Optimal raid level 1.
> @@ -3013,7 +3013,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
>  	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
>  
>  	cmd->request_desc->SCSIIO.MSIxIndex =
> -		instance->reply_map[raw_smp_processor_id()];
> +		scsi_cmnd_hctx_index(instance->host, scmd);
>  
>  	if (!fp_possible) {
>  		/* system pd firmware path */
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
