Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED698C433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1CE6113C
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhDSO5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 10:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhDSO5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 10:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618844207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ObVjZYSIxyI5J/di0bqmYZr2dcRunTHj/u9twcOFJzA=;
        b=g10m42v1LQKW/tGsufgPqTkIrjzpNTIBeG5vNxb8tb++meh6Ep/G6rqiwvFtxja9aQPwb7
        MQb5uKZb0dFDgJ5ZvFDU7qK5OgYqq/3tve8F8etWRLOVjwZ6sCZ+zhzncA8jDlHc3VMnNB
        E3NWxst6xRmvyKetH2l0jv6fa45vUmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-QmVUcXs1MYyqoQOMnPEpfw-1; Mon, 19 Apr 2021 10:56:43 -0400
X-MC-Unique: QmVUcXs1MYyqoQOMnPEpfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA218143FE;
        Mon, 19 Apr 2021 14:56:42 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 527255D742;
        Mon, 19 Apr 2021 14:56:31 +0000 (UTC)
Date:   Mon, 19 Apr 2021 10:56:30 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210419145630.GA5792@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210417000203.GA22241@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417000203.GA22241@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16 2021 at  8:02pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Fri, Apr 16 2021 at  7:53pm -0400,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > Hi,
> > 
> > This patchset reflects changes needed to make NVMe error handling and
> > ANA state updates work well with dm-multipath (which always sets
> > REQ_FAILFAST_TRANSPORT).
> > 
> > RHEL8 has been carrying an older ~5.9 based version of this patchset
> > (since RHEL8.3, August 2020).
> > 
> > RHEL9 is coming, would really prefer that these changes land upstream
> > rather than carry them within RHEL.
> > 
> > All review/feedback welcome.
> > 
> > Thanks,
> > Mike
> > 
> > v3 -> v4, less is more:
> > - folded REQ_FAILFAST_TRANSPORT local retry and FAILUP patches
> > - simplified nvme_failup_req(), removes needless blk_path_error() et al
> > - removed comment block in nvme_decide_disposition()
> > 
> > v2 -> v3:
> > - Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
> > - Eliminated __nvme_end_req() and added code comment to
> >   nvme_failup_req() in FAILUP handling patch.
> > 
> > Mike Snitzer (3):
> >   nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
> >   nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
> >   nvme: decouple basic ANA log page re-read support from native
> >     multipathing
> > 
> >  drivers/nvme/host/core.c      | 22 +++++++++++++++++++---
> >  drivers/nvme/host/multipath.c | 16 +++++++++++-----
> >  drivers/nvme/host/nvme.h      |  4 ++++
> >  include/linux/blk_types.h     |  8 ++++++++
> >  4 files changed, 42 insertions(+), 8 deletions(-)
> 
> Sorry for all the noise, but I had a cut-and-paste issue with this cover
> letter; should've said "[PATCH v4 0/4] ..."
> 
> While I'm replying, I _think_ there is consensus that patch 1 is
> worthwile and acceptable. Here is a combined diff of patches 2+3 to
> illustrate just how minimalist these proposed changes are:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 540d6fd8ffef..83ca96292157 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -299,6 +299,7 @@ enum nvme_disposition {
>  	COMPLETE,
>  	RETRY,
>  	FAILOVER,
> +	FAILUP,
>  };
>  
>  static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> @@ -306,15 +307,16 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	if (likely(nvme_req(req)->status == 0))
>  		return COMPLETE;
>  
> -	if (blk_noretry_request(req) ||
> +	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
>  	    (nvme_req(req)->status & NVME_SC_DNR) ||
>  	    nvme_req(req)->retries >= nvme_max_retries)
>  		return COMPLETE;
>  
> -	if (req->cmd_flags & REQ_NVME_MPATH) {
> +	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
>  		if (nvme_is_path_error(nvme_req(req)->status) ||
>  		    blk_queue_dying(req->q))
> -			return FAILOVER;
> +			return (req->cmd_flags & REQ_NVME_MPATH) ?
> +				FAILOVER : FAILUP;
>  	} else {
>  		if (blk_queue_dying(req->q))
>  			return COMPLETE;
> @@ -336,6 +338,14 @@ static inline void nvme_end_req(struct request *req)
>  	blk_mq_end_request(req, status);
>  }
>  
> +static inline void nvme_failup_req(struct request *req)
> +{
> +	nvme_update_ana(req);
> +
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	nvme_end_req(req);
> +}
> +
>  void nvme_complete_rq(struct request *req)
>  {
>  	trace_nvme_complete_rq(req);
> @@ -354,6 +364,9 @@ void nvme_complete_rq(struct request *req)
>  	case FAILOVER:
>  		nvme_failover_req(req);
>  		return;
> +	case FAILUP:
> +		nvme_failup_req(req);
> +		return;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a1d476e1ac02..7d94250264aa 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -65,23 +65,29 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  	}
>  }
>  
> -void nvme_failover_req(struct request *req)
> +void nvme_update_ana(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
>  	u16 status = nvme_req(req)->status & 0x7ff;
> -	unsigned long flags;
> -
> -	nvme_mpath_clear_current_path(ns);
>  
>  	/*
>  	 * If we got back an ANA error, we know the controller is alive but not
> -	 * ready to serve this namespace.  Kick of a re-read of the ANA
> +	 * ready to serve this namespace.  Kick off a re-read of the ANA
>  	 * information page, and just try any other available path for now.
>  	 */
>  	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
>  		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
>  		queue_work(nvme_wq, &ns->ctrl->ana_work);
>  	}
> +}
> +
> +void nvme_failover_req(struct request *req)
> +{
> +	struct nvme_ns *ns = req->q->queuedata;
> +	unsigned long flags;
> +
> +	nvme_mpath_clear_current_path(ns);
> +	nvme_update_ana(req);
>  
>  	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>  	blk_steal_bios(&ns->head->requeue_list, req);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 07b34175c6ce..4eed8536625c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
>  void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  			struct nvme_ctrl *ctrl, int *flags);
>  void nvme_failover_req(struct request *req);
> +void nvme_update_ana(struct request *req);
>  void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
>  int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
>  void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
> @@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  static inline void nvme_failover_req(struct request *req)
>  {
>  }
> +static inline void nvme_update_ana(struct request *req)
> +{
> +}
>  static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>  {
>  }

Since I sent these changes late on Friday I figured I'd try to get them
on your radar.

I would really appreciate timely review of this series for 5.13:
https://patchwork.kernel.org/project/dm-devel/list/?series=468905

Thanks,
Mike

