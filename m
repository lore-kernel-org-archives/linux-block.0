Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3839C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12DC21871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLRSFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:05:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:41890 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRSFY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:05:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 10:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="119447245"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Dec 2018 10:05:22 -0800
Date:   Tue, 18 Dec 2018 11:03:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     yupeng <yupeng0921@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
Message-ID: <20181218180306.GA19791@localhost.localdomain>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
 <20181218172645.GB13768@localhost.localdomain>
 <20181218174750.GA14416@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218174750.GA14416@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 06:47:50PM +0100, hch@lst.de wrote:
> On Tue, Dec 18, 2018 at 10:26:46AM -0700, Keith Busch wrote:
> > No need for a space after the %s. __print_disk_name already appends a
> > space if there's a disk name, and we don't want the extra space if there
> > isn't one. Also, every other nvme trace has a ',' after each entry. Not
> > a big deal, just minor format consistency.
> 
> Yeah.  What about something like this incremental patch to make the
> trace formatting and argument passing match what we otherwise do:

Nice, that looks good. It's also necessary for admin commands since
there was no other way to see which controller a completion came from
without this.

Reviewed-by: Keith Busch <keith.busch@intel.com> 


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2477bd906904..5a0bf6a24d50 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1004,8 +1004,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> -	trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
> -			nvmeq->sq_tail);
> +	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>  	nvme_end_request(req, cqe->status, cqe->result);
>  }
>  
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index cf666709bc50..3564120aa7b3 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -185,22 +185,24 @@ TRACE_EVENT(nvme_async_event,
>  #undef aer_name
>  
>  TRACE_EVENT(nvme_sq,
> -	TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
> -	TP_ARGS(rq_disk, qid, sq_head, sq_tail),
> +	TP_PROTO(struct request *req, __le16 sq_head, int sq_tail),
> +	TP_ARGS(req, sq_head, sq_tail),
>  	TP_STRUCT__entry(
> +		__field(int, ctrl_id)
>  		__array(char, disk, DISK_NAME_LEN)
>  		__field(int, qid)
> -		__field(int, sq_head)
> -		__field(int, sq_tail)
> +		__field(u16, sq_head)
> +		__field(u16, sq_tail)
>  	),
>  	TP_fast_assign(
> -		__assign_disk_name(__entry->disk, rq_disk);
> -		__entry->qid = qid;
> -		__entry->sq_head = sq_head;
> +		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
> +		__assign_disk_name(__entry->disk, req->rq_disk);
> +		__entry->qid = nvme_req_qid(req);
> +		__entry->sq_head = le16_to_cpu(sq_head);
>  		__entry->sq_tail = sq_tail;
>  	),
> -	TP_printk("nvme: %s qid=%d head=%d tail=%d",
> -		__print_disk_name(__entry->disk),
> +	TP_printk("nvme%d: %sqid=%d, head=%u, tail=%u",
> +		__entry->ctrl_id, __print_disk_name(__entry->disk),
>  		__entry->qid, __entry->sq_head, __entry->sq_tail
>  	)
>  );
