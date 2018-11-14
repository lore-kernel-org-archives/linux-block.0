Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99EDC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1922243E
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1922243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKOE4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:56:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727251AbeKOE4B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 23:56:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EFA4B0AE;
        Wed, 14 Nov 2018 18:51:32 +0000 (UTC)
Subject: Re: multipath-tools: add ANA support for NVMe device
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, linux-nvme@lists.infradead.org,
        chengjike.cheng@huawei.com, shenhong09@huawei.com,
        dm-devel@redhat.com, wangzhoumengjian@huawei.com,
        christophe.varoqui@opensvc.com, bmarzins@redhat.com,
        sschremm@netapp.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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 bA==
Organization: SUSE Linux GmbH
Message-ID: <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
Date:   Wed, 14 Nov 2018 19:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114174746.GA18526@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 6:47 PM, Mike Snitzer wrote:
> On Wed, Nov 14 2018 at  2:49am -0500,
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> On 11/14/18 6:38 AM, Mike Snitzer wrote:
>>> On Tue, Nov 13 2018 at  1:00pm -0500,
>>> Mike Snitzer <snitzer@redhat.com> wrote:
>>>
>>>> [1]: http://lists.infradead.org/pipermail/linux-nvme/2018-November/020765.html
>>>> [2]: https://www.redhat.com/archives/dm-devel/2018-November/msg00072.html
>>> ...
>>>
>>> I knew there had to be a pretty tight coupling between the NVMe driver's
>>> native multipathing and ANA support... and that the simplicity of
>>> Hannes' patch [1] was too good to be true.
>>>
>>> The real justification for not making Hannes' change is it'd effectively
>>> be useless without first splitting out the ANA handling done during NVMe
>>> request completion (NVME_SC_ANA_* cases in nvme_failover_req) that
>>> triggers re-reading the ANA log page accordingly.
>>>
>>> So without the ability to drive the ANA workqueue to trigger
>>> nvme_read_ana_log() from the nvme driver's completion path -- even if
>>> nvme_core.multipath=N -- it really doesn't buy multipath-tools anything
>>> to have the NVMe driver export the ana state via sysfs, because that ANA
>>> state will never get updated.
>>>
>> Hmm. Indeed, I was more focussed on having the sysfs attributes
>> displayed, so yes, indeed it needs some more work.
> ...
>>> Not holding my breath BUT:
>>> if decoupling the reading of ANA state from native NVMe multipathing
>>> specific work during nvme request completion were an acceptable
>>> advancement I'd gladly do the work.
>>>
>> I'd be happy to work on that, given that we'll have to have 'real'
>> ANA support for device-mapper anyway for SLE12 SP4 etc.
> 
> I had a close enough look yesterday that I figured I'd just implement
> what I reasoned through as one way forward, compile tested only (patch
> relative to Jens' for-4.21/block):
> 
>  drivers/nvme/host/core.c      | 14 +++++++---
>  drivers/nvme/host/multipath.c | 65 ++++++++++++++++++++++++++-----------------
>  drivers/nvme/host/nvme.h      |  4 +++
>  3 files changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f172d63db2b5..05313ab5d91e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -252,10 +252,16 @@ void nvme_complete_rq(struct request *req)
>  	trace_nvme_complete_rq(req);
>  
>  	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> -		if ((req->cmd_flags & REQ_NVME_MPATH) &&
> -		    blk_path_error(status)) {
> -			nvme_failover_req(req);
> -			return;
> +		if (blk_path_error(status)) {
> +			struct nvme_ns *ns = req->q->queuedata;
> +			u16 nvme_status = nvme_req(req)->status;
> +
> +			if (req->cmd_flags & REQ_NVME_MPATH) {
> +				nvme_failover_req(req);
> +				nvme_update_ana(ns, nvme_status);
> +				return;
> +			}
> +			nvme_update_ana(ns, nvme_status);
>  		}
>  
>  		if (!blk_queue_dying(req->q)) {
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 5e3cc8c59a39..f7fbc161dc8c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -22,7 +22,7 @@ MODULE_PARM_DESC(multipath,
>  
>  inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>  {
> -	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
> +	return ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
>  }
>  
>  /*
> @@ -47,6 +47,17 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  	}
>  }
>  
> +static bool nvme_ana_error(u16 status)
> +{
> +	switch (status & 0x7ff) {
> +	case NVME_SC_ANA_TRANSITION:
> +	case NVME_SC_ANA_INACCESSIBLE:
> +	case NVME_SC_ANA_PERSISTENT_LOSS:
> +		return true;
> +	}
> +	return false;
> +}
> +
>  void nvme_failover_req(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
> @@ -58,10 +69,7 @@ void nvme_failover_req(struct request *req)
>  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>  	blk_mq_end_request(req, 0);
>  
> -	switch (status & 0x7ff) {
> -	case NVME_SC_ANA_TRANSITION:
> -	case NVME_SC_ANA_INACCESSIBLE:
> -	case NVME_SC_ANA_PERSISTENT_LOSS:
> +	if (nvme_ana_error(status)) {
>  		/*
>  		 * If we got back an ANA error we know the controller is alive,
>  		 * but not ready to serve this namespaces.  The spec suggests
> @@ -69,31 +77,38 @@ void nvme_failover_req(struct request *req)
>  		 * that the admin and I/O queues are not serialized that is
>  		 * fundamentally racy.  So instead just clear the current path,
>  		 * mark the the path as pending and kick of a re-read of the ANA
> -		 * log page ASAP.
> +		 * log page ASAP (see nvme_update_ana() below).
>  		 */
>  		nvme_mpath_clear_current_path(ns);
> -		if (ns->ctrl->ana_log_buf) {
> -			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> -			queue_work(nvme_wq, &ns->ctrl->ana_work);
> +	} else {
> +		switch (status & 0x7ff) {
> +		case NVME_SC_HOST_PATH_ERROR:
> +			/*
> +			 * Temporary transport disruption in talking to the
> +			 * controller.  Try to send on a new path.
> +			 */
> +			nvme_mpath_clear_current_path(ns);
> +			break;
> +		default:
> +			/*
> +			 * Reset the controller for any non-ANA error as we
> +			 * don't know what caused the error.
> +			 */
> +			nvme_reset_ctrl(ns->ctrl);
> +			break;
>  		}
> -		break;
> -	case NVME_SC_HOST_PATH_ERROR:
> -		/*
> -		 * Temporary transport disruption in talking to the controller.
> -		 * Try to send on a new path.
> -		 */
> -		nvme_mpath_clear_current_path(ns);
> -		break;
> -	default:
> -		/*
> -		 * Reset the controller for any non-ANA error as we don't know
> -		 * what caused the error.
> -		 */
> -		nvme_reset_ctrl(ns->ctrl);
> -		break;
>  	}
Maybe move nvme_mpath_clear_current_path() out of the loop (it wouldn't
matter if we clear the path if we reset the controller afterwards); that
might even clean up the code even more.

> +}
>  
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +void nvme_update_ana(struct nvme_ns *ns, u16 status)
> +{
> +	if (nvme_ana_error(status) && ns->ctrl->ana_log_buf) {
> +		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> +		queue_work(nvme_wq, &ns->ctrl->ana_work);
> +	}
> +
> +	if (multipath)
> +		kblockd_schedule_work(&ns->head->requeue_work);
>  }

maybe use 'ns->head->disk' here; we only need to call this if we have a
multipath disk.

Remaining bits are okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
