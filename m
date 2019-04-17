Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAABFC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804B2206BA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfDQMKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:10:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731116AbfDQMKU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 08:10:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B16C1AFFC;
        Wed, 17 Apr 2019 12:10:18 +0000 (UTC)
Subject: Re: [PATCH V6 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-10-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bc4b8607-9fe7-aece-97f7-9d7d1c2c4e0b@suse.de>
Date:   Wed, 17 Apr 2019 14:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417034410.31957-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/19 5:44 AM, Ming Lei wrote:
> Hennes reported the following kernel oops:
> 
>      There is a race condition between namespace rescanning and
>      controller reset; during controller reset all namespaces are
>      quiesed vie nams_stop_ctrl(), and after reset all namespaces
>      are unquiesced again.
>      When namespace scanning was active by the time controller reset
>      was triggered the rescan code will call nvme_ns_remove(), which
>      then will cause a kernel crash in nvme_start_ctrl() as it'll trip
>      over uninitialized namespaces.
> 
> Patch "blk-mq: free hw queue's resource in hctx's release handler"
> should make this issue quite difficult to trigger. However it can't
> kill the issue completely becasue pre-condition of that patch is to
> hold request queue's refcount before calling block layer API, and
> there is still a small window between blk_cleanup_queue() and removing
> the ns from the controller namspace list in nvme_ns_remove().
> 
> Hold request queue's refcount until the ns is freed, then the above race
> can be avoided completely. Given the 'namespaces_rwsem' is always held
> to retrieve ns for starting/stopping request queue, this lock can prevent
> namespaces from being freed.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Reported-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 248ff3b48041..82cda6602ca7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -406,6 +406,7 @@ static void nvme_free_ns(struct kref *kref)
>   		nvme_nvm_unregister(ns);
>   
>   	put_disk(ns->disk);
> +	blk_put_queue(ns->queue);
>   	nvme_put_ns_head(ns->head);
>   	nvme_put_ctrl(ns->ctrl);
>   	kfree(ns);
> @@ -3229,6 +3230,11 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   		goto out_free_ns;
>   	}
>   
> +	if (!blk_get_queue(ns->queue)) {
> +		ret = -ENXIO;
> +		goto out_free_queue;
> +	}
> +
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>   	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>   		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
> @@ -3245,7 +3251,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	id = nvme_identify_ns(ctrl, nsid);
>   	if (!id) {
>   		ret = -EIO;
> -		goto out_free_queue;
> +		goto out_put_queue;
>   	}
>   
>   	if (id->ncap == 0) {
> @@ -3304,6 +3310,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	nvme_put_ns_head(ns->head);
>    out_free_id:
>   	kfree(id);
> + out_put_queue:
> +	blk_put_queue(ns->queue);
>    out_free_queue:
>   	blk_cleanup_queue(ns->queue);
>    out_free_ns:
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
